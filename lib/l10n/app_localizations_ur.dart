// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Urdu (`ur`).
class AppLocalizationsUr extends AppLocalizations {
  AppLocalizationsUr([String locale = 'ur']) : super(locale);

  @override
  String get appTitle => 'LoanWise';

  @override
  String get splashTagline => 'سمارٹ قرض اور ای ایم آئی کھاتہ';

  @override
  String get loginTitle => 'لاگ ان';

  @override
  String get nameLabel => 'نام';

  @override
  String get nameHint => 'اپنا پورا نام درج کریں';

  @override
  String get mobileLabel => 'موبائل نمبر';

  @override
  String get mobileHint => '10 ہندسوں کا موبائل نمبر';

  @override
  String get emailLabel => 'ای میل آئی ڈی';

  @override
  String get emailHint => 'name@example.com';

  @override
  String get signInButton => 'سائن ان کریں';

  @override
  String get errorNameRequired => 'براہ کرم اپنا نام درج کریں';

  @override
  String get errorMobileInvalid =>
      '6 سے 9 سے شروع ہونے والا 10 ہندسوں کا موبائل نمبر درج کریں';

  @override
  String get errorEmailInvalid => 'درست ای میل پتہ درج کریں';

  @override
  String get navHome => 'ہوم';

  @override
  String get navCustomers => 'گاہک';

  @override
  String get navLoans => 'قرضے';

  @override
  String get navProfile => 'پروفائل';

  @override
  String get welcomeBack => 'خوش آمدید،';

  @override
  String get openMenuTooltip => 'مینو کھولیں';

  @override
  String get openProfileTooltip => 'پروفائل کھولیں';

  @override
  String get totalLentLabel => 'کل دیا گیا قرض';

  @override
  String get availableToCollect => 'وصولی کے لیے باقی';

  @override
  String get activeLoansLabel => 'فعال قرضے';

  @override
  String get customersLabel => 'گاہک';

  @override
  String get emisDueThisMonthLabel => 'اس ماہ کی ای ایم آئی';

  @override
  String get quickActionsHeading => 'فوری کارروائیاں';

  @override
  String get actionAddCustomer => 'گاہک شامل کریں';

  @override
  String get actionCreateLoan => 'قرض بنائیں';

  @override
  String get actionLoans => 'قرضے';

  @override
  String get actionDocuments => 'دستاویزات';

  @override
  String get actionAllCustomers => 'تمام گاہک';

  @override
  String get actionProfile => 'پروفائل';

  @override
  String get thisMonthHeading => 'اس ماہ';

  @override
  String get viewAll => 'سب دیکھیں';

  @override
  String get collectedThisMonth => 'اس ماہ وصول ہوا';

  @override
  String get pendingThisMonth => 'اس ماہ باقی';

  @override
  String get recentLoansHeading => 'حالیہ قرضے';

  @override
  String get overdueEmisHeading => 'تاخیر شدہ ای ایم آئی';

  @override
  String get statusActive => 'فعال';

  @override
  String get statusCompleted => 'مکمل';

  @override
  String get statusOverdue => 'تاخیر شدہ';

  @override
  String get statusPending => 'زیر التوا';

  @override
  String get statusPaid => 'ادا شدہ';

  @override
  String nextEmiLabel(String date) {
    return 'اگلی ای ایم آئی: $date';
  }

  @override
  String dueSinceLabel(String date) {
    return 'مقررہ تاریخ: $date';
  }

  @override
  String get emptyRecentLoans =>
      'ابھی کوئی حالیہ قرض نہیں ہے۔ یہاں دیکھنے کے لیے قرض بنائیں۔';

  @override
  String get emptyOverdueEmis =>
      'سب مکمل ہے۔ کوئی تاخیر شدہ ای ایم آئی نہیں ہے۔';

  @override
  String get drawerBackupRestore => 'بیک اپ اور بحالی';

  @override
  String get drawerChangeTheme => 'تھیم تبدیل کریں';

  @override
  String get drawerChooseLanguage => 'زبان منتخب کریں';

  @override
  String get themeLight => 'لائٹ';

  @override
  String get themeDark => 'ڈارک';

  @override
  String get themeSystem => 'سسٹم';

  @override
  String get backupDialogMessage => 'آپ کے آلے کے لیے مقامی بیک اپ اپ ڈیٹ ہے۔';

  @override
  String get closeAction => 'بند کریں';

  @override
  String featureQueuedMessage(String feature) {
    return '$feature تیار ہے۔';
  }

  @override
  String get tabCustomersSubtitle =>
      'قرض لینے والوں، رابطے کی تفصیلات اور فعال قرضوں کا انتظام کریں۔';

  @override
  String get tabLoansSubtitle => 'فعال قرضے، سود اور ای ایم آئی شیڈول دیکھیں۔';

  @override
  String get tabProfileSubtitle =>
      'آپ کی رجسٹرڈ قرض دہندہ تفصیلات اور ترجیحات۔';

  @override
  String get signOutAction => 'سائن آؤٹ';

  @override
  String get addCustomerTitle => 'گاہک شامل کریں';

  @override
  String get editCustomerTitle => 'گاہک میں ترمیم کریں';

  @override
  String get customerNameLabel => 'گاہک کا نام';

  @override
  String get customerEmailLabel => 'گاہک کا ای میل';

  @override
  String get customerMobileLabel => 'موبائل نمبر';

  @override
  String get customerLocationLabel => 'مقام';

  @override
  String get locationRequiredError => 'براہ کرم مقام درج کریں';

  @override
  String get saveCustomerButton => 'گاہک محفوظ کریں';

  @override
  String get updateCustomerButton => 'گاہک اپ ڈیٹ کریں';

  @override
  String get customerAddedTitle => 'گاہک کامیابی سے شامل ہو گیا';

  @override
  String customerAddedMessage(String name) {
    return 'کیا آپ ابھی $name کے لیے قرض بنانا چاہتے ہیں؟';
  }

  @override
  String get laterButton => 'بعد میں';

  @override
  String get searchCustomersHint => 'نام یا موبائل سے تلاش کریں';

  @override
  String get noCustomersTitle => 'کوئی گاہک نہیں ملا';

  @override
  String get noCustomersSubtitle => 'پہلا گاہک شامل کرنے کے لیے + دبائیں۔';

  @override
  String get editCustomerMenu => 'تفصیلات میں ترمیم';

  @override
  String get deleteCustomerMenu => 'گاہک حذف کریں';

  @override
  String get createLoanMenu => 'قرض بنائیں';

  @override
  String get deleteCustomerConfirmTitle => 'گاہک حذف کریں؟';

  @override
  String deleteCustomerConfirmMessage(String name) {
    return 'یہ $name کو فعال گاہکوں کی فہرست سے ہٹا دے گا۔';
  }

  @override
  String get deleteAction => 'حذف کریں';

  @override
  String get cancelAction => 'منسوخ کریں';

  @override
  String get activeLoanDeleteBlocked =>
      'فعال قرض رکھنے والے گاہک کو حذف نہیں کیا جا سکتا۔';

  @override
  String get duplicateMobileError =>
      'اس موبائل نمبر والا گاہک پہلے سے موجود ہے۔';

  @override
  String get customerDetailTitle => 'گاہک کی تفصیلات';

  @override
  String get callAction => 'کال';

  @override
  String get smsAction => 'ایس ایم ایس';

  @override
  String get customerLoansHeading => 'گاہک کے قرضے';

  @override
  String get mobileLockedHelper =>
      'قرض موجود ہونے پر موبائل نمبر تبدیل نہیں کیا جا سکتا۔';

  @override
  String activeLoansCountLabel(int count) {
    return '$count فعال';
  }

  @override
  String get createLoanTitle => 'قرض بنائیں';

  @override
  String get searchCustomerMobileHint => '10 ہندسوں کا موبائل نمبر درج کریں';

  @override
  String get noCustomerWithMobile => 'اس موبائل نمبر پر کوئی گاہک نہیں ہے';

  @override
  String get addCustomerShortcut => 'گاہک شامل کریں';

  @override
  String get principalLabel => 'اصل رقم (₹)';

  @override
  String get monthlyRateLabel => 'ماہانہ شرح سود (%)';

  @override
  String get tenureMonthsLabel => 'مدت (ماہ)';

  @override
  String get loanTypeLabel => 'سود کی قسم';

  @override
  String get loanTypeSimple => 'سادہ سود';

  @override
  String get loanTypeCompound => 'مرکب سود';

  @override
  String get startDateLabel => 'شروع کی تاریخ';

  @override
  String get livePreviewHeading => 'لائیو ای ایم آئی پیش نظارہ';

  @override
  String get monthlyEmiLabel => 'ماہانہ ای ایم آئی';

  @override
  String get totalInterestLabel => 'کل سود';

  @override
  String get totalPayableLabel => 'کل قابل ادائیگی';

  @override
  String get createLoanButton => 'قرض بنائیں';

  @override
  String get loanCreatedTitle => 'قرض کامیابی سے بن گیا';

  @override
  String loanCreatedMessage(int count) {
    return '$count ماہانہ اقساط تیار کر دی گئی ہیں۔';
  }

  @override
  String get viewLoanOverview => 'قرض کا خلاصہ کھولیں';

  @override
  String get allLoansFilter => 'تمام';

  @override
  String get activeLoansFilter => 'فعال';

  @override
  String get completedLoansFilter => 'مکمل';

  @override
  String get noLoansTitle => 'ابھی کوئی قرض نہیں';

  @override
  String get noLoansSubtitle => 'ای ایم آئی شیڈول بنانے کے لیے قرض بنائیں۔';

  @override
  String get selectCustomerError =>
      'پہلے 10 ہندسوں کے موبائل سے گاہک منتخب کریں۔';

  @override
  String get invalidPrincipalError => '0 سے زیادہ اصل رقم درج کریں۔';

  @override
  String get invalidRateError => '0 سے 100 کے درمیان ماہانہ شرح درج کریں۔';

  @override
  String get invalidTenureError => '1 سے 600 ماہ کی مدت درج کریں۔';

  @override
  String get loanOverviewTitle => 'قرض کا خلاصہ';

  @override
  String get emiScheduleHeading => 'ای ایم آئی شیڈول';

  @override
  String get payButton => 'ادا کریں';

  @override
  String get payAllPendingButton => 'تمام زیر التوا ای ایم آئی ادا کریں';

  @override
  String confirmPayEmiTitle(int no) {
    return 'ای ایم آئی #$no ادا شدہ نشان زد کریں؟';
  }

  @override
  String confirmPayEmiMessage(String amount) {
    return '$amount کی ادائیگی کی تصدیق کریں۔';
  }

  @override
  String get paymentDateLabel => 'ادائیگی کی تاریخ';

  @override
  String get confirmPayAllTitle => 'تمام زیر التوا ای ایم آئی ادا کریں؟';

  @override
  String confirmPayAllMessage(int count, String amount) {
    return 'یہ باقی $count اقساط ($amount) ادا کر کے قرض معاہدہ پی ڈی ایف بنائے گا۔';
  }

  @override
  String installmentLabel(int no) {
    return 'قسط #$no';
  }

  @override
  String paidOnLabel(String date) {
    return 'ادائیگی: $date';
  }

  @override
  String get outOfOrderEmiError =>
      'براہ کرم پہلے پچھلی زیر التوا اقساط ترتیب سے ادا کریں۔';

  @override
  String emiPaidSuccess(int no) {
    return 'قسط #$no ادا شدہ نشان زد ہو گئی۔';
  }

  @override
  String get loanCompletedPdfGenerated =>
      'قرض مکمل! معاہدہ پی ڈی ایف دستاویزات میں محفوظ ہو گیا۔';

  @override
  String get viewPdfAction => 'پی ڈی ایف دیکھیں';

  @override
  String get openDocumentsAction => 'دستاویزات کھولیں';

  @override
  String progressPaidLabel(int paid, int total) {
    return '$total میں سے $paid ای ایم آئی ادا';
  }

  @override
  String get ledgerHeading => 'کھاتہ ہسٹری';

  @override
  String get ledgerDebitLabel => 'ڈیبٹ';

  @override
  String get ledgerCreditLabel => 'کریڈٹ';

  @override
  String get ledgerBalanceLabel => 'بقیہ';

  @override
  String get documentsTitle => 'دستاویزات';

  @override
  String get noDocumentsTitle => 'ابھی کوئی پی ڈی ایف دستاویز نہیں';

  @override
  String get noDocumentsSubtitle =>
      'قرض مکمل ادا ہونے پر معاہدہ خودکار طور پر یہاں آئے گا۔';

  @override
  String get viewPdfMenu => 'پی ڈی ایف دیکھیں';

  @override
  String get sharePdfMenu => 'پی ڈی ایف شیئر کریں';

  @override
  String get deletePdfMenu => 'پی ڈی ایف حذف کریں';

  @override
  String get editPdfMenu => 'پی ڈی ایف میں ترمیم';

  @override
  String get deletePdfConfirmTitle => 'دستاویز حذف کریں؟';

  @override
  String get deletePdfConfirmMessage =>
      'یہ تیار کردہ قرض معاہدہ دستاویزات سے ہٹا دے گا۔';

  @override
  String pagesCountLabel(int count) {
    return '$count صفحات';
  }

  @override
  String get documentViewerTitle => 'قرض معاہدہ ناظر';

  @override
  String get loanAgreementHeadline => 'قرض کا معاہدہ';

  @override
  String get lenderDetailsHeading => 'قرض دہندہ کی تفصیلات';

  @override
  String get borrowerDetailsHeading => 'قرض دار کی تفصیلات';

  @override
  String get installmentScheduleHeading => 'اقساط کا شیڈول';

  @override
  String get generatedOnLabel => 'تیاری کی تاریخ';

  @override
  String get documentIdLabel => 'دستاویز آئی ڈی';

  @override
  String pageOfLabel(int current, int total) {
    return 'صفحہ $current از $total';
  }

  @override
  String get signatureLender => 'قرض دہندہ کے دستخط';

  @override
  String get signatureBorrower => 'قرض دار کے دستخط';

  @override
  String get editPdfTitle => 'پی ڈی ایف میں ترمیم';

  @override
  String get snapshotNotice =>
      'تبدیلیاں صرف اس پی ڈی ایف اسنیپ شاٹ کو اپ ڈیٹ کرتی ہیں؛ اصل قرض یا کھاتہ نہیں بدلتا۔';

  @override
  String get pdfLanguageLabel => 'دستاویز کی زبان';

  @override
  String get statusTextLabel => 'حالت کا متن';

  @override
  String get previewButton => 'پیش نظارہ';

  @override
  String get regeneratePdfButton => 'پی ڈی ایف دوبارہ بنائیں';

  @override
  String get pdfRegeneratedSuccess => 'دستاویز کامیابی سے دوبارہ بن گئی۔';

  @override
  String shareReadyMessage(String title, int pages) {
    return 'شیئر کرنے کے لیے $title ($pages صفحات) تیار ہے۔';
  }

  @override
  String get copyHtmlAction => 'HTML کاپی کریں';

  @override
  String get htmlCopiedMessage => 'A4 HTML کلپ بورڈ میں کاپی ہو گیا۔';

  @override
  String get saveChangesButton => 'تبدیلیاں محفوظ کریں';

  @override
  String get profileUpdatedSuccess => 'پروفائل کامیابی سے اپ ڈیٹ ہو گئی۔';

  @override
  String get signOutConfirmTitle => 'سائن آؤٹ؟';

  @override
  String get signOutConfirmMessage =>
      'آپ کسی بھی وقت اپنی تفصیلات سے دوبارہ سائن ان کر سکتے ہیں۔';

  @override
  String get totalLoansStatLabel => 'کل قرضے';

  @override
  String get documentsStatLabel => 'دستاویزات';

  @override
  String get backupTitle => 'بیک اپ اور بحالی';

  @override
  String get backupSubtitle =>
      'مقامی اسنیپ شاٹ ایکسپورٹ کریں یا اپنا کھاتہ بحال کریں۔';

  @override
  String get exportBackupButton => 'مقامی بیک اپ بنائیں';

  @override
  String get restoreBackupButton => 'اسنیپ شاٹ بحال کریں';

  @override
  String get backupGeneratedMessage =>
      'بیک اپ اسنیپ شاٹ کلپ بورڈ میں کاپی ہو گیا۔';

  @override
  String get restoreSuccessMessage =>
      'بیک اپ اسنیپ شاٹ کامیابی سے بحال ہو گیا۔';

  @override
  String get restoreInvalidError => 'غلط بیک اپ JSON۔';

  @override
  String get pasteBackupHint => 'بحال کرنے کے لیے بیک اپ JSON یہاں پیسٹ کریں';

  @override
  String get driveComingSoonNote =>
      'Google Drive انکرپٹڈ AppData سنک مرحلہ 6 میں شامل ہوگا۔';

  @override
  String get emiPdfButton => 'EMI PDF';

  @override
  String get viewCompletePdfButton => 'مکمل قرض PDF';

  @override
  String emiPdfGeneratedMessage(int no) {
    return 'قسط #$no ادا ہو گئی اور PDF دستاویزات میں محفوظ ہو گئی۔';
  }

  @override
  String emiReceiptTag(int no) {
    return 'EMI #$no رسید';
  }

  @override
  String get completeLoanPdfTag => 'مکمل قرض PDF';

  @override
  String get emiCalculatorTitle => 'EMI کیلکولیٹر';

  @override
  String get emiCalculatorSubtitle =>
      'قرض بنانے سے پہلے ماہانہ قسط، کل سود اور ادائیگی کے شیڈول کا اندازہ لگائیں۔';

  @override
  String get principalShareLabel => 'اصل رقم کا حصہ';

  @override
  String get interestShareLabel => 'سود کا حصہ';

  @override
  String get resetFieldsButton => 'ری سیٹ';

  @override
  String get proceedToCreateLoanButton => 'ان شرائط کے ساتھ قرض بنائیں';

  @override
  String get schedulePreviewHeading => 'شیڈول کا پیش نظارہ';

  @override
  String get enterTermsForEstimate =>
      'EMI کا اندازہ دیکھنے کے لیے اصل رقم، ماہانہ شرح اور مدت درج کریں۔';

  @override
  String get systemDefaultLanguage => 'سسٹم ڈیفالٹ';

  @override
  String get choosePhotoTitle => 'پروفائل تصویر';

  @override
  String get pickFromGallery => 'گیلری سے منتخب کریں';

  @override
  String get takePhoto => 'تصویر کھینچیں';

  @override
  String get removePhoto => 'تصویر ہٹائیں';

  @override
  String get changeAvatarColor => 'بیج کا رنگ تبدیل کریں';

  @override
  String get photoPickFailedError => 'منتخب کردہ تصویر لوڈ نہیں ہو سکی۔';

  @override
  String get databaseError =>
      'ڈیٹا مقامی طور پر محفوظ نہیں ہو سکا۔ براہ کرم دوبارہ کوشش کریں۔';

  @override
  String get onboardingSkip => 'چھوڑیں';

  @override
  String get onboardingStart => 'شروع کریں';

  @override
  String get onboardingNext => 'آگے';

  @override
  String get onboardingTitle1 => 'سمارٹ قرض ہب';

  @override
  String get onboardingSubtitle1 =>
      'صارفین کا انتظام کریں، سادہ یا مرکب سود پر قرض بنائیں اور آف لائن منظم رہیں۔';

  @override
  String get onboardingTitle2 => 'EMI اور کھاتہ ٹریک کریں';

  @override
  String get onboardingSubtitle2 =>
      'ماہانہ اقساط، مقررہ تاریخیں اور وصولیاں ایک نظر میں دیکھیں۔';

  @override
  String get onboardingTitle3 => 'فوری قرض معاہدے';

  @override
  String get onboardingSubtitle3 =>
      'مکمل ادائیگی پر 13 زبانوں میں خودکار A4 قرض معاہدہ PDF تیار کریں۔';
}
