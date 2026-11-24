// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tamil (`ta`).
class AppLocalizationsTa extends AppLocalizations {
  AppLocalizationsTa([String locale = 'ta']) : super(locale);

  @override
  String get appTitle => 'LoanWise';

  @override
  String get splashTagline => 'ஸ்மார்ட் கடன் மற்றும் தவணை கணக்கு';

  @override
  String get loginTitle => 'உள்நுழைவு';

  @override
  String get nameLabel => 'பெயர்';

  @override
  String get nameHint => 'உங்கள் முழுப் பெயரை உள்ளிடவும்';

  @override
  String get mobileLabel => 'கைபேசி எண்';

  @override
  String get mobileHint => '10 இலக்க கைபேசி எண்';

  @override
  String get emailLabel => 'மின்னஞ்சல் ஐடி';

  @override
  String get emailHint => 'name@example.com';

  @override
  String get signInButton => 'உள்நுழையவும்';

  @override
  String get errorNameRequired => 'உங்கள் பெயரை உள்ளிடவும்';

  @override
  String get errorMobileInvalid =>
      '6 முதல் 9 வரை தொடங்கும் 10 இலக்க கைபேசி எண்ணை உள்ளிடவும்';

  @override
  String get errorEmailInvalid => 'சரியான மின்னஞ்சல் முகவரியை உள்ளிடவும்';

  @override
  String get navHome => 'முகப்பு';

  @override
  String get navCustomers => 'வாடிக்கையாளர்கள்';

  @override
  String get navLoans => 'கடன்கள்';

  @override
  String get navProfile => 'சுயவிவரம்';

  @override
  String get welcomeBack => 'மீண்டும் வருக,';

  @override
  String get openMenuTooltip => 'பட்டியலைத் திறக்கவும்';

  @override
  String get openProfileTooltip => 'சுயவிவரத்தைத் திறக்கவும்';

  @override
  String get totalLentLabel => 'மொத்த கடன் தொகை';

  @override
  String get availableToCollect => 'வசூலிக்கக் கிடைப்பது';

  @override
  String get activeLoansLabel => 'செயலில் உள்ள கடன்கள்';

  @override
  String get customersLabel => 'வாடிக்கையாளர்கள்';

  @override
  String get emisDueThisMonthLabel => 'இந்த மாத தவணைகள்';

  @override
  String get quickActionsHeading => 'விரைவுச் செயல்கள்';

  @override
  String get actionAddCustomer => 'வாடிக்கையாளர் சேர்க்க';

  @override
  String get actionCreateLoan => 'கடன் உருவாக்க';

  @override
  String get actionLoans => 'கடன்கள்';

  @override
  String get actionDocuments => 'ஆவணங்கள்';

  @override
  String get actionAllCustomers => 'அனைத்து வாடிக்கையாளர்கள்';

  @override
  String get actionProfile => 'சுயவிவரம்';

  @override
  String get thisMonthHeading => 'இந்த மாதம்';

  @override
  String get viewAll => 'அனைத்தும் பார்க்க';

  @override
  String get collectedThisMonth => 'இந்த மாதம் வசூல்';

  @override
  String get pendingThisMonth => 'இந்த மாதம் நிலுவை';

  @override
  String get recentLoansHeading => 'சமீபத்திய கடன்கள்';

  @override
  String get overdueEmisHeading => 'தாமதமான தவணைகள்';

  @override
  String get statusActive => 'செயலில்';

  @override
  String get statusCompleted => 'முடிந்தது';

  @override
  String get statusOverdue => 'தாமதம்';

  @override
  String get statusPending => 'நிலுவை';

  @override
  String get statusPaid => 'செலுத்தப்பட்டது';

  @override
  String nextEmiLabel(String date) {
    return 'அடுத்த தவணை: $date';
  }

  @override
  String dueSinceLabel(String date) {
    return 'கெடு: $date';
  }

  @override
  String get emptyRecentLoans =>
      'சமீபத்திய கடன்கள் இல்லை. தொடங்க புதிய கடன் உருவாக்கவும்.';

  @override
  String get emptyOverdueEmis =>
      'அனைத்தும் சரியாக உள்ளன. தாமதமான தவணைகள் இல்லை.';

  @override
  String get drawerBackupRestore => 'காப்பு மற்றும் மீட்டெடுப்பு';

  @override
  String get drawerChangeTheme => 'தீம் மாற்றவும்';

  @override
  String get drawerChooseLanguage => 'மொழியைத் தேர்ந்தெடுக்கவும்';

  @override
  String get themeLight => 'ஒளி';

  @override
  String get themeDark => 'இருள்';

  @override
  String get themeSystem => 'கணினி';

  @override
  String get backupDialogMessage =>
      'உங்கள் சாதனத்திற்கான உள்ளூர் காப்புப் பிரதி புதுப்பித்த நிலையில் உள்ளது.';

  @override
  String get closeAction => 'மூடு';

  @override
  String featureQueuedMessage(String feature) {
    return '$feature தயாராக உள்ளது.';
  }

  @override
  String get tabCustomersSubtitle =>
      'கடன் பெறுபவர்கள் மற்றும் தொடர்பு விவரங்களை நிர்வகிக்கவும்.';

  @override
  String get tabLoansSubtitle =>
      'செயலில் உள்ள கடன்கள் மற்றும் தவணை அட்டவணையைப் பார்க்கவும்.';

  @override
  String get tabProfileSubtitle =>
      'உங்கள் பதிவு செய்யப்பட்ட சுயவிவர விவரங்கள்.';

  @override
  String get signOutAction => 'வெளியேறு';

  @override
  String get addCustomerTitle => 'வாடிக்கையாளர் சேர்க்க';

  @override
  String get editCustomerTitle => 'வாடிக்கையாளர் திருத்து';

  @override
  String get customerNameLabel => 'வாடிக்கையாளர் பெயர்';

  @override
  String get customerEmailLabel => 'வாடிக்கையாளர் மின்னஞ்சல்';

  @override
  String get customerMobileLabel => 'கைபேசி எண்';

  @override
  String get customerLocationLabel => 'இடம்';

  @override
  String get locationRequiredError => 'இடத்தை உள்ளிடவும்';

  @override
  String get saveCustomerButton => 'வாடிக்கையாளரைச் சேமி';

  @override
  String get updateCustomerButton => 'வாடிக்கையாளரைப் புதுப்பி';

  @override
  String get customerAddedTitle => 'வாடிக்கையாளர் வெற்றிகரமாக சேர்க்கப்பட்டார்';

  @override
  String customerAddedMessage(String name) {
    return '$name என்பவருக்கு இப்போது கடன் உருவாக்க விரும்புகிறீர்களா?';
  }

  @override
  String get laterButton => 'பிறகு';

  @override
  String get searchCustomersHint => 'பெயர் அல்லது கைபேசி மூலம் தேடு';

  @override
  String get noCustomersTitle => 'வாடிக்கையாளர்கள் இல்லை';

  @override
  String get noCustomersSubtitle =>
      'முதல் வாடிக்கையாளரைச் சேர்க்க + ஐத் தட்டவும்.';

  @override
  String get editCustomerMenu => 'விவரங்களைத் திருத்து';

  @override
  String get deleteCustomerMenu => 'வாடிக்கையாளரை நீக்கு';

  @override
  String get createLoanMenu => 'கடன் உருவாக்கு';

  @override
  String get deleteCustomerConfirmTitle => 'வாடிக்கையாளரை நீக்கவா?';

  @override
  String deleteCustomerConfirmMessage(String name) {
    return 'இது $name ஐ செயலில் உள்ள பட்டியலிலிருந்து அகற்றும்.';
  }

  @override
  String get deleteAction => 'நீக்கு';

  @override
  String get cancelAction => 'ரத்து செய்';

  @override
  String get activeLoanDeleteBlocked =>
      'செயலில் உள்ள கடன் கொண்ட வாடிக்கையாளரை நீக்க முடியாது.';

  @override
  String get duplicateMobileError =>
      'இந்த கைபேசி எண்ணுடன் வாடிக்கையாளர் ஏற்கனவே உள்ளார்.';

  @override
  String get customerDetailTitle => 'வாடிக்கையாளர் விவரங்கள்';

  @override
  String get callAction => 'அழைப்பு';

  @override
  String get smsAction => 'குறுஞ்செய்தி';

  @override
  String get customerLoansHeading => 'வாடிக்கையாளர் கடன்கள்';

  @override
  String get mobileLockedHelper =>
      'கடன் உருவாக்கப்பட்ட பிறகு கைபேசி எண்ணை மாற்ற முடியாது.';

  @override
  String activeLoansCountLabel(int count) {
    return '$count செயலில்';
  }

  @override
  String get createLoanTitle => 'கடன் உருவாக்கு';

  @override
  String get searchCustomerMobileHint => '10 இலக்க கைபேசி எண்ணை உள்ளிடவும்';

  @override
  String get noCustomerWithMobile => 'இந்த கைபேசி எண்ணுடன் வாடிக்கையாளர் இல்லை';

  @override
  String get addCustomerShortcut => 'வாடிக்கையாளர் சேர்க்க';

  @override
  String get principalLabel => 'அசல் தொகை (₹)';

  @override
  String get monthlyRateLabel => 'வட்டி விகிதம் (மாதம் %)';

  @override
  String get tenureMonthsLabel => 'காலம் (மாதங்கள்)';

  @override
  String get loanTypeLabel => 'வட்டி வகை';

  @override
  String get loanTypeSimple => 'தனி வட்டி';

  @override
  String get loanTypeCompound => 'கூட்டு வட்டி';

  @override
  String get startDateLabel => 'தொடக்கத் தேதி';

  @override
  String get livePreviewHeading => 'நேரடி தவணை முன்னோட்டம்';

  @override
  String get monthlyEmiLabel => 'மாத தவணை';

  @override
  String get totalInterestLabel => 'மொத்த வட்டி';

  @override
  String get totalPayableLabel => 'மொத்த செலுத்த வேண்டியது';

  @override
  String get createLoanButton => 'கடன் உருவாக்கு';

  @override
  String get loanCreatedTitle => 'கடன் வெற்றிகரமாக உருவாக்கப்பட்டது';

  @override
  String loanCreatedMessage(int count) {
    return '$count மாதத் தவணைகள் உருவாக்கப்பட்டுள்ளன.';
  }

  @override
  String get viewLoanOverview => 'கடன் விவரம் திற';

  @override
  String get allLoansFilter => 'அனைத்தும்';

  @override
  String get activeLoansFilter => 'செயலில்';

  @override
  String get completedLoansFilter => 'முடிந்தது';

  @override
  String get noLoansTitle => 'கடன்கள் இல்லை';

  @override
  String get noLoansSubtitle => 'தவணை அட்டவணையை உருவாக்க கடன் சேர்க்கவும்.';

  @override
  String get selectCustomerError =>
      'முதலில் 10 இலக்க கைபேசி மூலம் வாடிக்கையாளரைத் தேர்ந்தெடுக்கவும்.';

  @override
  String get invalidPrincipalError => '0 ஐ விட அதிகமான அசல் தொகையை உள்ளிடவும்.';

  @override
  String get invalidRateError =>
      '0 முதல் 100 வரை மாத வட்டி விகிதம் உள்ளிடவும்.';

  @override
  String get invalidTenureError => '1 முதல் 600 மாதங்கள் வரை காலம் உள்ளிடவும்.';

  @override
  String get loanOverviewTitle => 'கடன் விவரம்';

  @override
  String get emiScheduleHeading => 'தவணை அட்டவணை';

  @override
  String get payButton => 'செலுத்து';

  @override
  String get payAllPendingButton => 'நிலுவை தவணைகளை எல்லாம் செலுத்து';

  @override
  String confirmPayEmiTitle(int no) {
    return 'தவணை #$no செலுத்தப்பட்டதாகக் குறிக்கவா?';
  }

  @override
  String confirmPayEmiMessage(String amount) {
    return '$amount செலுத்துவதை உறுதிப்படுத்தவும்.';
  }

  @override
  String get paymentDateLabel => 'செலுத்திய தேதி';

  @override
  String get confirmPayAllTitle => 'அனைத்து நிலுவை தவணைகளையும் செலுத்தவா?';

  @override
  String confirmPayAllMessage(int count, String amount) {
    return 'மீதமுள்ள $count தவணைகள் ($amount) செலுத்தப்பட்டு கடன் ஒப்பந்த PDF உருவாக்கப்படும்.';
  }

  @override
  String installmentLabel(int no) {
    return 'தவணை #$no';
  }

  @override
  String paidOnLabel(String date) {
    return 'செலுத்தியது: $date';
  }

  @override
  String get outOfOrderEmiError =>
      'முந்தைய நிலுவை தவணைகளை வரிசையாக முதலில் செலுத்தவும்.';

  @override
  String emiPaidSuccess(int no) {
    return 'தவணை #$no செலுத்தப்பட்டது.';
  }

  @override
  String get loanCompletedPdfGenerated =>
      'கடன் முடிந்தது! கடன் ஒப்பந்த PDF ஆவணங்களில் சேமிக்கப்பட்டது.';

  @override
  String get viewPdfAction => 'PDF பார்';

  @override
  String get openDocumentsAction => 'ஆவணங்கள் திற';

  @override
  String progressPaidLabel(int paid, int total) {
    return '$total இல் $paid தவணைகள் செலுத்தப்பட்டது';
  }

  @override
  String get ledgerHeading => 'கணக்குப் பதிவு';

  @override
  String get ledgerDebitLabel => 'பற்று';

  @override
  String get ledgerCreditLabel => 'வரவு';

  @override
  String get ledgerBalanceLabel => 'மீதி';

  @override
  String get documentsTitle => 'ஆவணங்கள்';

  @override
  String get noDocumentsTitle => 'PDF ஆவணங்கள் இல்லை';

  @override
  String get noDocumentsSubtitle =>
      'கடன் முழுமையாக செலுத்தப்பட்டதும் கடன் ஒப்பந்தம் தானாக இங்கே தோன்றும்.';

  @override
  String get viewPdfMenu => 'PDF பார்';

  @override
  String get sharePdfMenu => 'PDF பகிர்';

  @override
  String get deletePdfMenu => 'PDF நீக்கு';

  @override
  String get editPdfMenu => 'PDF திருத்து';

  @override
  String get deletePdfConfirmTitle => 'ஆவணத்தை நீக்கவா?';

  @override
  String get deletePdfConfirmMessage =>
      'இது உருவாக்கப்பட்ட கடன் ஒப்பந்தத்தை ஆவணங்களிலிருந்து அகற்றும்.';

  @override
  String pagesCountLabel(int count) {
    return '$count பக்கங்கள்';
  }

  @override
  String get documentViewerTitle => 'கடன் ஒப்பந்த பார்வையாளர்';

  @override
  String get loanAgreementHeadline => 'கடன் ஒப்பந்தம்';

  @override
  String get lenderDetailsHeading => 'கடன் வழங்குநர் விவரம்';

  @override
  String get borrowerDetailsHeading => 'கடன் பெறுநர் விவரம்';

  @override
  String get installmentScheduleHeading => 'தவணை அட்டவணை';

  @override
  String get generatedOnLabel => 'உருவாக்கப்பட்ட தேதி';

  @override
  String get documentIdLabel => 'ஆவண ஐடி';

  @override
  String pageOfLabel(int current, int total) {
    return 'பக்கம் $current / $total';
  }

  @override
  String get signatureLender => 'கடன் வழங்குநர் கையொப்பம்';

  @override
  String get signatureBorrower => 'கடன் பெறுநர் கையொப்பம்';

  @override
  String get editPdfTitle => 'PDF திருத்து';

  @override
  String get snapshotNotice =>
      'மாற்றங்கள் இந்த PDF நகலை மட்டுமே புதுப்பிக்கும்; அசல் கடன் அல்லது கணக்கை மாற்றாது.';

  @override
  String get pdfLanguageLabel => 'ஆவண மொழி';

  @override
  String get statusTextLabel => 'நிலை உரை';

  @override
  String get previewButton => 'முன்னோட்டம்';

  @override
  String get regeneratePdfButton => 'PDF மீண்டும் உருவாக்கு';

  @override
  String get pdfRegeneratedSuccess =>
      'ஆவணம் வெற்றிகரமாக மீண்டும் உருவாக்கப்பட்டது.';

  @override
  String shareReadyMessage(String title, int pages) {
    return '$title ($pages பக்கங்கள்) பகிரத் தயாராக உள்ளது.';
  }

  @override
  String get copyHtmlAction => 'HTML நகலெடு';

  @override
  String get htmlCopiedMessage => 'A4 HTML கிளிப்போர்டுக்கு நகலெடுக்கப்பட்டது.';

  @override
  String get saveChangesButton => 'மாற்றங்களைச் சேமி';

  @override
  String get profileUpdatedSuccess =>
      'சுயவிவரம் வெற்றிகரமாக புதுப்பிக்கப்பட்டது.';

  @override
  String get signOutConfirmTitle => 'வெளியேறவா?';

  @override
  String get signOutConfirmMessage =>
      'உங்கள் விவரங்களுடன் எப்போது வேண்டுமானாலும் மீண்டும் உள்நுழையலாம்.';

  @override
  String get totalLoansStatLabel => 'மொத்த கடன்கள்';

  @override
  String get documentsStatLabel => 'ஆவணங்கள்';

  @override
  String get backupTitle => 'காப்பு மற்றும் மீட்டெடுப்பு';

  @override
  String get backupSubtitle =>
      'உங்கள் கடன் கணக்கின் உள்ளூர் நகலை ஏற்றுமதி செய்யவும் அல்லது மீட்டெடுக்கவும்.';

  @override
  String get exportBackupButton => 'உள்ளூர் காப்பு உருவாக்கு';

  @override
  String get restoreBackupButton => 'நகலை மீட்டெடு';

  @override
  String get backupGeneratedMessage =>
      'காப்பு நகல் உருவாக்கப்பட்டு கிளிப்போர்டுக்கு நகலெடுக்கப்பட்டது.';

  @override
  String get restoreSuccessMessage =>
      'காப்பு நகல் வெற்றிகரமாக மீட்டெடுக்கப்பட்டது.';

  @override
  String get restoreInvalidError => 'தவறான காப்பு நகல் JSON.';

  @override
  String get pasteBackupHint =>
      'மீட்டெடுக்க ஏற்றுமதி செய்த JSON ஐ இங்கே ஒட்டவும்';

  @override
  String get driveComingSoonNote =>
      'Google Drive மறைகுறியாக்கப்பட்ட காப்பு படி 6 இல் சேர்க்கப்படும்.';

  @override
  String get emiPdfButton => 'EMI PDF';

  @override
  String get viewCompletePdfButton => 'முழு கடன் PDF';

  @override
  String emiPdfGeneratedMessage(int no) {
    return 'தவணை #$no செலுத்தப்பட்டது மற்றும் PDF ஆவணங்களில் சேமிக்கப்பட்டது.';
  }

  @override
  String emiReceiptTag(int no) {
    return 'EMI #$no ரசீது';
  }

  @override
  String get completeLoanPdfTag => 'முழு கடன் PDF';

  @override
  String get emiCalculatorTitle => 'EMI கணிப்பான்';

  @override
  String get emiCalculatorSubtitle =>
      'கடன் உருவாக்குவதற்கு முன் மாதாந்திர தவணை, மொத்த வட்டி மற்றும் அட்டவணையை மதிப்பிடுங்கள்.';

  @override
  String get principalShareLabel => 'அசல் பங்கு';

  @override
  String get interestShareLabel => 'வட்டி பங்கு';

  @override
  String get resetFieldsButton => 'மீட்டமை';

  @override
  String get proceedToCreateLoanButton => 'இந்த விவரங்களுடன் கடன் உருவாக்கு';

  @override
  String get schedulePreviewHeading => 'தவணை அட்டவணை முன்னோட்டம்';

  @override
  String get enterTermsForEstimate =>
      'EMI மதிப்பீட்டைப் பார்க்க அசல், மாத வட்டி மற்றும் காலத்தை உள்ளிடவும்.';

  @override
  String get systemDefaultLanguage => 'கணினி இயல்புநிலை';

  @override
  String get choosePhotoTitle => 'சுயவிவரப் படம்';

  @override
  String get pickFromGallery => 'கேலரியிலிருந்து தேர்வு செய்க';

  @override
  String get takePhoto => 'புகைப்படம் எடுக்கவும்';

  @override
  String get removePhoto => 'படத்தை அகற்று';

  @override
  String get changeAvatarColor => 'பேட்ஜ் நிறத்தை மாற்று';

  @override
  String get photoPickFailedError => 'தேர்ந்தெடுத்த படத்தை ஏற்ற முடியவில்லை.';

  @override
  String get databaseError =>
      'உள்ளூர் தரவைச் சேமிக்க முடியவில்லை. மீண்டும் முயற்சிக்கவும்.';

  @override
  String get onboardingSkip => 'தவிர்';

  @override
  String get onboardingStart => 'தொடங்கு';

  @override
  String get onboardingNext => 'அடுத்து';

  @override
  String get onboardingTitle1 => 'ஸ்மார்ட் கடன் மையம்';

  @override
  String get onboardingSubtitle1 =>
      'வாடிக்கையாளர்களை நிர்வகிக்கவும், எளிய அல்லது கூட்டு வட்டி கடன்களை ஆஃப்லைனில் உருவாக்கவும்.';

  @override
  String get onboardingTitle2 => 'EMI & கணக்குப் பதிவு';

  @override
  String get onboardingSubtitle2 =>
      'மாதாந்திர தவணைகள், நிலுவைத் தேதிகள் மற்றும் வசூல்களை உடனே கண்காணிக்கவும்.';

  @override
  String get onboardingTitle3 => 'உடனடி கடன் ஒப்பந்தம்';

  @override
  String get onboardingSubtitle3 =>
      'கடன் முடிந்தவுடன் 13 மொழிகளில் A4 கடன் ஒப்பந்த PDF-ஐ தானாக உருவாக்கவும்.';
}
