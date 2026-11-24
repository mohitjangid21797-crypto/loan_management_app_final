import 'package:material_ui/material_ui.dart';
import 'package:loan_management_app/core/error/failures.dart';
import 'package:loan_management_app/data/repositories/loanwise_store.dart';
import 'package:loan_management_app/domain/models/loan_models.dart';
import 'package:loan_management_app/services/loan_agreement_pdf_service.dart';

class AppState extends ChangeNotifier {
  AppState({
    ThemeMode initialThemeMode = ThemeMode.light,
    Locale? initialLocale = const Locale('en'),
    LenderProfile? initialProfile,
    bool initialSignedIn = false,
    bool initialHasSeenOnboarding = false,
    DashboardSummaryData? initialDashboardData,
    LoanWiseStore? store,
  })  : _themeMode = initialThemeMode,
        _localeOverride = initialLocale,
        _hasSeenOnboarding = initialHasSeenOnboarding,
        _dashboardOverride = initialDashboardData,
        _store = store ??
            LoanWiseStore.empty(
              profile: initialProfile,
              isSignedIn: initialSignedIn,
            );

  final LoanWiseStore _store;
  ThemeMode _themeMode;
  Locale? _localeOverride;
  bool _hasSeenOnboarding;
  int _selectedTabIndex = 0;
  DashboardSummaryData? _dashboardOverride;
  Future<void> _persistenceChain = Future<void>.value();

  Future<void> Function(LenderProfile profile)? onPersistProfile;
  Future<void> Function()? onClearProfile;
  Future<void> Function(ThemeMode mode)? onPersistThemeMode;
  Future<void> Function(Locale? locale)? onPersistLocale;
  Future<void> Function(bool seen)? onPersistOnboardingSeen;
  Future<void> Function(Customer customer)? onPersistCustomerUpsert;
  Future<void> Function(Customer customer)? onPersistCustomerDeleted;
  Future<void> Function(
    Loan loan,
    List<EmiScheduleItem> emis,
    LedgerEntry disbursement,
  )? onPersistLoanCreated;
  Future<void> Function(
    Loan updatedLoan,
    List<EmiScheduleItem> paidEmis,
    List<LedgerEntry> ledgerEntries,
  )? onPersistPaymentOutcome;
  Future<void> Function(LoanDocument document)? onPersistDocumentUpsert;
  Future<void> Function(String documentId)? onPersistDocumentDeleted;
  Future<void> Function({
    required LenderProfile profile,
    required List<Customer> customers,
    required List<Loan> loans,
    required Map<String, List<EmiScheduleItem>> emisByLoan,
    required List<LedgerEntry> ledger,
    required List<LoanDocument> documents,
  })? onPersistRestoreAll;

  LoanWiseStore get store => _store;
  ThemeMode get themeMode => _themeMode;
  Locale? get localeOverride => _localeOverride;
  Locale get locale => _localeOverride ?? const Locale('en');
  bool get hasSeenOnboarding => _hasSeenOnboarding;
  LenderProfile get profile => _store.profile;
  bool get isSignedIn => _store.isSignedIn;
  int get selectedTabIndex => _selectedTabIndex;

  DashboardSummaryData get dashboardData =>
      _dashboardOverride ?? _store.computeDashboardSummary();

  List<Customer> get customers => _store.activeCustomers;
  List<Loan> get loans => _store.loans;
  List<LoanDocument> get documents => _store.documents;

  Future<void> flushPersistence() => _persistenceChain;

  void _enqueuePersistence(Future<void> Function() task) {
    _persistenceChain = _persistenceChain.then((_) async {
      try {
        await task();
      } catch (e) {
        debugPrint('LoanWise persistence error: $e');
      }
    });
  }

  void _persistDocumentAndPdfFile(LoanDocument document) {
    final upsertCb = onPersistDocumentUpsert;
    if (upsertCb == null) return;
    _enqueuePersistence(() async {
      await upsertCb(document);
      try {
        final savedPath =
            await LoanAgreementPdfService.generateAndSavePdfFile(document);
        final updated = _store.updateDocumentPaths(
          documentId: document.id,
          filePath: savedPath,
          renderPath: savedPath,
        );
        if (updated != null) {
          await upsertCb(updated);
          notifyListeners();
        }
      } catch (e) {
        debugPrint('PDF generation error: $e');
      }
    });
  }

  void hydrateFromRepositories({
    LenderProfile? profile,
    ThemeMode? themeMode,
    Locale? localeOverride,
    bool applyLocaleOverride = false,
    bool? hasSeenOnboarding,
    List<Customer>? customers,
    List<Loan>? loans,
    Map<String, List<EmiScheduleItem>>? emisByLoan,
    List<LedgerEntry>? ledger,
    List<LoanDocument>? documents,
    int? maxIdSeq,
  }) {
    var changed = false;
    if (profile != null) {
      _store.setSignedIn(profile);
      changed = true;
    }
    if (hasSeenOnboarding != null && _hasSeenOnboarding != hasSeenOnboarding) {
      _hasSeenOnboarding = hasSeenOnboarding;
      changed = true;
    }
    if (customers != null &&
        loans != null &&
        emisByLoan != null &&
        ledger != null &&
        documents != null) {
      _store.hydrateFromSnapshot(
        customers: customers,
        loans: loans,
        emisByLoan: emisByLoan,
        ledger: ledger,
        documents: documents,
        maxIdSeq: maxIdSeq ?? 1000,
      );
      _dashboardOverride = null;
      changed = true;
    }
    if (themeMode != null && _themeMode != themeMode) {
      _themeMode = themeMode;
      changed = true;
    }
    if (applyLocaleOverride && _localeOverride != localeOverride) {
      _localeOverride = localeOverride;
      changed = true;
    }
    if (changed) {
      notifyListeners();
    }
  }

  void completeOnboarding() {
    if (_hasSeenOnboarding) return;
    _hasSeenOnboarding = true;
    notifyListeners();
    final cb = onPersistOnboardingSeen;
    if (cb != null) {
      _enqueuePersistence(() => cb(true));
    }
  }

  void setThemeMode(ThemeMode mode) {
    if (_themeMode == mode) return;
    _themeMode = mode;
    notifyListeners();
    final cb = onPersistThemeMode;
    if (cb != null) {
      _enqueuePersistence(() => cb(mode));
    }
  }

  void setLocale(Locale? newLocale) {
    if (_localeOverride == newLocale) return;
    _localeOverride = newLocale;
    notifyListeners();
    final cb = onPersistLocale;
    if (cb != null) {
      _enqueuePersistence(() => cb(newLocale));
    }
  }

  void setTabIndex(int index) {
    if (_selectedTabIndex == index || index < 0 || index > 3) return;
    _selectedTabIndex = index;
    notifyListeners();
  }

  void signIn(LenderProfile profile) {
    _store.setSignedIn(profile);
    _selectedTabIndex = 0;
    notifyListeners();
    final cb = onPersistProfile;
    if (cb != null) {
      _enqueuePersistence(() => cb(_store.profile));
    }
  }

  void updateProfile(LenderProfile profile) {
    _store.updateProfile(profile);
    notifyListeners();
    final cb = onPersistProfile;
    if (cb != null) {
      _enqueuePersistence(() => cb(_store.profile));
    }
  }

  void signOut() {
    _store.signOut();
    _selectedTabIndex = 0;
    notifyListeners();
    final cb = onClearProfile;
    if (cb != null) {
      _enqueuePersistence(() => cb());
    }
  }

  void setDashboardData(DashboardSummaryData data) {
    _dashboardOverride = data;
    notifyListeners();
  }

  Result<Customer> createCustomer({
    required String name,
    required String email,
    required String mobile,
    required String location,
  }) {
    final res = _store.createCustomer(
      name: name,
      email: email,
      mobile: mobile,
      location: location,
    );
    if (res is Success<Customer>) {
      _dashboardOverride = null;
      notifyListeners();
      final cb = onPersistCustomerUpsert;
      if (cb != null) {
        _enqueuePersistence(() => cb(res.data));
      }
    }
    return res;
  }

  Result<Customer> updateCustomer({
    required String customerId,
    required String name,
    required String email,
    required String mobile,
    required String location,
  }) {
    final res = _store.updateCustomer(
      customerId: customerId,
      name: name,
      email: email,
      mobile: mobile,
      location: location,
    );
    if (res is Success<Customer>) {
      _dashboardOverride = null;
      notifyListeners();
      final cb = onPersistCustomerUpsert;
      if (cb != null) {
        _enqueuePersistence(() => cb(res.data));
      }
    }
    return res;
  }

  Result<Customer> deleteCustomer(String customerId) {
    final res = _store.deleteCustomer(customerId);
    if (res is Success<Customer>) {
      _dashboardOverride = null;
      notifyListeners();
      final cb = onPersistCustomerDeleted;
      if (cb != null) {
        _enqueuePersistence(() => cb(res.data));
      }
    }
    return res;
  }

  Result<Loan> createLoan({
    required String customerId,
    required int principalPaise,
    required double monthlyRatePercent,
    required int tenureMonths,
    required LoanType type,
    required DateTime startDate,
  }) {
    final res = _store.createLoan(
      customerId: customerId,
      principalPaise: principalPaise,
      monthlyRatePercent: monthlyRatePercent,
      tenureMonths: tenureMonths,
      type: type,
      startDate: startDate,
    );
    if (res is Success<Loan>) {
      _dashboardOverride = null;
      notifyListeners();
      final cb = onPersistLoanCreated;
      if (cb != null) {
        final loan = res.data;
        final emis = _store.emisForLoan(loan.id);
        final ledger = _store.ledgerForLoan(loan.id);
        if (ledger.isNotEmpty) {
          _enqueuePersistence(() => cb(loan, emis, ledger.last));
        }
      }
    }
    return res;
  }

  Result<LoanPaymentOutcome> markEmiPaid({
    required String loanId,
    required String emiId,
    required DateTime paidDate,
  }) {
    final res = _store.markEmiPaid(
      loanId: loanId,
      emiId: emiId,
      paidDate: paidDate,
      languageCode: locale.languageCode,
    );
    if (res is Success<LoanPaymentOutcome>) {
      _dashboardOverride = null;
      notifyListeners();
      final outcome = res.data;
      final payCb = onPersistPaymentOutcome;
      if (payCb != null) {
        _enqueuePersistence(
          () => payCb(
            outcome.loan,
            outcome.paidInstallments,
            outcome.createdLedgerEntries,
          ),
        );
      }
      if (outcome.emiReceiptDocument != null) {
        _persistDocumentAndPdfFile(outcome.emiReceiptDocument!);
      }
      if (outcome.loanJustCompleted && outcome.generatedDocument != null) {
        _persistDocumentAndPdfFile(outcome.generatedDocument!);
      }
    }
    return res;
  }

  Result<LoanPaymentOutcome> payAllPendingEmis({
    required String loanId,
    required DateTime paidDate,
    bool simulatePdfFailure = false,
  }) {
    final res = _store.payAllPendingEmis(
      loanId: loanId,
      paidDate: paidDate,
      languageCode: locale.languageCode,
      simulatePdfFailure: simulatePdfFailure,
    );
    if (res is Success<LoanPaymentOutcome>) {
      _dashboardOverride = null;
      notifyListeners();
      final outcome = res.data;
      final payCb = onPersistPaymentOutcome;
      if (payCb != null) {
        _enqueuePersistence(
          () => payCb(
            outcome.loan,
            outcome.paidInstallments,
            outcome.createdLedgerEntries,
          ),
        );
      }
      if (outcome.generatedDocument != null) {
        _persistDocumentAndPdfFile(outcome.generatedDocument!);
      }
    }
    return res;
  }

  Result<LoanDocument> retryGeneratePdf(String loanId) =>
      generateCompleteLoanPdf(loanId);

  Result<LoanDocument> generateCompleteLoanPdf(String loanId) {
    final res = _store.generateDocumentForLoan(
      loanId: loanId,
      languageCode: locale.languageCode,
    );
    if (res is Success<LoanDocument>) {
      notifyListeners();
      _persistDocumentAndPdfFile(res.data);
    }
    return res;
  }

  Result<LoanDocument> generateEmiPdf({
    required String loanId,
    required String emiId,
  }) {
    final res = _store.generateDocumentForEmi(
      loanId: loanId,
      emiId: emiId,
      languageCode: locale.languageCode,
    );
    if (res is Success<LoanDocument>) {
      notifyListeners();
      _persistDocumentAndPdfFile(res.data);
    }
    return res;
  }

  Result<LoanDocument> regenerateDocumentSnapshot({
    required String documentId,
    required LoanDocumentSnapshot updatedSnapshot,
    required String languageCode,
  }) {
    final res = _store.regenerateDocumentSnapshot(
      documentId: documentId,
      updatedSnapshot: updatedSnapshot,
      languageCode: languageCode,
    );
    if (res is Success<LoanDocument>) {
      notifyListeners();
      _persistDocumentAndPdfFile(res.data);
    }
    return res;
  }

  Result<void> deleteDocument(String documentId) {
    final existing = _store.findDocumentById(documentId);
    final res = _store.deleteDocument(documentId);
    if (res.isSuccess) {
      notifyListeners();
      final cb = onPersistDocumentDeleted;
      if (cb != null) {
        _enqueuePersistence(() async {
          await cb(documentId);
          await LoanAgreementPdfService.deletePdfFileIfExists(existing?.filePath);
        });
      }
    }
    return res;
  }

  Result<void> restoreBackupJson(String json) {
    final res = _store.restoreFromBackupJson(json);
    if (res.isSuccess) {
      _dashboardOverride = null;
      notifyListeners();
      final cb = onPersistRestoreAll;
      if (cb != null) {
        _enqueuePersistence(
          () => cb(
            profile: _store.profile,
            customers: _store.allCustomersIncludingDeleted,
            loans: _store.loans,
            emisByLoan: _store.allEmisByLoan,
            ledger: _store.allLedgerEntries,
            documents: _store.documents,
          ),
        );
      }
    }
    return res;
  }
}
