// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'LoanWise';

  @override
  String get splashTagline => 'Smart Lending & EMI Ledger';

  @override
  String get loginTitle => 'Login';

  @override
  String get nameLabel => 'Name';

  @override
  String get nameHint => 'Enter your full name';

  @override
  String get mobileLabel => 'Mobile number';

  @override
  String get mobileHint => '10-digit mobile number';

  @override
  String get emailLabel => 'Email ID';

  @override
  String get emailHint => 'name@example.com';

  @override
  String get signInButton => 'Sign in';

  @override
  String get errorNameRequired => 'Please enter your name';

  @override
  String get errorMobileInvalid =>
      'Enter a 10 digit mobile number starting with 6 to 9';

  @override
  String get errorEmailInvalid => 'Enter a valid email address';

  @override
  String get navHome => 'Home';

  @override
  String get navCustomers => 'Customers';

  @override
  String get navLoans => 'Loans';

  @override
  String get navProfile => 'Profile';

  @override
  String get welcomeBack => 'Welcome back,';

  @override
  String get openMenuTooltip => 'Open menu';

  @override
  String get openProfileTooltip => 'Open profile';

  @override
  String get totalLentLabel => 'Total Lent';

  @override
  String get availableToCollect => 'Available to collect';

  @override
  String get activeLoansLabel => 'Active loans';

  @override
  String get customersLabel => 'Customers';

  @override
  String get emisDueThisMonthLabel => 'EMIs due this month';

  @override
  String get quickActionsHeading => 'Quick Actions';

  @override
  String get actionAddCustomer => 'Add Customer';

  @override
  String get actionCreateLoan => 'Create Loan';

  @override
  String get actionLoans => 'Loans';

  @override
  String get actionDocuments => 'Documents';

  @override
  String get actionAllCustomers => 'All Customers';

  @override
  String get actionProfile => 'Profile';

  @override
  String get thisMonthHeading => 'This Month';

  @override
  String get viewAll => 'View all';

  @override
  String get collectedThisMonth => 'Collected this month';

  @override
  String get pendingThisMonth => 'Pending this month';

  @override
  String get recentLoansHeading => 'Recent Loans';

  @override
  String get overdueEmisHeading => 'Overdue EMIs';

  @override
  String get statusActive => 'Active';

  @override
  String get statusCompleted => 'Completed';

  @override
  String get statusOverdue => 'Overdue';

  @override
  String get statusPending => 'Pending';

  @override
  String get statusPaid => 'Paid';

  @override
  String nextEmiLabel(String date) {
    return 'Next EMI: $date';
  }

  @override
  String dueSinceLabel(String date) {
    return 'Due: $date';
  }

  @override
  String get emptyRecentLoans =>
      'No recent loans yet. Create a loan to see activity here.';

  @override
  String get emptyOverdueEmis =>
      'All caught up. No overdue EMIs at the moment.';

  @override
  String get drawerBackupRestore => 'Backup and restore';

  @override
  String get drawerChangeTheme => 'Change theme';

  @override
  String get drawerChooseLanguage => 'Choose language';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeSystem => 'System';

  @override
  String get backupDialogMessage =>
      'Local backup is up to date for your device.';

  @override
  String get closeAction => 'Close';

  @override
  String featureQueuedMessage(String feature) {
    return '$feature is ready.';
  }

  @override
  String get tabCustomersSubtitle =>
      'Manage borrowers, contact details, and active loan records.';

  @override
  String get tabLoansSubtitle =>
      'Track active disbursements, interest, and EMI schedules.';

  @override
  String get tabProfileSubtitle =>
      'Your registered lender details and workspace preferences.';

  @override
  String get signOutAction => 'Sign out';

  @override
  String get addCustomerTitle => 'Add Customer';

  @override
  String get editCustomerTitle => 'Edit Customer';

  @override
  String get customerNameLabel => 'Customer name';

  @override
  String get customerEmailLabel => 'Customer email';

  @override
  String get customerMobileLabel => 'Mobile number';

  @override
  String get customerLocationLabel => 'Location';

  @override
  String get locationRequiredError => 'Please enter a location';

  @override
  String get saveCustomerButton => 'Save Customer';

  @override
  String get updateCustomerButton => 'Update Customer';

  @override
  String get customerAddedTitle => 'Customer added successfully';

  @override
  String customerAddedMessage(String name) {
    return 'Would you like to create a loan for $name now?';
  }

  @override
  String get laterButton => 'Later';

  @override
  String get searchCustomersHint => 'Search by name or mobile';

  @override
  String get noCustomersTitle => 'No customers found';

  @override
  String get noCustomersSubtitle => 'Tap + to add your first borrower.';

  @override
  String get editCustomerMenu => 'Edit customer details';

  @override
  String get deleteCustomerMenu => 'Delete customer';

  @override
  String get createLoanMenu => 'Create loan';

  @override
  String get deleteCustomerConfirmTitle => 'Delete customer?';

  @override
  String deleteCustomerConfirmMessage(String name) {
    return 'This will archive $name from your active customer list.';
  }

  @override
  String get deleteAction => 'Delete';

  @override
  String get cancelAction => 'Cancel';

  @override
  String get activeLoanDeleteBlocked =>
      'Cannot delete a customer who still has an active loan.';

  @override
  String get duplicateMobileError =>
      'A customer with this mobile number already exists.';

  @override
  String get customerDetailTitle => 'Customer Details';

  @override
  String get callAction => 'Call';

  @override
  String get smsAction => 'SMS';

  @override
  String get customerLoansHeading => 'Customer Loans';

  @override
  String get mobileLockedHelper =>
      'Mobile number cannot be changed once loans exist.';

  @override
  String activeLoansCountLabel(int count) {
    return '$count active';
  }

  @override
  String get createLoanTitle => 'Create Loan';

  @override
  String get searchCustomerMobileHint => 'Enter 10-digit customer mobile';

  @override
  String get noCustomerWithMobile => 'No customer with this mobile';

  @override
  String get addCustomerShortcut => 'Add customer';

  @override
  String get principalLabel => 'Principal amount (₹)';

  @override
  String get monthlyRateLabel => 'Interest rate (% per month)';

  @override
  String get tenureMonthsLabel => 'Tenure (months)';

  @override
  String get loanTypeLabel => 'Interest type';

  @override
  String get loanTypeSimple => 'Simple';

  @override
  String get loanTypeCompound => 'Compound';

  @override
  String get startDateLabel => 'Start date';

  @override
  String get livePreviewHeading => 'Live EMI Preview';

  @override
  String get monthlyEmiLabel => 'Monthly EMI';

  @override
  String get totalInterestLabel => 'Total interest';

  @override
  String get totalPayableLabel => 'Total payable';

  @override
  String get createLoanButton => 'Create Loan';

  @override
  String get loanCreatedTitle => 'Loan created successfully';

  @override
  String loanCreatedMessage(int count) {
    return '$count monthly EMIs have been generated.';
  }

  @override
  String get viewLoanOverview => 'Open Loan Overview';

  @override
  String get allLoansFilter => 'All';

  @override
  String get activeLoansFilter => 'Active';

  @override
  String get completedLoansFilter => 'Completed';

  @override
  String get noLoansTitle => 'No loans yet';

  @override
  String get noLoansSubtitle => 'Create a loan to generate its EMI schedule.';

  @override
  String get selectCustomerError =>
      'Select a customer by 10-digit mobile first.';

  @override
  String get invalidPrincipalError =>
      'Enter a principal amount greater than 0.';

  @override
  String get invalidRateError => 'Enter a monthly rate between 0 and 100.';

  @override
  String get invalidTenureError => 'Enter a tenure between 1 and 600 months.';

  @override
  String get loanOverviewTitle => 'Loan Overview';

  @override
  String get emiScheduleHeading => 'EMI Schedule';

  @override
  String get payButton => 'Pay';

  @override
  String get payAllPendingButton => 'Pay all pending EMIs';

  @override
  String confirmPayEmiTitle(int no) {
    return 'Mark EMI #$no paid?';
  }

  @override
  String confirmPayEmiMessage(String amount) {
    return 'Confirm payment of $amount.';
  }

  @override
  String get paymentDateLabel => 'Payment date';

  @override
  String get confirmPayAllTitle => 'Pay all pending EMIs?';

  @override
  String confirmPayAllMessage(int count, String amount) {
    return 'This will mark $count remaining EMIs ($amount) as paid and generate the Loan Agreement PDF.';
  }

  @override
  String installmentLabel(int no) {
    return 'Installment #$no';
  }

  @override
  String paidOnLabel(String date) {
    return 'Paid: $date';
  }

  @override
  String get outOfOrderEmiError =>
      'Please pay earlier pending installments in order first.';

  @override
  String emiPaidSuccess(int no) {
    return 'Installment #$no marked as paid.';
  }

  @override
  String get loanCompletedPdfGenerated =>
      'Loan completed! Loan Agreement PDF saved to Documents.';

  @override
  String get viewPdfAction => 'View PDF';

  @override
  String get openDocumentsAction => 'Open Documents';

  @override
  String progressPaidLabel(int paid, int total) {
    return '$paid of $total EMIs paid';
  }

  @override
  String get ledgerHeading => 'Ledger History';

  @override
  String get ledgerDebitLabel => 'Debit';

  @override
  String get ledgerCreditLabel => 'Credit';

  @override
  String get ledgerBalanceLabel => 'Balance';

  @override
  String get documentsTitle => 'Documents';

  @override
  String get noDocumentsTitle => 'No PDF documents yet';

  @override
  String get noDocumentsSubtitle =>
      'Loan Agreements appear here automatically once a loan is fully paid.';

  @override
  String get viewPdfMenu => 'View PDF';

  @override
  String get sharePdfMenu => 'Share PDF';

  @override
  String get deletePdfMenu => 'Delete PDF';

  @override
  String get editPdfMenu => 'Edit PDF';

  @override
  String get deletePdfConfirmTitle => 'Delete document?';

  @override
  String get deletePdfConfirmMessage =>
      'This removes the generated Loan Agreement from Documents.';

  @override
  String pagesCountLabel(int count) {
    return '$count pages';
  }

  @override
  String get documentViewerTitle => 'Loan Agreement Viewer';

  @override
  String get loanAgreementHeadline => 'Loan Agreement';

  @override
  String get lenderDetailsHeading => 'Lender Details';

  @override
  String get borrowerDetailsHeading => 'Borrower Details';

  @override
  String get installmentScheduleHeading => 'Installment Schedule';

  @override
  String get generatedOnLabel => 'Generated on';

  @override
  String get documentIdLabel => 'Document ID';

  @override
  String pageOfLabel(int current, int total) {
    return 'Page $current of $total';
  }

  @override
  String get signatureLender => 'Lender Signature';

  @override
  String get signatureBorrower => 'Borrower Signature';

  @override
  String get editPdfTitle => 'Edit PDF';

  @override
  String get snapshotNotice =>
      'Changes only update this PDF snapshot and never alter the original loan or ledger.';

  @override
  String get pdfLanguageLabel => 'Document language';

  @override
  String get statusTextLabel => 'Status label';

  @override
  String get previewButton => 'Preview';

  @override
  String get regeneratePdfButton => 'Regenerate PDF';

  @override
  String get pdfRegeneratedSuccess => 'Document regenerated successfully.';

  @override
  String shareReadyMessage(String title, int pages) {
    return 'Prepared $title ($pages pages) for sharing.';
  }

  @override
  String get copyHtmlAction => 'Copy HTML';

  @override
  String get htmlCopiedMessage => 'A4 HTML copied to clipboard.';

  @override
  String get saveChangesButton => 'Save Changes';

  @override
  String get profileUpdatedSuccess => 'Profile updated successfully.';

  @override
  String get signOutConfirmTitle => 'Sign out?';

  @override
  String get signOutConfirmMessage =>
      'You can sign back in anytime with your lender details.';

  @override
  String get totalLoansStatLabel => 'Total loans';

  @override
  String get documentsStatLabel => 'Documents';

  @override
  String get backupTitle => 'Backup and Restore';

  @override
  String get backupSubtitle =>
      'Export an encrypted-ready local snapshot or restore your lending ledger.';

  @override
  String get exportBackupButton => 'Create Local Backup';

  @override
  String get restoreBackupButton => 'Restore Snapshot';

  @override
  String get backupGeneratedMessage =>
      'Backup snapshot created and copied to clipboard.';

  @override
  String get restoreSuccessMessage => 'Backup snapshot restored successfully.';

  @override
  String get restoreInvalidError => 'Invalid backup snapshot JSON.';

  @override
  String get pasteBackupHint => 'Paste exported backup JSON here to restore';

  @override
  String get driveComingSoonNote =>
      'Google Drive encrypted AppData sync is scheduled for Stage 6.';

  @override
  String get emiPdfButton => 'EMI PDF';

  @override
  String get viewCompletePdfButton => 'Complete Loan PDF';

  @override
  String emiPdfGeneratedMessage(int no) {
    return 'Installment #$no paid and PDF saved to Documents.';
  }

  @override
  String emiReceiptTag(int no) {
    return 'EMI #$no Receipt';
  }

  @override
  String get completeLoanPdfTag => 'Complete Loan PDF';

  @override
  String get emiCalculatorTitle => 'EMI Calculator';

  @override
  String get emiCalculatorSubtitle =>
      'Estimate monthly payments, total interest, and repayment schedule before creating a loan.';

  @override
  String get principalShareLabel => 'Principal share';

  @override
  String get interestShareLabel => 'Interest share';

  @override
  String get resetFieldsButton => 'Reset';

  @override
  String get proceedToCreateLoanButton => 'Proceed to Create Loan';

  @override
  String get schedulePreviewHeading => 'Schedule Preview';

  @override
  String get enterTermsForEstimate =>
      'Enter principal, monthly rate, and duration to see your EMI estimate.';

  @override
  String get systemDefaultLanguage => 'System default';

  @override
  String get choosePhotoTitle => 'Profile photo';

  @override
  String get pickFromGallery => 'Choose from gallery';

  @override
  String get takePhoto => 'Take photo';

  @override
  String get removePhoto => 'Remove photo';

  @override
  String get changeAvatarColor => 'Change badge color';

  @override
  String get photoPickFailedError => 'Could not load selected image.';

  @override
  String get databaseError => 'Could not save data locally. Please try again.';

  @override
  String get onboardingSkip => 'Skip';

  @override
  String get onboardingStart => 'Start';

  @override
  String get onboardingNext => 'Next';

  @override
  String get onboardingTitle1 => 'SMART LENDING HUB';

  @override
  String get onboardingSubtitle1 =>
      'Manage borrowers, create simple or compound loans, and stay organized offline.';

  @override
  String get onboardingTitle2 => 'TRACK EMIS & LEDGER';

  @override
  String get onboardingSubtitle2 =>
      'Monitor monthly installments, due dates, and collections at a glance.';

  @override
  String get onboardingTitle3 => 'INSTANT LOAN AGREEMENTS';

  @override
  String get onboardingSubtitle3 =>
      'Generate A4 Loan Agreements automatically in 13 languages once paid.';
}
