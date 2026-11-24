// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Telugu (`te`).
class AppLocalizationsTe extends AppLocalizations {
  AppLocalizationsTe([String locale = 'te']) : super(locale);

  @override
  String get appTitle => 'LoanWise';

  @override
  String get splashTagline => 'స్మార్ట్ రుణం & ఈఎంఐ ఖాతా';

  @override
  String get loginTitle => 'లాగిన్';

  @override
  String get nameLabel => 'పేరు';

  @override
  String get nameHint => 'మీ పూర్తి పేరు నమోదు చేయండి';

  @override
  String get mobileLabel => 'మొబైల్ నంబర్';

  @override
  String get mobileHint => '10 అంకెల మొబైల్ నంబర్';

  @override
  String get emailLabel => 'ఇమెయిల్ ఐడి';

  @override
  String get emailHint => 'name@example.com';

  @override
  String get signInButton => 'సైన్ ఇన్ చేయండి';

  @override
  String get errorNameRequired => 'దయచేసి మీ పేరు నమోదు చేయండి';

  @override
  String get errorMobileInvalid =>
      '6 నుండి 9 తో ప్రారంభమయ్యే 10 అంకెల మొబైల్ నంబర్ నమోదు చేయండి';

  @override
  String get errorEmailInvalid => 'సరైన ఇమెయిల్ చిరునామా నమోదు చేయండి';

  @override
  String get navHome => 'హోమ్';

  @override
  String get navCustomers => 'కస్టమర్లు';

  @override
  String get navLoans => 'రుణాలు';

  @override
  String get navProfile => 'ప్రొఫైల్';

  @override
  String get welcomeBack => 'తిరిగి స్వాగతం,';

  @override
  String get openMenuTooltip => 'మెను తెరవండి';

  @override
  String get openProfileTooltip => 'ప్రొఫైల్ తెరవండి';

  @override
  String get totalLentLabel => 'మొత్తం ఇచ్చిన రుణం';

  @override
  String get availableToCollect => 'వసూలుకు అందుబాటులో';

  @override
  String get activeLoansLabel => 'సక్రియ రుణాలు';

  @override
  String get customersLabel => 'కస్టమర్లు';

  @override
  String get emisDueThisMonthLabel => 'ఈ నెల బకాయి ఈఎంఐలు';

  @override
  String get quickActionsHeading => 'త్వరిత చర్యలు';

  @override
  String get actionAddCustomer => 'కస్టమర్‌ను జోడించండి';

  @override
  String get actionCreateLoan => 'రుణం సృష్టించండి';

  @override
  String get actionLoans => 'రుణాలు';

  @override
  String get actionDocuments => 'పత్రాలు';

  @override
  String get actionAllCustomers => 'అందరు కస్టమర్లు';

  @override
  String get actionProfile => 'ప్రొఫైల్';

  @override
  String get thisMonthHeading => 'ఈ నెల';

  @override
  String get viewAll => 'అన్నీ చూడండి';

  @override
  String get collectedThisMonth => 'ఈ నెల వసూలు';

  @override
  String get pendingThisMonth => 'ఈ నెల పెండింగ్';

  @override
  String get recentLoansHeading => 'ఇటీవలి రుణాలు';

  @override
  String get overdueEmisHeading => 'గడువు మీరిన ఈఎంఐలు';

  @override
  String get statusActive => 'సక్రియం';

  @override
  String get statusCompleted => 'పూర్తయింది';

  @override
  String get statusOverdue => 'గడువు మీరింది';

  @override
  String get statusPending => 'పెండింగ్';

  @override
  String get statusPaid => 'చెల్లించబడింది';

  @override
  String nextEmiLabel(String date) {
    return 'తదుపరి ఈఎంఐ: $date';
  }

  @override
  String dueSinceLabel(String date) {
    return 'గడువు: $date';
  }

  @override
  String get emptyRecentLoans =>
      'ఇంకా ఇటీవలి రుణాలు లేవు. ప్రారంభించడానికి రుణం సృష్టించండి.';

  @override
  String get emptyOverdueEmis =>
      'అన్నీ సరిగా ఉన్నాయి. గడువు మీరిన ఈఎంఐలు లేవు.';

  @override
  String get drawerBackupRestore => 'బ్యాకప్ మరియు పునరుద్ధరణ';

  @override
  String get drawerChangeTheme => 'థీమ్ మార్చండి';

  @override
  String get drawerChooseLanguage => 'భాషను ఎంచుకోండి';

  @override
  String get themeLight => 'లైట్';

  @override
  String get themeDark => 'డార్క్';

  @override
  String get themeSystem => 'సిస్టమ్';

  @override
  String get backupDialogMessage =>
      'మీ పరికరం కోసం స్థానిక బ్యాకప్ తాజాగా ఉంది.';

  @override
  String get closeAction => 'మూసివేయండి';

  @override
  String featureQueuedMessage(String feature) {
    return '$feature సిద్ధంగా ఉంది.';
  }

  @override
  String get tabCustomersSubtitle =>
      'రుణగ్రహీతలు, సంప్రదింపు వివరాలు మరియు సక్రియ రుణాలను నిర్వహించండి.';

  @override
  String get tabLoansSubtitle =>
      'సక్రియ రుణాలు, వడ్డీ మరియు ఈఎంఐ షెడ్యూల్‌లను ట్రాక్ చేయండి.';

  @override
  String get tabProfileSubtitle =>
      'మీ నమోదిత రుణదాత వివరాలు మరియు ప్రాధాన్యతలు.';

  @override
  String get signOutAction => 'సైన్ అవుట్';

  @override
  String get addCustomerTitle => 'కస్టమర్‌ను జోడించండి';

  @override
  String get editCustomerTitle => 'కస్టమర్‌ను సవరించండి';

  @override
  String get customerNameLabel => 'కస్టమర్ పేరు';

  @override
  String get customerEmailLabel => 'కస్టమర్ ఇమెయిల్';

  @override
  String get customerMobileLabel => 'మొబైల్ నంబర్';

  @override
  String get customerLocationLabel => 'ప్రాంతం';

  @override
  String get locationRequiredError => 'దయచేసి ప్రాంతాన్ని నమోదు చేయండి';

  @override
  String get saveCustomerButton => 'కస్టమర్‌ను సేవ్ చేయండి';

  @override
  String get updateCustomerButton => 'కస్టమర్‌ను అప్‌డేట్ చేయండి';

  @override
  String get customerAddedTitle => 'కస్టమర్ విజయవంతంగా జోడించబడింది';

  @override
  String customerAddedMessage(String name) {
    return 'మీరు ఇప్పుడు $name కోసం రుణం సృష్టించాలనుకుంటున్నారా?';
  }

  @override
  String get laterButton => 'తర్వాత';

  @override
  String get searchCustomersHint => 'పేరు లేదా మొబైల్ ద్వారా వెతకండి';

  @override
  String get noCustomersTitle => 'కస్టమర్లు కనుగొనబడలేదు';

  @override
  String get noCustomersSubtitle => 'మొదటి కస్టమర్‌ను జోడించడానికి + నొక్కండి.';

  @override
  String get editCustomerMenu => 'వివరాలు సవరించండి';

  @override
  String get deleteCustomerMenu => 'కస్టమర్‌ను తొలగించండి';

  @override
  String get createLoanMenu => 'రుణం సృష్టించండి';

  @override
  String get deleteCustomerConfirmTitle => 'కస్టమర్‌ను తొలగించాలా?';

  @override
  String deleteCustomerConfirmMessage(String name) {
    return 'ఇది $nameని సక్రియ కస్టమర్ జాబితా నుండి తొలగిస్తుంది.';
  }

  @override
  String get deleteAction => 'తొలగించు';

  @override
  String get cancelAction => 'రద్దు';

  @override
  String get activeLoanDeleteBlocked =>
      'సక్రియ రుణం ఉన్న కస్టమర్‌ను తొలగించలేము.';

  @override
  String get duplicateMobileError =>
      'ఈ మొబైల్ నంబర్‌తో కస్టమర్ ఇప్పటికే ఉన్నారు.';

  @override
  String get customerDetailTitle => 'కస్టమర్ వివరాలు';

  @override
  String get callAction => 'కాల్';

  @override
  String get smsAction => 'SMS';

  @override
  String get customerLoansHeading => 'కస్టమర్ రుణాలు';

  @override
  String get mobileLockedHelper => 'రుణాలు ఉన్నప్పుడు మొబైల్ నంబర్ మార్చలేము.';

  @override
  String activeLoansCountLabel(int count) {
    return '$count సక్రియం';
  }

  @override
  String get createLoanTitle => 'రుణం సృష్టించండి';

  @override
  String get searchCustomerMobileHint => '10 అంకెల మొబైల్ నంబర్ నమోదు చేయండి';

  @override
  String get noCustomerWithMobile => 'ఈ మొబైల్‌తో కస్టమర్ లేరు';

  @override
  String get addCustomerShortcut => 'కస్టమర్‌ను జోడించండి';

  @override
  String get principalLabel => 'అసలు మొత్తం (₹)';

  @override
  String get monthlyRateLabel => 'వడ్డీ రేటు (నెలకు %)';

  @override
  String get tenureMonthsLabel => 'కాలపరిమితి (నెలలు)';

  @override
  String get loanTypeLabel => 'వడ్డీ రకం';

  @override
  String get loanTypeSimple => 'సాధారణ';

  @override
  String get loanTypeCompound => 'చక్రవడ్డీ';

  @override
  String get startDateLabel => 'ప్రారంభ తేదీ';

  @override
  String get livePreviewHeading => 'లైవ్ ఈఎంఐ ప్రివ్యూ';

  @override
  String get monthlyEmiLabel => 'నెలవారీ ఈఎంఐ';

  @override
  String get totalInterestLabel => 'మొత్తం వడ్డీ';

  @override
  String get totalPayableLabel => 'మొత్తం చెల్లించాల్సింది';

  @override
  String get createLoanButton => 'రుణం సృష్టించండి';

  @override
  String get loanCreatedTitle => 'రుణం విజయవంతంగా సృష్టించబడింది';

  @override
  String loanCreatedMessage(int count) {
    return '$count నెలవారీ ఈఎంఐలు రూపొందించబడ్డాయి.';
  }

  @override
  String get viewLoanOverview => 'రుణ వివరాలు తెరవండి';

  @override
  String get allLoansFilter => 'అన్నీ';

  @override
  String get activeLoansFilter => 'సక్రియం';

  @override
  String get completedLoansFilter => 'పూర్తయింది';

  @override
  String get noLoansTitle => 'ఇంకా రుణాలు లేవు';

  @override
  String get noLoansSubtitle => 'ఈఎంఐ షెడ్యూల్ కోసం రుణం సృష్టించండి.';

  @override
  String get selectCustomerError =>
      'ముందుగా 10 అంకెల మొబైల్‌తో కస్టమర్‌ను ఎంచుకోండి.';

  @override
  String get invalidPrincipalError =>
      '0 కంటే ఎక్కువ అసలు మొత్తాన్ని నమోదు చేయండి.';

  @override
  String get invalidRateError => '0 నుండి 100 మధ్య నెలవారీ రేటు నమోదు చేయండి.';

  @override
  String get invalidTenureError =>
      '1 నుండి 600 నెలల మధ్య కాలపరిమితి నమోదు చేయండి.';

  @override
  String get loanOverviewTitle => 'రుణ వివరాలు';

  @override
  String get emiScheduleHeading => 'ఈఎంఐ షెడ్యూల్';

  @override
  String get payButton => 'చెల్లించు';

  @override
  String get payAllPendingButton => 'అన్ని పెండింగ్ ఈఎంఐలు చెల్లించండి';

  @override
  String confirmPayEmiTitle(int no) {
    return 'ఈఎంఐ #$no చెల్లించినట్లు గుర్తించాలా?';
  }

  @override
  String confirmPayEmiMessage(String amount) {
    return '$amount చెల్లింపును నిర్ధారించండి.';
  }

  @override
  String get paymentDateLabel => 'చెల్లింపు తేదీ';

  @override
  String get confirmPayAllTitle => 'అన్ని పెండింగ్ ఈఎంఐలు చెల్లించాలా?';

  @override
  String confirmPayAllMessage(int count, String amount) {
    return 'మిగిలిన $count ఈఎంఐలు ($amount) చెల్లించబడి రుణ ఒప్పందం PDF రూపొందించబడుతుంది.';
  }

  @override
  String installmentLabel(int no) {
    return 'వాయిదా #$no';
  }

  @override
  String paidOnLabel(String date) {
    return 'చెల్లించినది: $date';
  }

  @override
  String get outOfOrderEmiError =>
      'దయచేసి ముందుగా మునుపటి పెండింగ్ వాయిదాలను క్రమంలో చెల్లించండి.';

  @override
  String emiPaidSuccess(int no) {
    return 'వాయిదా #$no చెల్లించబడింది.';
  }

  @override
  String get loanCompletedPdfGenerated =>
      'రుణం పూర్తయింది! రుణ ఒప్పందం PDF పత్రాలలో సేవ్ చేయబడింది.';

  @override
  String get viewPdfAction => 'PDF చూడండి';

  @override
  String get openDocumentsAction => 'పత్రాలు తెరవండి';

  @override
  String progressPaidLabel(int paid, int total) {
    return '$total లో $paid ఈఎంఐలు చెల్లించబడ్డాయి';
  }

  @override
  String get ledgerHeading => 'లెడ్జర్ చరిత్ర';

  @override
  String get ledgerDebitLabel => 'డెబిట్';

  @override
  String get ledgerCreditLabel => 'క్రెడిట్';

  @override
  String get ledgerBalanceLabel => 'బ్యాలెన్స్';

  @override
  String get documentsTitle => 'పత్రాలు';

  @override
  String get noDocumentsTitle => 'ఇంకా PDF పత్రాలు లేవు';

  @override
  String get noDocumentsSubtitle =>
      'రుణం పూర్తిగా చెల్లించిన తర్వాత రుణ ఒప్పందాలు ఇక్కడ కనిపిస్తాయి.';

  @override
  String get viewPdfMenu => 'PDF చూడండి';

  @override
  String get sharePdfMenu => 'PDF షేర్ చేయండి';

  @override
  String get deletePdfMenu => 'PDF తొలగించండి';

  @override
  String get editPdfMenu => 'PDF సవరించండి';

  @override
  String get deletePdfConfirmTitle => 'పత్రాన్ని తొలగించాలా?';

  @override
  String get deletePdfConfirmMessage =>
      'ఇది పత్రాల నుండి రూపొందించిన రుణ ఒప్పందాన్ని తొలగిస్తుంది.';

  @override
  String pagesCountLabel(int count) {
    return '$count పేజీలు';
  }

  @override
  String get documentViewerTitle => 'రుణ ఒప్పందం వ్యూయర్';

  @override
  String get loanAgreementHeadline => 'రుణ ఒప్పందం';

  @override
  String get lenderDetailsHeading => 'రుణదాత వివరాలు';

  @override
  String get borrowerDetailsHeading => 'రుణగ్రహీత వివరాలు';

  @override
  String get installmentScheduleHeading => 'వాయిదాల షెడ్యూల్';

  @override
  String get generatedOnLabel => 'రూపొందించిన తేదీ';

  @override
  String get documentIdLabel => 'పత్రం ID';

  @override
  String pageOfLabel(int current, int total) {
    return 'పేజీ $current / $total';
  }

  @override
  String get signatureLender => 'రుణదాత సంతకం';

  @override
  String get signatureBorrower => 'రుణగ్రహీత సంతకం';

  @override
  String get editPdfTitle => 'PDF సవరించండి';

  @override
  String get snapshotNotice =>
      'మార్పులు ఈ PDF స్నాప్‌షాట్‌ను మాత్రమే అప్‌డేట్ చేస్తాయి; అసలు రుణాన్ని మార్చవు.';

  @override
  String get pdfLanguageLabel => 'పత్రం భాష';

  @override
  String get statusTextLabel => 'స్థితి లేబుల్';

  @override
  String get previewButton => 'ప్రివ్యూ';

  @override
  String get regeneratePdfButton => 'PDF మళ్లీ రూపొందించు';

  @override
  String get pdfRegeneratedSuccess => 'పత్రం విజయవంతంగా మళ్లీ రూపొందించబడింది.';

  @override
  String shareReadyMessage(String title, int pages) {
    return '$title ($pages పేజీలు) షేర్ చేయడానికి సిద్ధంగా ఉంది.';
  }

  @override
  String get copyHtmlAction => 'HTML కాపీ';

  @override
  String get htmlCopiedMessage => 'A4 HTML క్లిప్‌బోర్డ్‌కు కాపీ చేయబడింది.';

  @override
  String get saveChangesButton => 'మార్పులను సేవ్ చేయండి';

  @override
  String get profileUpdatedSuccess => 'ప్రొఫైల్ విజయవంతంగా అప్‌డేట్ చేయబడింది.';

  @override
  String get signOutConfirmTitle => 'సైన్ అవుట్ చేయాలా?';

  @override
  String get signOutConfirmMessage =>
      'మీ వివరాలతో ఎప్పుడైనా తిరిగి సైన్ ఇన్ చేయవచ్చు.';

  @override
  String get totalLoansStatLabel => 'మొత్తం రుణాలు';

  @override
  String get documentsStatLabel => 'పత్రాలు';

  @override
  String get backupTitle => 'బ్యాకప్ మరియు పునరుద్ధరణ';

  @override
  String get backupSubtitle =>
      'మీ రుణ ఖాతా యొక్క స్థానిక స్నాప్‌షాట్ ఎగుమతి లేదా పునరుద్ధరించండి.';

  @override
  String get exportBackupButton => 'స్థానిక బ్యాకప్ సృష్టించండి';

  @override
  String get restoreBackupButton => 'స్నాప్‌షాట్ పునరుద్ధరించండి';

  @override
  String get backupGeneratedMessage =>
      'బ్యాకప్ స్నాప్‌షాట్ రూపొందించబడి క్లిప్‌బోర్డ్‌కు కాపీ చేయబడింది.';

  @override
  String get restoreSuccessMessage =>
      'బ్యాకప్ స్నాప్‌షాట్ విజయవంతంగా పునరుద్ధరించబడింది.';

  @override
  String get restoreInvalidError => 'చెల్లని బ్యాకప్ స్నాప్‌షాట్ JSON.';

  @override
  String get pasteBackupHint =>
      'పునరుద్ధరించడానికి ఎగుమతి చేసిన బ్యాకప్ JSONని ఇక్కడ అతికించండి';

  @override
  String get driveComingSoonNote =>
      'Google Drive ఎన్‌క్రిప్టెడ్ సింక్ దశ 6 లో జోడించబడుతుంది.';

  @override
  String get emiPdfButton => 'EMI PDF';

  @override
  String get viewCompletePdfButton => 'పూర్తి రుణ PDF';

  @override
  String emiPdfGeneratedMessage(int no) {
    return 'వాయిదా #$no చెల్లించబడింది మరియు PDF డాక్యుమెంట్లలో సేవ్ చేయబడింది.';
  }

  @override
  String emiReceiptTag(int no) {
    return 'EMI #$no రసీదు';
  }

  @override
  String get completeLoanPdfTag => 'పూర్తి రుణ PDF';

  @override
  String get emiCalculatorTitle => 'EMI కాలిక్యులేటర్';

  @override
  String get emiCalculatorSubtitle =>
      'రుణం సృష్టించే ముందు నెలవారీ వాయిదా, మొత్తం వడ్డీ మరియు చెల్లింపు షెడ్యూల్‌ను అంచనా వేయండి.';

  @override
  String get principalShareLabel => 'అసలు వాటా';

  @override
  String get interestShareLabel => 'వడ్డీ వాటా';

  @override
  String get resetFieldsButton => 'రీసెట్';

  @override
  String get proceedToCreateLoanButton => 'ఈ నిబంధనలతో రుణం సృష్టించండి';

  @override
  String get schedulePreviewHeading => 'షెడ్యూల్ ప్రివ్యూ';

  @override
  String get enterTermsForEstimate =>
      'EMI అంచనా చూడటానికి అసలు, నెలవారీ వడ్డీ రేటు మరియు వ్యవధిని నమోదు చేయండి.';

  @override
  String get systemDefaultLanguage => 'సిస్టమ్ డిఫాల్ట్';

  @override
  String get choosePhotoTitle => 'ప్రొఫైల్ ఫోటో';

  @override
  String get pickFromGallery => 'గ్యాలరీ నుండి ఎంచుకోండి';

  @override
  String get takePhoto => 'ఫోటో తీయండి';

  @override
  String get removePhoto => 'ఫోటోను తొలగించండి';

  @override
  String get changeAvatarColor => 'బ్యాడ్జ్ రంగు మార్చండి';

  @override
  String get photoPickFailedError =>
      'ఎంచుకున్న చిత్రాన్ని లోడ్ చేయడం సాధ్యం కాలేదు.';

  @override
  String get databaseError =>
      'డేటాను స్థానికంగా సేవ్ చేయడం సాధ్యం కాలేదు. మళ్లీ ప్రయత్నించండి.';

  @override
  String get onboardingSkip => 'దాటవేయి';

  @override
  String get onboardingStart => 'ప్రారంభించు';

  @override
  String get onboardingNext => 'తదుపరి';

  @override
  String get onboardingTitle1 => 'స్మార్ట్ లోన్ హబ్';

  @override
  String get onboardingSubtitle1 =>
      'రుణగ్రహీతలను నిర్వహించండి, సాధారణ లేదా చక్రవడ్డీ రుణాలను ఆఫ్‌లైన్‌లో సృష్టించండి.';

  @override
  String get onboardingTitle2 => 'EMIలు & లెడ్జర్ ట్రాకింగ్';

  @override
  String get onboardingSubtitle2 =>
      'నెలవారీ వాయిదాలు, గడువు తేదీలు మరియు వసూళ్లను సులభంగా గమనించండి.';

  @override
  String get onboardingTitle3 => 'తక్షణ రుణ ఒప్పందాలు';

  @override
  String get onboardingSubtitle3 =>
      'పూర్తి చెల్లింపు తర్వాత 13 భాషల్లో A4 లోన్ అగ్రిమెంట్ PDFను స్వయంచాలకంగా రూపొందించండి.';
}
