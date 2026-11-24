// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Panjabi Punjabi (`pa`).
class AppLocalizationsPa extends AppLocalizations {
  AppLocalizationsPa([String locale = 'pa']) : super(locale);

  @override
  String get appTitle => 'LoanWise';

  @override
  String get splashTagline => 'ਸਮਾਰਟ ਕਰਜ਼ਾ ਅਤੇ EMI ਖਾਤਾ';

  @override
  String get loginTitle => 'ਲੌਗਇਨ';

  @override
  String get nameLabel => 'ਨਾਮ';

  @override
  String get nameHint => 'ਆਪਣਾ ਪੂਰਾ ਨਾਮ ਦਰਜ ਕਰੋ';

  @override
  String get mobileLabel => 'ਮੋਬਾਈਲ ਨੰਬਰ';

  @override
  String get mobileHint => '10 ਅੰਕਾਂ ਦਾ ਮੋਬਾਈਲ ਨੰਬਰ';

  @override
  String get emailLabel => 'ਈਮੇਲ ਆਈਡੀ';

  @override
  String get emailHint => 'name@example.com';

  @override
  String get signInButton => 'ਸਾਈਨ ਇਨ ਕਰੋ';

  @override
  String get errorNameRequired => 'ਕਿਰਪਾ ਕਰਕੇ ਆਪਣਾ ਨਾਮ ਦਰਜ ਕਰੋ';

  @override
  String get errorMobileInvalid =>
      '6 ਤੋਂ 9 ਨਾਲ ਸ਼ੁਰੂ ਹੋਣ ਵਾਲਾ 10 ਅੰਕਾਂ ਦਾ ਮੋਬਾਈਲ ਨੰਬਰ ਦਰਜ ਕਰੋ';

  @override
  String get errorEmailInvalid => 'ਇੱਕ ਵੈਧ ਈਮੇਲ ਪਤਾ ਦਰਜ ਕਰੋ';

  @override
  String get navHome => 'ਹੋਮ';

  @override
  String get navCustomers => 'ਗਾਹਕ';

  @override
  String get navLoans => 'ਕਰਜ਼ੇ';

  @override
  String get navProfile => 'ਪ੍ਰੋਫਾਈਲ';

  @override
  String get welcomeBack => 'ਵਾਪਸੀ ਤੇ ਸਵਾਗਤ ਹੈ,';

  @override
  String get openMenuTooltip => 'ਮੇਨੂ ਖੋਲ੍ਹੋ';

  @override
  String get openProfileTooltip => 'ਪ੍ਰੋਫਾਈਲ ਖੋਲ੍ਹੋ';

  @override
  String get totalLentLabel => 'ਕੁੱਲ ਦਿੱਤਾ ਕਰਜ਼ਾ';

  @override
  String get availableToCollect => 'ਵਸੂਲੀ ਲਈ ਉਪਲਬਧ';

  @override
  String get activeLoansLabel => 'ਸਰਗਰਮ ਕਰਜ਼ੇ';

  @override
  String get customersLabel => 'ਗਾਹਕ';

  @override
  String get emisDueThisMonthLabel => 'ਇਸ ਮਹੀਨੇ ਦੀਆਂ EMI';

  @override
  String get quickActionsHeading => 'ਤੁਰੰਤ ਕਾਰਵਾਈਆਂ';

  @override
  String get actionAddCustomer => 'ਗਾਹਕ ਜੋੜੋ';

  @override
  String get actionCreateLoan => 'ਕਰਜ਼ਾ ਬਣਾਓ';

  @override
  String get actionLoans => 'ਕਰਜ਼ੇ';

  @override
  String get actionDocuments => 'ਦਸਤਾਵੇਜ਼';

  @override
  String get actionAllCustomers => 'ਸਾਰੇ ਗਾਹਕ';

  @override
  String get actionProfile => 'ਪ੍ਰੋਫਾਈਲ';

  @override
  String get thisMonthHeading => 'ਇਸ ਮਹੀਨੇ';

  @override
  String get viewAll => 'ਸਭ ਵੇਖੋ';

  @override
  String get collectedThisMonth => 'ਇਸ ਮਹੀਨੇ ਵਸੂਲਿਆ';

  @override
  String get pendingThisMonth => 'ਇਸ ਮਹੀਨੇ ਬਕਾਇਆ';

  @override
  String get recentLoansHeading => 'ਹਾਲੀਆ ਕਰਜ਼ੇ';

  @override
  String get overdueEmisHeading => 'ਮਿਆਦ ਪੁੱਗੀਆਂ EMI';

  @override
  String get statusActive => 'ਸਰਗਰਮ';

  @override
  String get statusCompleted => 'ਪੂਰਾ';

  @override
  String get statusOverdue => 'ਮਿਆਦ ਪੁੱਗੀ';

  @override
  String get statusPending => 'ਬਕਾਇਆ';

  @override
  String get statusPaid => 'ਭੁਗਤਾਨ ਹੋਇਆ';

  @override
  String nextEmiLabel(String date) {
    return 'ਅਗਲੀ EMI: $date';
  }

  @override
  String dueSinceLabel(String date) {
    return 'ਬਕਾਇਆ ਮਿਤੀ: $date';
  }

  @override
  String get emptyRecentLoans =>
      'ਅਜੇ ਕੋਈ ਹਾਲੀਆ ਕਰਜ਼ਾ ਨਹੀਂ ਹੈ। ਇੱਥੇ ਵੇਖਣ ਲਈ ਕਰਜ਼ਾ ਬਣਾਓ।';

  @override
  String get emptyOverdueEmis => 'ਸਭ ਠੀਕ ਹੈ। ਕੋਈ ਮਿਆਦ ਪੁੱਗੀ EMI ਨਹੀਂ ਹੈ।';

  @override
  String get drawerBackupRestore => 'ਬੈਕਅੱਪ ਅਤੇ ਰੀਸਟੋਰ';

  @override
  String get drawerChangeTheme => 'ਥੀਮ ਬਦਲੋ';

  @override
  String get drawerChooseLanguage => 'ਭਾਸ਼ਾ ਚੁਣੋ';

  @override
  String get themeLight => 'ਲਾਈਟ';

  @override
  String get themeDark => 'ਡਾਰਕ';

  @override
  String get themeSystem => 'ਸਿਸਟਮ';

  @override
  String get backupDialogMessage => 'ਤੁਹਾਡੀ ਡਿਵਾਈਸ ਲਈ ਲੋਕਲ ਬੈਕਅੱਪ ਅੱਪਡੇਟ ਹੈ।';

  @override
  String get closeAction => 'ਬੰਦ ਕਰੋ';

  @override
  String featureQueuedMessage(String feature) {
    return '$feature ਤਿਆਰ ਹੈ।';
  }

  @override
  String get tabCustomersSubtitle =>
      'ਕਰਜ਼ਦਾਰਾਂ, ਸੰਪਰਕ ਵੇਰਵਿਆਂ ਅਤੇ ਸਰਗਰਮ ਕਰਜ਼ਿਆਂ ਦਾ ਪ੍ਰਬੰਧਨ ਕਰੋ।';

  @override
  String get tabLoansSubtitle => 'ਸਰਗਰਮ ਕਰਜ਼ੇ, ਵਿਆਜ ਅਤੇ EMI ਸਾਰਣੀ ਵੇਖੋ।';

  @override
  String get tabProfileSubtitle => 'ਤੁਹਾਡੇ ਦਰਜ ਕਰਜ਼ਦਾਤਾ ਵੇਰਵੇ ਅਤੇ ਤਰਜੀਹਾਂ।';

  @override
  String get signOutAction => 'ਸਾਈਨ ਆਊਟ';

  @override
  String get addCustomerTitle => 'ਗਾਹਕ ਜੋੜੋ';

  @override
  String get editCustomerTitle => 'ਗਾਹਕ ਸੋਧੋ';

  @override
  String get customerNameLabel => 'ਗਾਹਕ ਦਾ ਨਾਮ';

  @override
  String get customerEmailLabel => 'ਗਾਹਕ ਦੀ ਈਮੇਲ';

  @override
  String get customerMobileLabel => 'ਮੋਬਾਈਲ ਨੰਬਰ';

  @override
  String get customerLocationLabel => 'ਟਿਕਾਣਾ';

  @override
  String get locationRequiredError => 'ਕਿਰਪਾ ਕਰਕੇ ਟਿਕਾਣਾ ਦਰਜ ਕਰੋ';

  @override
  String get saveCustomerButton => 'ਗਾਹਕ ਸੰਭਾਲੋ';

  @override
  String get updateCustomerButton => 'ਗਾਹਕ ਅੱਪਡੇਟ ਕਰੋ';

  @override
  String get customerAddedTitle => 'ਗਾਹਕ ਸਫਲਤਾਪੂਰਵਕ ਜੋੜਿਆ ਗਿਆ';

  @override
  String customerAddedMessage(String name) {
    return 'ਕੀ ਤੁਸੀਂ ਹੁਣ $name ਲਈ ਕਰਜ਼ਾ ਬਣਾਉਣਾ ਚਾਹੁੰਦੇ ਹੋ?';
  }

  @override
  String get laterButton => 'ਬਾਅਦ ਵਿੱਚ';

  @override
  String get searchCustomersHint => 'ਨਾਮ ਜਾਂ ਮੋਬਾਈਲ ਨਾਲ ਖੋਜੋ';

  @override
  String get noCustomersTitle => 'ਕੋਈ ਗਾਹਕ ਨਹੀਂ ਮਿਲਿਆ';

  @override
  String get noCustomersSubtitle => 'ਆਪਣਾ ਪਹਿਲਾ ਗਾਹਕ ਜੋੜਨ ਲਈ + ਦਬਾਓ।';

  @override
  String get editCustomerMenu => 'ਵੇਰਵੇ ਸੋਧੋ';

  @override
  String get deleteCustomerMenu => 'ਗਾਹਕ ਹਟਾਓ';

  @override
  String get createLoanMenu => 'ਕਰਜ਼ਾ ਬਣਾਓ';

  @override
  String get deleteCustomerConfirmTitle => 'ਗਾਹਕ ਹਟਾਓ?';

  @override
  String deleteCustomerConfirmMessage(String name) {
    return 'ਇਹ $name ਨੂੰ ਤੁਹਾਡੀ ਸਰਗਰਮ ਸੂਚੀ ਵਿੱਚੋਂ ਹਟਾ ਦੇਵੇਗਾ।';
  }

  @override
  String get deleteAction => 'ਹਟਾਓ';

  @override
  String get cancelAction => 'ਰੱਦ ਕਰੋ';

  @override
  String get activeLoanDeleteBlocked =>
      'ਸਰਗਰਮ ਕਰਜ਼ੇ ਵਾਲੇ ਗਾਹਕ ਨੂੰ ਹਟਾਇਆ ਨਹੀਂ ਜਾ ਸਕਦਾ।';

  @override
  String get duplicateMobileError =>
      'ਇਸ ਮੋਬਾਈਲ ਨੰਬਰ ਵਾਲਾ ਗਾਹਕ ਪਹਿਲਾਂ ਹੀ ਮੌਜੂਦ ਹੈ।';

  @override
  String get customerDetailTitle => 'ਗਾਹਕ ਦੇ ਵੇਰਵੇ';

  @override
  String get callAction => 'ਕਾਲ';

  @override
  String get smsAction => 'SMS';

  @override
  String get customerLoansHeading => 'ਗਾਹਕ ਦੇ ਕਰਜ਼ੇ';

  @override
  String get mobileLockedHelper =>
      'ਕਰਜ਼ੇ ਮੌਜੂਦ ਹੋਣ ਤੇ ਮੋਬਾਈਲ ਨੰਬਰ ਬਦਲਿਆ ਨਹੀਂ ਜਾ ਸਕਦਾ।';

  @override
  String activeLoansCountLabel(int count) {
    return '$count ਸਰਗਰਮ';
  }

  @override
  String get createLoanTitle => 'ਕਰਜ਼ਾ ਬਣਾਓ';

  @override
  String get searchCustomerMobileHint => '10 ਅੰਕਾਂ ਦਾ ਮੋਬਾਈਲ ਦਰਜ ਕਰੋ';

  @override
  String get noCustomerWithMobile => 'ਇਸ ਮੋਬਾਈਲ ਨਾਲ ਕੋਈ ਗਾਹਕ ਨਹੀਂ';

  @override
  String get addCustomerShortcut => 'ਗਾਹਕ ਜੋੜੋ';

  @override
  String get principalLabel => 'ਮੂਲ ਰਕਮ (₹)';

  @override
  String get monthlyRateLabel => 'ਮਾਸਿਕ ਵਿਆਜ ਦਰ (%)';

  @override
  String get tenureMonthsLabel => 'ਮਿਆਦ (ਮਹੀਨੇ)';

  @override
  String get loanTypeLabel => 'ਵਿਆਜ ਦੀ ਕਿਸਮ';

  @override
  String get loanTypeSimple => 'ਸਾਧਾਰਨ';

  @override
  String get loanTypeCompound => 'ਮਿਸ਼ਰਿਤ';

  @override
  String get startDateLabel => 'ਸ਼ੁਰੂਆਤੀ ਮਿਤੀ';

  @override
  String get livePreviewHeading => 'ਲਾਈਵ EMI ਪ੍ਰੀਵਿਊ';

  @override
  String get monthlyEmiLabel => 'ਮਾਸਿਕ EMI';

  @override
  String get totalInterestLabel => 'ਕੁੱਲ ਵਿਆਜ';

  @override
  String get totalPayableLabel => 'ਕੁੱਲ ਭੁਗਤਾਨਯੋਗ';

  @override
  String get createLoanButton => 'ਕਰਜ਼ਾ ਬਣਾਓ';

  @override
  String get loanCreatedTitle => 'ਕਰਜ਼ਾ ਸਫਲਤਾਪੂਰਵਕ ਬਣਿਆ';

  @override
  String loanCreatedMessage(int count) {
    return '$count ਮਾਸਿਕ EMI ਬਣਾਈਆਂ ਗਈਆਂ ਹਨ।';
  }

  @override
  String get viewLoanOverview => 'ਕਰਜ਼ਾ ਸਾਰ ਖੋਲ੍ਹੋ';

  @override
  String get allLoansFilter => 'ਸਭ';

  @override
  String get activeLoansFilter => 'ਸਰਗਰਮ';

  @override
  String get completedLoansFilter => 'ਪੂਰਾ ਹੋਇਆ';

  @override
  String get noLoansTitle => 'ਅਜੇ ਕੋਈ ਕਰਜ਼ਾ ਨਹੀਂ';

  @override
  String get noLoansSubtitle => 'EMI ਸਾਰਣੀ ਬਣਾਉਣ ਲਈ ਕਰਜ਼ਾ ਬਣਾਓ।';

  @override
  String get selectCustomerError => 'ਪਹਿਲਾਂ 10 ਅੰਕਾਂ ਦੇ ਮੋਬਾਈਲ ਨਾਲ ਗਾਹਕ ਚੁਣੋ।';

  @override
  String get invalidPrincipalError => '0 ਤੋਂ ਵੱਧ ਮੂਲ ਰਕਮ ਦਰਜ ਕਰੋ।';

  @override
  String get invalidRateError => '0 ਤੋਂ 100 ਦੇ ਵਿਚਕਾਰ ਮਾਸਿਕ ਦਰ ਦਰਜ ਕਰੋ।';

  @override
  String get invalidTenureError => '1 ਤੋਂ 600 ਮਹੀਨਿਆਂ ਦੀ ਮਿਆਦ ਦਰਜ ਕਰੋ।';

  @override
  String get loanOverviewTitle => 'ਕਰਜ਼ੇ ਦਾ ਸਾਰ';

  @override
  String get emiScheduleHeading => 'EMI ਸਾਰਣੀ';

  @override
  String get payButton => 'ਭੁਗਤਾਨ ਕਰੋ';

  @override
  String get payAllPendingButton => 'ਸਾਰੀਆਂ ਬਕਾਇਆ EMI ਭੁਗਤਾਨ ਕਰੋ';

  @override
  String confirmPayEmiTitle(int no) {
    return 'EMI #$no ਭੁਗਤਾਨ ਹੋਈ ਮੰਨੋ?';
  }

  @override
  String confirmPayEmiMessage(String amount) {
    return '$amount ਦੇ ਭੁਗਤਾਨ ਦੀ ਪੁਸ਼ਟੀ ਕਰੋ।';
  }

  @override
  String get paymentDateLabel => 'ਭੁਗਤਾਨ ਮਿਤੀ';

  @override
  String get confirmPayAllTitle => 'ਸਾਰੀਆਂ ਬਕਾਇਆ EMI ਭੁਗਤਾਨ ਕਰੋ?';

  @override
  String confirmPayAllMessage(int count, String amount) {
    return 'ਇਹ $count ਬਾਕੀ EMI ($amount) ਭੁਗਤਾਨ ਕਰੇਗਾ ਅਤੇ ਕਰਜ਼ਾ ਸਮਝੌਤਾ PDF ਬਣਾਏਗਾ।';
  }

  @override
  String installmentLabel(int no) {
    return 'ਕਿਸਤ #$no';
  }

  @override
  String paidOnLabel(String date) {
    return 'ਭੁਗਤਾਨ: $date';
  }

  @override
  String get outOfOrderEmiError =>
      'ਕਿਰਪਾ ਕਰਕੇ ਪਹਿਲਾਂ ਪਿਛਲੀਆਂ ਬਕਾਇਆ ਕਿਸਤਾਂ ਕ੍ਰਮ ਵਿੱਚ ਭੁਗਤਾਨ ਕਰੋ।';

  @override
  String emiPaidSuccess(int no) {
    return 'ਕਿਸਤ #$no ਦਾ ਭੁਗਤਾਨ ਦਰਜ ਹੋ ਗਿਆ।';
  }

  @override
  String get loanCompletedPdfGenerated =>
      'ਕਰਜ਼ਾ ਪੂਰਾ ਹੋਇਆ! ਸਮਝੌਤਾ PDF ਦਸਤਾਵੇਜ਼ਾਂ ਵਿੱਚ ਸੇਵ ਹੋ ਗਈ।';

  @override
  String get viewPdfAction => 'PDF ਵੇਖੋ';

  @override
  String get openDocumentsAction => 'ਦਸਤਾਵੇਜ਼ ਖੋਲ੍ਹੋ';

  @override
  String progressPaidLabel(int paid, int total) {
    return '$total ਵਿੱਚੋਂ $paid EMI ਭੁਗਤਾਨ';
  }

  @override
  String get ledgerHeading => 'ਖਾਤਾ ਇਤਿਹਾਸ';

  @override
  String get ledgerDebitLabel => 'ਡੈਬਿਟ';

  @override
  String get ledgerCreditLabel => 'ਕ੍ਰੈਡਿਟ';

  @override
  String get ledgerBalanceLabel => 'ਬਕਾਇਆ';

  @override
  String get documentsTitle => 'ਦਸਤਾਵੇਜ਼';

  @override
  String get noDocumentsTitle => 'ਅਜੇ ਕੋਈ PDF ਦਸਤਾਵੇਜ਼ ਨਹੀਂ';

  @override
  String get noDocumentsSubtitle =>
      'ਕਰਜ਼ਾ ਪੂਰਾ ਭੁਗਤਾਨ ਹੋਣ ਤੇ ਸਮਝੌਤਾ ਇੱਥੇ ਦਿਖੇਗਾ।';

  @override
  String get viewPdfMenu => 'PDF ਵੇਖੋ';

  @override
  String get sharePdfMenu => 'PDF ਸਾਂਝੀ ਕਰੋ';

  @override
  String get deletePdfMenu => 'PDF ਹਟਾਓ';

  @override
  String get editPdfMenu => 'PDF ਸੋਧੋ';

  @override
  String get deletePdfConfirmTitle => 'ਦਸਤਾਵੇਜ਼ ਹਟਾਓ?';

  @override
  String get deletePdfConfirmMessage =>
      'ਇਹ ਬਣੇ ਕਰਜ਼ਾ ਸਮਝੌਤੇ ਨੂੰ ਦਸਤਾਵੇਜ਼ਾਂ ਵਿੱਚੋਂ ਹਟਾ ਦੇਵੇਗਾ।';

  @override
  String pagesCountLabel(int count) {
    return '$count ਪੰਨੇ';
  }

  @override
  String get documentViewerTitle => 'ਕਰਜ਼ਾ ਸਮਝੌਤਾ ਦਰਸ਼ਕ';

  @override
  String get loanAgreementHeadline => 'ਕਰਜ਼ਾ ਸਮਝੌਤਾ';

  @override
  String get lenderDetailsHeading => 'ਕਰਜ਼ਦਾਤਾ ਵੇਰਵੇ';

  @override
  String get borrowerDetailsHeading => 'ਕਰਜ਼ਦਾਰ ਵੇਰਵੇ';

  @override
  String get installmentScheduleHeading => 'ਕਿਸਤ ਸਾਰਣੀ';

  @override
  String get generatedOnLabel => 'ਤਿਆਰ ਮਿਤੀ';

  @override
  String get documentIdLabel => 'ਦਸਤਾਵੇਜ਼ ID';

  @override
  String pageOfLabel(int current, int total) {
    return 'ਪੰਨਾ $current / $total';
  }

  @override
  String get signatureLender => 'ਕਰਜ਼ਦਾਤਾ ਦੇ ਦਸਤਖਤ';

  @override
  String get signatureBorrower => 'ਕਰਜ਼ਦਾਰ ਦੇ ਦਸਤਖਤ';

  @override
  String get editPdfTitle => 'PDF ਸੋਧੋ';

  @override
  String get snapshotNotice =>
      'ਬਦਲਾਅ ਸਿਰਫ਼ ਇਸ PDF ਸਨੈਪਸ਼ਾਟ ਨੂੰ ਅੱਪਡੇਟ ਕਰਦੇ ਹਨ, ਅਸਲ ਕਰਜ਼ੇ ਜਾਂ ਖਾਤੇ ਨੂੰ ਨਹੀਂ।';

  @override
  String get pdfLanguageLabel => 'ਦਸਤਾਵੇਜ਼ ਦੀ ਭਾਸ਼ਾ';

  @override
  String get statusTextLabel => 'ਸਥਿਤੀ ਟੈਕਸਟ';

  @override
  String get previewButton => 'ਪ੍ਰੀਵਿਊ';

  @override
  String get regeneratePdfButton => 'PDF ਦੁਬਾਰਾ ਬਣਾਓ';

  @override
  String get pdfRegeneratedSuccess => 'ਦਸਤਾਵੇਜ਼ ਸਫਲਤਾਪੂਰਵਕ ਦੁਬਾਰਾ ਬਣਿਆ।';

  @override
  String shareReadyMessage(String title, int pages) {
    return 'ਸਾਂਝਾ ਕਰਨ ਲਈ $title ($pages ਪੰਨੇ) ਤਿਆਰ ਹੈ।';
  }

  @override
  String get copyHtmlAction => 'HTML ਕਾਪੀ ਕਰੋ';

  @override
  String get htmlCopiedMessage => 'A4 HTML ਕਲਿੱਪਬੋਰਡ ਵਿੱਚ ਕਾਪੀ ਹੋਇਆ।';

  @override
  String get saveChangesButton => 'ਬਦਲਾਅ ਸੰਭਾਲੋ';

  @override
  String get profileUpdatedSuccess => 'ਪ੍ਰੋਫਾਈਲ ਸਫਲਤਾਪੂਰਵਕ ਅੱਪਡੇਟ ਹੋਈ।';

  @override
  String get signOutConfirmTitle => 'ਸਾਈਨ ਆਊਟ?';

  @override
  String get signOutConfirmMessage =>
      'ਤੁਸੀਂ ਕਿਸੇ ਵੀ ਸਮੇਂ ਆਪਣੇ ਵੇਰਵਿਆਂ ਨਾਲ ਵਾਪਸ ਸਾਈਨ ਇਨ ਕਰ ਸਕਦੇ ਹੋ।';

  @override
  String get totalLoansStatLabel => 'ਕੁੱਲ ਕਰਜ਼ੇ';

  @override
  String get documentsStatLabel => 'ਦਸਤਾਵੇਜ਼';

  @override
  String get backupTitle => 'ਬੈਕਅੱਪ ਅਤੇ ਰੀਸਟੋਰ';

  @override
  String get backupSubtitle =>
      'ਲੋਕਲ ਸਨੈਪਸ਼ਾਟ ਐਕਸਪੋਰਟ ਕਰੋ ਜਾਂ ਆਪਣਾ ਖਾਤਾ ਰੀਸਟੋਰ ਕਰੋ।';

  @override
  String get exportBackupButton => 'ਲੋਕਲ ਬੈਕਅੱਪ ਬਣਾਓ';

  @override
  String get restoreBackupButton => 'ਸਨੈਪਸ਼ਾਟ ਰੀਸਟੋਰ ਕਰੋ';

  @override
  String get backupGeneratedMessage =>
      'ਬੈਕਅੱਪ ਸਨੈਪਸ਼ਾਟ ਕਲਿੱਪਬੋਰਡ ਵਿੱਚ ਕਾਪੀ ਹੋਇਆ।';

  @override
  String get restoreSuccessMessage => 'ਬੈਕਅੱਪ ਸਨੈਪਸ਼ਾਟ ਸਫਲਤਾਪੂਰਵਕ ਰੀਸਟੋਰ ਹੋਇਆ।';

  @override
  String get restoreInvalidError => 'ਅਵੈਧ ਬੈਕਅੱਪ ਸਨੈਪਸ਼ਾਟ JSON।';

  @override
  String get pasteBackupHint => 'ਰੀਸਟੋਰ ਕਰਨ ਲਈ ਬੈਕਅੱਪ JSON ਇੱਥੇ ਪੇਸਟ ਕਰੋ';

  @override
  String get driveComingSoonNote =>
      'Google Drive ਐਨਕ੍ਰਿਪਟਡ AppData ਸਿੰਕ ਪੜਾਅ 6 ਵਿੱਚ ਆਵੇਗਾ।';

  @override
  String get emiPdfButton => 'EMI PDF';

  @override
  String get viewCompletePdfButton => 'ਪੂਰਾ ਕਰਜ਼ਾ PDF';

  @override
  String emiPdfGeneratedMessage(int no) {
    return 'ਕਿਸ਼ਤ #$no ਦਾ ਭੁਗਤਾਨ ਹੋ ਗਿਆ ਅਤੇ PDF ਦਸਤਾਵੇਜ਼ਾਂ ਵਿੱਚ ਸੁਰੱਖਿਅਤ ਹੋ ਗਿਆ।';
  }

  @override
  String emiReceiptTag(int no) {
    return 'EMI #$no ਰਸੀਦ';
  }

  @override
  String get completeLoanPdfTag => 'ਪੂਰਾ ਕਰਜ਼ਾ PDF';

  @override
  String get emiCalculatorTitle => 'EMI ਕੈਲਕੁਲੇਟਰ';

  @override
  String get emiCalculatorSubtitle =>
      'ਕਰਜ਼ਾ ਬਣਾਉਣ ਤੋਂ ਪਹਿਲਾਂ ਮਹੀਨਾਵਾਰ ਕਿਸ਼ਤ, ਕੁੱਲ ਵਿਆਜ ਅਤੇ ਅਦਾਇਗੀ ਸੂਚੀ ਦਾ ਅੰਦਾਜ਼ਾ ਲਗਾਓ।';

  @override
  String get principalShareLabel => 'ਮੂਲ ਹਿੱਸਾ';

  @override
  String get interestShareLabel => 'ਵਿਆਜ ਹਿੱਸਾ';

  @override
  String get resetFieldsButton => 'ਰੀਸੈੱਟ';

  @override
  String get proceedToCreateLoanButton => 'ਇਹਨਾਂ ਸ਼ਰਤਾਂ ਨਾਲ ਕਰਜ਼ਾ ਬਣਾਓ';

  @override
  String get schedulePreviewHeading => 'ਸੂਚੀ ਝਲਕ';

  @override
  String get enterTermsForEstimate =>
      'EMI ਅੰਦਾਜ਼ਾ ਦੇਖਣ ਲਈ ਮੂਲ ਰਕਮ, ਮਹੀਨਾਵਾਰ ਦਰ ਅਤੇ ਮਿਆਦ ਦਰਜ ਕਰੋ।';

  @override
  String get systemDefaultLanguage => 'ਸਿਸਟਮ ਡਿਫਾਲਟ';

  @override
  String get choosePhotoTitle => 'ਪ੍ਰੋਫਾਈਲ ਫੋਟੋ';

  @override
  String get pickFromGallery => 'ਗੈਲਰੀ ਵਿੱਚੋਂ ਚੁਣੋ';

  @override
  String get takePhoto => 'ਫੋਟੋ ਖਿੱਚੋ';

  @override
  String get removePhoto => 'ਫੋਟੋ ਹਟਾਓ';

  @override
  String get changeAvatarColor => 'ਬੈਜ ਰੰਗ ਬਦਲੋ';

  @override
  String get photoPickFailedError => 'ਚੁਣੀ ਗਈ ਤਸਵੀਰ ਲੋਡ ਨਹੀਂ ਹੋ ਸਕੀ।';

  @override
  String get databaseError =>
      'ਡੇਟਾ ਸਥਾਨਕ ਤੌਰ ਉੱਤੇ ਸੇਵ ਨਹੀਂ ਹੋ ਸਕਿਆ। ਕਿਰਪਾ ਕਰਕੇ ਦੁਬਾਰਾ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String get onboardingSkip => 'ਛੱਡੋ';

  @override
  String get onboardingStart => 'ਸ਼ੁਰੂ ਕਰੋ';

  @override
  String get onboardingNext => 'ਅੱਗੇ';

  @override
  String get onboardingTitle1 => 'ਸਮਾਰਟ ਕਰਜ਼ਾ ਹੱਬ';

  @override
  String get onboardingSubtitle1 =>
      'ਗਾਹਕਾਂ ਦਾ ਪ੍ਰਬੰਧ ਕਰੋ, ਸਧਾਰਨ ਜਾਂ ਮਿਸ਼ਰਤ ਵਿਆਜ ਕਰਜ਼ੇ ਬਣਾਓ ਅਤੇ ਆਫਲਾਈਨ ਸੰਗਠਿਤ ਰਹੋ।';

  @override
  String get onboardingTitle2 => 'EMI ਅਤੇ ਖਾਤਾ ਟ੍ਰੈਕ ਕਰੋ';

  @override
  String get onboardingSubtitle2 =>
      'ਮਹੀਨਾਵਾਰ ਕਿਸ਼ਤਾਂ, ਨਿਯਤ ਮਿਤੀਆਂ ਅਤੇ ਵਸੂਲੀ ਨੂੰ ਇੱਕ ਨਜ਼ਰ ਵਿੱਚ ਦੇਖੋ।';

  @override
  String get onboardingTitle3 => 'ਤੁਰੰਤ ਕਰਜ਼ਾ ਇਕਰਾਰਨਾਮਾ';

  @override
  String get onboardingSubtitle3 =>
      'ਪੂਰਾ ਭੁਗਤਾਨ ਹੋਣ \'ਤੇ 13 ਭਾਸ਼ਾਵਾਂ ਵਿੱਚ ਆਪਣੇ ਆਪ A4 ਕਰਜ਼ਾ ਇਕਰਾਰਨਾਮਾ PDF ਬਣਾਓ।';
}
