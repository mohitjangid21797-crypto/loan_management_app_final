// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Marathi (`mr`).
class AppLocalizationsMr extends AppLocalizations {
  AppLocalizationsMr([String locale = 'mr']) : super(locale);

  @override
  String get appTitle => 'LoanWise';

  @override
  String get splashTagline => 'स्मार्ट कर्ज आणि ईएमआय खातेवही';

  @override
  String get loginTitle => 'लॉगिन';

  @override
  String get nameLabel => 'नाव';

  @override
  String get nameHint => 'तुमचे पूर्ण नाव लिहा';

  @override
  String get mobileLabel => 'मोबाईल क्रमांक';

  @override
  String get mobileHint => '10 अंकी मोबाईल क्रमांक';

  @override
  String get emailLabel => 'ईमेल आयडी';

  @override
  String get emailHint => 'name@example.com';

  @override
  String get signInButton => 'साइन इन करा';

  @override
  String get errorNameRequired => 'कृपया तुमचे नाव लिहा';

  @override
  String get errorMobileInvalid =>
      '6 ते 9 ने सुरू होणारा 10 अंकी मोबाईल क्रमांक टाका';

  @override
  String get errorEmailInvalid => 'वैध ईमेल पत्ता टाका';

  @override
  String get navHome => 'होम';

  @override
  String get navCustomers => 'ग्राहक';

  @override
  String get navLoans => 'कर्ज';

  @override
  String get navProfile => 'प्रोफाइल';

  @override
  String get welcomeBack => 'पुन्हा स्वागत आहे,';

  @override
  String get openMenuTooltip => 'मेनू उघडा';

  @override
  String get openProfileTooltip => 'प्रोफाइल उघडा';

  @override
  String get totalLentLabel => 'एकूण दिलेले कर्ज';

  @override
  String get availableToCollect => 'वसुलीसाठी उपलब्ध';

  @override
  String get activeLoansLabel => 'सक्रिय कर्जे';

  @override
  String get customersLabel => 'ग्राहक';

  @override
  String get emisDueThisMonthLabel => 'या महिन्यातील देय ईएमआय';

  @override
  String get quickActionsHeading => 'त्वरित क्रिया';

  @override
  String get actionAddCustomer => 'ग्राहक जोडा';

  @override
  String get actionCreateLoan => 'कर्ज तयार करा';

  @override
  String get actionLoans => 'कर्जे';

  @override
  String get actionDocuments => 'कागदपत्रे';

  @override
  String get actionAllCustomers => 'सर्व ग्राहक';

  @override
  String get actionProfile => 'प्रोफाइल';

  @override
  String get thisMonthHeading => 'या महिन्यात';

  @override
  String get viewAll => 'सर्व पहा';

  @override
  String get collectedThisMonth => 'या महिन्यात जमा';

  @override
  String get pendingThisMonth => 'या महिन्यात प्रलंबित';

  @override
  String get recentLoansHeading => 'अलीकडील कर्जे';

  @override
  String get overdueEmisHeading => 'थकीत ईएमआय';

  @override
  String get statusActive => 'सक्रिय';

  @override
  String get statusCompleted => 'पूर्ण';

  @override
  String get statusOverdue => 'थकीत';

  @override
  String get statusPending => 'प्रलंबित';

  @override
  String get statusPaid => 'भरलेले';

  @override
  String nextEmiLabel(String date) {
    return 'पुढील ईएमआय: $date';
  }

  @override
  String dueSinceLabel(String date) {
    return 'देय: $date';
  }

  @override
  String get emptyRecentLoans =>
      'अजून अलीकडील कर्जे नाहीत. सुरुवात करण्यासाठी कर्ज तयार करा.';

  @override
  String get emptyOverdueEmis =>
      'सर्व अद्ययावत आहे. सध्या कोणताही थकीत ईएमआय नाही.';

  @override
  String get drawerBackupRestore => 'बॅकअप आणि पुनर्संचयित';

  @override
  String get drawerChangeTheme => 'थीम बदला';

  @override
  String get drawerChooseLanguage => 'भाषा निवडा';

  @override
  String get themeLight => 'लाइट';

  @override
  String get themeDark => 'डार्क';

  @override
  String get themeSystem => 'सिस्टम';

  @override
  String get backupDialogMessage =>
      'तुमच्या डिव्हाइससाठी स्थानिक बॅकअप अद्ययावत आहे.';

  @override
  String get closeAction => 'बंद करा';

  @override
  String featureQueuedMessage(String feature) {
    return '$feature तयार आहे.';
  }

  @override
  String get tabCustomersSubtitle =>
      'कर्जदार, संपर्क तपशील आणि सक्रिय कर्जे व्यवस्थापित करा.';

  @override
  String get tabLoansSubtitle => 'सक्रिय कर्जे, व्याज आणि ईएमआय वेळापत्रक पहा.';

  @override
  String get tabProfileSubtitle =>
      'तुमचे नोंदणीकृत सावकार तपशील आणि प्राधान्ये.';

  @override
  String get signOutAction => 'साइन आउट';

  @override
  String get addCustomerTitle => 'ग्राहक जोडा';

  @override
  String get editCustomerTitle => 'ग्राहक संपादित करा';

  @override
  String get customerNameLabel => 'ग्राहकाचे नाव';

  @override
  String get customerEmailLabel => 'ग्राहक ईमेल';

  @override
  String get customerMobileLabel => 'मोबाईल क्रमांक';

  @override
  String get customerLocationLabel => 'ठिकाण';

  @override
  String get locationRequiredError => 'कृपया ठिकाण प्रविष्ट करा';

  @override
  String get saveCustomerButton => 'ग्राहक जतन करा';

  @override
  String get updateCustomerButton => 'ग्राहक अपडेट करा';

  @override
  String get customerAddedTitle => 'ग्राहक यशस्वीरित्या जोडला';

  @override
  String customerAddedMessage(String name) {
    return 'तुम्हाला आता $name साठी कर्ज तयार करायचे आहे का?';
  }

  @override
  String get laterButton => 'नंतर';

  @override
  String get searchCustomersHint => 'नाव किंवा मोबाईलने शोधा';

  @override
  String get noCustomersTitle => 'ग्राहक आढळले नाहीत';

  @override
  String get noCustomersSubtitle => 'पहिला ग्राहक जोडण्यासाठी + वर टॅप करा.';

  @override
  String get editCustomerMenu => 'तपशील संपादित करा';

  @override
  String get deleteCustomerMenu => 'ग्राहक हटवा';

  @override
  String get createLoanMenu => 'कर्ज तयार करा';

  @override
  String get deleteCustomerConfirmTitle => 'ग्राहक हटवायचा?';

  @override
  String deleteCustomerConfirmMessage(String name) {
    return 'हे $name ला सक्रिय ग्राहक यादीतून काढेल.';
  }

  @override
  String get deleteAction => 'हटवा';

  @override
  String get cancelAction => 'रद्द करा';

  @override
  String get activeLoanDeleteBlocked =>
      'सक्रिय कर्ज असलेला ग्राहक हटवता येत नाही.';

  @override
  String get duplicateMobileError =>
      'या मोबाईल क्रमांकाचा ग्राहक आधीच अस्तित्वात आहे.';

  @override
  String get customerDetailTitle => 'ग्राहक तपशील';

  @override
  String get callAction => 'कॉल';

  @override
  String get smsAction => 'एसएमएस';

  @override
  String get customerLoansHeading => 'ग्राहकाची कर्जे';

  @override
  String get mobileLockedHelper =>
      'कर्ज असल्यास मोबाईल क्रमांक बदलता येत नाही.';

  @override
  String activeLoansCountLabel(int count) {
    return '$count सक्रिय';
  }

  @override
  String get createLoanTitle => 'कर्ज तयार करा';

  @override
  String get searchCustomerMobileHint => '10 अंकी ग्राहक मोबाईल टाका';

  @override
  String get noCustomerWithMobile => 'या मोबाईलचा ग्राहक नाही';

  @override
  String get addCustomerShortcut => 'ग्राहक जोडा';

  @override
  String get principalLabel => 'मुद्दल रक्कम (₹)';

  @override
  String get monthlyRateLabel => 'व्याज दर (प्रति महिना %)';

  @override
  String get tenureMonthsLabel => 'कालावधी (महिने)';

  @override
  String get loanTypeLabel => 'व्याज प्रकार';

  @override
  String get loanTypeSimple => 'सरळ';

  @override
  String get loanTypeCompound => 'चक्रवाढ';

  @override
  String get startDateLabel => 'सुरुवात तारीख';

  @override
  String get livePreviewHeading => 'लाइव्ह ईएमआय पूर्वावलोकन';

  @override
  String get monthlyEmiLabel => 'मासिक ईएमआय';

  @override
  String get totalInterestLabel => 'एकूण व्याज';

  @override
  String get totalPayableLabel => 'एकूण देय';

  @override
  String get createLoanButton => 'कर्ज तयार करा';

  @override
  String get loanCreatedTitle => 'कर्ज यशस्वीरित्या तयार झाले';

  @override
  String loanCreatedMessage(int count) {
    return '$count मासिक ईएमआय तयार केले आहेत.';
  }

  @override
  String get viewLoanOverview => 'कर्ज तपशील उघडा';

  @override
  String get allLoansFilter => 'सर्व';

  @override
  String get activeLoansFilter => 'सक्रिय';

  @override
  String get completedLoansFilter => 'पूर्ण';

  @override
  String get noLoansTitle => 'अजून कर्जे नाहीत';

  @override
  String get noLoansSubtitle => 'ईएमआय वेळापत्रक तयार करण्यासाठी कर्ज जोडा.';

  @override
  String get selectCustomerError => 'प्रथम 10 अंकी मोबाईलने ग्राहक निवडा.';

  @override
  String get invalidPrincipalError => '0 पेक्षा जास्त मुद्दल टाका.';

  @override
  String get invalidRateError => '0 ते 100 दरम्यान मासिक दर टाका.';

  @override
  String get invalidTenureError => '1 ते 600 महिन्यांदरम्यान कालावधी टाका.';

  @override
  String get loanOverviewTitle => 'कर्ज आढावा';

  @override
  String get emiScheduleHeading => 'ईएमआय वेळापत्रक';

  @override
  String get payButton => 'भरा';

  @override
  String get payAllPendingButton => 'सर्व प्रलंबित ईएमआय भरा';

  @override
  String confirmPayEmiTitle(int no) {
    return 'ईएमआय #$no भरलेला म्हणून नोंदवायचा?';
  }

  @override
  String confirmPayEmiMessage(String amount) {
    return '$amount पेमेंटची खात्री करा.';
  }

  @override
  String get paymentDateLabel => 'पेमेंट तारीख';

  @override
  String get confirmPayAllTitle => 'सर्व प्रलंबित ईएमआय भरायचे?';

  @override
  String confirmPayAllMessage(int count, String amount) {
    return 'उर्वरित $count ईएमआय ($amount) भरले जातील आणि कर्ज करार PDF तयार होईल.';
  }

  @override
  String installmentLabel(int no) {
    return 'हप्ता #$no';
  }

  @override
  String paidOnLabel(String date) {
    return 'भरले: $date';
  }

  @override
  String get outOfOrderEmiError =>
      'कृपया आधी आधीचे प्रलंबित हप्ते क्रमाने भरा.';

  @override
  String emiPaidSuccess(int no) {
    return 'हप्ता #$no भरला गेला.';
  }

  @override
  String get loanCompletedPdfGenerated =>
      'कर्ज पूर्ण! कर्ज करार PDF कागदपत्रांमध्ये जतन झाला.';

  @override
  String get viewPdfAction => 'PDF पहा';

  @override
  String get openDocumentsAction => 'कागदपत्रे उघडा';

  @override
  String progressPaidLabel(int paid, int total) {
    return '$total पैकी $paid ईएमआय भरले';
  }

  @override
  String get ledgerHeading => 'खातेवही इतिहास';

  @override
  String get ledgerDebitLabel => 'नावे';

  @override
  String get ledgerCreditLabel => 'जमा';

  @override
  String get ledgerBalanceLabel => 'शिल्लक';

  @override
  String get documentsTitle => 'कागदपत्रे';

  @override
  String get noDocumentsTitle => 'अजून कोणतीही PDF कागदपत्रे नाहीत';

  @override
  String get noDocumentsSubtitle =>
      'कर्ज पूर्ण भरल्यावर कर्ज करार आपोआप येथे दिसेल.';

  @override
  String get viewPdfMenu => 'PDF पहा';

  @override
  String get sharePdfMenu => 'PDF शेअर करा';

  @override
  String get deletePdfMenu => 'PDF हटवा';

  @override
  String get editPdfMenu => 'PDF संपादित करा';

  @override
  String get deletePdfConfirmTitle => 'कागदपत्र हटवायचे?';

  @override
  String get deletePdfConfirmMessage =>
      'हे कागदपत्रांमधून तयार केलेला कर्ज करार काढून टाकेल.';

  @override
  String pagesCountLabel(int count) {
    return '$count पाने';
  }

  @override
  String get documentViewerTitle => 'कर्ज करार दर्शक';

  @override
  String get loanAgreementHeadline => 'कर्ज करार';

  @override
  String get lenderDetailsHeading => 'सावकार तपशील';

  @override
  String get borrowerDetailsHeading => 'कर्जदार तपशील';

  @override
  String get installmentScheduleHeading => 'हप्ता वेळापत्रक';

  @override
  String get generatedOnLabel => 'तयार दिनांक';

  @override
  String get documentIdLabel => 'दस्तऐवज आयडी';

  @override
  String pageOfLabel(int current, int total) {
    return 'पान $current / $total';
  }

  @override
  String get signatureLender => 'सावकाराची स्वाक्षरी';

  @override
  String get signatureBorrower => 'कर्जदाराची स्वाक्षरी';

  @override
  String get editPdfTitle => 'PDF संपादित करा';

  @override
  String get snapshotNotice =>
      'बदल फक्त हा PDF स्नॅपशॉट अपडेट करतात; मूळ कर्ज किंवा खातेवही बदलत नाही.';

  @override
  String get pdfLanguageLabel => 'कागदपत्राची भाषा';

  @override
  String get statusTextLabel => 'स्थिती लेबल';

  @override
  String get previewButton => 'पूर्वावलोकन';

  @override
  String get regeneratePdfButton => 'PDF पुन्हा तयार करा';

  @override
  String get pdfRegeneratedSuccess => 'कागदपत्र यशस्वीरित्या पुन्हा तयार झाले.';

  @override
  String shareReadyMessage(String title, int pages) {
    return '$title ($pages पाने) शेअरसाठी तयार आहे.';
  }

  @override
  String get copyHtmlAction => 'HTML कॉपी करा';

  @override
  String get htmlCopiedMessage => 'A4 HTML क्लिपबोर्डवर कॉपी केले.';

  @override
  String get saveChangesButton => 'बदल जतन करा';

  @override
  String get profileUpdatedSuccess => 'प्रोफाइल यशस्वीरित्या अपडेट झाले.';

  @override
  String get signOutConfirmTitle => 'साइन आउट करायचे?';

  @override
  String get signOutConfirmMessage =>
      'तुमच्या तपशिलांसह तुम्ही कधीही पुन्हा साइन इन करू शकता.';

  @override
  String get totalLoansStatLabel => 'एकूण कर्जे';

  @override
  String get documentsStatLabel => 'कागदपत्रे';

  @override
  String get backupTitle => 'बॅकअप आणि पुनर्संचयित';

  @override
  String get backupSubtitle =>
      'तुमच्या कर्ज खात्याचा स्थानिक स्नॅपशॉट निर्यात किंवा पुनर्संचयित करा.';

  @override
  String get exportBackupButton => 'स्थानिक बॅकअप तयार करा';

  @override
  String get restoreBackupButton => 'स्नॅपशॉट पुनर्संचयित करा';

  @override
  String get backupGeneratedMessage =>
      'बॅकअप स्नॅपशॉट तयार करून क्लिपबोर्डवर कॉपी केला.';

  @override
  String get restoreSuccessMessage =>
      'बॅकअप स्नॅपशॉट यशस्वीरित्या पुनर्संचयित झाला.';

  @override
  String get restoreInvalidError => 'अवैध बॅकअप स्नॅपशॉट JSON.';

  @override
  String get pasteBackupHint =>
      'पुनर्संचयित करण्यासाठी निर्यात केलेले बॅकअप JSON येथे पेस्ट करा';

  @override
  String get driveComingSoonNote =>
      'Google Drive एन्क्रिप्टेड सिंक टप्पा 6 मध्ये येईल.';

  @override
  String get emiPdfButton => 'EMI PDF';

  @override
  String get viewCompletePdfButton => 'संपूर्ण कर्ज PDF';

  @override
  String emiPdfGeneratedMessage(int no) {
    return 'हप्ता #$no भरला गेला आणि PDF दस्तऐवजांमध्ये जतन केले.';
  }

  @override
  String emiReceiptTag(int no) {
    return 'EMI #$no पावती';
  }

  @override
  String get completeLoanPdfTag => 'संपूर्ण कर्ज PDF';

  @override
  String get emiCalculatorTitle => 'EMI कॅल्क्युलेटर';

  @override
  String get emiCalculatorSubtitle =>
      'कर्ज तयार करण्यापूर्वी मासिक हप्ता, एकूण व्याज आणि परतफेड वेळापत्रकाचा अंदाज घ्या.';

  @override
  String get principalShareLabel => 'मुद्दल हिस्सा';

  @override
  String get interestShareLabel => 'व्याज हिस्सा';

  @override
  String get resetFieldsButton => 'रीसेट करा';

  @override
  String get proceedToCreateLoanButton => 'या अटींसह कर्ज तयार करा';

  @override
  String get schedulePreviewHeading => 'हप्ता वेळापत्रक पूर्वावलोकन';

  @override
  String get enterTermsForEstimate =>
      'EMI अंदाज पाहण्यासाठी मुद्दल, मासिक व्याजदर आणि कालावधी प्रविष्ट करा.';

  @override
  String get systemDefaultLanguage => 'सिस्टम डीफॉल्ट';

  @override
  String get choosePhotoTitle => 'प्रोफाइल फोटो';

  @override
  String get pickFromGallery => 'गॅलरीतून निवडा';

  @override
  String get takePhoto => 'फोटो काढा';

  @override
  String get removePhoto => 'फोटो काढा टाका';

  @override
  String get changeAvatarColor => 'बॅज रंग बदला';

  @override
  String get photoPickFailedError => 'निवडलेली प्रतिमा लोड करता आली नाही.';

  @override
  String get databaseError =>
      'डेटा स्थानिक पातळीवर जतन करता आला नाही. कृपया पुन्हा प्रयत्न करा.';

  @override
  String get onboardingSkip => 'वगळा';

  @override
  String get onboardingStart => 'सुरू करा';

  @override
  String get onboardingNext => 'पुढे';

  @override
  String get onboardingTitle1 => 'स्मार्ट कर्ज केंद्र';

  @override
  String get onboardingSubtitle1 =>
      'ग्राहक व्यवस्थापित करा, सरळ किंवा चक्रवाढ व्याज कर्ज तयार करा आणि ऑफलाइन सुसज्ज राहा.';

  @override
  String get onboardingTitle2 => 'EMI आणि खातेवही ट्रॅक करा';

  @override
  String get onboardingSubtitle2 =>
      'मासिक हप्ते, देय तारखा आणि वसुली एका दृष्टीक्षेपात पहा.';

  @override
  String get onboardingTitle3 => 'त्वरित कर्ज करारपत्र';

  @override
  String get onboardingSubtitle3 =>
      'पूर्ण परतफेडीनंतर १३ भाषांमध्ये स्वयंचलित A4 कर्ज करार PDF तयार करा.';
}
