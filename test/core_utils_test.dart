import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:loan_management_app/core/error/failures.dart';
import 'package:loan_management_app/core/utils/date_utils.dart';
import 'package:loan_management_app/core/utils/emi_calculator.dart';
import 'package:loan_management_app/core/utils/indian_currency_formatter.dart';
import 'package:loan_management_app/core/utils/validators.dart';
import 'package:loan_management_app/data/repositories/loanwise_store.dart';
import 'package:loan_management_app/domain/models/loan_models.dart';
import 'package:loan_management_app/l10n/supported_languages.dart';
import 'package:loan_management_app/services/loan_agreement_pdf_service.dart';

void main() {
  group('ARB localization completeness', () {
    test('all 13 ARB files contain identical translation keys', () {
      final enMap = jsonDecode(
        File('lib/l10n/app_en.arb').readAsStringSync(),
      ) as Map<String, dynamic>;
      final enKeys = enMap.keys
          .where((k) => !k.startsWith('@'))
          .toSet();

      expect(kSupportedLanguageOptions.length, 13);
      for (final option in kSupportedLanguageOptions) {
        final code = option.locale.languageCode;
        final file = File('lib/l10n/app_$code.arb');
        expect(file.existsSync(), isTrue, reason: 'Missing app_$code.arb');
        final map = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
        final keys = map.keys.where((k) => !k.startsWith('@')).toSet();
        expect(
          keys,
          equals(enKeys),
          reason: 'Key mismatch in app_$code.arb',
        );
      }
    });
  });

  group('IndianCurrencyFormatter', () {
    test('formats lakh and crore amounts and integer paise cleanly', () {
      expect(IndianCurrencyFormatter.format(0), '₹0.00');
      expect(IndianCurrencyFormatter.format(999), '₹999.00');
      expect(IndianCurrencyFormatter.format(1000), '₹1,000.00');
      expect(IndianCurrencyFormatter.format(99999), '₹99,999.00');
      expect(IndianCurrencyFormatter.format(100000), '₹1,00,000.00');
      expect(IndianCurrencyFormatter.format(2456280.00), '₹24,56,280.00');
      expect(IndianCurrencyFormatter.formatPaise(245628000), '₹24,56,280.00');
      expect(
        IndianCurrencyFormatter.format(250000, decimals: 0),
        '₹2,50,000',
      );
    });
  });

  group('Validators', () {
    test('validates login and customer/loan fields', () {
      expect(LoginValidators.validateName(''), NameValidationError.required);
      expect(LoginValidators.validateName('Alex Johnson'), isNull);
      expect(
        LoginValidators.validateMobile('5876543210'),
        MobileValidationError.invalid,
      );
      expect(LoginValidators.validateMobile('9876543210'), isNull);
      expect(LoginValidators.validateEmail(''), isNull);
      expect(
        LoginValidators.validateEmail('', required: true),
        EmailValidationError.invalid,
      );
      expect(
        LoginValidators.validateEmail('user@domain'),
        EmailValidationError.invalid,
      );
      expect(LoginValidators.validateEmail('alex@loanwise.in'), isNull);
      expect(
        LoanValidators.validateLocation(' '),
        LocationValidationError.required,
      );
      expect(LoanValidators.validateLocation('Pune'), isNull);
      expect(
        LoanValidators.validatePrincipalText('0'),
        PrincipalValidationError.invalid,
      );
      expect(LoanValidators.parsePrincipalPaise('10000'), 1000000);
      expect(
        LoanValidators.validateRateText('105'),
        RateValidationError.invalid,
      );
      expect(LoanValidators.parseRatePercent('2.5'), 2.5);
      expect(
        LoanValidators.validateTenureText('601'),
        TenureValidationError.invalid,
      );
      expect(LoanValidators.parseTenureMonths('600'), 600);
    });
  });

  group('LoanDateUtils', () {
    test('clamps month-end due dates across Feb and 30-day months', () {
      final jan31 = DateTime.utc(2025, 1, 31);
      expect(
        LoanDateUtils.addMonthsClamped(jan31, 1),
        DateTime.utc(2025, 2, 28),
      );
      expect(
        LoanDateUtils.addMonthsClamped(DateTime.utc(2024, 1, 31), 1),
        DateTime.utc(2024, 2, 29),
      );
      expect(
        LoanDateUtils.addMonthsClamped(DateTime.utc(2026, 8, 31), 1),
        DateTime.utc(2026, 9, 30),
      );
    });

    test('computes overdue dynamically without storing it', () {
      final today = DateTime.utc(2026, 5, 10);
      expect(
        LoanDateUtils.isOverdueEmi(
          dueDate: DateTime.utc(2026, 5, 9),
          isPaid: false,
          now: today,
        ),
        isTrue,
      );
      expect(
        LoanDateUtils.isOverdueEmi(
          dueDate: DateTime.utc(2026, 5, 9),
          isPaid: true,
          now: today,
        ),
        isFalse,
      );
      expect(
        LoanDateUtils.isOverdueEmi(
          dueDate: DateTime.utc(2026, 5, 10),
          isPaid: false,
          now: today,
        ),
        isFalse,
      );
    });
  });

  group('EmiCalculator', () {
    test('simple interest puts rounding leftover in final row and sums exactly',
        () {
      final res = EmiCalculator.calculate(
        principalPaise: 1000001, // ₹10,000.01
        monthlyRatePercent: 2.0,
        tenureMonths: 7,
        loanType: LoanType.simple,
        startDate: DateTime.utc(2026, 1, 15),
      );
      expect(res.rows.length, 7);
      final sumEmis = res.rows.fold<int>(0, (s, r) => s + r.emiPaise);
      final sumPrincipal =
          res.rows.fold<int>(0, (s, r) => s + r.principalPartPaise);
      expect(sumEmis, res.totalPayablePaise);
      expect(sumPrincipal, 1000001);
      expect(res.rows.last.remainingBalancePaise, 0);
    });

    test('compound reducing balance and zero rate sum exactly', () {
      final compound = EmiCalculator.calculate(
        principalPaise: 5000000,
        monthlyRatePercent: 2.5,
        tenureMonths: 12,
        loanType: LoanType.compound,
        startDate: DateTime.utc(2026, 1, 10),
      );
      expect(compound.rows.length, 12);
      expect(
        compound.rows.fold<int>(0, (s, r) => s + r.principalPartPaise),
        5000000,
      );
      expect(
        compound.rows.fold<int>(0, (s, r) => s + r.emiPaise),
        compound.totalPayablePaise,
      );
      expect(compound.rows.last.remainingBalancePaise, 0);

      final zeroRate = EmiCalculator.calculate(
        principalPaise: 100000,
        monthlyRatePercent: 0.0,
        tenureMonths: 3,
        loanType: LoanType.compound,
        startDate: DateTime.utc(2026, 1, 10),
      );
      expect(zeroRate.totalInterestPaise, 0);
      expect(zeroRate.totalPayablePaise, 100000);
      expect(zeroRate.rows.fold<int>(0, (s, r) => s + r.emiPaise), 100000);
    });

    test('supports max 600-month schedule with exact reconciliation', () {
      final res = EmiCalculator.calculate(
        principalPaise: 100000000,
        monthlyRatePercent: 1.0,
        tenureMonths: 600,
        loanType: LoanType.compound,
        startDate: DateTime.utc(2026, 1, 31),
      );
      expect(res.rows.length, 600);
      expect(res.rows.last.remainingBalancePaise, 0);
      expect(
        res.rows.fold<int>(0, (s, r) => s + r.emiPaise),
        res.totalPayablePaise,
      );
    });
  });

  group('LoanWiseStore transactions & rules', () {
    test('enforces duplicate mobile, active-loan delete block, and rollback',
        () {
      final store = LoanWiseStore.empty(isSignedIn: true);
      final cRes = store.createCustomer(
        name: 'Asha Mehta',
        email: 'asha@example.in',
        mobile: '9811112222',
        location: 'Surat',
      );
      final customer = (cRes as Success<Customer>).data;

      // Duplicate mobile rejected.
      final dup = store.createCustomer(
        name: 'Duplicate Asha',
        email: 'dup@example.in',
        mobile: '9811112222',
        location: 'Surat',
      );
      expect(dup.failureOrNull?.type, FailureType.duplicateMobile);

      // Atomic rollback on simulated mid-transaction error.
      final rolledBack = store.createLoan(
        customerId: customer.id,
        principalPaise: 5000000,
        monthlyRatePercent: 2.0,
        tenureMonths: 4,
        type: LoanType.simple,
        startDate: DateTime.utc(2026, 1, 10),
        beforeCommitHook: () => throw StateError('disk full'),
      );
      expect(rolledBack.failureOrNull?.type, FailureType.database);
      expect(store.loans, isEmpty);
      expect(store.allLedgerEntries, isEmpty);

      // Valid loan creation.
      final loanRes = store.createLoan(
        customerId: customer.id,
        principalPaise: 5000000,
        monthlyRatePercent: 2.0,
        tenureMonths: 3,
        type: LoanType.simple,
        startDate: DateTime.utc(2026, 1, 10),
      );
      final loan = (loanRes as Success<Loan>).data;
      expect(store.emisForLoan(loan.id).length, 3);

      // Deleting customer with active loan is blocked.
      final delBlocked = store.deleteCustomer(customer.id);
      expect(delBlocked.failureOrNull?.type, FailureType.activeLoan);

      // Out-of-order EMI payment is rejected.
      final emis = store.emisForLoan(loan.id);
      final outOfOrder = store.markEmiPaid(
        loanId: loan.id,
        emiId: emis[1].id,
        paidDate: DateTime.utc(2026, 2, 10),
      );
      expect(outOfOrder.failureOrNull?.type, FailureType.outOfOrderEmi);

      // Pay first EMI -> generates EMI #1 receipt PDF; then pay all remaining -> completes loan + ledger balance 0 + Complete Loan PDF.
      final pay1 = store.markEmiPaid(
        loanId: loan.id,
        emiId: emis[0].id,
        paidDate: DateTime.utc(2026, 2, 10),
      );
      expect(pay1.isSuccess, isTrue);
      final pay1Outcome = (pay1 as Success<LoanPaymentOutcome>).data;
      expect(pay1Outcome.emiReceiptDocument, isNotNull);
      expect(pay1Outcome.emiReceiptDocument!.emiInstallmentNo, 1);

      final payAll = store.payAllPendingEmis(
        loanId: loan.id,
        paidDate: DateTime.utc(2026, 2, 12),
      );
      final outcome = (payAll as Success<LoanPaymentOutcome>).data;
      expect(outcome.loan.status, LoanStatus.completed);
      expect(outcome.generatedDocument, isNotNull);
      expect(outcome.generatedDocument!.emiInstallmentNo, isNull);
      expect(store.currentCustomerLedgerBalance(customer.id), 0);

      // Now delete succeeds (soft delete), and mobile becomes reusable.
      final delOk = store.deleteCustomer(customer.id);
      expect(delOk.isSuccess, isTrue);
      final recreate = store.createCustomer(
        name: 'New Owner',
        email: 'new@example.in',
        mobile: '9811112222',
        location: 'Surat',
      );
      expect(recreate.isSuccess, isTrue);
    });

    test('PDF generation failure preserves paid EMIs cleanly', () {
      final store = LoanWiseStore.empty(isSignedIn: true);
      final customer = (store.createCustomer(
        name: 'Kiran Rao',
        email: 'kiran@example.in',
        mobile: '9822334455',
        location: 'Hyderabad',
      ) as Success<Customer>)
          .data;
      final loan = (store.createLoan(
        customerId: customer.id,
        principalPaise: 1000000,
        monthlyRatePercent: 1.0,
        tenureMonths: 2,
        type: LoanType.simple,
        startDate: DateTime.utc(2026, 1, 5),
      ) as Success<Loan>)
          .data;

      final res = store.payAllPendingEmis(
        loanId: loan.id,
        paidDate: DateTime.utc(2026, 1, 20),
        simulatePdfFailure: true,
      );
      final outcome = (res as Success<LoanPaymentOutcome>).data;
      expect(outcome.loan.status, LoanStatus.completed);
      expect(outcome.pdfFailure?.type, FailureType.pdf);
      expect(store.documents, isEmpty);

      final retry = store.generateDocumentForLoan(loanId: loan.id);
      expect(retry.isSuccess, isTrue);
      expect(store.documents.length, 1);
    });

    test(
      'paying installment 4 generates PDF containing cumulative installments 1..4 without blank email lines',
      () {
        final store = LoanWiseStore.empty(
          isSignedIn: true,
          profile: const LenderProfile(
            name: 'Sita Devi',
            mobile: '9812345678',
            email: '',
          ),
        );
        final customer = (store.createCustomer(
          name: 'Ravi Verma',
          email: '',
          mobile: '9876501122',
          location: 'Jaipur',
        ) as Success<Customer>)
            .data;
        final loan = (store.createLoan(
          customerId: customer.id,
          principalPaise: 6000000,
          monthlyRatePercent: 2.0,
          tenureMonths: 6,
          type: LoanType.simple,
          startDate: DateTime.utc(2026, 1, 10),
        ) as Success<Loan>)
            .data;

        final emis = store.emisForLoan(loan.id);
        late LoanDocument doc4;
        for (int i = 0; i < 4; i++) {
          final payRes = store.markEmiPaid(
            loanId: loan.id,
            emiId: emis[i].id,
            paidDate: DateTime.utc(2026, 2 + i, 10),
          );
          expect(payRes.isSuccess, isTrue);
          doc4 = (payRes as Success<LoanPaymentOutcome>)
              .data
              .emiReceiptDocument!;
        }

        expect(doc4.emiInstallmentNo, 4);
        expect(
          doc4.snapshot.schedule.map((e) => e.installmentNo).toList(),
          [1, 2, 3, 4],
        );
        expect(
          doc4.snapshot.schedule.every((e) => e.isPaid),
          isTrue,
        );
        expect(doc4.pageCount, 1);
        expect(doc4.htmlContent.contains('Email:'), isFalse);
        for (int no = 1; no <= 4; no++) {
          expect(doc4.htmlContent.contains('<tr><td>$no</td>'), isTrue);
        }
        expect(doc4.htmlContent.contains('<tr><td>5</td>'), isFalse);
      },
    );
  });

  group('LoanAgreementPdfService pagination & HTML', () {
    test('paginates 25 -> [25] and 200 -> [60, 70, 70] with RTL Urdu support',
        () {
      final calc200 = EmiCalculator.calculate(
        principalPaise: 20000000,
        monthlyRatePercent: 1.0,
        tenureMonths: 200,
        loanType: LoanType.simple,
        startDate: DateTime.utc(2026, 1, 1),
      );
      final schedule200 = calc200.rows
          .map(
            (r) => EmiScheduleItem(
              id: 'E-${r.installmentNo}',
              loanId: 'LN-200',
              installmentNo: r.installmentNo,
              dueDate: r.dueDate,
              emiPaise: r.emiPaise,
              principalPartPaise: r.principalPartPaise,
              interestPartPaise: r.interestPartPaise,
              remainingBalancePaise: r.remainingBalancePaise,
              status: EmiStatus.paid,
              paidDate: r.dueDate,
            ),
          )
          .toList();

      final pages25 = LoanAgreementPdfService.paginateInstallments(
        schedule200.take(25).toList(),
      );
      expect(pages25.map((p) => p.length).toList(), [25]);

      final pages200 = LoanAgreementPdfService.paginateInstallments(schedule200);
      expect(pages200.map((p) => p.length).toList(), [60, 70, 70]);

      final snap = LoanDocumentSnapshot(
        lenderName: 'Alex Johnson',
        lenderMobile: '9876543210',
        lenderEmail: 'alex@loanwise.in',
        borrowerName: 'Zoya Khan',
        borrowerMobile: '9812345678',
        borrowerEmail: 'zoya@example.in',
        borrowerLocation: 'Lucknow',
        loanId: 'LN-200',
        principalPaise: 20000000,
        monthlyRatePercent: 1.0,
        tenureMonths: 200,
        loanType: LoanType.simple,
        startDate: DateTime.utc(2026, 1, 1),
        monthlyEmiPaise: calc200.monthlyEmiPaise,
        totalInterestPaise: calc200.totalInterestPaise,
        totalPayablePaise: calc200.totalPayablePaise,
        statusText: 'Paid',
        schedule: schedule200,
      );

      final htmlEn = LoanAgreementPdfService.buildDocumentHtml(
        documentId: 'DOC-1',
        snapshot: snap,
        languageCode: 'en',
        generatedAt: DateTime.utc(2026, 2, 1, 10, 30),
      );
      expect(htmlEn.contains('data-page="1"'), isTrue);
      expect(htmlEn.contains('data-page="2"'), isTrue);
      expect(htmlEn.contains('data-page="3"'), isTrue);
      expect(
        htmlEn.indexOf('data-role="lender"'),
        lessThan(htmlEn.indexOf('data-role="borrower"')),
      );
      expect(htmlEn.contains('John Doe'), isFalse);

      final htmlUr = LoanAgreementPdfService.buildDocumentHtml(
        documentId: 'DOC-1',
        snapshot: snap,
        languageCode: 'ur',
        generatedAt: DateTime.utc(2026, 2, 1, 10, 30),
      );
      expect(htmlUr.contains('dir="rtl"'), isTrue);
      expect(htmlUr.contains('Noto Naskh Arabic'), isTrue);
    });
  });
}
