import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:loan_management_app/app.dart';
import 'package:loan_management_app/core/utils/emi_calculator.dart';
import 'package:loan_management_app/data/dao/loanwise_dao.dart';
import 'package:loan_management_app/data/dao/user_dao.dart';
import 'package:loan_management_app/data/db/app_database.dart';
import 'package:loan_management_app/data/models/user_db_model.dart';
import 'package:loan_management_app/data/repositories/loanwise_store.dart';
import 'package:loan_management_app/domain/models/loan_models.dart';
import 'package:loan_management_app/services/loan_agreement_pdf_service.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('LoanWiseDao SQLite persistence & atomic transactions', () {
    late AppDatabase appDb;
    late LoanWiseDao dao;
    late UserDao userDao;

    setUp(() async {
      appDb = await AppDatabase.openInMemory();
      dao = LoanWiseDao(appDb);
      userDao = UserDao(appDb);
    });

    tearDown(() async {
      await appDb.close();
    });

    test(
      'createLoanAtomic commits loan + all EMIs + disbursement ledger cleanly and rolls back on failure',
      () async {
        final now = DateTime(2026, 3, 1);
        final customer = Customer(
          id: 'CUS-1001',
          name: 'Asha Verma',
          email: 'asha@example.com',
          mobile: '9876501111',
          location: 'Jaipur',
          createdAt: now,
          updatedAt: now,
        );
        await dao.upsertCustomer(customer);

        final calc = EmiCalculator.calculate(
          principalPaise: 10000000,
          monthlyRatePercent: 2.0,
          tenureMonths: 3,
          loanType: LoanType.simple,
          startDate: now,
        );
        final loan = Loan(
          id: 'LN-1002',
          customerId: customer.id,
          principalPaise: 10000000,
          monthlyRatePercent: 2.0,
          tenureMonths: 3,
          type: LoanType.simple,
          startDate: now,
          status: LoanStatus.active,
          totalPayablePaise: calc.totalPayablePaise,
          totalInterestPaise: calc.totalInterestPaise,
          monthlyEmiPaise: calc.monthlyEmiPaise,
          createdAt: now,
        );
        final emis = [
          for (int i = 0; i < calc.rows.length; i++)
            EmiScheduleItem(
              id: 'EMI-${1010 + i}',
              loanId: loan.id,
              installmentNo: calc.rows[i].installmentNo,
              dueDate: calc.rows[i].dueDate,
              emiPaise: calc.rows[i].emiPaise,
              principalPartPaise: calc.rows[i].principalPartPaise,
              interestPartPaise: calc.rows[i].interestPartPaise,
              remainingBalancePaise: calc.rows[i].remainingBalancePaise,
              status: EmiStatus.pending,
            ),
        ];
        final disbursement = LedgerEntry(
          id: 'LDG-1020',
          customerId: customer.id,
          loanId: loan.id,
          kind: LedgerKind.disbursement,
          debitPaise: loan.totalPayablePaise,
          creditPaise: 0,
          balanceAfterPaise: loan.totalPayablePaise,
          createdAt: now,
        );

        // Simulate mid-transaction failure -> full rollback expected.
        await expectLater(
          () => dao.createLoanAtomic(
            loan: loan,
            emis: emis,
            disbursement: disbursement,
            beforeCommitHook: () => throw StateError('Simulated crash'),
          ),
          throwsStateError,
        );

        expect(await appDb.database.query('loans'), isEmpty);
        expect(await appDb.database.query('emis'), isEmpty);
        expect(await appDb.database.query('ledger'), isEmpty);

        // Now commit cleanly.
        await dao.createLoanAtomic(
          loan: loan,
          emis: emis,
          disbursement: disbursement,
        );

        final loaded = await dao.loadAll();
        expect(loaded.customers.length, 1);
        expect(loaded.loans.length, 1);
        expect(loaded.emisByLoan[loan.id]?.length, 3);
        expect(loaded.ledger.length, 1);
        expect(loaded.maxNumericId, 1020);
      },
    );

    test(
      'enforces active unique mobile and allows re-creating same mobile after soft-delete',
      () async {
        final now = DateTime(2026, 3, 1);
        final first = Customer(
          id: 'CUS-1001',
          name: 'First',
          email: 'first@example.com',
          mobile: '9876543210',
          location: 'Delhi',
          createdAt: now,
          updatedAt: now,
        );
        await dao.upsertCustomer(first);

        final duplicate = Customer(
          id: 'CUS-1002',
          name: 'Duplicate',
          email: 'dup@example.com',
          mobile: '9876543210',
          location: 'Delhi',
          createdAt: now,
          updatedAt: now,
        );
        await expectLater(() => dao.upsertCustomer(duplicate), throwsException);

        await dao.softDeleteCustomer(first.copyWith(deletedAt: now));
        await dao.upsertCustomer(duplicate);

        final rows = await appDb.database.query('customers');
        expect(rows.length, 2);
      },
    );

    test(
      'recordEmiPaymentAtomic, upsertDocument, deleteDocument, and replaceAllForRestore roundtrip cleanly',
      () async {
        final now = DateTime(2026, 3, 5);
        const profile = LenderProfile(
          name: 'Lender One',
          mobile: '9800000001',
          email: 'lender@loanwise.in',
        );
        await userDao.upsertUser(
          UserDbModel(
            name: profile.name,
            mobile: profile.mobile,
            email: profile.email,
            createdAt: now.toIso8601String(),
            updatedAt: now.toIso8601String(),
          ),
        );

        final store = LoanWiseStore.empty(profile: profile, isSignedIn: true);
        final cust = store
            .createCustomer(
              name: 'Kiran Rao',
              email: 'kiran@example.com',
              mobile: '9811112222',
              location: 'Pune',
            )
            .dataOrNull!;
        final loan = store
            .createLoan(
              customerId: cust.id,
              principalPaise: 5000000,
              monthlyRatePercent: 2.0,
              tenureMonths: 2,
              type: LoanType.simple,
              startDate: now,
            )
            .dataOrNull!;

        await dao.upsertCustomer(cust);
        await dao.createLoanAtomic(
          loan: loan,
          emis: store.emisForLoan(loan.id),
          disbursement: store.ledgerForLoan(loan.id).first,
        );

        final payRes = store.payAllPendingEmis(
          loanId: loan.id,
          paidDate: now.add(const Duration(days: 30)),
          languageCode: 'en',
        );
        final outcome = payRes.dataOrNull!;
        await dao.recordEmiPaymentAtomic(
          updatedLoan: outcome.loan,
          paidEmis: outcome.paidInstallments,
          ledgerEntries: outcome.createdLedgerEntries,
        );
        final doc = outcome.generatedDocument!;
        await dao.upsertDocument(doc);

        var loaded = await dao.loadAll();
        expect(loaded.loans.single.status, LoanStatus.completed);
        expect(
          loaded.emisByLoan[loan.id]!.every((e) => e.status == EmiStatus.paid),
          isTrue,
        );
        expect(loaded.ledger.length, 3);
        expect(loaded.documents.length, 1);
        expect(loaded.documents.single.id, doc.id);

        // Update document snapshot and verify single-row update.
        final updatedDoc = doc.copyWith(
          languageCode: 'hi',
          filePath: '/tmp/updated.pdf',
        );
        await dao.upsertDocument(updatedDoc);
        loaded = await dao.loadAll();
        expect(loaded.documents.length, 1);
        expect(loaded.documents.single.languageCode, 'hi');
        expect(loaded.documents.single.filePath, '/tmp/updated.pdf');

        // Delete document.
        await dao.deleteDocument(doc.id);
        loaded = await dao.loadAll();
        expect(loaded.documents, isEmpty);

        // Replace all via backup restore.
        await dao.replaceAllForRestore(
          profile: profile,
          customers: [cust],
          loans: [outcome.loan],
          emisByLoan: {loan.id: store.emisForLoan(loan.id)},
          ledger: store.ledgerForLoan(loan.id),
          documents: [updatedDoc],
        );
        loaded = await dao.loadAll();
        expect(loaded.documents.length, 1);
        expect(loaded.documents.single.languageCode, 'hi');
      },
    );
  });

  group('Real A4 PDF binary generation & pagination', () {
    LoanDocumentSnapshot makeSnapshot(int months) {
      final start = DateTime(2026, 1, 15);
      final calc = EmiCalculator.calculate(
        principalPaise: 12000000,
        monthlyRatePercent: 1.5,
        tenureMonths: months,
        loanType: LoanType.simple,
        startDate: start,
      );
      final installments = [
        for (int i = 0; i < calc.rows.length; i++)
          EmiScheduleItem(
            id: 'EMI-${3000 + i}',
            loanId: 'LN-2001',
            installmentNo: calc.rows[i].installmentNo,
            dueDate: calc.rows[i].dueDate,
            emiPaise: calc.rows[i].emiPaise,
            principalPartPaise: calc.rows[i].principalPartPaise,
            interestPartPaise: calc.rows[i].interestPartPaise,
            remainingBalancePaise: calc.rows[i].remainingBalancePaise,
            status: EmiStatus.paid,
            paidDate: calc.rows[i].dueDate,
          ),
      ];
      return LoanDocumentSnapshot(
        loanId: 'LN-2001',
        lenderName: 'Meera Patel',
        lenderMobile: '9822223333',
        lenderEmail: 'meera@loanwise.in',
        borrowerName: 'Ramesh Kumar',
        borrowerMobile: '9833334444',
        borrowerEmail: 'ramesh@example.com',
        borrowerLocation: 'Ahmedabad',
        principalPaise: 12000000,
        monthlyRatePercent: 1.5,
        tenureMonths: months,
        loanType: LoanType.simple,
        startDate: start,
        monthlyEmiPaise: calc.monthlyEmiPaise,
        totalInterestPaise: calc.totalInterestPaise,
        totalPayablePaise: calc.totalPayablePaise,
        statusText: 'Completed',
        schedule: installments,
      );
    }

    int countPdfPages(List<int> pdfBytes) {
      final text = latin1.decode(pdfBytes, allowInvalid: true);
      return RegExp(r'/Type\s*/Page(?![a-zA-Z])').allMatches(text).length;
    }

    test(
      'builds valid PDF bytes following 60 rows page 1 and 70 rows later pages',
      () async {
        for (final entry in <int, int>{
          1: 1,
          60: 1,
          61: 2,
          130: 2,
          131: 3,
        }.entries) {
          final snapshot = makeSnapshot(entry.key);
          final bytes = await LoanAgreementPdfService.buildPdfBytes(
            documentId: 'DOC-9001',
            snapshot: snapshot,
            languageCode: 'en',
            generatedAt: DateTime(2026, 6, 1),
          );
          expect(bytes.length, greaterThan(500));
          expect(ascii.decode(bytes.take(5).toList()), '%PDF-');
          expect(countPdfPages(bytes), entry.value);
        }
      },
    );

    test(
      'generateAndSavePdfFile writes real .pdf to disk and deletePdfFileIfExists cleans it up',
      () async {
        final snapshot = makeSnapshot(12);
        final now = DateTime(2026, 6, 1);
        final doc = LoanDocument(
          id: 'DOC-9999',
          loanId: 'LN-2001',
          customerMobile: snapshot.borrowerMobile,
          languageCode: 'en',
          title: 'Loan Agreement - LN-2001',
          snapshot: snapshot,
          htmlContent: LoanAgreementPdfService.buildDocumentHtml(
            documentId: 'DOC-9999',
            snapshot: snapshot,
            languageCode: 'en',
            generatedAt: now,
          ),
          pageCount: 1,
          renderPath: 'pending',
          createdAt: now,
          updatedAt: now,
        );

        final path = await LoanAgreementPdfService.generateAndSavePdfFile(doc);
        final file = File(path);
        expect(file.existsSync(), isTrue);
        final savedBytes = await file.readAsBytes();
        expect(ascii.decode(savedBytes.take(5).toList()), '%PDF-');

        await LoanAgreementPdfService.deletePdfFileIfExists(path);
        expect(file.existsSync(), isFalse);
      },
    );
  });

  group('End-to-end LoanWiseApp SQLite persistence across restarts', () {
    testWidgets(
      'persists customers, loans, paid EMIs, and Loan Agreement PDF across fresh app relaunch',
      (WidgetTester tester) async {
        SharedPreferences.setMockInitialValues(<String, Object>{});
        final prefs = await SharedPreferences.getInstance();
        final db = await AppDatabase.openInMemory();
        addTearDown(() async => db.close());

        final dao = LoanWiseDao(db);

        // Launch 1: Sign in, add customer, create loan, pay all EMIs -> PDF auto-generated.
        await tester.pumpWidget(
          LoanWiseApp(appDatabase: db, sharedPreferences: prefs),
        );
        await tester.pump(const Duration(milliseconds: 3500));
        await tester.pump(const Duration(milliseconds: 500));
        await tester.pump(const Duration(milliseconds: 400));

        await tester.tap(find.byKey(const ValueKey('onboarding_skip_button')));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 400));

        await tester.enterText(
          find.byKey(const ValueKey('login_name_field')),
          'Vikram Seth',
        );
        await tester.enterText(
          find.byKey(const ValueKey('login_mobile_field')),
          '9876543210',
        );
        await tester.enterText(
          find.byKey(const ValueKey('login_email_field')),
          'vikram@loanwise.in',
        );
        await tester.pump();
        final signInBtn = find.byKey(const ValueKey('login_sign_in_button'));
        await tester.ensureVisible(signInBtn);
        await tester.tap(signInBtn);
        await tester.pump(const Duration(milliseconds: 350));
        await tester.pumpAndSettle();

        // Add Customer.
        await tester.tap(find.byKey(const ValueKey('quick_action_0')));
        await tester.pumpAndSettle();
        await tester.enterText(
          find.byKey(const ValueKey('customer_name_field')),
          'Neha Kapoor',
        );
        await tester.enterText(
          find.byKey(const ValueKey('customer_email_field')),
          'neha@example.com',
        );
        await tester.enterText(
          find.byKey(const ValueKey('customer_mobile_field')),
          '9844455566',
        );
        await tester.enterText(
          find.byKey(const ValueKey('customer_location_field')),
          'Bengaluru',
        );
        await tester.pump();
        final saveCustBtn = find.byKey(const ValueKey('save_customer_button'));
        await tester.ensureVisible(saveCustBtn);
        await tester.tap(saveCustBtn);
        await tester.pumpAndSettle();

        // Create Loan from pop-up suggestion.
        await tester.tap(
          find.byKey(const ValueKey('customer_added_create_loan_button')),
        );
        await tester.pumpAndSettle();
        await tester.enterText(
          find.byKey(const ValueKey('create_loan_principal')),
          '60000',
        );
        await tester.enterText(
          find.byKey(const ValueKey('create_loan_rate')),
          '2',
        );
        await tester.enterText(
          find.byKey(const ValueKey('create_loan_tenure')),
          '3',
        );
        await tester.pump();
        final createLoanBtn =
            find.byKey(const ValueKey('create_loan_submit_button'));
        await tester.ensureVisible(createLoanBtn);
        await tester.tap(createLoanBtn);
        await tester.pumpAndSettle();

        await tester.tap(
          find.byKey(const ValueKey('dialog_open_loan_overview')),
        );
        await tester.pumpAndSettle();

        // Pay all pending EMIs -> marks Completed & generates Loan Agreement PDF.
        final payAllBtn = find.byKey(const ValueKey('pay_all_pending_button'));
        await tester.ensureVisible(payAllBtn);
        await tester.tap(payAllBtn);
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const ValueKey('confirm_pay_all_button')));
        await tester.pumpAndSettle();

        expect(find.text('Completed'), findsWidgets);

        // Give async DAO persistence + PDF file generation time to settle across real IO & FakeAsync microtasks.
        for (int i = 0; i < 4; i++) {
          await tester.runAsync(() async {
            await Future<void>.delayed(const Duration(milliseconds: 150));
          });
          await tester.pump();
        }

        final snapshotBeforeRestart = await tester.runAsync(() => dao.loadAll());
        expect(snapshotBeforeRestart, isNotNull);
        expect(snapshotBeforeRestart!.customers.length, 1);
        expect(snapshotBeforeRestart.loans.length, 1);
        expect(snapshotBeforeRestart.loans.single.status, LoanStatus.completed);
        expect(snapshotBeforeRestart.emisByLoan.values.single.length, 3);
        expect(snapshotBeforeRestart.documents.length, 1);

        final generatedFilePath = snapshotBeforeRestart.documents.single.filePath;
        if (generatedFilePath.isNotEmpty) {
          addTearDown(
            () => LoanAgreementPdfService.deletePdfFileIfExists(
              generatedFilePath,
            ),
          );
        }

        // Launch 2: Fresh LoanWiseApp reading from same SQLite DB & SharedPreferences.
        await tester.pumpWidget(Container());
        await tester.pump();
        await tester.pumpWidget(
          LoanWiseApp(appDatabase: db, sharedPreferences: prefs),
        );
        await tester.pump(const Duration(milliseconds: 3500));
        await tester.pump(const Duration(milliseconds: 500));
        await tester.pumpAndSettle();

        // Should skip Login and land directly on Dashboard with persisted customer/loan.
        expect(find.byKey(const ValueKey('login_name_field')), findsNothing);
        expect(find.text('Total Lent'), findsOneWidget);

        // Open Documents -> persisted PDF card for Neha Kapoor's mobile exists.
        final docsAction = find.byKey(const ValueKey('quick_action_3'));
        await tester.drag(
          find.byType(Scrollable).first,
          const Offset(0, -350),
        );
        await tester.pumpAndSettle();
        await tester.tap(docsAction);
        await tester.pumpAndSettle();
        expect(find.textContaining('9844455566'), findsWidgets);
        expect(find.textContaining('Loan Agreement'), findsWidgets);

        await tester.pageBack();
        await tester.pumpAndSettle();
        await tester.scrollUntilVisible(
          find.text('Neha Kapoor'),
          200,
          scrollable: find.byType(Scrollable).first,
        );
        expect(find.text('Neha Kapoor'), findsWidgets);
      },
    );

    testWidgets(
      'persists profile & customers via SharedPreferences fallback when appDatabase is null (Web runtime)',
      (WidgetTester tester) async {
        SharedPreferences.setMockInitialValues(<String, Object>{});
        final prefs = await SharedPreferences.getInstance();

        // Launch 1 (no SQLite DB, just SharedPreferences — matches Flutter Web startup)
        await tester.pumpWidget(LoanWiseApp(sharedPreferences: prefs));
        await tester.pump(const Duration(milliseconds: 3500));
        await tester.pump(const Duration(milliseconds: 500));
        await tester.pump(const Duration(milliseconds: 400));

        await tester.tap(find.byKey(const ValueKey('onboarding_skip_button')));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 400));

        await tester.enterText(
          find.byKey(const ValueKey('login_name_field')),
          'Ananya Roy',
        );
        await tester.enterText(
          find.byKey(const ValueKey('login_mobile_field')),
          '9876543210',
        );
        await tester.enterText(
          find.byKey(const ValueKey('login_email_field')),
          'ananya@loanwise.in',
        );
        await tester.pump();
        final signInBtn = find.byKey(const ValueKey('login_sign_in_button'));
        await tester.ensureVisible(signInBtn);
        await tester.tap(signInBtn);
        await tester.pump(const Duration(milliseconds: 350));
        await tester.pumpAndSettle();

        expect(prefs.getBool('loanwise_web_signed_in'), isTrue);
        expect(prefs.getString('loanwise_web_store_json'), isNotNull);

        // Launch 2 (fresh widget tree reading from SharedPreferences only)
        await tester.pumpWidget(Container());
        await tester.pump();
        await tester.pumpWidget(LoanWiseApp(sharedPreferences: prefs));
        await tester.pump(const Duration(milliseconds: 3500));
        await tester.pump(const Duration(milliseconds: 500));
        await tester.pumpAndSettle();

        expect(find.byKey(const ValueKey('login_name_field')), findsNothing);
        expect(find.textContaining('Ananya Roy'), findsOneWidget);
      },
    );
  });
}
