// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'LoanWise';

  @override
  String get splashTagline => 'स्मार्ट ऋण और ईएमआई खाता';

  @override
  String get loginTitle => 'लॉगिन';

  @override
  String get nameLabel => 'नाम';

  @override
  String get nameHint => 'अपना पूरा नाम दर्ज करें';

  @override
  String get mobileLabel => 'मोबाइल नंबर';

  @override
  String get mobileHint => '10 अंकों का मोबाइल नंबर';

  @override
  String get emailLabel => 'ईमेल आईडी';

  @override
  String get emailHint => 'name@example.com';

  @override
  String get signInButton => 'साइन इन करें';

  @override
  String get errorNameRequired => 'कृपया अपना नाम दर्ज करें';

  @override
  String get errorMobileInvalid =>
      '6 से 9 से शुरू होने वाला 10 अंकों का मोबाइल नंबर दर्ज करें';

  @override
  String get errorEmailInvalid => 'मान्य ईमेल पता दर्ज करें';

  @override
  String get navHome => 'होम';

  @override
  String get navCustomers => 'ग्राहक';

  @override
  String get navLoans => 'ऋण';

  @override
  String get navProfile => 'प्रोफ़ाइल';

  @override
  String get welcomeBack => 'वापसी पर स्वागत है,';

  @override
  String get openMenuTooltip => 'मेनू खोलें';

  @override
  String get openProfileTooltip => 'प्रोफ़ाइल खोलें';

  @override
  String get totalLentLabel => 'कुल दिया गया ऋण';

  @override
  String get availableToCollect => 'संग्रह के लिए उपलब्ध';

  @override
  String get activeLoansLabel => 'सक्रिय ऋण';

  @override
  String get customersLabel => 'ग्राहक';

  @override
  String get emisDueThisMonthLabel => 'इस माह देय ईएमआई';

  @override
  String get quickActionsHeading => 'त्वरित कार्य';

  @override
  String get actionAddCustomer => 'ग्राहक जोड़ें';

  @override
  String get actionCreateLoan => 'ऋण बनाएं';

  @override
  String get actionLoans => 'ऋण';

  @override
  String get actionDocuments => 'दस्तावेज़';

  @override
  String get actionAllCustomers => 'सभी ग्राहक';

  @override
  String get actionProfile => 'प्रोफ़ाइल';

  @override
  String get thisMonthHeading => 'इस महीने';

  @override
  String get viewAll => 'सभी देखें';

  @override
  String get collectedThisMonth => 'इस माह एकत्रित';

  @override
  String get pendingThisMonth => 'इस माह लंबित';

  @override
  String get recentLoansHeading => 'हाल के ऋण';

  @override
  String get overdueEmisHeading => 'अतिदेय ईएमआई';

  @override
  String get statusActive => 'सक्रिय';

  @override
  String get statusCompleted => 'पूर्ण';

  @override
  String get statusOverdue => 'अतिदेय';

  @override
  String get statusPending => 'लंबित';

  @override
  String get statusPaid => 'भुगतान किया';

  @override
  String nextEmiLabel(String date) {
    return 'अगली ईएमआई: $date';
  }

  @override
  String dueSinceLabel(String date) {
    return 'देय: $date';
  }

  @override
  String get emptyRecentLoans =>
      'अभी कोई हालिया ऋण नहीं है। गतिविधि देखने के लिए ऋण बनाएं।';

  @override
  String get emptyOverdueEmis =>
      'सब अद्यतित है। फिलहाल कोई अतिदेय ईएमआई नहीं है।';

  @override
  String get drawerBackupRestore => 'बैकअप और रीस्टोर';

  @override
  String get drawerChangeTheme => 'थीम बदलें';

  @override
  String get drawerChooseLanguage => 'भाषा चुनें';

  @override
  String get themeLight => 'लाइट';

  @override
  String get themeDark => 'डार्क';

  @override
  String get themeSystem => 'सिस्टम';

  @override
  String get backupDialogMessage =>
      'आपके डिवाइस के लिए स्थानीय बैकअप अद्यतित है।';

  @override
  String get closeAction => 'बंद करें';

  @override
  String featureQueuedMessage(String feature) {
    return '$feature तैयार है।';
  }

  @override
  String get tabCustomersSubtitle =>
      'उधारकर्ताओं, संपर्क विवरण और सक्रिय ऋण रिकॉर्ड का प्रबंधन करें।';

  @override
  String get tabLoansSubtitle =>
      'सक्रिय ऋण, ब्याज और ईएमआई अनुसूची ट्रैक करें।';

  @override
  String get tabProfileSubtitle =>
      'आपका पंजीकृत ऋणदाता विवरण और कार्यक्षेत्र प्राथमिकताएं।';

  @override
  String get signOutAction => 'साइन आउट';

  @override
  String get addCustomerTitle => 'ग्राहक जोड़ें';

  @override
  String get editCustomerTitle => 'ग्राहक संपादित करें';

  @override
  String get customerNameLabel => 'ग्राहक का नाम';

  @override
  String get customerEmailLabel => 'ग्राहक ईमेल';

  @override
  String get customerMobileLabel => 'मोबाइल नंबर';

  @override
  String get customerLocationLabel => 'स्थान';

  @override
  String get locationRequiredError => 'कृपया स्थान दर्ज करें';

  @override
  String get saveCustomerButton => 'ग्राहक सहेजें';

  @override
  String get updateCustomerButton => 'ग्राहक अपडेट करें';

  @override
  String get customerAddedTitle => 'ग्राहक सफलतापूर्वक जोड़ा गया';

  @override
  String customerAddedMessage(String name) {
    return 'क्या आप अभी $name के लिए ऋण बनाना चाहते हैं?';
  }

  @override
  String get laterButton => 'बाद में';

  @override
  String get searchCustomersHint => 'नाम या मोबाइल से खोजें';

  @override
  String get noCustomersTitle => 'कोई ग्राहक नहीं मिला';

  @override
  String get noCustomersSubtitle => 'अपना पहला ग्राहक जोड़ने के लिए + दबाएं।';

  @override
  String get editCustomerMenu => 'ग्राहक विवरण संपादित करें';

  @override
  String get deleteCustomerMenu => 'ग्राहक हटाएं';

  @override
  String get createLoanMenu => 'ऋण बनाएं';

  @override
  String get deleteCustomerConfirmTitle => 'ग्राहक हटाएं?';

  @override
  String deleteCustomerConfirmMessage(String name) {
    return 'यह $name को आपकी सक्रिय ग्राहक सूची से हटा देगा।';
  }

  @override
  String get deleteAction => 'हटाएं';

  @override
  String get cancelAction => 'रद्द करें';

  @override
  String get activeLoanDeleteBlocked =>
      'सक्रिय ऋण वाले ग्राहक को हटाया नहीं जा सकता।';

  @override
  String get duplicateMobileError =>
      'इस मोबाइल नंबर वाला ग्राहक पहले से मौजूद है।';

  @override
  String get customerDetailTitle => 'ग्राहक विवरण';

  @override
  String get callAction => 'कॉल';

  @override
  String get smsAction => 'एसएमएस';

  @override
  String get customerLoansHeading => 'ग्राहक के ऋण';

  @override
  String get mobileLockedHelper =>
      'ऋण होने के बाद मोबाइल नंबर नहीं बदला जा सकता।';

  @override
  String activeLoansCountLabel(int count) {
    return '$count सक्रिय';
  }

  @override
  String get createLoanTitle => 'ऋण बनाएं';

  @override
  String get searchCustomerMobileHint => '10 अंकों का ग्राहक मोबाइल दर्ज करें';

  @override
  String get noCustomerWithMobile => 'इस मोबाइल वाला कोई ग्राहक नहीं';

  @override
  String get addCustomerShortcut => 'ग्राहक जोड़ें';

  @override
  String get principalLabel => 'मूलधन राशि (₹)';

  @override
  String get monthlyRateLabel => 'ब्याज दर (% प्रति माह)';

  @override
  String get tenureMonthsLabel => 'अवधि (महीने)';

  @override
  String get loanTypeLabel => 'ब्याज प्रकार';

  @override
  String get loanTypeSimple => 'साधारण';

  @override
  String get loanTypeCompound => 'चक्रवृद्धि';

  @override
  String get startDateLabel => 'प्रारंभ तिथि';

  @override
  String get livePreviewHeading => 'लाइव ईएमआई पूर्वावलोकन';

  @override
  String get monthlyEmiLabel => 'मासिक ईएमआई';

  @override
  String get totalInterestLabel => 'कुल ब्याज';

  @override
  String get totalPayableLabel => 'कुल देय';

  @override
  String get createLoanButton => 'ऋण बनाएं';

  @override
  String get loanCreatedTitle => 'ऋण सफलतापूर्वक बनाया गया';

  @override
  String loanCreatedMessage(int count) {
    return '$count मासिक ईएमआई तैयार की गई हैं।';
  }

  @override
  String get viewLoanOverview => 'ऋण विवरण खोलें';

  @override
  String get allLoansFilter => 'सभी';

  @override
  String get activeLoansFilter => 'सक्रिय';

  @override
  String get completedLoansFilter => 'पूर्ण';

  @override
  String get noLoansTitle => 'अभी कोई ऋण नहीं';

  @override
  String get noLoansSubtitle => 'ईएमआई अनुसूची बनाने के लिए नया ऋण जोड़ें।';

  @override
  String get selectCustomerError => 'पहले 10 अंकों के मोबाइल से ग्राहक चुनें।';

  @override
  String get invalidPrincipalError => '0 से अधिक मूलधन दर्ज करें।';

  @override
  String get invalidRateError => '0 से 100 के बीच मासिक दर दर्ज करें।';

  @override
  String get invalidTenureError => '1 से 600 महीनों के बीच अवधि दर्ज करें।';

  @override
  String get loanOverviewTitle => 'ऋण अवलोकन';

  @override
  String get emiScheduleHeading => 'ईएमआई अनुसूची';

  @override
  String get payButton => 'भुगतान';

  @override
  String get payAllPendingButton => 'सभी लंबित ईएमआई चुकाएं';

  @override
  String confirmPayEmiTitle(int no) {
    return 'ईएमआई #$no का भुगतान दर्ज करें?';
  }

  @override
  String confirmPayEmiMessage(String amount) {
    return '$amount के भुगतान की पुष्टि करें।';
  }

  @override
  String get paymentDateLabel => 'भुगतान तिथि';

  @override
  String get confirmPayAllTitle => 'सभी लंबित ईएमआई चुकाएं?';

  @override
  String confirmPayAllMessage(int count, String amount) {
    return 'इससे शेष $count ईएमआई ($amount) चुकता हो जाएंगी और ऋण समझौता पीडीएफ तैयार होगी।';
  }

  @override
  String installmentLabel(int no) {
    return 'किस्त #$no';
  }

  @override
  String paidOnLabel(String date) {
    return 'भुगतान: $date';
  }

  @override
  String get outOfOrderEmiError =>
      'कृपया पहले पिछली लंबित किस्तों का भुगतान क्रम से करें।';

  @override
  String emiPaidSuccess(int no) {
    return 'किस्त #$no का भुगतान दर्ज हुआ।';
  }

  @override
  String get loanCompletedPdfGenerated =>
      'ऋण पूर्ण! ऋण समझौता पीडीएफ दस्तावेज़ में सहेजा गया।';

  @override
  String get viewPdfAction => 'पीडीएफ देखें';

  @override
  String get openDocumentsAction => 'दस्तावेज़ खोलें';

  @override
  String progressPaidLabel(int paid, int total) {
    return '$total में से $paid ईएमआई भुगतान';
  }

  @override
  String get ledgerHeading => 'खाता बही इतिहास';

  @override
  String get ledgerDebitLabel => 'नामे';

  @override
  String get ledgerCreditLabel => 'जमा';

  @override
  String get ledgerBalanceLabel => 'शेष';

  @override
  String get documentsTitle => 'दस्तावेज़';

  @override
  String get noDocumentsTitle => 'अभी कोई पीडीएफ दस्तावेज़ नहीं';

  @override
  String get noDocumentsSubtitle =>
      'ऋण पूर्ण भुगतान के बाद ऋण समझौता स्वतः यहाँ दिखाई देगा।';

  @override
  String get viewPdfMenu => 'पीडीएफ देखें';

  @override
  String get sharePdfMenu => 'पीडीएफ साझा करें';

  @override
  String get deletePdfMenu => 'पीडीएफ हटाएं';

  @override
  String get editPdfMenu => 'पीडीएफ संपादित करें';

  @override
  String get deletePdfConfirmTitle => 'दस्तावेज़ हटाएं?';

  @override
  String get deletePdfConfirmMessage =>
      'यह दस्तावेज़ से तैयार ऋण समझौते को हटा देगा।';

  @override
  String pagesCountLabel(int count) {
    return '$count पृष्ठ';
  }

  @override
  String get documentViewerTitle => 'ऋण समझौता दर्शक';

  @override
  String get loanAgreementHeadline => 'ऋण समझौता';

  @override
  String get lenderDetailsHeading => 'ऋणदाता विवरण';

  @override
  String get borrowerDetailsHeading => 'ऋणकर्ता विवरण';

  @override
  String get installmentScheduleHeading => 'किस्त अनुसूची';

  @override
  String get generatedOnLabel => 'निर्माण तिथि';

  @override
  String get documentIdLabel => 'दस्तावेज़ आईडी';

  @override
  String pageOfLabel(int current, int total) {
    return 'पृष्ठ $current / $total';
  }

  @override
  String get signatureLender => 'ऋणदाता के हस्ताक्षर';

  @override
  String get signatureBorrower => 'ऋणकर्ता के हस्ताक्षर';

  @override
  String get editPdfTitle => 'पीडीएफ संपादित करें';

  @override
  String get snapshotNotice =>
      'बदलाव केवल इस पीडीएफ स्नैपशॉट को अपडेट करते हैं, मूल ऋण या खाता बही को नहीं।';

  @override
  String get pdfLanguageLabel => 'दस्तावेज़ भाषा';

  @override
  String get statusTextLabel => 'स्थिति लेबल';

  @override
  String get previewButton => 'पूर्वावलोकन';

  @override
  String get regeneratePdfButton => 'पीडीएफ पुनः बनाएं';

  @override
  String get pdfRegeneratedSuccess =>
      'दस्तावेज़ सफलतापूर्वक पुनः तैयार किया गया।';

  @override
  String shareReadyMessage(String title, int pages) {
    return '$title ($pages पृष्ठ) साझा करने के लिए तैयार है।';
  }

  @override
  String get copyHtmlAction => 'HTML कॉपी करें';

  @override
  String get htmlCopiedMessage => 'A4 HTML क्लिपबोर्ड पर कॉपी किया गया।';

  @override
  String get saveChangesButton => 'बदलाव सहेजें';

  @override
  String get profileUpdatedSuccess => 'प्रोफ़ाइल सफलतापूर्वक अपडेट की गई।';

  @override
  String get signOutConfirmTitle => 'साइन आउट करें?';

  @override
  String get signOutConfirmMessage =>
      'आप अपने ऋणदाता विवरण से कभी भी वापस साइन इन कर सकते हैं।';

  @override
  String get totalLoansStatLabel => 'कुल ऋण';

  @override
  String get documentsStatLabel => 'दस्तावेज़';

  @override
  String get backupTitle => 'बैकअप और रीस्टोर';

  @override
  String get backupSubtitle =>
      'अपने ऋण खाते का स्थानीय स्नैपशॉट निर्यात करें या रीस्टोर करें।';

  @override
  String get exportBackupButton => 'स्थानीय बैकअप बनाएं';

  @override
  String get restoreBackupButton => 'स्नैपशॉट रीस्टोर करें';

  @override
  String get backupGeneratedMessage =>
      'बैकअप स्नैपशॉट तैयार कर क्लिपबोर्ड पर कॉपी किया गया।';

  @override
  String get restoreSuccessMessage =>
      'बैकअप स्नैपशॉट सफलतापूर्वक रीस्टोर किया गया।';

  @override
  String get restoreInvalidError => 'अमान्य बैकअप स्नैपशॉट JSON।';

  @override
  String get pasteBackupHint =>
      'रीस्टोर करने के लिए निर्यात किया गया बैकअप JSON यहाँ पेस्ट करें';

  @override
  String get driveComingSoonNote =>
      'Google Drive एन्क्रिप्टेड बैकअप चरण 6 के लिए निर्धारित है।';

  @override
  String get emiPdfButton => 'EMI PDF';

  @override
  String get viewCompletePdfButton => 'पूर्ण ऋण PDF';

  @override
  String emiPdfGeneratedMessage(int no) {
    return 'किस्त #$no का भुगतान हो गया और PDF दस्तावेज़ों में सहेजा गया।';
  }

  @override
  String emiReceiptTag(int no) {
    return 'EMI #$no रसीद';
  }

  @override
  String get completeLoanPdfTag => 'पूर्ण ऋण PDF';

  @override
  String get emiCalculatorTitle => 'EMI कैलकुलेटर';

  @override
  String get emiCalculatorSubtitle =>
      'ऋण बनाने से पहले मासिक किस्त, कुल ब्याज और भुगतान अनुसूची का अनुमान लगाएं।';

  @override
  String get principalShareLabel => 'मूलधन हिस्सा';

  @override
  String get interestShareLabel => 'ब्याज हिस्सा';

  @override
  String get resetFieldsButton => 'रीसेट करें';

  @override
  String get proceedToCreateLoanButton => 'इन शर्तों से ऋण बनाएं';

  @override
  String get schedulePreviewHeading => 'किस्त अनुसूची पूर्वावलोकन';

  @override
  String get enterTermsForEstimate =>
      'EMI अनुमान देखने के लिए मूलधन, मासिक ब्याज दर और अवधि दर्ज करें।';

  @override
  String get systemDefaultLanguage => 'सिस्टम डिफ़ॉल्ट';

  @override
  String get choosePhotoTitle => 'प्रोफ़ाइल फ़ोटो';

  @override
  String get pickFromGallery => 'गैलरी से चुनें';

  @override
  String get takePhoto => 'फ़ोटो लें';

  @override
  String get removePhoto => 'फ़ोटो हटाएं';

  @override
  String get changeAvatarColor => 'बैज रंग बदलें';

  @override
  String get photoPickFailedError => 'चयनित छवि लोड नहीं हो सकी।';

  @override
  String get databaseError =>
      'डेटा स्थानीय रूप से सहेजा नहीं जा सका। कृपया पुनः प्रयास करें।';

  @override
  String get onboardingSkip => 'छोड़ें';

  @override
  String get onboardingStart => 'शुरू करें';

  @override
  String get onboardingNext => 'आगे';

  @override
  String get onboardingTitle1 => 'स्मार्ट ऋण केंद्र';

  @override
  String get onboardingSubtitle1 =>
      'ग्राहकों को प्रबंधित करें, सरल या चक्रवृद्धि ऋण बनाएं और ऑफ़लाइन व्यवस्थित रहें।';

  @override
  String get onboardingTitle2 => 'EMI और बहीखाता ट्रैक करें';

  @override
  String get onboardingSubtitle2 =>
      'मासिक किस्तें, देय तिथियां और वसूली एक नज़र में देखें।';

  @override
  String get onboardingTitle3 => 'तुरंत ऋण अनुबंध PDF';

  @override
  String get onboardingSubtitle3 =>
      'पूर्ण भुगतान के बाद 13 भाषाओं में स्वतः A4 ऋण अनुबंध PDF बनाएं।';
}
