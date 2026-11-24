import 'dart:convert';

import 'package:loan_management_app/core/error/failures.dart';
import 'package:loan_management_app/core/utils/date_utils.dart';
import 'package:loan_management_app/core/utils/emi_calculator.dart';
import 'package:loan_management_app/core/utils/indian_currency_formatter.dart';
import 'package:loan_management_app/core/utils/validators.dart';
import 'package:loan_management_app/domain/models/loan_models.dart';
import 'package:loan_management_app/services/loan_agreement_pdf_service.dart';

class LoanPaymentOutcome {
  const LoanPaymentOutcome({
    required this.loan,
    required this.paidInstallments,
    required this.loanJustCompleted,
    this.generatedDocument,
    this.emiReceiptDocument,
    this.pdfFailure,
    this.createdLedgerEntries = const [],
  });

  final Loan loan;
  final List<EmiScheduleItem> paidInstallments;
  final bool loanJustCompleted;
  final LoanDocument? generatedDocument;
  final LoanDocument? emiReceiptDocument;
  final AppFailure? pdfFailure;
  final List<LedgerEntry> createdLedgerEntries;
}

class LoanWiseStore {
  LoanWiseStore._(
    this._profile,
    this._isSignedIn,
  );

  factory LoanWiseStore.empty({
    LenderProfile? profile,
    bool isSignedIn = false,
  }) {
    return LoanWiseStore._(
      profile ??
          const LenderProfile(
            name: '',
            mobile: '',
            email: '',
          ),
      isSignedIn,
    );
  }

  LenderProfile _profile;
  bool _isSignedIn;
  int _idSeq = 1000;

  final List<Customer> _customers = [];
  final List<Loan> _loans = [];
  final Map<String, List<EmiScheduleItem>> _emisByLoan = {};
  final List<LedgerEntry> _ledger = [];
  final List<LoanDocument> _documents = [];

  LenderProfile get profile => _profile;
  bool get isSignedIn => _isSignedIn;

  List<Customer> get activeCustomers {
    final list = _customers.where((c) => !c.isDeleted).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return List.unmodifiable(list);
  }

  List<Customer> get allCustomersIncludingDeleted =>
      List.unmodifiable(_customers);

  List<Loan> get loans {
    final list = List<Loan>.from(_loans)
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return List.unmodifiable(list);
  }

  List<LoanDocument> get documents {
    final list = List<LoanDocument>.from(_documents)
      ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return List.unmodifiable(list);
  }

  List<LedgerEntry> get allLedgerEntries => List.unmodifiable(_ledger);

  Map<String, List<EmiScheduleItem>> get allEmisByLoan => Map.unmodifiable({
        for (final entry in _emisByLoan.entries)
          entry.key: List<EmiScheduleItem>.unmodifiable(entry.value),
      });

  void hydrateFromSnapshot({
    required List<Customer> customers,
    required List<Loan> loans,
    required Map<String, List<EmiScheduleItem>> emisByLoan,
    required List<LedgerEntry> ledger,
    required List<LoanDocument> documents,
    required int maxIdSeq,
  }) {
    _customers
      ..clear()
      ..addAll(customers);
    _loans
      ..clear()
      ..addAll(loans);
    _emisByLoan
      ..clear()
      ..addAll({
        for (final entry in emisByLoan.entries)
          entry.key: List<EmiScheduleItem>.from(entry.value),
      });
    _ledger
      ..clear()
      ..addAll(ledger);
    _documents
      ..clear()
      ..addAll(documents);
    if (maxIdSeq > _idSeq) {
      _idSeq = maxIdSeq;
    }
  }

  LoanDocument? updateDocumentPaths({
    required String documentId,
    required String filePath,
    String? renderPath,
  }) {
    final index = _documents.indexWhere((d) => d.id == documentId);
    if (index == -1) return null;
    final updated = _documents[index].copyWith(
      filePath: filePath,
      renderPath: renderPath ?? (filePath.isNotEmpty ? filePath : null),
    );
    _documents[index] = updated;
    return updated;
  }

  String _nextId(String prefix) {
    _idSeq++;
    return '$prefix-$_idSeq';
  }

  Customer? findCustomerById(String id) {
    for (final c in _customers) {
      if (c.id == id && !c.isDeleted) return c;
    }
    return null;
  }

  Customer? findCustomerAnyById(String id) {
    for (final c in _customers) {
      if (c.id == id) return c;
    }
    return null;
  }

  Customer? findCustomerByMobile(String mobile) {
    final clean = mobile.trim();
    for (final c in _customers) {
      if (c.mobile == clean && !c.isDeleted) return c;
    }
    return null;
  }

  Loan? findLoanById(String loanId) {
    for (final l in _loans) {
      if (l.id == loanId) return l;
    }
    return null;
  }

  LoanDocument? findDocumentById(String docId) {
    for (final d in _documents) {
      if (d.id == docId) return d;
    }
    return null;
  }

  List<Loan> loansForCustomer(String customerId) {
    final list = _loans.where((l) => l.customerId == customerId).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return List.unmodifiable(list);
  }

  int activeLoansCountForCustomer(String customerId) {
    return _loans
        .where((l) => l.customerId == customerId && l.status == LoanStatus.active)
        .length;
  }

  bool hasAnyLoans(String customerId) {
    return _loans.any((l) => l.customerId == customerId);
  }

  List<EmiScheduleItem> emisForLoan(String loanId) {
    return List.unmodifiable(_emisByLoan[loanId] ?? const []);
  }

  List<LedgerEntry> ledgerForLoan(String loanId) {
    return List.unmodifiable(
      _ledger.where((e) => e.loanId == loanId).toList(),
    );
  }

  int currentLoanLedgerBalance(String loanId) {
    final entries = _ledger.where((e) => e.loanId == loanId).toList();
    if (entries.isEmpty) return 0;
    return entries.last.balanceAfterPaise;
  }

  int currentCustomerLedgerBalance(String customerId) {
    final entries = _ledger.where((e) => e.customerId == customerId).toList();
    if (entries.isEmpty) return 0;
    return entries.last.balanceAfterPaise;
  }

  void setSignedIn(LenderProfile profile) {
    final now = DateTime.now().toUtc();
    _profile = profile.copyWith(
      createdAt: _profile.createdAt ?? now,
      updatedAt: now,
    );
    _isSignedIn = true;
  }

  void updateProfile(LenderProfile updated) {
    _profile = updated.copyWith(
      createdAt: _profile.createdAt ?? DateTime.now().toUtc(),
      updatedAt: DateTime.now().toUtc(),
    );
  }

  void signOut() {
    _isSignedIn = false;
  }

  T _runAtomic<T>(T Function() action) {
    final prevSeq = _idSeq;
    final prevCustomers = List<Customer>.from(_customers);
    final prevLoans = List<Loan>.from(_loans);
    final prevEmis = {
      for (final entry in _emisByLoan.entries)
        entry.key: List<EmiScheduleItem>.from(entry.value),
    };
    final prevLedger = List<LedgerEntry>.from(_ledger);
    final prevDocs = List<LoanDocument>.from(_documents);

    try {
      return action();
    } catch (_) {
      _idSeq = prevSeq;
      _customers
        ..clear()
        ..addAll(prevCustomers);
      _loans
        ..clear()
        ..addAll(prevLoans);
      _emisByLoan
        ..clear()
        ..addAll(prevEmis);
      _ledger
        ..clear()
        ..addAll(prevLedger);
      _documents
        ..clear()
        ..addAll(prevDocs);
      rethrow;
    }
  }

  Result<Customer> createCustomer({
    required String name,
    required String email,
    required String mobile,
    required String location,
    DateTime? createdAt,
  }) {
    final cleanName = name.trim();
    final cleanEmail = email.trim();
    final cleanMobile = mobile.trim();
    final cleanLocation = location.trim();

    if (LoginValidators.validateName(cleanName) != null) {
      return const Err(
        AppFailure(
          type: FailureType.validation,
          messageKey: 'errorNameRequired',
        ),
      );
    }
    if (LoginValidators.validateMobile(cleanMobile) != null) {
      return const Err(
        AppFailure(
          type: FailureType.validation,
          messageKey: 'errorMobileInvalid',
        ),
      );
    }
    if (LoginValidators.validateEmail(cleanEmail) != null) {
      return const Err(
        AppFailure(
          type: FailureType.validation,
          messageKey: 'errorEmailInvalid',
        ),
      );
    }
    if (LoanValidators.validateLocation(cleanLocation) != null) {
      return const Err(
        AppFailure(
          type: FailureType.validation,
          messageKey: 'locationRequiredError',
        ),
      );
    }
    if (findCustomerByMobile(cleanMobile) != null) {
      return const Err(
        AppFailure(
          type: FailureType.duplicateMobile,
          messageKey: 'duplicateMobileError',
        ),
      );
    }

    final now = createdAt ?? DateTime.now().toUtc();
    final customer = Customer(
      id: _nextId('CUS'),
      name: cleanName,
      email: cleanEmail,
      mobile: cleanMobile,
      location: cleanLocation,
      createdAt: now,
      updatedAt: now,
    );
    _customers.add(customer);
    return Success(customer);
  }

  Result<Customer> updateCustomer({
    required String customerId,
    required String name,
    required String email,
    required String mobile,
    required String location,
  }) {
    final index = _customers.indexWhere((c) => c.id == customerId && !c.isDeleted);
    if (index == -1) {
      return const Err(
        AppFailure(
          type: FailureType.notFound,
          messageKey: 'noCustomersTitle',
        ),
      );
    }
    final existing = _customers[index];
    final cleanName = name.trim();
    final cleanEmail = email.trim();
    final cleanMobile = mobile.trim();
    final cleanLocation = location.trim();

    if (LoginValidators.validateName(cleanName) != null) {
      return const Err(
        AppFailure(
          type: FailureType.validation,
          messageKey: 'errorNameRequired',
        ),
      );
    }
    if (LoginValidators.validateMobile(cleanMobile) != null) {
      return const Err(
        AppFailure(
          type: FailureType.validation,
          messageKey: 'errorMobileInvalid',
        ),
      );
    }
    if (LoginValidators.validateEmail(cleanEmail) != null) {
      return const Err(
        AppFailure(
          type: FailureType.validation,
          messageKey: 'errorEmailInvalid',
        ),
      );
    }
    if (LoanValidators.validateLocation(cleanLocation) != null) {
      return const Err(
        AppFailure(
          type: FailureType.validation,
          messageKey: 'locationRequiredError',
        ),
      );
    }

    if (cleanMobile != existing.mobile && hasAnyLoans(customerId)) {
      return const Err(
        AppFailure(
          type: FailureType.validation,
          messageKey: 'mobileLockedHelper',
        ),
      );
    }

    final duplicate = _customers.any(
      (c) => c.id != customerId && !c.isDeleted && c.mobile == cleanMobile,
    );
    if (duplicate) {
      return const Err(
        AppFailure(
          type: FailureType.duplicateMobile,
          messageKey: 'duplicateMobileError',
        ),
      );
    }

    final updated = existing.copyWith(
      name: cleanName,
      email: cleanEmail,
      mobile: cleanMobile,
      location: cleanLocation,
      updatedAt: DateTime.now().toUtc(),
    );
    _customers[index] = updated;
    return Success(updated);
  }

  Result<Customer> deleteCustomer(String customerId) {
    final index = _customers.indexWhere((c) => c.id == customerId && !c.isDeleted);
    if (index == -1) {
      return const Err(
        AppFailure(
          type: FailureType.notFound,
          messageKey: 'noCustomersTitle',
        ),
      );
    }
    if (activeLoansCountForCustomer(customerId) > 0) {
      return const Err(
        AppFailure(
          type: FailureType.activeLoan,
          messageKey: 'activeLoanDeleteBlocked',
        ),
      );
    }
    final now = DateTime.now().toUtc();
    final deleted = _customers[index].copyWith(
      deletedAt: now,
      updatedAt: now,
    );
    _customers[index] = deleted;
    return Success(deleted);
  }

  Result<Loan> createLoan({
    required String customerId,
    required int principalPaise,
    required double monthlyRatePercent,
    required int tenureMonths,
    required LoanType type,
    required DateTime startDate,
    DateTime? createdAt,
    void Function()? beforeCommitHook,
  }) {
    if (principalPaise <= 0) {
      return const Err(
        AppFailure(
          type: FailureType.validation,
          messageKey: 'invalidPrincipalError',
        ),
      );
    }
    if (monthlyRatePercent < 0 || monthlyRatePercent > 100) {
      return const Err(
        AppFailure(
          type: FailureType.validation,
          messageKey: 'invalidRateError',
        ),
      );
    }
    if (tenureMonths < 1 || tenureMonths > 600) {
      return const Err(
        AppFailure(
          type: FailureType.validation,
          messageKey: 'invalidTenureError',
        ),
      );
    }

    try {
      return _runAtomic<Result<Loan>>(() {
        final customer = findCustomerById(customerId);
        if (customer == null) {
          return const Err(
            AppFailure(
              type: FailureType.notFound,
              messageKey: 'selectCustomerError',
            ),
          );
        }

        final utcStart = LoanDateUtils.toUtcMidnight(startDate);
        final calc = EmiCalculator.calculate(
          principalPaise: principalPaise,
          monthlyRatePercent: monthlyRatePercent,
          tenureMonths: tenureMonths,
          loanType: type,
          startDate: utcStart,
        );

        final loanId = _nextId('LN');
        final now = createdAt ?? DateTime.now().toUtc();

        final loan = Loan(
          id: loanId,
          customerId: customerId,
          principalPaise: principalPaise,
          monthlyRatePercent: monthlyRatePercent,
          tenureMonths: tenureMonths,
          type: type,
          startDate: utcStart,
          status: LoanStatus.active,
          totalPayablePaise: calc.totalPayablePaise,
          totalInterestPaise: calc.totalInterestPaise,
          monthlyEmiPaise: calc.monthlyEmiPaise,
          createdAt: now,
        );

        final emiItems = calc.rows
            .map(
              (r) => EmiScheduleItem(
                id: _nextId('EMI'),
                loanId: loanId,
                installmentNo: r.installmentNo,
                dueDate: r.dueDate,
                emiPaise: r.emiPaise,
                principalPartPaise: r.principalPartPaise,
                interestPartPaise: r.interestPartPaise,
                remainingBalancePaise: r.remainingBalancePaise,
                status: EmiStatus.pending,
              ),
            )
            .toList();

        final prevBalance = currentCustomerLedgerBalance(customerId);
        final ledgerEntry = LedgerEntry(
          id: _nextId('LDG'),
          customerId: customerId,
          loanId: loanId,
          kind: LedgerKind.disbursement,
          debitPaise: calc.totalPayablePaise,
          creditPaise: 0,
          balanceAfterPaise: prevBalance + calc.totalPayablePaise,
          createdAt: now,
        );

        _loans.add(loan);
        _emisByLoan[loanId] = emiItems;
        _ledger.add(ledgerEntry);

        if (beforeCommitHook != null) {
          beforeCommitHook();
        }

        return Success(loan);
      });
    } catch (e) {
      return Err(
        AppFailure(
          type: FailureType.database,
          messageKey: 'database',
          detail: e.toString(),
        ),
      );
    }
  }

  Result<LoanPaymentOutcome> markEmiPaid({
    required String loanId,
    required String emiId,
    required DateTime paidDate,
    String languageCode = 'en',
    void Function()? beforeCommitHook,
  }) {
    late Result<LoanPaymentOutcome> txResult;
    try {
      txResult = _runAtomic<Result<LoanPaymentOutcome>>(() {
        final loanIndex = _loans.indexWhere((l) => l.id == loanId);
        if (loanIndex == -1) {
          return const Err(
            AppFailure(
              type: FailureType.notFound,
              messageKey: 'noLoansTitle',
            ),
          );
        }
        final schedule = _emisByLoan[loanId];
        if (schedule == null) {
          return const Err(
            AppFailure(
              type: FailureType.notFound,
              messageKey: 'noLoansTitle',
            ),
          );
        }
        final emiIndex = schedule.indexWhere((e) => e.id == emiId);
        if (emiIndex == -1) {
          return const Err(
            AppFailure(
              type: FailureType.notFound,
              messageKey: 'noLoansTitle',
            ),
          );
        }
        final target = schedule[emiIndex];
        if (target.isPaid) {
          return const Err(
            AppFailure(
              type: FailureType.alreadyPaid,
              messageKey: 'statusPaid',
            ),
          );
        }

        // Enforce strict in-order rule.
        final hasEarlierPending = schedule.any(
          (item) =>
              item.installmentNo < target.installmentNo && !item.isPaid,
        );
        if (hasEarlierPending) {
          return const Err(
            AppFailure(
              type: FailureType.outOfOrderEmi,
              messageKey: 'outOfOrderEmiError',
            ),
          );
        }

        final utcPaid = LoanDateUtils.toUtcMidnight(paidDate);
        final updatedItem = target.copyWith(
          status: EmiStatus.paid,
          paidDate: utcPaid,
        );
        schedule[emiIndex] = updatedItem;

        final loan = _loans[loanIndex];
        final prevBalance = currentCustomerLedgerBalance(loan.customerId);
        final nextBalance =
            (prevBalance - updatedItem.emiPaise).clamp(0, 1 << 62);
        final ledgerEntry = LedgerEntry(
          id: _nextId('LDG'),
          customerId: loan.customerId,
          loanId: loanId,
          kind: LedgerKind.payment,
          debitPaise: 0,
          creditPaise: updatedItem.emiPaise,
          balanceAfterPaise: nextBalance,
          createdAt: DateTime.now().toUtc(),
        );
        _ledger.add(ledgerEntry);

        final allPaid = schedule.every((e) => e.isPaid);
        final updatedLoan = allPaid
            ? loan.copyWith(status: LoanStatus.completed)
            : loan;
        _loans[loanIndex] = updatedLoan;

        if (beforeCommitHook != null) {
          beforeCommitHook();
        }

        return Success(
          LoanPaymentOutcome(
            loan: updatedLoan,
            paidInstallments: [updatedItem],
            loanJustCompleted: allPaid && loan.status == LoanStatus.active,
            createdLedgerEntries: [ledgerEntry],
          ),
        );
      });
    } catch (e) {
      return Err(
        AppFailure(
          type: FailureType.database,
          messageKey: 'database',
          detail: e.toString(),
        ),
      );
    }

    if (txResult is Success<LoanPaymentOutcome>) {
      final outcome = txResult.data;
      final paidItem = outcome.paidInstallments.first;
      final emiDocResult = generateDocumentForEmi(
        loanId: outcome.loan.id,
        emiId: paidItem.id,
        languageCode: languageCode,
      );

      LoanDocument? completeDoc;
      AppFailure? failure = emiDocResult.failureOrNull;
      if (outcome.loanJustCompleted) {
        final completeResult = generateDocumentForLoan(
          loanId: outcome.loan.id,
          languageCode: languageCode,
        );
        completeDoc = completeResult.dataOrNull;
        failure = completeResult.failureOrNull ?? failure;
      }

      return Success(
        LoanPaymentOutcome(
          loan: outcome.loan,
          paidInstallments: outcome.paidInstallments,
          loanJustCompleted: outcome.loanJustCompleted,
          generatedDocument: completeDoc ?? emiDocResult.dataOrNull,
          emiReceiptDocument: emiDocResult.dataOrNull,
          pdfFailure: failure,
          createdLedgerEntries: outcome.createdLedgerEntries,
        ),
      );
    }
    return txResult;
  }

  Result<LoanPaymentOutcome> payAllPendingEmis({
    required String loanId,
    required DateTime paidDate,
    String languageCode = 'en',
    void Function()? beforeCommitHook,
    bool simulatePdfFailure = false,
  }) {
    late Result<LoanPaymentOutcome> txResult;
    try {
      txResult = _runAtomic<Result<LoanPaymentOutcome>>(() {
        final loanIndex = _loans.indexWhere((l) => l.id == loanId);
        if (loanIndex == -1) {
          return const Err(
            AppFailure(
              type: FailureType.notFound,
              messageKey: 'noLoansTitle',
            ),
          );
        }
        final schedule = _emisByLoan[loanId];
        if (schedule == null) {
          return const Err(
            AppFailure(
              type: FailureType.notFound,
              messageKey: 'noLoansTitle',
            ),
          );
        }
        final loan = _loans[loanIndex];
        final utcPaid = LoanDateUtils.toUtcMidnight(paidDate);
        final paidList = <EmiScheduleItem>[];

        final createdLedger = <LedgerEntry>[];
        int runningBalance = currentCustomerLedgerBalance(loan.customerId);
        for (int i = 0; i < schedule.length; i++) {
          final item = schedule[i];
          if (!item.isPaid) {
            final updated = item.copyWith(
              status: EmiStatus.paid,
              paidDate: utcPaid,
            );
            schedule[i] = updated;
            paidList.add(updated);
            runningBalance =
                (runningBalance - updated.emiPaise).clamp(0, 1 << 62);
            final entry = LedgerEntry(
              id: _nextId('LDG'),
              customerId: loan.customerId,
              loanId: loanId,
              kind: LedgerKind.payment,
              debitPaise: 0,
              creditPaise: updated.emiPaise,
              balanceAfterPaise: runningBalance,
              createdAt: DateTime.now().toUtc(),
            );
            _ledger.add(entry);
            createdLedger.add(entry);
          }
        }

        final completedLoan = loan.copyWith(status: LoanStatus.completed);
        _loans[loanIndex] = completedLoan;

        if (beforeCommitHook != null) {
          beforeCommitHook();
        }

        return Success(
          LoanPaymentOutcome(
            loan: completedLoan,
            paidInstallments: paidList,
            loanJustCompleted: true,
            createdLedgerEntries: createdLedger,
          ),
        );
      });
    } catch (e) {
      return Err(
        AppFailure(
          type: FailureType.database,
          messageKey: 'database',
          detail: e.toString(),
        ),
      );
    }

    if (txResult is Err<LoanPaymentOutcome>) {
      return txResult;
    }

    final outcome = (txResult as Success<LoanPaymentOutcome>).data;
    final docResult = generateDocumentForLoan(
      loanId: loanId,
      languageCode: languageCode,
      simulateFailure: simulatePdfFailure,
    );

    return Success(
      LoanPaymentOutcome(
        loan: outcome.loan,
        paidInstallments: outcome.paidInstallments,
        loanJustCompleted: true,
        generatedDocument: docResult.dataOrNull,
        pdfFailure: docResult.failureOrNull,
        createdLedgerEntries: outcome.createdLedgerEntries,
      ),
    );
  }

  Result<LoanDocument> generateDocumentForLoan({
    required String loanId,
    String languageCode = 'en',
    DateTime? generatedAt,
    bool simulateFailure = false,
  }) {
    if (simulateFailure) {
      return const Err(
        AppFailure(
          type: FailureType.pdf,
          messageKey: 'pdf',
          detail: 'Simulated HTML-to-PDF conversion failure.',
        ),
      );
    }
    final loan = findLoanById(loanId);
    if (loan == null) {
      return const Err(
        AppFailure(
          type: FailureType.notFound,
          messageKey: 'noLoansTitle',
        ),
      );
    }
    final customer = findCustomerAnyById(loan.customerId);
    if (customer == null) {
      return const Err(
        AppFailure(
          type: FailureType.notFound,
          messageKey: 'noCustomersTitle',
        ),
      );
    }

    final schedule = emisForLoan(loanId);
    final localizedStrings =
        LoanAgreementPdfService.stringsForLanguage(languageCode);
    final statusText = loan.status == LoanStatus.completed
        ? localizedStrings.paid
        : localizedStrings.pending;

    final snapshot = LoanDocumentSnapshot(
      lenderName: _profile.name,
      lenderMobile: _profile.mobile,
      lenderEmail: _profile.email,
      borrowerName: customer.name,
      borrowerMobile: customer.mobile,
      borrowerEmail: customer.email,
      borrowerLocation: customer.location,
      loanId: loan.id,
      principalPaise: loan.principalPaise,
      monthlyRatePercent: loan.monthlyRatePercent,
      tenureMonths: loan.tenureMonths,
      loanType: loan.type,
      startDate: loan.startDate,
      monthlyEmiPaise: loan.monthlyEmiPaise,
      totalInterestPaise: loan.totalInterestPaise,
      totalPayablePaise: loan.totalPayablePaise,
      statusText: statusText,
      schedule: List<EmiScheduleItem>.from(schedule),
    );

    final now = generatedAt ?? DateTime.now().toUtc();
    final docId = _nextId('DOC');
    final html = LoanAgreementPdfService.buildDocumentHtml(
      documentId: docId,
      snapshot: snapshot,
      languageCode: languageCode,
      generatedAt: now,
    );
    final pageCount =
        LoanAgreementPdfService.paginateInstallments(snapshot.schedule).length;

    final doc = LoanDocument(
      id: docId,
      loanId: loan.id,
      customerMobile: customer.mobile,
      languageCode: languageCode,
      title: '${localizedStrings.headline} - ${customer.name} (${loan.id})',
      snapshot: snapshot,
      htmlContent: html,
      pageCount: pageCount,
      renderPath: 'html_a4',
      createdAt: now,
      updatedAt: now,
    );

    // Replace existing complete loan document if one already exists for this loan.
    final existingIdx = _documents.indexWhere(
      (d) => d.loanId == loan.id && d.emiInstallmentNo == null,
    );
    if (existingIdx != -1) {
      final replaced = doc.copyWith(
        id: _documents[existingIdx].id,
        createdAt: _documents[existingIdx].createdAt,
      );
      _documents[existingIdx] = replaced;
      return Success(replaced);
    }

    _documents.add(doc);
    return Success(doc);
  }

  LoanDocument? findDocumentForLoan(String loanId) {
    for (final doc in _documents) {
      if (doc.loanId == loanId && doc.emiInstallmentNo == null) {
        return doc;
      }
    }
    return null;
  }

  LoanDocument? findDocumentForEmi(String loanId, int installmentNo) {
    for (final doc in _documents) {
      if (doc.loanId == loanId && doc.emiInstallmentNo == installmentNo) {
        return doc;
      }
    }
    return null;
  }

  Result<LoanDocument> generateDocumentForEmi({
    required String loanId,
    required String emiId,
    String languageCode = 'en',
    DateTime? generatedAt,
    bool simulateFailure = false,
  }) {
    if (simulateFailure) {
      return const Err(
        AppFailure(
          type: FailureType.pdf,
          messageKey: 'pdf',
          detail: 'Simulated HTML-to-PDF conversion failure.',
        ),
      );
    }
    final loan = findLoanById(loanId);
    if (loan == null) {
      return const Err(
        AppFailure(
          type: FailureType.notFound,
          messageKey: 'noLoansTitle',
        ),
      );
    }
    final customer = findCustomerAnyById(loan.customerId);
    if (customer == null) {
      return const Err(
        AppFailure(
          type: FailureType.notFound,
          messageKey: 'noCustomersTitle',
        ),
      );
    }

    final schedule = emisForLoan(loanId);
    EmiScheduleItem? targetEmi;
    for (final item in schedule) {
      if (item.id == emiId) {
        targetEmi = item;
        break;
      }
    }
    if (targetEmi == null) {
      return const Err(
        AppFailure(
          type: FailureType.notFound,
          messageKey: 'noLoansTitle',
        ),
      );
    }

    final localizedStrings =
        LoanAgreementPdfService.stringsForLanguage(languageCode);
    final statusText = targetEmi.isPaid
        ? '${localizedStrings.paid} · EMI #${targetEmi.installmentNo}'
        : '${localizedStrings.pending} · EMI #${targetEmi.installmentNo}';

    final snapshot = LoanDocumentSnapshot(
      lenderName: _profile.name,
      lenderMobile: _profile.mobile,
      lenderEmail: _profile.email,
      borrowerName: customer.name,
      borrowerMobile: customer.mobile,
      borrowerEmail: customer.email,
      borrowerLocation: customer.location,
      loanId: loan.id,
      principalPaise: loan.principalPaise,
      monthlyRatePercent: loan.monthlyRatePercent,
      tenureMonths: loan.tenureMonths,
      loanType: loan.type,
      startDate: loan.startDate,
      monthlyEmiPaise: loan.monthlyEmiPaise,
      totalInterestPaise: loan.totalInterestPaise,
      totalPayablePaise: loan.totalPayablePaise,
      statusText: statusText,
      schedule: [targetEmi],
    );

    final now = generatedAt ?? DateTime.now().toUtc();
    final docId = _nextId('DOC');
    final html = LoanAgreementPdfService.buildDocumentHtml(
      documentId: docId,
      snapshot: snapshot,
      languageCode: languageCode,
      generatedAt: now,
      emiInstallmentNo: targetEmi.installmentNo,
    );

    final doc = LoanDocument(
      id: docId,
      loanId: loan.id,
      customerMobile: customer.mobile,
      languageCode: languageCode,
      title:
          '${localizedStrings.headline} - EMI #${targetEmi.installmentNo} (${customer.name} · ${loan.id})',
      snapshot: snapshot,
      htmlContent: html,
      pageCount: 1,
      renderPath: 'html_a4',
      createdAt: now,
      updatedAt: now,
      emiInstallmentNo: targetEmi.installmentNo,
    );

    final existingIdx = _documents.indexWhere(
      (d) =>
          d.loanId == loan.id &&
          d.emiInstallmentNo == targetEmi!.installmentNo,
    );
    if (existingIdx != -1) {
      final replaced = doc.copyWith(
        id: _documents[existingIdx].id,
        createdAt: _documents[existingIdx].createdAt,
      );
      _documents[existingIdx] = replaced;
      return Success(replaced);
    }

    _documents.add(doc);
    return Success(doc);
  }

  Result<LoanDocument> regenerateDocumentSnapshot({
    required String documentId,
    required LoanDocumentSnapshot updatedSnapshot,
    required String languageCode,
    DateTime? updatedAt,
  }) {
    final index = _documents.indexWhere((d) => d.id == documentId);
    if (index == -1) {
      return const Err(
        AppFailure(
          type: FailureType.notFound,
          messageKey: 'noDocumentsTitle',
        ),
      );
    }

    final existing = _documents[index];
    final localizedStrings =
        LoanAgreementPdfService.stringsForLanguage(languageCode);
    final now = updatedAt ?? DateTime.now().toUtc();
    final html = LoanAgreementPdfService.buildDocumentHtml(
      documentId: existing.id,
      snapshot: updatedSnapshot,
      languageCode: languageCode,
      generatedAt: now,
      emiInstallmentNo: existing.emiInstallmentNo,
    );
    final pageCount = LoanAgreementPdfService.paginateInstallments(
      updatedSnapshot.schedule,
    ).length;

    final regeneratedTitle = existing.emiInstallmentNo == null
        ? '${localizedStrings.headline} - ${updatedSnapshot.borrowerName} (${updatedSnapshot.loanId})'
        : '${localizedStrings.headline} - EMI #${existing.emiInstallmentNo} (${updatedSnapshot.borrowerName} · ${updatedSnapshot.loanId})';

    final regenerated = existing.copyWith(
      customerMobile: updatedSnapshot.borrowerMobile,
      languageCode: languageCode,
      title: regeneratedTitle,
      snapshot: updatedSnapshot,
      htmlContent: html,
      pageCount: pageCount,
      renderPath: 'html_a4',
      updatedAt: now,
    );

    _documents[index] = regenerated;
    return Success(regenerated);
  }

  Result<void> deleteDocument(String documentId) {
    final index = _documents.indexWhere((d) => d.id == documentId);
    if (index == -1) {
      return const Err(
        AppFailure(
          type: FailureType.notFound,
          messageKey: 'noDocumentsTitle',
        ),
      );
    }
    _documents.removeAt(index);
    return const Success(null);
  }

  DashboardSummaryData computeDashboardSummary([DateTime? referenceNow]) {
    final now = LoanDateUtils.toUtcMidnight(referenceNow ?? DateTime.now().toUtc());

    int totalLentPaise = 0;
    int activeLoansCount = 0;
    for (final loan in _loans) {
      totalLentPaise += loan.principalPaise;
      if (loan.status == LoanStatus.active) {
        activeLoansCount++;
      }
    }

    int emisDueThisMonth = 0;
    int collectedThisMonthPaise = 0;
    int pendingThisMonthPaise = 0;
    final overdueItems = <OverdueEmiItem>[];

    for (final loan in _loans) {
      final customer = findCustomerAnyById(loan.customerId);
      final schedule = _emisByLoan[loan.id] ?? const <EmiScheduleItem>[];
      for (final emi in schedule) {
        if (LoanDateUtils.isSameUtcMonth(emi.dueDate, now)) {
          if (emi.isPaid) {
            collectedThisMonthPaise += emi.emiPaise;
          } else {
            emisDueThisMonth++;
            pendingThisMonthPaise += emi.emiPaise;
          }
        } else if (emi.isPaid &&
            emi.paidDate != null &&
            LoanDateUtils.isSameUtcMonth(emi.paidDate!, now)) {
          collectedThisMonthPaise += emi.emiPaise;
        }

        if (emi.isOverdueAt(now)) {
          overdueItems.add(
            OverdueEmiItem(
              id: emi.id,
              loanId: loan.id,
              customerName: customer?.name ?? loan.customerId,
              mobile: customer?.mobile ?? '',
              emiAmount: emi.emiPaise / 100.0,
              dueDate: LoanDateUtils.formatShortDate(emi.dueDate),
            ),
          );
        }
      }
    }

    final recentLoans = loans.take(5).map((loan) {
      final customer = findCustomerAnyById(loan.customerId);
      final schedule = _emisByLoan[loan.id] ?? const <EmiScheduleItem>[];
      final nextPending = schedule.where((e) => !e.isPaid).toList();
      final nextDate = nextPending.isNotEmpty
          ? nextPending.first.dueDate
          : (schedule.isNotEmpty ? schedule.last.dueDate : loan.startDate);
      return LoanItem(
        id: loan.id,
        customerId: loan.customerId,
        customerName: customer?.name ?? loan.customerId,
        mobile: customer?.mobile ?? '',
        principal: loan.principalPaise / 100.0,
        status: loan.status,
        nextEmiDate: LoanDateUtils.formatShortDate(nextDate),
      );
    }).toList();

    final collectedRatio = (collectedThisMonthPaise + pendingThisMonthPaise) > 0
        ? ((collectedThisMonthPaise * 100) /
                (collectedThisMonthPaise + pendingThisMonthPaise))
            .round()
        : 0;

    return DashboardSummaryData(
      totalLent: totalLentPaise / 100.0,
      monthlyGrowthPercent: collectedRatio,
      activeLoansCount: activeLoansCount,
      customersCount: activeCustomers.length,
      emisDueThisMonth: emisDueThisMonth,
      collectedThisMonth: collectedThisMonthPaise / 100.0,
      pendingThisMonth: pendingThisMonthPaise / 100.0,
      recentLoans: recentLoans,
      overdueEmis: overdueItems,
    );
  }

  String exportBackupJson() {
    final payload = {
      'format': 'LMBK_JSON',
      'version': 1,
      'exportedAt': DateTime.now().toUtc().toIso8601String(),
      'profile': _profile.toJson(),
      'customers': _customers.map((c) => c.toJson()).toList(),
      'loans': _loans.map((l) => l.toJson()).toList(),
      'emis': {
        for (final entry in _emisByLoan.entries)
          entry.key: entry.value.map((e) => e.toJson()).toList(),
      },
      'ledger': _ledger.map((e) => e.toJson()).toList(),
      'documents': _documents.map((d) => d.toJson()).toList(),
    };
    return const JsonEncoder.withIndent('  ').convert(payload);
  }

  Result<void> restoreFromBackupJson(String rawJson) {
    try {
      final decoded = jsonDecode(rawJson);
      if (decoded is! Map<String, dynamic> ||
          decoded['format'] != 'LMBK_JSON' ||
          decoded['customers'] is! List ||
          decoded['loans'] is! List ||
          decoded['emis'] is! Map) {
        return const Err(
          AppFailure(
            type: FailureType.validation,
            messageKey: 'restoreInvalidError',
          ),
        );
      }

      _runAtomic(() {
        if (decoded['profile'] is Map<String, dynamic>) {
          _profile =
              LenderProfile.fromJson(decoded['profile'] as Map<String, dynamic>);
        }
        _customers
          ..clear()
          ..addAll(
            (decoded['customers'] as List<dynamic>).map(
              (c) => Customer.fromJson(c as Map<String, dynamic>),
            ),
          );
        _loans
          ..clear()
          ..addAll(
            (decoded['loans'] as List<dynamic>).map(
              (l) => Loan.fromJson(l as Map<String, dynamic>),
            ),
          );
        _emisByLoan.clear();
        final emisMap = decoded['emis'] as Map<String, dynamic>;
        for (final entry in emisMap.entries) {
          _emisByLoan[entry.key] = (entry.value as List<dynamic>)
              .map((e) => EmiScheduleItem.fromJson(e as Map<String, dynamic>))
              .toList();
        }
        _ledger
          ..clear()
          ..addAll(
            ((decoded['ledger'] as List<dynamic>?) ?? const []).map(
              (e) => LedgerEntry.fromJson(e as Map<String, dynamic>),
            ),
          );
        _documents
          ..clear()
          ..addAll(
            ((decoded['documents'] as List<dynamic>?) ?? const []).map(
              (d) => LoanDocument.fromJson(d as Map<String, dynamic>),
            ),
          );
      });
      return const Success(null);
    } catch (_) {
      return const Err(
        AppFailure(
          type: FailureType.validation,
          messageKey: 'restoreInvalidError',
        ),
      );
    }
  }

  String localizedFailureMessage(
    AppFailure failure, {
    required String Function(String key) resolveKey,
  }) {
    return resolveKey(failure.messageKey);
  }

  String formatMoneyPaise(int paise) => IndianCurrencyFormatter.formatPaise(paise);
}
