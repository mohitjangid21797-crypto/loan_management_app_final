// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Assamese (`as`).
class AppLocalizationsAs extends AppLocalizations {
  AppLocalizationsAs([String locale = 'as']) : super(locale);

  @override
  String get appTitle => 'LoanWise';

  @override
  String get splashTagline => 'স্মাৰ্ট ঋণ আৰু EMI খাতা';

  @override
  String get loginTitle => 'লগইন';

  @override
  String get nameLabel => 'নাম';

  @override
  String get nameHint => 'আপোনাৰ সম্পূৰ্ণ নাম লিখক';

  @override
  String get mobileLabel => 'ম’বাইল নম্বৰ';

  @override
  String get mobileHint => '১০ টা সংখ্যাৰ ম’বাইল নম্বৰ';

  @override
  String get emailLabel => 'ইমেইল আইডি';

  @override
  String get emailHint => 'name@example.com';

  @override
  String get signInButton => 'ছাইন ইন কৰক';

  @override
  String get errorNameRequired => 'অনুগ্ৰহ কৰি আপোনাৰ নাম লিখক';

  @override
  String get errorMobileInvalid =>
      '৬ ৰ পৰা ৯ ৰে আৰম্ভ হোৱা ১০ টা সংখ্যাৰ ম’বাইল নম্বৰ লিখক';

  @override
  String get errorEmailInvalid => 'এটা বৈধ ইমেইল ঠিকনা লিখক';

  @override
  String get navHome => 'হ’ম';

  @override
  String get navCustomers => 'গ্ৰাহক';

  @override
  String get navLoans => 'ঋণ';

  @override
  String get navProfile => 'প্ৰ’ফাইল';

  @override
  String get welcomeBack => 'পুনৰ স্বাগতম,';

  @override
  String get openMenuTooltip => 'মেনু খোলক';

  @override
  String get openProfileTooltip => 'প্ৰ’ফাইল খোলক';

  @override
  String get totalLentLabel => 'মুঠ প্ৰদান কৰা ঋণ';

  @override
  String get availableToCollect => 'সংগ্ৰহৰ বাবে উপলব্ধ';

  @override
  String get activeLoansLabel => 'সক্ৰিয় ঋণ';

  @override
  String get customersLabel => 'গ্ৰাহক';

  @override
  String get emisDueThisMonthLabel => 'এই মাহৰ EMI';

  @override
  String get quickActionsHeading => 'দ্ৰুত কাৰ্য্য';

  @override
  String get actionAddCustomer => 'গ্ৰাহক যোগ কৰক';

  @override
  String get actionCreateLoan => 'ঋণ সৃষ্টি কৰক';

  @override
  String get actionLoans => 'ঋণ';

  @override
  String get actionDocuments => 'নথিপত্ৰ';

  @override
  String get actionAllCustomers => 'সকলো গ্ৰাহক';

  @override
  String get actionProfile => 'প্ৰ’ফাইল';

  @override
  String get thisMonthHeading => 'এই মাহ';

  @override
  String get viewAll => 'সকলো চাওক';

  @override
  String get collectedThisMonth => 'এই মাহত সংগ্ৰহ';

  @override
  String get pendingThisMonth => 'এই মাহত বাকী';

  @override
  String get recentLoansHeading => 'শেহতীয়া ঋণ';

  @override
  String get overdueEmisHeading => 'সময় উকলা EMI';

  @override
  String get statusActive => 'সক্ৰিয়';

  @override
  String get statusCompleted => 'সম্পূৰ্ণ';

  @override
  String get statusOverdue => 'সময় উকলিছে';

  @override
  String get statusPending => 'বাকী';

  @override
  String get statusPaid => 'পৰিশোধিত';

  @override
  String nextEmiLabel(String date) {
    return 'পৰৱৰ্তী EMI: $date';
  }

  @override
  String dueSinceLabel(String date) {
    return 'দেয় তাৰিখ: $date';
  }

  @override
  String get emptyRecentLoans =>
      'এতিয়ালৈকে কোনো শেহতীয়া ঋণ নাই। চাবলৈ এটা ঋণ সৃষ্টি কৰক।';

  @override
  String get emptyOverdueEmis => 'সকলো ঠিক আছে। কোনো সময় উকলা EMI নাই।';

  @override
  String get drawerBackupRestore => 'বেকআপ আৰু পুনৰুদ্ধাৰ';

  @override
  String get drawerChangeTheme => 'থিম সলনি কৰক';

  @override
  String get drawerChooseLanguage => 'ভাষা বাছনি কৰক';

  @override
  String get themeLight => 'লাইট';

  @override
  String get themeDark => 'ডাৰ্ক';

  @override
  String get themeSystem => 'ছিষ্টেম';

  @override
  String get backupDialogMessage =>
      'আপোনাৰ ডিভাইচৰ বাবে স্থানীয় বেকআপ আপডেট কৰা হৈছে।';

  @override
  String get closeAction => 'বন্ধ কৰক';

  @override
  String featureQueuedMessage(String feature) {
    return '$feature সাজু।';
  }

  @override
  String get tabCustomersSubtitle =>
      'ঋণগ্ৰহীতা, যোগাযোগৰ তথ্য আৰু সক্ৰিয় ঋণ পৰিচালনা কৰক।';

  @override
  String get tabLoansSubtitle => 'সক্ৰিয় ঋণ, সূত আৰু EMI সূচী চাওক।';

  @override
  String get tabProfileSubtitle => 'আপোনাৰ পঞ্জীভুক্ত ঋণদাতা তথ্য আৰু পছন্দ।';

  @override
  String get signOutAction => 'ছাইন আউট';

  @override
  String get addCustomerTitle => 'গ্ৰাহক যোগ কৰক';

  @override
  String get editCustomerTitle => 'গ্ৰাহক সম্পাদনা কৰক';

  @override
  String get customerNameLabel => 'গ্ৰাহকৰ নাম';

  @override
  String get customerEmailLabel => 'গ্ৰাহকৰ ইমেইল';

  @override
  String get customerMobileLabel => 'ম’বাইল নম্বৰ';

  @override
  String get customerLocationLabel => 'স্থান';

  @override
  String get locationRequiredError => 'অনুগ্ৰহ কৰি স্থান লিখক';

  @override
  String get saveCustomerButton => 'গ্ৰাহক সংৰক্ষণ কৰক';

  @override
  String get updateCustomerButton => 'গ্ৰাহক আপডেট কৰক';

  @override
  String get customerAddedTitle => 'গ্ৰাহক সফলভাৱে যোগ কৰা হ’ল';

  @override
  String customerAddedMessage(String name) {
    return 'আপুনি এতিয়া $name-ৰ বাবে ঋণ সৃষ্টি কৰিব বিচাৰেনেকি?';
  }

  @override
  String get laterButton => 'পাছত';

  @override
  String get searchCustomersHint => 'নাম বা ম’বাইলেৰে সন্ধান কৰক';

  @override
  String get noCustomersTitle => 'কোনো গ্ৰাহক পোৱা নগ’ল';

  @override
  String get noCustomersSubtitle => 'প্ৰথম গ্ৰাহক যোগ কৰিবলৈ + টিপক।';

  @override
  String get editCustomerMenu => 'তথ্য সম্পাদনা কৰক';

  @override
  String get deleteCustomerMenu => 'গ্ৰাহক মচক';

  @override
  String get createLoanMenu => 'ঋণ সৃষ্টি কৰক';

  @override
  String get deleteCustomerConfirmTitle => 'গ্ৰাহক মচিবনে?';

  @override
  String deleteCustomerConfirmMessage(String name) {
    return 'ই $name-ক আপোনাৰ সক্ৰিয় তালিকাৰ পৰা আঁতৰাব।';
  }

  @override
  String get deleteAction => 'মচক';

  @override
  String get cancelAction => 'বাতিল';

  @override
  String get activeLoanDeleteBlocked => 'সক্ৰিয় ঋণ থকা গ্ৰাহক মচিব নোৱাৰি।';

  @override
  String get duplicateMobileError => 'এই ম’বাইল নম্বৰৰ গ্ৰাহক ইতিমধ্যে আছে।';

  @override
  String get customerDetailTitle => 'গ্ৰাহকৰ বিৱৰণ';

  @override
  String get callAction => 'কল';

  @override
  String get smsAction => 'SMS';

  @override
  String get customerLoansHeading => 'গ্ৰাহকৰ ঋণ';

  @override
  String get mobileLockedHelper => 'ঋণ থাকিলে ম’বাইল নম্বৰ সলনি কৰিব নোৱাৰি।';

  @override
  String activeLoansCountLabel(int count) {
    return '$count সক্ৰিয়';
  }

  @override
  String get createLoanTitle => 'ঋণ সৃষ্টি কৰক';

  @override
  String get searchCustomerMobileHint => '১০ সংখ্যাৰ ম’বাইল লিখক';

  @override
  String get noCustomerWithMobile => 'এই ম’বাইল নম্বৰৰ কোনো গ্ৰাহক নাই';

  @override
  String get addCustomerShortcut => 'গ্ৰাহক যোগ কৰক';

  @override
  String get principalLabel => 'মূলধন (₹)';

  @override
  String get monthlyRateLabel => 'মাহিলী সূতৰ হাৰ (%)';

  @override
  String get tenureMonthsLabel => 'সময়সীমা (মাহ)';

  @override
  String get loanTypeLabel => 'সূতৰ প্ৰকাৰ';

  @override
  String get loanTypeSimple => 'সৰল সূত';

  @override
  String get loanTypeCompound => 'চক্ৰবৃদ্ধি সূত';

  @override
  String get startDateLabel => 'আৰম্ভণি তাৰিখ';

  @override
  String get livePreviewHeading => 'লাইভ EMI পূৰ্বদৰ্শন';

  @override
  String get monthlyEmiLabel => 'মাহিলী EMI';

  @override
  String get totalInterestLabel => 'মুঠ সূত';

  @override
  String get totalPayableLabel => 'মুঠ দেয়';

  @override
  String get createLoanButton => 'ঋণ সৃষ্টি কৰক';

  @override
  String get loanCreatedTitle => 'ঋণ সফলভাৱে সৃষ্টি হ’ল';

  @override
  String loanCreatedMessage(int count) {
    return '$count মাহিলী EMI সৃষ্টি কৰা হৈছে।';
  }

  @override
  String get viewLoanOverview => 'ঋণৰ সাৰাংশ খোলক';

  @override
  String get allLoansFilter => 'সকলো';

  @override
  String get activeLoansFilter => 'সক্ৰিয়';

  @override
  String get completedLoansFilter => 'সম্পূৰ্ণ';

  @override
  String get noLoansTitle => 'এতিয়ালৈকে কোনো ঋণ নাই';

  @override
  String get noLoansSubtitle => 'EMI সূচী বনাবলৈ এটা ঋণ সৃষ্টি কৰক।';

  @override
  String get selectCustomerError =>
      'প্ৰথমে ১০ সংখ্যাৰ ম’বাইলেৰে গ্ৰাহক বাছনি কৰক।';

  @override
  String get invalidPrincipalError => '০ তকৈ বেছি মূলধন লিখক।';

  @override
  String get invalidRateError => '০ ৰ পৰা ১০০ ৰ ভিতৰত মাহিলী হাৰ লিখক।';

  @override
  String get invalidTenureError => '১ ৰ পৰা ৬০০ মাহৰ সময়সীমা লিখক।';

  @override
  String get loanOverviewTitle => 'ঋণৰ সাৰাংশ';

  @override
  String get emiScheduleHeading => 'EMI সূচী';

  @override
  String get payButton => 'পৰিশোধ';

  @override
  String get payAllPendingButton => 'সকলো বাকী EMI পৰিশোধ কৰক';

  @override
  String confirmPayEmiTitle(int no) {
    return 'EMI #$no পৰিশোধিত চিহ্নিত কৰিবনে?';
  }

  @override
  String confirmPayEmiMessage(String amount) {
    return '$amount ৰ পৰিশোধ নিশ্চিত কৰক।';
  }

  @override
  String get paymentDateLabel => 'পৰিশোধৰ তাৰিখ';

  @override
  String get confirmPayAllTitle => 'সকলো বাকী EMI পৰিশোধ কৰিবনে?';

  @override
  String confirmPayAllMessage(int count, String amount) {
    return 'ই বাকী $count টা EMI ($amount) পৰিশোধ কৰি ঋণ চুক্তি PDF তৈয়াৰ কৰিব।';
  }

  @override
  String installmentLabel(int no) {
    return 'কিস্তি #$no';
  }

  @override
  String paidOnLabel(String date) {
    return 'পৰিশোধ: $date';
  }

  @override
  String get outOfOrderEmiError =>
      'অনুগ্ৰহ কৰি আগৰ বাকী কিস্তিবোৰ ক্ৰম অনুসৰি পৰিশোধ কৰক।';

  @override
  String emiPaidSuccess(int no) {
    return 'কিস্তি #$no পৰিশোধিত হ’ল।';
  }

  @override
  String get loanCompletedPdfGenerated =>
      'ঋণ সম্পূৰ্ণ! চুক্তি PDF নথিপত্ৰত সংৰক্ষিত হ’ল।';

  @override
  String get viewPdfAction => 'PDF চাওক';

  @override
  String get openDocumentsAction => 'নথিপত্ৰ খোলক';

  @override
  String progressPaidLabel(int paid, int total) {
    return '$total ৰ ভিতৰত $paid EMI পৰিশোধ';
  }

  @override
  String get ledgerHeading => 'খাতাৰ ইতিহাস';

  @override
  String get ledgerDebitLabel => 'ডেবিট';

  @override
  String get ledgerCreditLabel => 'ক্ৰেডিট';

  @override
  String get ledgerBalanceLabel => 'বাকী';

  @override
  String get documentsTitle => 'নথিপত্ৰ';

  @override
  String get noDocumentsTitle => 'এতিয়ালৈকে কোনো PDF নথিপত্ৰ নাই';

  @override
  String get noDocumentsSubtitle =>
      'ঋণ সম্পূৰ্ণ পৰিশোধ হ’লে চুক্তি ইয়াত দেখা যাব।';

  @override
  String get viewPdfMenu => 'PDF চাওক';

  @override
  String get sharePdfMenu => 'PDF শ্বেয়াৰ কৰক';

  @override
  String get deletePdfMenu => 'PDF মচক';

  @override
  String get editPdfMenu => 'PDF সম্পাদনা কৰক';

  @override
  String get deletePdfConfirmTitle => 'নথিপত্ৰ মচিবনে?';

  @override
  String get deletePdfConfirmMessage => 'ই নথিপত্ৰৰ পৰা ঋণ চুক্তি আঁতৰাব।';

  @override
  String pagesCountLabel(int count) {
    return '$count পৃষ্ঠা';
  }

  @override
  String get documentViewerTitle => 'ঋণ চুক্তি দৰ্শক';

  @override
  String get loanAgreementHeadline => 'ঋণ চুক্তি';

  @override
  String get lenderDetailsHeading => 'ঋণদাতাৰ বিৱৰণ';

  @override
  String get borrowerDetailsHeading => 'ঋণগ্ৰহীতাৰ বিৱৰণ';

  @override
  String get installmentScheduleHeading => 'কিস্তি সূচী';

  @override
  String get generatedOnLabel => 'তৈয়াৰ কৰা তাৰিখ';

  @override
  String get documentIdLabel => 'নথিপত্ৰ ID';

  @override
  String pageOfLabel(int current, int total) {
    return 'পৃষ্ঠা $current / $total';
  }

  @override
  String get signatureLender => 'ঋণদাতাৰ স্বাক্ষৰ';

  @override
  String get signatureBorrower => 'ঋণগ্ৰহীতাৰ স্বাক্ষৰ';

  @override
  String get editPdfTitle => 'PDF সম্পাদনা';

  @override
  String get snapshotNotice =>
      'সলনিয়ে কেৱল এই PDF স্নেপশ্বট আপডেট কৰে; মূল ঋণ বা খাতা সলনি নহয়।';

  @override
  String get pdfLanguageLabel => 'নথিপত্ৰৰ ভাষা';

  @override
  String get statusTextLabel => 'স্থিতিৰ লেখা';

  @override
  String get previewButton => 'পূৰ্বদৰ্শন';

  @override
  String get regeneratePdfButton => 'PDF পুনৰ সৃষ্টি';

  @override
  String get pdfRegeneratedSuccess => 'নথিপত্ৰ সফলভাৱে পুনৰ সৃষ্টি হ’ল।';

  @override
  String shareReadyMessage(String title, int pages) {
    return 'শ্বেয়াৰৰ বাবে $title ($pages পৃষ্ঠা) সাজু।';
  }

  @override
  String get copyHtmlAction => 'HTML কপি কৰক';

  @override
  String get htmlCopiedMessage => 'A4 HTML ক্লিপব’ৰ্ডত কপি হ’ল।';

  @override
  String get saveChangesButton => 'সলনি সংৰক্ষণ কৰক';

  @override
  String get profileUpdatedSuccess => 'প্ৰ’ফাইল সফলভাৱে আপডেট হ’ল।';

  @override
  String get signOutConfirmTitle => 'ছাইন আউট?';

  @override
  String get signOutConfirmMessage =>
      'আপুনি যিকোনো সময়তে আপোনাৰ তথ্যৰে পুনৰ ছাইন ইন কৰিব পাৰে।';

  @override
  String get totalLoansStatLabel => 'মুঠ ঋণ';

  @override
  String get documentsStatLabel => 'নথিপত্ৰ';

  @override
  String get backupTitle => 'বেকআপ আৰু পুনৰুদ্ধাৰ';

  @override
  String get backupSubtitle =>
      'স্থানীয় স্নেপশ্বট এক্সপ’ৰ্ট কৰক বা আপোনাৰ খাতা পুনৰুদ্ধাৰ কৰক।';

  @override
  String get exportBackupButton => 'স্থানীয় বেকআপ সৃষ্টি';

  @override
  String get restoreBackupButton => 'স্নেপশ্বট পুনৰুদ্ধাৰ';

  @override
  String get backupGeneratedMessage => 'বেকআপ স্নেপশ্বট ক্লিপব’ৰ্ডত কপি হ’ল।';

  @override
  String get restoreSuccessMessage => 'বেকআপ স্নেপশ্বট সফলভাৱে পুনৰুদ্ধাৰ হ’ল।';

  @override
  String get restoreInvalidError => 'অবৈধ বেকআপ JSON।';

  @override
  String get pasteBackupHint => 'পুনৰুদ্ধাৰৰ বাবে বেকআপ JSON ইয়াত পেষ্ট কৰক';

  @override
  String get driveComingSoonNote =>
      'Google Drive এনক্ৰিপ্টেড AppData ছিঙ্ক পৰ্যায় ৬ ত আহিব।';

  @override
  String get emiPdfButton => 'EMI PDF';

  @override
  String get viewCompletePdfButton => 'সম্পূৰ্ণ ঋণ PDF';

  @override
  String emiPdfGeneratedMessage(int no) {
    return 'কিস্তি #$no পৰিশোধ কৰা হ\'ল আৰু PDF নথিপত্ৰত সংৰক্ষণ কৰা হ\'ল।';
  }

  @override
  String emiReceiptTag(int no) {
    return 'EMI #$no ৰচিদ';
  }

  @override
  String get completeLoanPdfTag => 'সম্পূৰ্ণ ঋণ PDF';

  @override
  String get emiCalculatorTitle => 'EMI কেলকুলেটৰ';

  @override
  String get emiCalculatorSubtitle =>
      'ঋণ সৃষ্টি কৰাৰ আগতে মাহেকীয়া কিস্তি, মুঠ সূদ আৰু পৰিশোধ তালিকা অনুমান কৰক।';

  @override
  String get principalShareLabel => 'মূলধনৰ অংশ';

  @override
  String get interestShareLabel => 'সূদৰ অংশ';

  @override
  String get resetFieldsButton => 'ৰিছেট';

  @override
  String get proceedToCreateLoanButton => 'এই চৰ্তেৰে ঋণ সৃষ্টি কৰক';

  @override
  String get schedulePreviewHeading => 'তালিকা পূৰ্বলোকন';

  @override
  String get enterTermsForEstimate =>
      'EMI অনুমান চাবলৈ মূলধন, মাহেকীয়া হাৰ আৰু ম্যাদ লিখক।';

  @override
  String get systemDefaultLanguage => 'চিষ্টেম ডিফল্ট';

  @override
  String get choosePhotoTitle => 'প্ৰফাইল ফটো';

  @override
  String get pickFromGallery => 'গেলেৰীৰ পৰা বাছনি কৰক';

  @override
  String get takePhoto => 'ফটো তোলক';

  @override
  String get removePhoto => 'ফটো আঁতৰাওক';

  @override
  String get changeAvatarColor => 'বেজৰ ৰং সলনি কৰক';

  @override
  String get photoPickFailedError => 'নিৰ্বাচিত ছবিখন ল’ড কৰিব পৰা নগ’ল।';

  @override
  String get databaseError =>
      'ডাটা স্থানীয়ভাৱে সংৰক্ষণ কৰিব পৰা নগ’ল। অনুগ্ৰহ কৰি পুনৰ চেষ্টা কৰক।';

  @override
  String get onboardingSkip => 'এৰাই যাওক';

  @override
  String get onboardingStart => 'আৰম্ভ কৰক';

  @override
  String get onboardingNext => 'পৰৱৰ্তী';

  @override
  String get onboardingTitle1 => 'স্মাৰ্ট ঋণ হাব';

  @override
  String get onboardingSubtitle1 =>
      'গ্ৰাহক পৰিচালনা কৰক, সৰল বা চক্ৰবৃদ্ধি ঋণ সৃষ্টি কৰক আৰু অফলাইনত সুশৃংখল থাকক।';

  @override
  String get onboardingTitle2 => 'EMI আৰু খতিয়ান ট্ৰেক কৰক';

  @override
  String get onboardingSubtitle2 =>
      'মাহিলী কিস্তি, নিৰ্ধাৰিত তাৰিখ আৰু আদায় একে দৃষ্টিতে চাওক।';

  @override
  String get onboardingTitle3 => 'তাৎক্ষণিক ঋণ চুক্তি';

  @override
  String get onboardingSubtitle3 =>
      'সম্পূৰ্ণ পৰিশোধৰ পাছত ১৩টা ভাষাত স্বয়ংক্ৰিয়ভাৱে A4 ঋণ চুক্তি PDF প্ৰস্তুত কৰক।';
}
