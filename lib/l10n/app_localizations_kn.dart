// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kannada (`kn`).
class AppLocalizationsKn extends AppLocalizations {
  AppLocalizationsKn([String locale = 'kn']) : super(locale);

  @override
  String get appTitle => 'LoanWise';

  @override
  String get splashTagline => 'ಸ್ಮಾರ್ಟ್ ಸಾಲ ಮತ್ತು ಇಎಂಐ ಖಾತೆ';

  @override
  String get loginTitle => 'ಲಾಗಿನ್';

  @override
  String get nameLabel => 'ಹೆಸರು';

  @override
  String get nameHint => 'ನಿಮ್ಮ ಪೂರ್ಣ ಹೆಸರನ್ನು ನಮೂದಿಸಿ';

  @override
  String get mobileLabel => 'ಮೊಬೈಲ್ ಸಂಖ್ಯೆ';

  @override
  String get mobileHint => '10 ಅಂಕಿಯ ಮೊಬೈಲ್ ಸಂಖ್ಯೆ';

  @override
  String get emailLabel => 'ಇಮೇಲ್ ಐಡಿ';

  @override
  String get emailHint => 'name@example.com';

  @override
  String get signInButton => 'ಸೈನ್ ಇನ್ ಮಾಡಿ';

  @override
  String get errorNameRequired => 'ದಯವಿಟ್ಟು ನಿಮ್ಮ ಹೆಸರನ್ನು ನಮೂದಿಸಿ';

  @override
  String get errorMobileInvalid =>
      '6 ರಿಂದ 9 ರಲ್ಲಿ ಪ್ರಾರಂಭವಾಗುವ 10 ಅಂಕಿಯ ಮೊಬೈಲ್ ಸಂಖ್ಯೆಯನ್ನು ನಮೂದಿಸಿ';

  @override
  String get errorEmailInvalid => 'ಮಾನ್ಯ ಇಮೇಲ್ ವಿಳಾಸವನ್ನು ನಮೂದಿಸಿ';

  @override
  String get navHome => 'ಹೋಮ್';

  @override
  String get navCustomers => 'ಗ್ರಾಹಕರು';

  @override
  String get navLoans => 'ಸಾಲಗಳು';

  @override
  String get navProfile => 'ಪ್ರೊಫೈಲ್';

  @override
  String get welcomeBack => 'ಮತ್ತೆ ಸ್ವಾಗತ,';

  @override
  String get openMenuTooltip => 'ಮೆನು ತೆರೆಯಿರಿ';

  @override
  String get openProfileTooltip => 'ಪ್ರೊಫೈಲ್ ತೆರೆಯಿರಿ';

  @override
  String get totalLentLabel => 'ಒಟ್ಟು ನೀಡಿದ ಸಾಲ';

  @override
  String get availableToCollect => 'ಸಂಗ್ರಹಕ್ಕೆ ಲಭ್ಯ';

  @override
  String get activeLoansLabel => 'ಸಕ್ರಿಯ ಸಾಲಗಳು';

  @override
  String get customersLabel => 'ಗ್ರಾಹಕರು';

  @override
  String get emisDueThisMonthLabel => 'ಈ ತಿಂಗಳ ಬಾಕಿ ಇಎಂಐ';

  @override
  String get quickActionsHeading => 'ತ್ವರಿತ ಕ್ರಿಯೆಗಳು';

  @override
  String get actionAddCustomer => 'ಗ್ರಾಹಕರನ್ನು ಸೇರಿಸಿ';

  @override
  String get actionCreateLoan => 'ಸಾಲ ರಚಿಸಿ';

  @override
  String get actionLoans => 'ಸಾಲಗಳು';

  @override
  String get actionDocuments => 'ದಾಖಲೆಗಳು';

  @override
  String get actionAllCustomers => 'ಎಲ್ಲಾ ಗ್ರಾಹಕರು';

  @override
  String get actionProfile => 'ಪ್ರೊಫೈಲ್';

  @override
  String get thisMonthHeading => 'ಈ ತಿಂಗಳು';

  @override
  String get viewAll => 'ಎಲ್ಲಾ ನೋಡಿ';

  @override
  String get collectedThisMonth => 'ಈ ತಿಂಗಳು ಸಂಗ್ರಹ';

  @override
  String get pendingThisMonth => 'ಈ ತಿಂಗಳು ಬಾಕಿ';

  @override
  String get recentLoansHeading => 'ಇತ್ತೀಚಿನ ಸಾಲಗಳು';

  @override
  String get overdueEmisHeading => 'ಅವಧಿ ಮೀರಿದ ಇಎಂಐಗಳು';

  @override
  String get statusActive => 'ಸಕ್ರಿಯ';

  @override
  String get statusCompleted => 'ಪೂರ್ಣಗೊಂಡಿದೆ';

  @override
  String get statusOverdue => 'ಬಾಕಿ';

  @override
  String get statusPending => 'ಬಾಕಿ ಇದೆ';

  @override
  String get statusPaid => 'ಪಾವತಿಸಲಾಗಿದೆ';

  @override
  String nextEmiLabel(String date) {
    return 'ಮುಂದಿನ ಇಎಂಐ: $date';
  }

  @override
  String dueSinceLabel(String date) {
    return 'ಬಾಕಿ ದಿನಾಂಕ: $date';
  }

  @override
  String get emptyRecentLoans =>
      'ಇನ್ನೂ ಯಾವುದೇ ಇತ್ತೀಚಿನ ಸಾಲಗಳಿಲ್ಲ. ಪ್ರಾರಂಭಿಸಲು ಸಾಲ ರಚಿಸಿ.';

  @override
  String get emptyOverdueEmis =>
      'ಎಲ್ಲವೂ ನವೀಕೃತವಾಗಿದೆ. ಸದ್ಯಕ್ಕೆ ಯಾವುದೇ ಬಾಕಿ ಇಎಂಐ ಇಲ್ಲ.';

  @override
  String get drawerBackupRestore => 'ಬ್ಯಾಕಪ್ ಮತ್ತು ಮರುಸ್ಥಾಪನೆ';

  @override
  String get drawerChangeTheme => 'ಥೀಮ್ ಬದಲಾಯಿಸಿ';

  @override
  String get drawerChooseLanguage => 'ಭಾಷೆ ಆಯ್ಕೆಮಾಡಿ';

  @override
  String get themeLight => 'ಲೈಟ್';

  @override
  String get themeDark => 'ಡಾರ್ಕ್';

  @override
  String get themeSystem => 'ಸಿಸ್ಟಮ್';

  @override
  String get backupDialogMessage =>
      'ನಿಮ್ಮ ಸಾಧನಕ್ಕಾಗಿ ಸ್ಥಳೀಯ ಬ್ಯಾಕಪ್ ನವೀಕೃತವಾಗಿದೆ.';

  @override
  String get closeAction => 'ಮುಚ್ಚಿ';

  @override
  String featureQueuedMessage(String feature) {
    return '$feature ಸಿದ್ಧವಾಗಿದೆ.';
  }

  @override
  String get tabCustomersSubtitle =>
      'ಸಾಲಗಾರರು, ಸಂಪರ್ಕ ವಿವರಗಳು ಮತ್ತು ಸಕ್ರಿಯ ಸಾಲಗಳನ್ನು ನಿರ್ವಹಿಸಿ.';

  @override
  String get tabLoansSubtitle =>
      'ಸಕ್ರಿಯ ಸಾಲಗಳು, ಬಡ್ಡಿ ಮತ್ತು ಇಎಂಐ ವೇಳಾಪಟ್ಟಿಯನ್ನು ಟ್ರ್ಯಾಕ್ ಮಾಡಿ.';

  @override
  String get tabProfileSubtitle =>
      'ನಿಮ್ಮ ನೋಂದಾಯಿತ ಸಾಲದಾತ ವಿವರಗಳು ಮತ್ತು ಆದ್ಯತೆಗಳು.';

  @override
  String get signOutAction => 'ಸೈನ್ ಔಟ್';

  @override
  String get addCustomerTitle => 'ಗ್ರಾಹಕರನ್ನು ಸೇರಿಸಿ';

  @override
  String get editCustomerTitle => 'ಗ್ರಾಹಕರನ್ನು ಸಂಪಾದಿಸಿ';

  @override
  String get customerNameLabel => 'ಗ್ರಾಹಕರ ಹೆಸರು';

  @override
  String get customerEmailLabel => 'ಗ್ರಾಹಕರ ಇಮೇಲ್';

  @override
  String get customerMobileLabel => 'ಮೊಬೈಲ್ ಸಂಖ್ಯೆ';

  @override
  String get customerLocationLabel => 'ಸ್ಥಳ';

  @override
  String get locationRequiredError => 'ದಯವಿಟ್ಟು ಸ್ಥಳವನ್ನು ನಮೂದಿಸಿ';

  @override
  String get saveCustomerButton => 'ಗ್ರಾಹಕರನ್ನು ಉಳಿಸಿ';

  @override
  String get updateCustomerButton => 'ಗ್ರಾಹಕರನ್ನು ನವೀಕರಿಸಿ';

  @override
  String get customerAddedTitle => 'ಗ್ರಾಹಕರನ್ನು ಯಶಸ್ವಿಯಾಗಿ ಸೇರಿಸಲಾಗಿದೆ';

  @override
  String customerAddedMessage(String name) {
    return 'ನೀವು ಈಗ $name ಅವರಿಗೆ ಸಾಲ ರಚಿಸಲು ಬಯಸುವಿರಾ?';
  }

  @override
  String get laterButton => 'ನಂತರ';

  @override
  String get searchCustomersHint => 'ಹೆಸರು ಅಥವಾ ಮೊಬೈಲ್ ಮೂಲಕ ಹುಡುಕಿ';

  @override
  String get noCustomersTitle => 'ಯಾವುದೇ ಗ್ರಾಹಕರು ಕಂಡುಬಂದಿಲ್ಲ';

  @override
  String get noCustomersSubtitle => 'ಮೊದಲ ಗ್ರಾಹಕರನ್ನು ಸೇರಿಸಲು + ಟ್ಯಾಪ್ ಮಾಡಿ.';

  @override
  String get editCustomerMenu => 'ವಿವರಗಳನ್ನು ಸಂಪಾದಿಸಿ';

  @override
  String get deleteCustomerMenu => 'ಗ್ರಾಹಕರನ್ನು ಅಳಿಸಿ';

  @override
  String get createLoanMenu => 'ಸಾಲ ರಚಿಸಿ';

  @override
  String get deleteCustomerConfirmTitle => 'ಗ್ರಾಹಕರನ್ನು ಅಳಿಸಬೇಕೇ?';

  @override
  String deleteCustomerConfirmMessage(String name) {
    return 'ಇದು $name ಅವರನ್ನು ಸಕ್ರಿಯ ಪಟ್ಟಿಯಿಂದ ತೆಗೆದುಹಾಕುತ್ತದೆ.';
  }

  @override
  String get deleteAction => 'ಅಳಿಸಿ';

  @override
  String get cancelAction => 'ರದ್ದುಮಾಡಿ';

  @override
  String get activeLoanDeleteBlocked =>
      'ಸಕ್ರಿಯ ಸಾಲ ಹೊಂದಿರುವ ಗ್ರಾಹಕರನ್ನು ಅಳಿಸಲು ಸಾಧ್ಯವಿಲ್ಲ.';

  @override
  String get duplicateMobileError =>
      'ಈ ಮೊಬೈಲ್ ಸಂಖ್ಯೆಯೊಂದಿಗೆ ಗ್ರಾಹಕರು ಈಗಾಗಲೇ ಇದ್ದಾರೆ.';

  @override
  String get customerDetailTitle => 'ಗ್ರಾಹಕರ ವಿವರಗಳು';

  @override
  String get callAction => 'ಕರೆ';

  @override
  String get smsAction => 'SMS';

  @override
  String get customerLoansHeading => 'ಗ್ರಾಹಕರ ಸಾಲಗಳು';

  @override
  String get mobileLockedHelper =>
      'ಸಾಲಗಳು ಇದ್ದ ನಂತರ ಮೊಬೈಲ್ ಸಂಖ್ಯೆ ಬದಲಾಯಿಸಲು ಸಾಧ್ಯವಿಲ್ಲ.';

  @override
  String activeLoansCountLabel(int count) {
    return '$count ಸಕ್ರಿಯ';
  }

  @override
  String get createLoanTitle => 'ಸಾಲ ರಚಿಸಿ';

  @override
  String get searchCustomerMobileHint => '10 ಅಂಕಿಯ ಗ್ರಾಹಕ ಮೊಬೈಲ್ ನಮೂದಿಸಿ';

  @override
  String get noCustomerWithMobile => 'ಈ ಮೊಬೈಲ್‌ನೊಂದಿಗೆ ಗ್ರಾಹಕರಿಲ್ಲ';

  @override
  String get addCustomerShortcut => 'ಗ್ರಾಹಕರನ್ನು ಸೇರಿಸಿ';

  @override
  String get principalLabel => 'ಅಸಲು ಮೊತ್ತ (₹)';

  @override
  String get monthlyRateLabel => 'ಬಡ್ಡಿ ದರ (ತಿಂಗಳಿಗೆ %)';

  @override
  String get tenureMonthsLabel => 'ಅವಧಿ (ತಿಂಗಳುಗಳು)';

  @override
  String get loanTypeLabel => 'ಬಡ್ಡಿ ಪ್ರಕಾರ';

  @override
  String get loanTypeSimple => 'ಸರಳ';

  @override
  String get loanTypeCompound => 'ಚಕ್ರಬಡ್ಡಿ';

  @override
  String get startDateLabel => 'ಪ್ರಾರಂಭ ದಿನಾಂಕ';

  @override
  String get livePreviewHeading => 'ಲೈವ್ ಇಎಂಐ ಮುನ್ನೋಟ';

  @override
  String get monthlyEmiLabel => 'ಮಾಸಿಕ ಇಎಂಐ';

  @override
  String get totalInterestLabel => 'ಒಟ್ಟು ಬಡ್ಡಿ';

  @override
  String get totalPayableLabel => 'ಒಟ್ಟು ಪಾವತಿಸಬೇಕಾದದ್ದು';

  @override
  String get createLoanButton => 'ಸಾಲ ರಚಿಸಿ';

  @override
  String get loanCreatedTitle => 'ಸಾಲ ಯಶಸ್ವಿಯಾಗಿ ರಚಿಸಲಾಗಿದೆ';

  @override
  String loanCreatedMessage(int count) {
    return '$count ಮಾಸಿಕ ಇಎಂಐಗಳನ್ನು ರಚಿಸಲಾಗಿದೆ.';
  }

  @override
  String get viewLoanOverview => 'ಸಾಲದ ವಿವರ ತೆರೆಯಿರಿ';

  @override
  String get allLoansFilter => 'ಎಲ್ಲಾ';

  @override
  String get activeLoansFilter => 'ಸಕ್ರಿಯ';

  @override
  String get completedLoansFilter => 'ಪೂರ್ಣಗೊಂಡಿದೆ';

  @override
  String get noLoansTitle => 'ಇನ್ನೂ ಸಾಲಗಳಿಲ್ಲ';

  @override
  String get noLoansSubtitle => 'ಇಎಂಐ ವೇಳಾಪಟ್ಟಿ ರಚಿಸಲು ಸಾಲವನ್ನು ಸೇರಿಸಿ.';

  @override
  String get selectCustomerError =>
      'ಮೊದಲು 10 ಅಂಕಿಯ ಮೊಬೈಲ್‌ನಿಂದ ಗ್ರಾಹಕರನ್ನು ಆಯ್ಕೆಮಾಡಿ.';

  @override
  String get invalidPrincipalError =>
      '0 ಕ್ಕಿಂತ ಹೆಚ್ಚಿನ ಅಸಲು ಮೊತ್ತವನ್ನು ನಮೂದಿಸಿ.';

  @override
  String get invalidRateError => '0 ರಿಂದ 100 ನಡುವೆ ಮಾಸಿಕ ದರವನ್ನು ನಮೂದಿಸಿ.';

  @override
  String get invalidTenureError => '1 ರಿಂದ 600 ತಿಂಗಳುಗಳ ನಡುವೆ ಅವಧಿ ನಮೂದಿಸಿ.';

  @override
  String get loanOverviewTitle => 'ಸಾಲದ ವಿವರ';

  @override
  String get emiScheduleHeading => 'ಇಎಂಐ ವೇಳಾಪಟ್ಟಿ';

  @override
  String get payButton => 'ಪಾವತಿಸಿ';

  @override
  String get payAllPendingButton => 'ಎಲ್ಲಾ ಬಾಕಿ ಇಎಂಐಗಳನ್ನು ಪಾವತಿಸಿ';

  @override
  String confirmPayEmiTitle(int no) {
    return 'ಇಎಂಐ #$no ಪಾವತಿಸಲಾಗಿದೆ ಎಂದು ಗುರುತಿಸಬೇಕೇ?';
  }

  @override
  String confirmPayEmiMessage(String amount) {
    return '$amount ಪಾವತಿಯನ್ನು ದೃಢೀಕರಿಸಿ.';
  }

  @override
  String get paymentDateLabel => 'ಪಾವತಿ ದಿನಾಂಕ';

  @override
  String get confirmPayAllTitle => 'ಎಲ್ಲಾ ಬಾಕಿ ಇಎಂಐಗಳನ್ನು ಪಾವತಿಸಬೇಕೇ?';

  @override
  String confirmPayAllMessage(int count, String amount) {
    return 'ಉಳಿದ $count ಇಎಂಐಗಳು ($amount) ಪಾವತಿಸಲ್ಪಡುತ್ತವೆ ಮತ್ತು ಸಾಲ ಒಪ್ಪಂದ PDF ರಚಿಸಲಾಗುತ್ತದೆ.';
  }

  @override
  String installmentLabel(int no) {
    return 'ಕಂತು #$no';
  }

  @override
  String paidOnLabel(String date) {
    return 'ಪಾವತಿ: $date';
  }

  @override
  String get outOfOrderEmiError =>
      'ದಯವಿಟ್ಟು ಮೊದಲು ಹಿಂದಿನ ಬಾಕಿ ಕಂತುಗಳನ್ನು ಕ್ರಮವಾಗಿ ಪಾವತಿಸಿ.';

  @override
  String emiPaidSuccess(int no) {
    return 'ಕಂತು #$no ಪಾವತಿಸಲಾಗಿದೆ.';
  }

  @override
  String get loanCompletedPdfGenerated =>
      'ಸಾಲ ಪೂರ್ಣಗೊಂಡಿದೆ! ಸಾಲ ಒಪ್ಪಂದ PDF ದಾಖಲೆಗಳಲ್ಲಿ ಉಳಿಸಲಾಗಿದೆ.';

  @override
  String get viewPdfAction => 'PDF ನೋಡಿ';

  @override
  String get openDocumentsAction => 'ದಾಖಲೆಗಳನ್ನು ತೆರೆಯಿರಿ';

  @override
  String progressPaidLabel(int paid, int total) {
    return '$total ರಲ್ಲಿ $paid ಇಎಂಐ ಪಾವತಿಸಲಾಗಿದೆ';
  }

  @override
  String get ledgerHeading => 'ಲೆಡ್ಜರ್ ಇತಿಹಾಸ';

  @override
  String get ledgerDebitLabel => 'ಡೆಬಿಟ್';

  @override
  String get ledgerCreditLabel => 'ಕ್ರೆಡಿಟ್';

  @override
  String get ledgerBalanceLabel => 'ಬಾಕಿ';

  @override
  String get documentsTitle => 'ದಾಖಲೆಗಳು';

  @override
  String get noDocumentsTitle => 'ಇನ್ನೂ ಯಾವುದೇ PDF ದಾಖಲೆಗಳಿಲ್ಲ';

  @override
  String get noDocumentsSubtitle =>
      'ಸಾಲ ಸಂಪೂರ್ಣ ಪಾವತಿಯಾದ ನಂತರ ಸಾಲ ಒಪ್ಪಂದಗಳು ಇಲ್ಲಿ ಕಾಣಿಸುತ್ತವೆ.';

  @override
  String get viewPdfMenu => 'PDF ನೋಡಿ';

  @override
  String get sharePdfMenu => 'PDF ಹಂಚಿಕೊಳ್ಳಿ';

  @override
  String get deletePdfMenu => 'PDF ಅಳಿಸಿ';

  @override
  String get editPdfMenu => 'PDF ಸಂಪಾದಿಸಿ';

  @override
  String get deletePdfConfirmTitle => 'ದಾಖಲೆ ಅಳಿಸಬೇಕೇ?';

  @override
  String get deletePdfConfirmMessage =>
      'ಇದು ದಾಖಲೆಗಳಿಂದ ರಚಿಸಲಾದ ಸಾಲ ಒಪ್ಪಂದವನ್ನು ತೆಗೆದುಹಾಕುತ್ತದೆ.';

  @override
  String pagesCountLabel(int count) {
    return '$count ಪುಟಗಳು';
  }

  @override
  String get documentViewerTitle => 'ಸಾಲ ಒಪ್ಪಂದ ವೀಕ್ಷಕ';

  @override
  String get loanAgreementHeadline => 'ಸಾಲ ಒಪ್ಪಂದ';

  @override
  String get lenderDetailsHeading => 'ಸಾಲದಾತರ ವಿವರಗಳು';

  @override
  String get borrowerDetailsHeading => 'ಸಾಲಗಾರರ ವಿವರಗಳು';

  @override
  String get installmentScheduleHeading => 'ಕಂತುಗಳ ವೇಳಾಪಟ್ಟಿ';

  @override
  String get generatedOnLabel => 'ರಚಿಸಿದ ದಿನಾಂಕ';

  @override
  String get documentIdLabel => 'ದಾಖಲೆ ID';

  @override
  String pageOfLabel(int current, int total) {
    return 'ಪುಟ $current / $total';
  }

  @override
  String get signatureLender => 'ಸಾಲದಾತರ ಸಹಿ';

  @override
  String get signatureBorrower => 'ಸಾಲಗಾರರ ಸಹಿ';

  @override
  String get editPdfTitle => 'PDF ಸಂಪಾದಿಸಿ';

  @override
  String get snapshotNotice =>
      'ಬದಲಾವಣೆಗಳು ಈ PDF ಸ್ನ್ಯಾಪ್‌ಶಾಟ್ ಅನ್ನು ಮಾತ್ರ ನವೀಕರಿಸುತ್ತವೆ; ಮೂಲ ಸಾಲವನ್ನು ಬದಲಾಯಿಸುವುದಿಲ್ಲ.';

  @override
  String get pdfLanguageLabel => 'ದಾಖಲೆಯ ಭಾಷೆ';

  @override
  String get statusTextLabel => 'ಸ್ಥಿತಿ ಲೇಬಲ್';

  @override
  String get previewButton => 'ಮುನ್ನೋಟ';

  @override
  String get regeneratePdfButton => 'PDF ಮರುರಚಿಸಿ';

  @override
  String get pdfRegeneratedSuccess => 'ದಾಖಲೆ ಯಶಸ್ವಿಯಾಗಿ ಮರುರಚಿಸಲಾಗಿದೆ.';

  @override
  String shareReadyMessage(String title, int pages) {
    return '$title ($pages ಪುಟಗಳು) ಹಂಚಿಕೆಗೆ ಸಿದ್ಧವಾಗಿದೆ.';
  }

  @override
  String get copyHtmlAction => 'HTML ನಕಲಿಸಿ';

  @override
  String get htmlCopiedMessage => 'A4 HTML ಕ್ಲಿಪ್‌ಬೋರ್ಡ್‌ಗೆ ನಕಲಿಸಲಾಗಿದೆ.';

  @override
  String get saveChangesButton => 'ಬದಲಾವಣೆಗಳನ್ನು ಉಳಿಸಿ';

  @override
  String get profileUpdatedSuccess => 'ಪ್ರೊಫೈಲ್ ಯಶಸ್ವಿಯಾಗಿ ನವೀಕರಿಸಲಾಗಿದೆ.';

  @override
  String get signOutConfirmTitle => 'ಸೈನ್ ಔಟ್ ಮಾಡಬೇಕೇ?';

  @override
  String get signOutConfirmMessage =>
      'ನಿಮ್ಮ ವಿವರಗಳೊಂದಿಗೆ ನೀವು ಯಾವಾಗ ಬೇಕಾದರೂ ಮತ್ತೆ ಸೈನ್ ಇನ್ ಮಾಡಬಹುದು.';

  @override
  String get totalLoansStatLabel => 'ಒಟ್ಟು ಸಾಲಗಳು';

  @override
  String get documentsStatLabel => 'ದಾಖಲೆಗಳು';

  @override
  String get backupTitle => 'ಬ್ಯಾಕಪ್ ಮತ್ತು ಮರುಸ್ಥಾಪನೆ';

  @override
  String get backupSubtitle =>
      'ನಿಮ್ಮ ಸಾಲದ ಖಾತೆಯ ಸ್ಥಳೀಯ ಸ್ನ್ಯಾಪ್‌ಶಾಟ್ ರಫ್ತು ಅಥವಾ ಮರುಸ್ಥಾಪಿಸಿ.';

  @override
  String get exportBackupButton => 'ಸ್ಥಳೀಯ ಬ್ಯಾಕಪ್ ರಚಿಸಿ';

  @override
  String get restoreBackupButton => 'ಸ್ನ್ಯಾಪ್‌ಶಾಟ್ ಮರುಸ್ಥಾಪಿಸಿ';

  @override
  String get backupGeneratedMessage =>
      'ಬ್ಯಾಕಪ್ ಸ್ನ್ಯಾಪ್‌ಶಾಟ್ ರಚಿಸಿ ಕ್ಲಿಪ್‌ಬೋರ್ಡ್‌ಗೆ ನಕಲಿಸಲಾಗಿದೆ.';

  @override
  String get restoreSuccessMessage =>
      'ಬ್ಯಾಕಪ್ ಸ್ನ್ಯಾಪ್‌ಶಾಟ್ ಯಶಸ್ವಿಯಾಗಿ ಮರುಸ್ಥಾಪಿಸಲಾಗಿದೆ.';

  @override
  String get restoreInvalidError => 'ಅಮಾನ್ಯ ಬ್ಯಾಕಪ್ ಸ್ನ್ಯಾಪ್‌ಶಾಟ್ JSON.';

  @override
  String get pasteBackupHint =>
      'ಮರುಸ್ಥಾಪಿಸಲು ರಫ್ತು ಮಾಡಿದ ಬ್ಯಾಕಪ್ JSON ಅನ್ನು ಇಲ್ಲಿ ಅಂಟಿಸಿ';

  @override
  String get driveComingSoonNote =>
      'Google Drive ಎನ್‌ಕ್ರಿಪ್ಟ್ ಸಿಂಕ್ ಹಂತ 6 ರಲ್ಲಿ ಬರುತ್ತದೆ.';

  @override
  String get emiPdfButton => 'EMI PDF';

  @override
  String get viewCompletePdfButton => 'ಸಂಪೂರ್ಣ ಸಾಲ PDF';

  @override
  String emiPdfGeneratedMessage(int no) {
    return 'ಕಂತು #$no ಪಾವತಿಸಲಾಗಿದೆ ಮತ್ತು PDF ದಾಖಲೆಗಳಲ್ಲಿ ಉಳಿಸಲಾಗಿದೆ.';
  }

  @override
  String emiReceiptTag(int no) {
    return 'EMI #$no ರಸೀದಿ';
  }

  @override
  String get completeLoanPdfTag => 'ಸಂಪೂರ್ಣ ಸಾಲ PDF';

  @override
  String get emiCalculatorTitle => 'EMI ಕ್ಯಾಲ್ಕುಲೇಟರ್';

  @override
  String get emiCalculatorSubtitle =>
      'ಸಾಲ ರಚಿಸುವ ಮೊದಲು ಮಾಸಿಕ ಕಂತು, ಒಟ್ಟು ಬಡ್ಡಿ ಮತ್ತು ಮರುಪಾವತಿ ವೇಳಾಪಟ್ಟಿಯನ್ನು ಅಂದಾಜು ಮಾಡಿ.';

  @override
  String get principalShareLabel => 'ಅಸಲು ಪಾಲು';

  @override
  String get interestShareLabel => 'ಬಡ್ಡಿ ಪಾಲು';

  @override
  String get resetFieldsButton => 'ಮರುಹೊಂದಿಸಿ';

  @override
  String get proceedToCreateLoanButton => 'ಈ ನಿಯಮಗಳೊಂದಿಗೆ ಸಾಲ ರಚಿಸಿ';

  @override
  String get schedulePreviewHeading => 'ವೇಳಾಪಟ್ಟಿ ಮುನ್ನೋಟ';

  @override
  String get enterTermsForEstimate =>
      'EMI ಅಂದಾಜು ನೋಡಲು ಅಸಲು, ಮಾಸಿಕ ಬಡ್ಡಿ ದರ ಮತ್ತು ಅವಧಿಯನ್ನು ನಮೂದಿಸಿ.';

  @override
  String get systemDefaultLanguage => 'ಸಿಸ್ಟಮ್ ಡೀಫಾಲ್ಟ್';

  @override
  String get choosePhotoTitle => 'ಪ್ರೊಫೈಲ್ ಫೋಟೋ';

  @override
  String get pickFromGallery => 'ಗ್ಯಾಲರಿಯಿಂದ ಆಯ್ಕೆಮಾಡಿ';

  @override
  String get takePhoto => 'ಫೋಟೋ ತೆಗೆಯಿರಿ';

  @override
  String get removePhoto => 'ಫೋಟೋ ತೆಗೆದುಹಾಕಿ';

  @override
  String get changeAvatarColor => 'ಬ್ಯಾಡ್ಜ್ ಬಣ್ಣ ಬದಲಾಯಿಸಿ';

  @override
  String get photoPickFailedError =>
      'ಆಯ್ಕೆಮಾಡಿದ ಚಿತ್ರವನ್ನು ಲೋಡ್ ಮಾಡಲು ಸಾಧ್ಯವಾಗಲಿಲ್ಲ.';

  @override
  String get databaseError =>
      'ಡೇಟಾವನ್ನು ಸ್ಥಳೀಯವಾಗಿ ಉಳಿಸಲು ಸಾಧ್ಯವಾಗಲಿಲ್ಲ. ದಯವಿಟ್ಟು ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.';

  @override
  String get onboardingSkip => 'ಬಿಟ್ಟುಬಿಡಿ';

  @override
  String get onboardingStart => 'ಪ್ರಾರಂಭಿಸಿ';

  @override
  String get onboardingNext => 'ಮುಂದೆ';

  @override
  String get onboardingTitle1 => 'ಸ್ಮಾರ್ಟ್ ಸಾಲ ಕೇಂದ್ರ';

  @override
  String get onboardingSubtitle1 =>
      'ಗ್ರಾಹಕರನ್ನು ನಿರ್ವಹಿಸಿ, ಸರಳ ಅಥವಾ ಚಕ್ರಬಡ್ಡಿ ಸಾಲಗಳನ್ನು ಆಫ್‌ಲೈನ್‌ನಲ್ಲಿ ರಚಿಸಿ.';

  @override
  String get onboardingTitle2 => 'EMI ಮತ್ತು ಲೆಡ್ಜರ್ ಟ್ರ್ಯಾಕ್';

  @override
  String get onboardingSubtitle2 =>
      'ತಿಂಗಳ ಕಂತುಗಳು, ಅಂತಿಮ ದಿನಾಂಕಗಳು ಮತ್ತು ವಸೂಲಾತಿಯನ್ನು ಒಂದೇ ನೋಟದಲ್ಲಿ ಗಮನಿಸಿ.';

  @override
  String get onboardingTitle3 => 'ತ್ವರಿತ ಸಾಲ ಒಪ್ಪಂದಗಳು';

  @override
  String get onboardingSubtitle3 =>
      'ಪೂರ್ಣ ಪಾವತಿಯ ನಂತರ 13 ಭಾಷೆಗಳಲ್ಲಿ ಸ್ವಯಂಚಾಲಿತವಾಗಿ A4 ಸಾಲ ಒಪ್ಪಂದ PDF ರಚಿಸಿ.';
}
