// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Oriya (`or`).
class AppLocalizationsOr extends AppLocalizations {
  AppLocalizationsOr([String locale = 'or']) : super(locale);

  @override
  String get appTitle => 'LoanWise';

  @override
  String get splashTagline => 'ସ୍ମାର୍ଟ ଋଣ ଏବଂ EMI ଖାତା';

  @override
  String get loginTitle => 'ଲଗଇନ୍';

  @override
  String get nameLabel => 'ନାମ';

  @override
  String get nameHint => 'ଆପଣଙ୍କ ସମ୍ପୂର୍ଣ୍ଣ ନାମ ଦିଅନ୍ତୁ';

  @override
  String get mobileLabel => 'ମୋବାଇଲ୍ ନମ୍ବର';

  @override
  String get mobileHint => '10 ଅଙ୍କ ବିଶିଷ୍ଟ ମୋବାଇଲ୍ ନମ୍ବର';

  @override
  String get emailLabel => 'ଇମେଲ୍ ଆଇଡି';

  @override
  String get emailHint => 'name@example.com';

  @override
  String get signInButton => 'ସାଇନ୍ ଇନ୍';

  @override
  String get errorNameRequired => 'ଦୟାକରି ଆପଣଙ୍କ ନାମ ଦିଅନ୍ତୁ';

  @override
  String get errorMobileInvalid =>
      '6 ରୁ 9 ମଧ୍ୟରେ ଆରମ୍ଭ ହେଉଥିବା 10 ଅଙ୍କର ମୋବାଇଲ୍ ନମ୍ବର ଦିଅନ୍ତୁ';

  @override
  String get errorEmailInvalid => 'ଏକ ବୈଧ ଇମେଲ୍ ଠିକଣା ଦିଅନ୍ତୁ';

  @override
  String get navHome => 'ହୋମ୍';

  @override
  String get navCustomers => 'ଗ୍ରାହକ';

  @override
  String get navLoans => 'ଋଣ';

  @override
  String get navProfile => 'ପ୍ରୋଫାଇଲ୍';

  @override
  String get welcomeBack => 'ପୁନଃ ସ୍ୱାଗତ,';

  @override
  String get openMenuTooltip => 'ମେନୁ ଖୋଲନ୍ତୁ';

  @override
  String get openProfileTooltip => 'ପ୍ରୋଫାଇଲ୍ ଖୋଲନ୍ତୁ';

  @override
  String get totalLentLabel => 'ମୋଟ ଦିଆଯାଇଥିବା ଋଣ';

  @override
  String get availableToCollect => 'ଆଦାୟ ପାଇଁ ବାକି';

  @override
  String get activeLoansLabel => 'ସକ୍ରିୟ ଋଣ';

  @override
  String get customersLabel => 'ଗ୍ରାହକ';

  @override
  String get emisDueThisMonthLabel => 'ଏହି ମାସର EMI';

  @override
  String get quickActionsHeading => 'ତ୍ୱରିତ କାର୍ଯ୍ୟ';

  @override
  String get actionAddCustomer => 'ଗ୍ରାହକ ଯୋଡନ୍ତୁ';

  @override
  String get actionCreateLoan => 'ଋଣ ସୃଷ୍ଟି କରନ୍ତୁ';

  @override
  String get actionLoans => 'ଋଣ';

  @override
  String get actionDocuments => 'ଦଲିଲ';

  @override
  String get actionAllCustomers => 'ସମସ୍ତ ଗ୍ରାହକ';

  @override
  String get actionProfile => 'ପ୍ରୋଫାଇଲ୍';

  @override
  String get thisMonthHeading => 'ଏହି ମାସ';

  @override
  String get viewAll => 'ସବୁ ଦେଖନ୍ତୁ';

  @override
  String get collectedThisMonth => 'ଏହି ମାସରେ ଆଦାୟ';

  @override
  String get pendingThisMonth => 'ଏହି ମାସରେ ବାକି';

  @override
  String get recentLoansHeading => 'ସାମ୍ପ୍ରତିକ ଋଣ';

  @override
  String get overdueEmisHeading => 'ବାକି ପଡ଼ିଥିବା EMI';

  @override
  String get statusActive => 'ସକ୍ରିୟ';

  @override
  String get statusCompleted => 'ସମ୍ପୂର୍ଣ୍ଣ';

  @override
  String get statusOverdue => 'ଅତିବାହିତ';

  @override
  String get statusPending => 'ବାକି';

  @override
  String get statusPaid => 'ପରିଶୋଧିତ';

  @override
  String nextEmiLabel(String date) {
    return 'ପରବର୍ତ୍ତୀ EMI: $date';
  }

  @override
  String dueSinceLabel(String date) {
    return 'ଦେୟ ତାରିଖ: $date';
  }

  @override
  String get emptyRecentLoans =>
      'ଏପର୍ଯ୍ୟନ୍ତ କୌଣସି ସାମ୍ପ୍ରତିକ ଋଣ ନାହିଁ। ଦେଖିବା ପାଇଁ ଏକ ଋଣ ସୃଷ୍ଟି କରନ୍ତୁ।';

  @override
  String get emptyOverdueEmis => 'ସବୁ ଠିକ୍ ଅଛି। କୌଣସି ବାକି EMI ନାହିଁ।';

  @override
  String get drawerBackupRestore => 'ବ୍ୟାକଅପ୍ ଏବଂ ପୁନରୁଦ୍ଧାର';

  @override
  String get drawerChangeTheme => 'ଥିମ୍ ବଦଳାନ୍ତୁ';

  @override
  String get drawerChooseLanguage => 'ଭାଷା ବାଛନ୍ତୁ';

  @override
  String get themeLight => 'ଲାଇଟ୍';

  @override
  String get themeDark => 'ଡାର୍କ';

  @override
  String get themeSystem => 'ସିଷ୍ଟମ୍';

  @override
  String get backupDialogMessage =>
      'ଆପଣଙ୍କ ଡିଭାଇସ୍ ପାଇଁ ଲୋକାଲ୍ ବ୍ୟାକଅପ୍ ଅଦ୍ୟତନ ଅଛି।';

  @override
  String get closeAction => 'ବନ୍ଦ କରନ୍ତୁ';

  @override
  String featureQueuedMessage(String feature) {
    return '$feature ପ୍ରସ୍ତୁତ ଅଛି।';
  }

  @override
  String get tabCustomersSubtitle =>
      'ଋଣଗ୍ରହୀତା, ଯୋଗାଯୋଗ ତଥ୍ୟ ଏବଂ ସକ୍ରିୟ ଋଣ ପରିଚାଳନା କରନ୍ତୁ।';

  @override
  String get tabLoansSubtitle => 'ସକ୍ରିୟ ଋଣ, ସୁଧ ଏବଂ EMI ସୂଚୀ ଦେଖନ୍ତୁ।';

  @override
  String get tabProfileSubtitle => 'ଆପଣଙ୍କ ପଞ୍ଜୀକୃତ ଋଣଦାତା ବିବରଣୀ ଏବଂ ପସନ୍ଦ।';

  @override
  String get signOutAction => 'ସାଇନ୍ ଆଉଟ୍';

  @override
  String get addCustomerTitle => 'ଗ୍ରାହକ ଯୋଡନ୍ତୁ';

  @override
  String get editCustomerTitle => 'ଗ୍ରାହକ ସମ୍ପାଦନ କରନ୍ତୁ';

  @override
  String get customerNameLabel => 'ଗ୍ରାହକଙ୍କ ନାମ';

  @override
  String get customerEmailLabel => 'ଗ୍ରାହକଙ୍କ ଇମେଲ୍';

  @override
  String get customerMobileLabel => 'ମୋବାଇଲ୍ ନମ୍ବର';

  @override
  String get customerLocationLabel => 'ସ୍ଥାନ';

  @override
  String get locationRequiredError => 'ଦୟାକରି ସ୍ଥାନ ଦିଅନ୍ତୁ';

  @override
  String get saveCustomerButton => 'ଗ୍ରାହକ ସଞ୍ଚୟ କରନ୍ତୁ';

  @override
  String get updateCustomerButton => 'ଗ୍ରାହକ ଅଦ୍ୟତନ କରନ୍ତୁ';

  @override
  String get customerAddedTitle => 'ଗ୍ରାହକ ସଫଳତାର ସହ ଯୋଡାଗଲା';

  @override
  String customerAddedMessage(String name) {
    return 'ଆପଣ ବର୍ତ୍ତମାନ $name ପାଇଁ ଏକ ଋଣ ସୃଷ୍ଟି କରିବାକୁ ଚାହୁଁଛନ୍ତି କି?';
  }

  @override
  String get laterButton => 'ପରେ';

  @override
  String get searchCustomersHint => 'ନାମ କିମ୍ବା ମୋବାଇଲ୍ ଦ୍ୱାରା ଖୋଜନ୍ତୁ';

  @override
  String get noCustomersTitle => 'କୌଣସି ଗ୍ରାହକ ମିଳିଲା ନାହିଁ';

  @override
  String get noCustomersSubtitle => 'ପ୍ରଥମ ଗ୍ରାହକ ଯୋଡିବାକୁ + ଟ୍ୟାପ୍ କରନ୍ତୁ।';

  @override
  String get editCustomerMenu => 'ତଥ୍ୟ ସମ୍ପାଦନ କରନ୍ତୁ';

  @override
  String get deleteCustomerMenu => 'ଗ୍ରାହକ ବିଲୋପ କରନ୍ତୁ';

  @override
  String get createLoanMenu => 'ଋଣ ସୃଷ୍ଟି କରନ୍ତୁ';

  @override
  String get deleteCustomerConfirmTitle => 'ଗ୍ରାହକ ବିଲୋପ କରିବେ?';

  @override
  String deleteCustomerConfirmMessage(String name) {
    return 'ଏହା $name କୁ ସକ୍ରିୟ ତାଲିକାରୁ ହଟାଇ ଦେବ।';
  }

  @override
  String get deleteAction => 'ବିଲୋପ';

  @override
  String get cancelAction => 'ବାତିଲ୍';

  @override
  String get activeLoanDeleteBlocked =>
      'ସକ୍ରିୟ ଋଣ ଥିବା ଗ୍ରାହକଙ୍କୁ ବିଲୋପ କରାଯାଇପାରିବ ନାହିଁ।';

  @override
  String get duplicateMobileError =>
      'ଏହି ମୋବାଇଲ୍ ନମ୍ବରରେ ଏକ ଗ୍ରାହକ ପୂର୍ବରୁ ଅଛନ୍ତି।';

  @override
  String get customerDetailTitle => 'ଗ୍ରାହକ ବିବରଣୀ';

  @override
  String get callAction => 'କଲ୍';

  @override
  String get smsAction => 'SMS';

  @override
  String get customerLoansHeading => 'ଗ୍ରାହକଙ୍କ ଋଣ';

  @override
  String get mobileLockedHelper => 'ଋଣ ଥିଲେ ମୋବାଇଲ୍ ନମ୍ବର ବଦଳାଯାଇପାରିବ ନାହିଁ।';

  @override
  String activeLoansCountLabel(int count) {
    return '$count ସକ୍ରିୟ';
  }

  @override
  String get createLoanTitle => 'ଋଣ ସୃଷ୍ଟି କରନ୍ତୁ';

  @override
  String get searchCustomerMobileHint => '10 ଅଙ୍କର ମୋବାଇଲ୍ ଦିଅନ୍ତୁ';

  @override
  String get noCustomerWithMobile =>
      'ଏହି ମୋବାଇଲ୍ ନମ୍ବରରେ କୌଣସି ଗ୍ରାହକ ନାହାନ୍ତି';

  @override
  String get addCustomerShortcut => 'ଗ୍ରାହକ ଯୋଡନ୍ତୁ';

  @override
  String get principalLabel => 'ମୂଳଧନ (₹)';

  @override
  String get monthlyRateLabel => 'ମାସିକ ସୁଧ ହାର (%)';

  @override
  String get tenureMonthsLabel => 'ସମୟସୀମା (ମାସ)';

  @override
  String get loanTypeLabel => 'ସୁଧ ପ୍ରକାର';

  @override
  String get loanTypeSimple => 'ସରଳ ସୁଧ';

  @override
  String get loanTypeCompound => 'ଚକ୍ରବୃଦ୍ଧି ସୁଧ';

  @override
  String get startDateLabel => 'ଆରମ୍ଭ ତାରିଖ';

  @override
  String get livePreviewHeading => 'ଲାଇଭ୍ EMI ପ୍ରିଭ୍ୟୁ';

  @override
  String get monthlyEmiLabel => 'ମାସିକ EMI';

  @override
  String get totalInterestLabel => 'ମୋଟ ସୁଧ';

  @override
  String get totalPayableLabel => 'ମୋଟ ଦେୟ';

  @override
  String get createLoanButton => 'ଋଣ ସୃଷ୍ଟି କରନ୍ତୁ';

  @override
  String get loanCreatedTitle => 'ଋଣ ସଫଳତାର ସହ ସୃଷ୍ଟି ହେଲା';

  @override
  String loanCreatedMessage(int count) {
    return '$count ମାସିକ EMI ସୃଷ୍ଟି କରାଯାଇଛି।';
  }

  @override
  String get viewLoanOverview => 'ଋଣ ସାରାଂଶ ଖୋଲନ୍ତୁ';

  @override
  String get allLoansFilter => 'ସମସ୍ତ';

  @override
  String get activeLoansFilter => 'ସକ୍ରିୟ';

  @override
  String get completedLoansFilter => 'ସମ୍ପୂର୍ଣ୍ଣ';

  @override
  String get noLoansTitle => 'ଏପର୍ଯ୍ୟନ୍ତ କୌଣସି ଋଣ ନାହିଁ';

  @override
  String get noLoansSubtitle => 'EMI ସୂଚୀ ପାଇଁ ଏକ ଋଣ ସୃଷ୍ଟି କରନ୍ତୁ।';

  @override
  String get selectCustomerError =>
      'ପ୍ରଥମେ 10 ଅଙ୍କର ମୋବାଇଲ୍ ଦ୍ୱାରା ଗ୍ରାହକ ବାଛନ୍ତୁ।';

  @override
  String get invalidPrincipalError => '0 ରୁ ଅଧିକ ମୂଳଧନ ଦିଅନ୍ତୁ।';

  @override
  String get invalidRateError => '0 ରୁ 100 ମଧ୍ୟରେ ମାସିକ ହାର ଦିଅନ୍ତୁ।';

  @override
  String get invalidTenureError => '1 ରୁ 600 ମାସ ମଧ୍ୟରେ ସମୟ ଦିଅନ୍ତୁ।';

  @override
  String get loanOverviewTitle => 'ଋଣ ସାରାଂଶ';

  @override
  String get emiScheduleHeading => 'EMI ସୂଚୀ';

  @override
  String get payButton => 'ପରିଶୋଧ';

  @override
  String get payAllPendingButton => 'ସମସ୍ତ ବାକି EMI ପରିଶୋଧ କରନ୍ତୁ';

  @override
  String confirmPayEmiTitle(int no) {
    return 'EMI #$no ପରିଶୋଧିତ ଚିହ୍ନିତ କରିବେ?';
  }

  @override
  String confirmPayEmiMessage(String amount) {
    return '$amount ର ପରିଶୋଧ ନିଶ୍ଚିତ କରନ୍ତୁ।';
  }

  @override
  String get paymentDateLabel => 'ପରିଶୋଧ ତାରିଖ';

  @override
  String get confirmPayAllTitle => 'ସମସ୍ତ ବାକି EMI ପରିଶୋଧ କରିବେ?';

  @override
  String confirmPayAllMessage(int count, String amount) {
    return 'ଏହା $count ବାକି EMI ($amount) ପରିଶୋଧ କରି ଋଣ ଚୁକ୍ତି PDF ସୃଷ୍ଟି କରିବ।';
  }

  @override
  String installmentLabel(int no) {
    return 'କିସ୍ତି #$no';
  }

  @override
  String paidOnLabel(String date) {
    return 'ପରିଶୋଧ: $date';
  }

  @override
  String get outOfOrderEmiError =>
      'ଦୟାକରି ପ୍ରଥମେ ପୂର୍ବ ବାକି କିସ୍ତି କ୍ରମରେ ପରିଶୋଧ କରନ୍ତୁ।';

  @override
  String emiPaidSuccess(int no) {
    return 'କିସ୍ତି #$no ପରିଶୋଧିତ ହେଲା।';
  }

  @override
  String get loanCompletedPdfGenerated =>
      'ଋଣ ସମ୍ପୂର୍ଣ୍ଣ ହେଲା! ଚୁକ୍ତି PDF ଦଲିଲରେ ସଞ୍ଚୟ ହେଲା।';

  @override
  String get viewPdfAction => 'PDF ଦେଖନ୍ତୁ';

  @override
  String get openDocumentsAction => 'ଦଲିଲ ଖୋଲନ୍ତୁ';

  @override
  String progressPaidLabel(int paid, int total) {
    return '$total ରୁ $paid EMI ପରିଶୋଧ';
  }

  @override
  String get ledgerHeading => 'ଖାତା ଇତିହାସ';

  @override
  String get ledgerDebitLabel => 'ଡେବିଟ୍';

  @override
  String get ledgerCreditLabel => 'କ୍ରେଡିଟ୍';

  @override
  String get ledgerBalanceLabel => 'ବାକି';

  @override
  String get documentsTitle => 'ଦଲିଲ';

  @override
  String get noDocumentsTitle => 'ଏପର୍ଯ୍ୟନ୍ତ କୌଣସି PDF ଦଲିଲ ନାହିଁ';

  @override
  String get noDocumentsSubtitle =>
      'ଋଣ ସମ୍ପୂର୍ଣ୍ଣ ପରିଶୋଧ ହେଲେ ଚୁକ୍ତି ଏଠାରେ ଦେଖାଯିବ।';

  @override
  String get viewPdfMenu => 'PDF ଦେଖନ୍ତୁ';

  @override
  String get sharePdfMenu => 'PDF ସେୟାର କରନ୍ତୁ';

  @override
  String get deletePdfMenu => 'PDF ବିଲୋପ କରନ୍ତୁ';

  @override
  String get editPdfMenu => 'PDF ସମ୍ପାଦନ କରନ୍ତୁ';

  @override
  String get deletePdfConfirmTitle => 'ଦଲିଲ ବିଲୋପ କରିବେ?';

  @override
  String get deletePdfConfirmMessage => 'ଏହା ଦଲିଲରୁ ଋଣ ଚୁକ୍ତିକୁ ହଟାଇ ଦେବ।';

  @override
  String pagesCountLabel(int count) {
    return '$count ପୃଷ୍ଠା';
  }

  @override
  String get documentViewerTitle => 'ଋଣ ଚୁକ୍ତି ଦର୍ଶକ';

  @override
  String get loanAgreementHeadline => 'ଋଣ ଚୁକ୍ତି';

  @override
  String get lenderDetailsHeading => 'ଋଣଦାତା ବିବରଣୀ';

  @override
  String get borrowerDetailsHeading => 'ଋଣଗ୍ରହୀତା ବିବରଣୀ';

  @override
  String get installmentScheduleHeading => 'କିସ୍ତି ସୂଚୀ';

  @override
  String get generatedOnLabel => 'ପ୍ରସ୍ତୁତ ତାରିଖ';

  @override
  String get documentIdLabel => 'ଦଲିଲ ID';

  @override
  String pageOfLabel(int current, int total) {
    return 'ପୃଷ୍ଠା $current / $total';
  }

  @override
  String get signatureLender => 'ଋଣଦାତାଙ୍କ ସ୍ୱାକ୍ଷର';

  @override
  String get signatureBorrower => 'ଋଣଗ୍ରହୀତାଙ୍କ ସ୍ୱାକ୍ଷର';

  @override
  String get editPdfTitle => 'PDF ସମ୍ପାଦନ';

  @override
  String get snapshotNotice =>
      'ପରିବର୍ତ୍ତନ କେବଳ ଏହି PDF ସ୍ନାପସଟ୍ କୁ ଅଦ୍ୟତନ କରେ; ମୂଳ ଋଣ କିମ୍ବା ଖାତା ବଦଳେ ନାହିଁ।';

  @override
  String get pdfLanguageLabel => 'ଦଲିଲର ଭାଷା';

  @override
  String get statusTextLabel => 'ସ୍ଥିତି ଲେଖା';

  @override
  String get previewButton => 'ପ୍ରିଭ୍ୟୁ';

  @override
  String get regeneratePdfButton => 'PDF ପୁନଃ ସୃଷ୍ଟି';

  @override
  String get pdfRegeneratedSuccess => 'ଦଲିଲ ସଫଳତାର ସହ ପୁନଃ ସୃଷ୍ଟି ହେଲା।';

  @override
  String shareReadyMessage(String title, int pages) {
    return 'ସେୟାର ପାଇଁ $title ($pages ପୃଷ୍ଠା) ପ୍ରସ୍ତୁତ।';
  }

  @override
  String get copyHtmlAction => 'HTML କପି କରନ୍ତୁ';

  @override
  String get htmlCopiedMessage => 'A4 HTML କ୍ଲିପ୍‌ବୋର୍ଡକୁ କପି ହେଲା।';

  @override
  String get saveChangesButton => 'ପରିବର୍ତ୍ତନ ସଞ୍ଚୟ';

  @override
  String get profileUpdatedSuccess => 'ପ୍ରୋଫାଇଲ୍ ସଫଳତାର ସହ ଅଦ୍ୟତନ ହେଲା।';

  @override
  String get signOutConfirmTitle => 'ସାଇନ୍ ଆଉଟ୍?';

  @override
  String get signOutConfirmMessage =>
      'ଆପଣ ଯେକୌଣସି ସମୟରେ ପୁଣି ସାଇନ୍ ଇନ୍ କରିପାରିବେ।';

  @override
  String get totalLoansStatLabel => 'ମୋଟ ଋଣ';

  @override
  String get documentsStatLabel => 'ଦଲିଲ';

  @override
  String get backupTitle => 'ବ୍ୟାକଅପ୍ ଏବଂ ପୁନରୁଦ୍ଧାର';

  @override
  String get backupSubtitle =>
      'ଲୋକାଲ୍ ସ୍ନାପସଟ୍ ଏକ୍ସପୋର୍ଟ କରନ୍ତୁ କିମ୍ବା ଖାତା ପୁନରୁଦ୍ଧାର କରନ୍ତୁ।';

  @override
  String get exportBackupButton => 'ଲୋକାଲ୍ ବ୍ୟାକଅପ୍ ସୃଷ୍ଟି';

  @override
  String get restoreBackupButton => 'ସ୍ନାପସଟ୍ ପୁନରୁଦ୍ଧାର';

  @override
  String get backupGeneratedMessage =>
      'ବ୍ୟାକଅପ୍ ସ୍ନାପସଟ୍ କ୍ଲିପ୍‌ବୋର୍ଡକୁ କପି ହେଲା।';

  @override
  String get restoreSuccessMessage =>
      'ବ୍ୟାକଅପ୍ ସ୍ନାପସଟ୍ ସଫଳତାର ସହ ପୁନରୁଦ୍ଧାର ହେଲା।';

  @override
  String get restoreInvalidError => 'ଅବୈଧ ବ୍ୟାକଅପ୍ JSON।';

  @override
  String get pasteBackupHint =>
      'ପୁନରୁଦ୍ଧାର ପାଇଁ ବ୍ୟାକଅପ୍ JSON ଏଠାରେ ପେଷ୍ଟ କରନ୍ତୁ';

  @override
  String get driveComingSoonNote =>
      'Google Drive ଏନକ୍ରିପ୍ଟେଡ୍ AppData ସିଙ୍କ୍ ପର୍ଯ୍ୟାୟ 6 ରେ ଆସିବ।';

  @override
  String get emiPdfButton => 'EMI PDF';

  @override
  String get viewCompletePdfButton => 'ସମ୍ପୂର୍ଣ୍ଣ ଋଣ PDF';

  @override
  String emiPdfGeneratedMessage(int no) {
    return 'କିସ୍ତି #$no ପଇଠ ହୋଇଛି ଏବଂ PDF ଡକ୍ୟୁମେଣ୍ଟରେ ସଂରକ୍ଷିତ ହୋଇଛି।';
  }

  @override
  String emiReceiptTag(int no) {
    return 'EMI #$no ରସିଦ';
  }

  @override
  String get completeLoanPdfTag => 'ସମ୍ପୂର୍ଣ୍ଣ ଋଣ PDF';

  @override
  String get emiCalculatorTitle => 'EMI କାଲକୁଲେଟର';

  @override
  String get emiCalculatorSubtitle =>
      'ଋଣ ସୃଷ୍ଟି କରିବା ପୂର୍ବରୁ ମାସିକ କିସ୍ତି, ମୋଟ ସୁଧ ଏବଂ ପରିଶୋଧ ତାଲିକା ଆକଳନ କରନ୍ତୁ।';

  @override
  String get principalShareLabel => 'ମୂଳଧନ ଅଂଶ';

  @override
  String get interestShareLabel => 'ସୁଧ ଅଂଶ';

  @override
  String get resetFieldsButton => 'ରିସେଟ୍';

  @override
  String get proceedToCreateLoanButton => 'ଏହି ସର୍ତ୍ତରେ ଋଣ ସୃଷ୍ଟି କରନ୍ତୁ';

  @override
  String get schedulePreviewHeading => 'ତାଲିକା ପୂର୍ବାବଲୋକନ';

  @override
  String get enterTermsForEstimate =>
      'EMI ଆକଳନ ଦେଖିବାକୁ ମୂଳଧନ, ମାସିକ ହାର ଏବଂ ଅବଧି ଦିଅନ୍ତୁ।';

  @override
  String get systemDefaultLanguage => 'ସିଷ୍ଟମ୍ ଡିଫଲ୍ଟ';

  @override
  String get choosePhotoTitle => 'ପ୍ରୋଫାଇଲ୍ ଫଟୋ';

  @override
  String get pickFromGallery => 'ଗ୍ୟାଲେରୀରୁ ବାଛନ୍ତୁ';

  @override
  String get takePhoto => 'ଫଟୋ ଉଠାନ୍ତୁ';

  @override
  String get removePhoto => 'ଫଟୋ ହଟାନ୍ତୁ';

  @override
  String get changeAvatarColor => 'ବ୍ୟାଜ୍ ରଙ୍ଗ ବଦଳାନ୍ତୁ';

  @override
  String get photoPickFailedError => 'ବଛାଯାଇଥିବା ଛବି ଲୋଡ୍ ହୋଇପାରିଲା ନାହିଁ।';

  @override
  String get databaseError =>
      'ତଥ୍ୟ ସ୍ଥାନୀୟ ଭାବେ ସଞ୍ଚୟ ହୋଇପାରିଲା ନାହିଁ। ଦୟାକରି ପୁଣି ଚେଷ୍ଟା କରନ୍ତୁ।';

  @override
  String get onboardingSkip => 'ଛାଡ଼ନ୍ତୁ';

  @override
  String get onboardingStart => 'ଆରମ୍ଭ କରନ୍ତୁ';

  @override
  String get onboardingNext => 'ପରବର୍ତ୍ତୀ';

  @override
  String get onboardingTitle1 => 'ସ୍ମାର୍ଟ ଋଣ ହବ୍';

  @override
  String get onboardingSubtitle1 =>
      'ଗ୍ରାହକଙ୍କୁ ପରିଚାଳନା କରନ୍ତୁ, ସରଳ କିମ୍ବା ଚକ୍ରବୃଦ୍ଧି ଋଣ ତିଆରି କରନ୍ତୁ ଏବଂ ଅଫଲାଇନରେ ସୁବ୍ୟବସ୍ଥିତ ରୁହନ୍ତୁ।';

  @override
  String get onboardingTitle2 => 'EMI ଓ ଖାତା ଟ୍ରାକ୍';

  @override
  String get onboardingSubtitle2 =>
      'ମାସିକ କିସ୍ତି, ଦେୟ ତାରିଖ ଏବଂ ଆଦାୟକୁ ଗୋଟିଏ ନଜରରେ ଦେଖନ୍ତୁ।';

  @override
  String get onboardingTitle3 => 'ତୁରନ୍ତ ଋଣ ଚୁକ୍ତିନାମା';

  @override
  String get onboardingSubtitle3 =>
      'ସମ୍ପୂର୍ଣ୍ଣ ପଇଠ ପରେ 13ଟି ଭାଷାରେ ସ୍ୱୟଂଚାଳିତ A4 ଋଣ ଚୁକ୍ତି PDF ପ୍ରସ୍ତୁତ କରନ୍ତୁ।';
}
