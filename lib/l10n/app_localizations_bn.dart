// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get appTitle => 'LoanWise';

  @override
  String get splashTagline => 'স্মার্ট ঋণ ও ইএমআই খাতা';

  @override
  String get loginTitle => 'লগইন';

  @override
  String get nameLabel => 'নাম';

  @override
  String get nameHint => 'আপনার পূর্ণ নাম লিখুন';

  @override
  String get mobileLabel => 'মোবাইল নম্বর';

  @override
  String get mobileHint => '১০ সংখ্যার মোবাইল নম্বর';

  @override
  String get emailLabel => 'ইমেল আইডি';

  @override
  String get emailHint => 'name@example.com';

  @override
  String get signInButton => 'সাইন ইন করুন';

  @override
  String get errorNameRequired => 'অনুগ্রহ করে আপনার নাম লিখুন';

  @override
  String get errorMobileInvalid =>
      '৬ থেকে ৯ দিয়ে শুরু ১০ সংখ্যার মোবাইল নম্বর লিখুন';

  @override
  String get errorEmailInvalid => 'সঠিক ইমেল ঠিকানা লিখুন';

  @override
  String get navHome => 'হোম';

  @override
  String get navCustomers => 'গ্রাহক';

  @override
  String get navLoans => 'ঋণ';

  @override
  String get navProfile => 'প্রোফাইল';

  @override
  String get welcomeBack => 'স্বাগতম,';

  @override
  String get openMenuTooltip => 'মেনু খুলুন';

  @override
  String get openProfileTooltip => 'প্রোফাইল খুলুন';

  @override
  String get totalLentLabel => 'মোট প্রদত্ত ঋণ';

  @override
  String get availableToCollect => 'সংগ্রহের জন্য উপলব্ধ';

  @override
  String get activeLoansLabel => 'সক্রিয় ঋণ';

  @override
  String get customersLabel => 'গ্রাহক';

  @override
  String get emisDueThisMonthLabel => 'এই মাসে বকেয়া ইএমআই';

  @override
  String get quickActionsHeading => 'দ্রুত কার্যক্রম';

  @override
  String get actionAddCustomer => 'গ্রাহক যোগ করুন';

  @override
  String get actionCreateLoan => 'ঋণ তৈরি করুন';

  @override
  String get actionLoans => 'ঋণ';

  @override
  String get actionDocuments => 'নথিপত্র';

  @override
  String get actionAllCustomers => 'সকল গ্রাহক';

  @override
  String get actionProfile => 'প্রোফাইল';

  @override
  String get thisMonthHeading => 'এই মাসে';

  @override
  String get viewAll => 'সব দেখুন';

  @override
  String get collectedThisMonth => 'এই মাসে সংগৃহীত';

  @override
  String get pendingThisMonth => 'এই মাসে বাকি';

  @override
  String get recentLoansHeading => 'সাম্প্রতিক ঋণ';

  @override
  String get overdueEmisHeading => 'মেয়াদোত্তীর্ণ ইএমআই';

  @override
  String get statusActive => 'সক্রিয়';

  @override
  String get statusCompleted => 'সম্পন্ন';

  @override
  String get statusOverdue => 'বকেয়া';

  @override
  String get statusPending => 'বাকি';

  @override
  String get statusPaid => 'পরিশোধিত';

  @override
  String nextEmiLabel(String date) {
    return 'পরবর্তী ইএমআই: $date';
  }

  @override
  String dueSinceLabel(String date) {
    return 'বকেয়া: $date';
  }

  @override
  String get emptyRecentLoans =>
      'এখনও কোনো সাম্প্রতিক ঋণ নেই। শুরু করতে ঋণ তৈরি করুন।';

  @override
  String get emptyOverdueEmis => 'সব ঠিক আছে। মুহূর্তে কোনো বকেয়া ইএমআই নেই।';

  @override
  String get drawerBackupRestore => 'ব্যাকআপ ও পুনরুদ্ধার';

  @override
  String get drawerChangeTheme => 'থিম পরিবর্তন করুন';

  @override
  String get drawerChooseLanguage => 'ভাষা নির্বাচন করুন';

  @override
  String get themeLight => 'লাইট';

  @override
  String get themeDark => 'ডার্ক';

  @override
  String get themeSystem => 'সিস্টেম';

  @override
  String get backupDialogMessage =>
      'আপনার ডিভাইসের জন্য স্থানীয় ব্যাকআপ হালনাগাদ রয়েছে।';

  @override
  String get closeAction => 'বন্ধ করুন';

  @override
  String featureQueuedMessage(String feature) {
    return '$feature প্রস্তুত।';
  }

  @override
  String get tabCustomersSubtitle =>
      'ঋণগ্রহীতা, যোগাযোগের তথ্য এবং সক্রিয় ঋণ পরিচালনা করুন।';

  @override
  String get tabLoansSubtitle =>
      'সক্রিয় ঋণ, সুদ এবং ইএমআই সময়সূচী ট্র্যাক করুন।';

  @override
  String get tabProfileSubtitle => 'আপনার নিবন্ধিত ঋণদাতার তথ্য এবং পছন্দসমূহ।';

  @override
  String get signOutAction => 'সাইন আউট';

  @override
  String get addCustomerTitle => 'গ্রাহক যোগ করুন';

  @override
  String get editCustomerTitle => 'গ্রাহক সম্পাদনা';

  @override
  String get customerNameLabel => 'গ্রাহকের নাম';

  @override
  String get customerEmailLabel => 'গ্রাহকের ইমেল';

  @override
  String get customerMobileLabel => 'মোবাইল নম্বর';

  @override
  String get customerLocationLabel => 'অবস্থান';

  @override
  String get locationRequiredError => 'অনুগ্রহ করে অবস্থান লিখুন';

  @override
  String get saveCustomerButton => 'গ্রাহক সংরক্ষণ করুন';

  @override
  String get updateCustomerButton => 'গ্রাহক আপডেট করুন';

  @override
  String get customerAddedTitle => 'গ্রাহক সফলভাবে যোগ হয়েছে';

  @override
  String customerAddedMessage(String name) {
    return 'আপনি কি এখনই $name-এর জন্য ঋণ তৈরি করতে চান?';
  }

  @override
  String get laterButton => 'পরে';

  @override
  String get searchCustomersHint => 'নাম বা মোবাইল দিয়ে খুঁজুন';

  @override
  String get noCustomersTitle => 'কোনো গ্রাহক পাওয়া যায়নি';

  @override
  String get noCustomersSubtitle => 'প্রথম গ্রাহক যোগ করতে + চাপুন।';

  @override
  String get editCustomerMenu => 'তথ্য সম্পাদনা';

  @override
  String get deleteCustomerMenu => 'গ্রাহক মুছুন';

  @override
  String get createLoanMenu => 'ঋণ তৈরি করুন';

  @override
  String get deleteCustomerConfirmTitle => 'গ্রাহক মুছবেন?';

  @override
  String deleteCustomerConfirmMessage(String name) {
    return 'এটি $name-কে সক্রিয় গ্রাহক তালিকা থেকে সরাবে।';
  }

  @override
  String get deleteAction => 'মুছুন';

  @override
  String get cancelAction => 'বাতিল';

  @override
  String get activeLoanDeleteBlocked =>
      'সক্রিয় ঋণ থাকা গ্রাহককে মোছা যাবে না।';

  @override
  String get duplicateMobileError =>
      'এই মোবাইল নম্বরে একজন গ্রাহক ইতিমধ্যেই আছেন।';

  @override
  String get customerDetailTitle => 'গ্রাহকের বিবরণ';

  @override
  String get callAction => 'কল';

  @override
  String get smsAction => 'এসএমএস';

  @override
  String get customerLoansHeading => 'গ্রাহকের ঋণসমূহ';

  @override
  String get mobileLockedHelper =>
      'ঋণ থাকলে মোবাইল নম্বর পরিবর্তন করা যাবে না।';

  @override
  String activeLoansCountLabel(int count) {
    return '$count সক্রিয়';
  }

  @override
  String get createLoanTitle => 'ঋণ তৈরি করুন';

  @override
  String get searchCustomerMobileHint => '১০ সংখ্যার গ্রাহক মোবাইল লিখুন';

  @override
  String get noCustomerWithMobile => 'এই মোবাইলে কোনো গ্রাহক নেই';

  @override
  String get addCustomerShortcut => 'গ্রাহক যোগ করুন';

  @override
  String get principalLabel => 'মূল টাকা (₹)';

  @override
  String get monthlyRateLabel => 'সুদের হার (মাসিক %)';

  @override
  String get tenureMonthsLabel => 'মেয়াদ (মাস)';

  @override
  String get loanTypeLabel => 'সুদের ধরন';

  @override
  String get loanTypeSimple => 'সরল';

  @override
  String get loanTypeCompound => 'চক্রবৃদ্ধি';

  @override
  String get startDateLabel => 'শুরুর তারিখ';

  @override
  String get livePreviewHeading => 'লাইভ ইএমআই প্রিভিউ';

  @override
  String get monthlyEmiLabel => 'মাসিক ইএমআই';

  @override
  String get totalInterestLabel => 'মোট সুদ';

  @override
  String get totalPayableLabel => 'মোট প্রদেয়';

  @override
  String get createLoanButton => 'ঋণ তৈরি করুন';

  @override
  String get loanCreatedTitle => 'ঋণ সফলভাবে তৈরি হয়েছে';

  @override
  String loanCreatedMessage(int count) {
    return '$countটি মাসিক ইএমআই তৈরি হয়েছে।';
  }

  @override
  String get viewLoanOverview => 'ঋণ বিবরণ খুলুন';

  @override
  String get allLoansFilter => 'সব';

  @override
  String get activeLoansFilter => 'সক্রিয়';

  @override
  String get completedLoansFilter => 'সম্পন্ন';

  @override
  String get noLoansTitle => 'এখনও কোনো ঋণ নেই';

  @override
  String get noLoansSubtitle => 'ইএমআই সময়সূচী তৈরি করতে ঋণ যোগ করুন।';

  @override
  String get selectCustomerError =>
      'প্রথমে ১০ সংখ্যার মোবাইলে গ্রাহক নির্বাচন করুন।';

  @override
  String get invalidPrincipalError => '০-এর বেশি মূল টাকা লিখুন।';

  @override
  String get invalidRateError => '০ থেকে ১০০-এর মধ্যে মাসিক হার লিখুন।';

  @override
  String get invalidTenureError => '১ থেকে ৬০০ মাসের মধ্যে মেয়াদ লিখুন।';

  @override
  String get loanOverviewTitle => 'ঋণ বিবরণ';

  @override
  String get emiScheduleHeading => 'ইএমআই সময়সূচী';

  @override
  String get payButton => 'পরিশোধ';

  @override
  String get payAllPendingButton => 'সব বাকি ইএমআই পরিশোধ করুন';

  @override
  String confirmPayEmiTitle(int no) {
    return 'ইএমআই #$no পরিশোধিত করবেন?';
  }

  @override
  String confirmPayEmiMessage(String amount) {
    return '$amount পরিশোধ নিশ্চিত করুন।';
  }

  @override
  String get paymentDateLabel => 'পরিশোধের তারিখ';

  @override
  String get confirmPayAllTitle => 'সব বাকি ইএমআই পরিশোধ করবেন?';

  @override
  String confirmPayAllMessage(int count, String amount) {
    return 'বাকি $countটি ইএমআই ($amount) পরিশোধিত হবে এবং ঋণ চুক্তি পিডিএফ তৈরি হবে।';
  }

  @override
  String installmentLabel(int no) {
    return 'কিস্তি #$no';
  }

  @override
  String paidOnLabel(String date) {
    return 'পরিশোধ: $date';
  }

  @override
  String get outOfOrderEmiError =>
      'অনুগ্রহ করে আগের বাকি কিস্তিগুলো ক্রমানুসারে পরিশোধ করুন।';

  @override
  String emiPaidSuccess(int no) {
    return 'কিস্তি #$no পরিশোধিত হয়েছে।';
  }

  @override
  String get loanCompletedPdfGenerated =>
      'ঋণ সম্পন্ন! ঋণ চুক্তি পিডিএফ নথিপত্রে সংরক্ষিত হয়েছে।';

  @override
  String get viewPdfAction => 'পিডিএফ দেখুন';

  @override
  String get openDocumentsAction => 'নথিপত্র খুলুন';

  @override
  String progressPaidLabel(int paid, int total) {
    return '$total-এর মধ্যে $paid ইএমআই পরিশোধিত';
  }

  @override
  String get ledgerHeading => 'লেজার ইতিহাস';

  @override
  String get ledgerDebitLabel => 'ডেবিট';

  @override
  String get ledgerCreditLabel => 'ক্রেডিট';

  @override
  String get ledgerBalanceLabel => 'ব্যালেন্স';

  @override
  String get documentsTitle => 'নথিপত্র';

  @override
  String get noDocumentsTitle => 'এখনও কোনো পিডিএফ নেই';

  @override
  String get noDocumentsSubtitle =>
      'ঋণ সম্পূর্ণ পরিশোধ হলে ঋণ চুক্তি এখানে স্বয়ংক্রিয়ভাবে দেখা যাবে।';

  @override
  String get viewPdfMenu => 'পিডিএফ দেখুন';

  @override
  String get sharePdfMenu => 'পিডিএফ শেয়ার করুন';

  @override
  String get deletePdfMenu => 'পিডিএফ মুছুন';

  @override
  String get editPdfMenu => 'পিডিএফ সম্পাদনা';

  @override
  String get deletePdfConfirmTitle => 'নথি মুছবেন?';

  @override
  String get deletePdfConfirmMessage =>
      'এটি নথিপত্র থেকে তৈরি ঋণ চুক্তিটি মুছে ফেলবে।';

  @override
  String pagesCountLabel(int count) {
    return '$count পৃষ্ঠা';
  }

  @override
  String get documentViewerTitle => 'ঋণ চুক্তি দর্শক';

  @override
  String get loanAgreementHeadline => 'ঋণ চুক্তি';

  @override
  String get lenderDetailsHeading => 'ঋণদাতার বিবরণ';

  @override
  String get borrowerDetailsHeading => 'ঋণগ্রহীতার বিবরণ';

  @override
  String get installmentScheduleHeading => 'কিস্তির সময়সূচী';

  @override
  String get generatedOnLabel => 'তৈরির তারিখ';

  @override
  String get documentIdLabel => 'নথি আইডি';

  @override
  String pageOfLabel(int current, int total) {
    return 'পৃষ্ঠা $current / $total';
  }

  @override
  String get signatureLender => 'ঋণদাতার স্বাক্ষর';

  @override
  String get signatureBorrower => 'ঋণগ্রহীতার স্বাক্ষর';

  @override
  String get editPdfTitle => 'পিডিএফ সম্পাদনা';

  @override
  String get snapshotNotice =>
      'পরিবর্তনগুলো শুধু এই পিডিএফ স্ন্যাপশট আপডেট করে, মূল ঋণ বা লেজার নয়।';

  @override
  String get pdfLanguageLabel => 'নথির ভাষা';

  @override
  String get statusTextLabel => 'স্থিতি লেখা';

  @override
  String get previewButton => 'প্রিভিউ';

  @override
  String get regeneratePdfButton => 'পিডিএফ পুনরায় তৈরি';

  @override
  String get pdfRegeneratedSuccess => 'নথি সফলভাবে পুনরায় তৈরি হয়েছে।';

  @override
  String shareReadyMessage(String title, int pages) {
    return '$title ($pages পৃষ্ঠা) শেয়ারের জন্য প্রস্তুত।';
  }

  @override
  String get copyHtmlAction => 'HTML কপি';

  @override
  String get htmlCopiedMessage => 'A4 HTML ক্লিপবোর্ডে কপি হয়েছে।';

  @override
  String get saveChangesButton => 'পরিবর্তন সংরক্ষণ';

  @override
  String get profileUpdatedSuccess => 'প্রোফাইল সফলভাবে আপডেট হয়েছে।';

  @override
  String get signOutConfirmTitle => 'সাইন আউট করবেন?';

  @override
  String get signOutConfirmMessage =>
      'আপনার বিবরণ দিয়ে যেকোনো সময় আবার সাইন ইন করতে পারবেন।';

  @override
  String get totalLoansStatLabel => 'মোট ঋণ';

  @override
  String get documentsStatLabel => 'নথিপত্র';

  @override
  String get backupTitle => 'ব্যাকআপ ও পুনরুদ্ধার';

  @override
  String get backupSubtitle =>
      'আপনার ঋণ খাতার স্থানীয় স্ন্যাপশট রপ্তানি বা পুনরুদ্ধার করুন।';

  @override
  String get exportBackupButton => 'স্থানীয় ব্যাকআপ তৈরি করুন';

  @override
  String get restoreBackupButton => 'স্ন্যাপশট পুনরুদ্ধার করুন';

  @override
  String get backupGeneratedMessage =>
      'ব্যাকআপ স্ন্যাপশট তৈরি করে ক্লিপবোর্ডে কপি করা হয়েছে।';

  @override
  String get restoreSuccessMessage =>
      'ব্যাকআপ স্ন্যাপশট সফলভাবে পুনরুদ্ধার হয়েছে।';

  @override
  String get restoreInvalidError => 'অবৈধ ব্যাকআপ স্ন্যাপশট JSON।';

  @override
  String get pasteBackupHint =>
      'পুনরুদ্ধার করতে রপ্তানি করা ব্যাকআপ JSON এখানে পেস্ট করুন';

  @override
  String get driveComingSoonNote =>
      'Google Drive এনক্রিপ্টেড সিঙ্ক ধাপ ৬-এ যুক্ত হবে।';

  @override
  String get emiPdfButton => 'EMI PDF';

  @override
  String get viewCompletePdfButton => 'সম্পূর্ণ ঋণ PDF';

  @override
  String emiPdfGeneratedMessage(int no) {
    return 'কিস্তি #$no পরিশোধ করা হয়েছে এবং PDF ডকুমেন্টে সংরক্ষণ করা হয়েছে।';
  }

  @override
  String emiReceiptTag(int no) {
    return 'EMI #$no রসিদ';
  }

  @override
  String get completeLoanPdfTag => 'সম্পূর্ণ ঋণ PDF';

  @override
  String get emiCalculatorTitle => 'EMI ক্যালকুলেটর';

  @override
  String get emiCalculatorSubtitle =>
      'ঋণ তৈরি করার আগে মাসিক কিস্তি, মোট সুদ এবং পরিশোধের সময়সূচি অনুমান করুন।';

  @override
  String get principalShareLabel => 'আসল অংশ';

  @override
  String get interestShareLabel => 'সুদের অংশ';

  @override
  String get resetFieldsButton => 'রিসেট করুন';

  @override
  String get proceedToCreateLoanButton => 'এই শর্তে ঋণ তৈরি করুন';

  @override
  String get schedulePreviewHeading => 'সময়সূচি প্রিভিউ';

  @override
  String get enterTermsForEstimate =>
      'EMI অনুমান দেখতে আসল, মাসিক সুদের হার এবং মেয়াদ লিখুন।';

  @override
  String get systemDefaultLanguage => 'সিস্টেম ডিফল্ট';

  @override
  String get choosePhotoTitle => 'প্রোফাইল ছবি';

  @override
  String get pickFromGallery => 'গ্যালারি থেকে বাছাই করুন';

  @override
  String get takePhoto => 'ছবি তুলুন';

  @override
  String get removePhoto => 'ছবি সরান';

  @override
  String get changeAvatarColor => 'ব্যাজ রঙ পরিবর্তন করুন';

  @override
  String get photoPickFailedError => 'নির্বাচিত ছবি লোড করা যায়নি।';

  @override
  String get databaseError =>
      'স্থানীয়ভাবে ডেটা সংরক্ষণ করা যায়নি। অনুগ্রহ করে আবার চেষ্টা করুন।';

  @override
  String get onboardingSkip => 'এড়িয়ে যান';

  @override
  String get onboardingStart => 'শুরু করুন';

  @override
  String get onboardingNext => 'পরবর্তী';

  @override
  String get onboardingTitle1 => 'স্মার্ট লেন্ডিং হাব';

  @override
  String get onboardingSubtitle1 =>
      'গ্রাহকদের পরিচালনা করুন, সরল বা চক্রবৃদ্ধি ঋণ তৈরি করুন এবং অফলাইনে গুছিয়ে রাখুন।';

  @override
  String get onboardingTitle2 => 'EMI ও খতিয়ান ট্র্যাক করুন';

  @override
  String get onboardingSubtitle2 =>
      'মাসিক কিস্তি, নির্ধারিত তারিখ এবং আদায়ের হিসাব এক নজরে দেখুন।';

  @override
  String get onboardingTitle3 => 'তাৎক্ষণিক ঋণ চুক্তিপত্র';

  @override
  String get onboardingSubtitle3 =>
      'সম্পূর্ণ পরিশোধের পর ১৩টি ভাষায় স্বয়ংক্রিয়ভাবে A4 ঋণ চুক্তি PDF তৈরি করুন।';
}
