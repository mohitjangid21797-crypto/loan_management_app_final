// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Gujarati (`gu`).
class AppLocalizationsGu extends AppLocalizations {
  AppLocalizationsGu([String locale = 'gu']) : super(locale);

  @override
  String get appTitle => 'LoanWise';

  @override
  String get splashTagline => 'સ્માર્ટ લોન અને EMI ખાતાવહી';

  @override
  String get loginTitle => 'લોગિન';

  @override
  String get nameLabel => 'નામ';

  @override
  String get nameHint => 'તમારું પૂરું નામ દાખલ કરો';

  @override
  String get mobileLabel => 'મોબાઇલ નંબર';

  @override
  String get mobileHint => '10 અંકનો મોબાઇલ નંબર';

  @override
  String get emailLabel => 'ઇમેઇલ આઈડી';

  @override
  String get emailHint => 'name@example.com';

  @override
  String get signInButton => 'સાઇન ઇન કરો';

  @override
  String get errorNameRequired => 'કૃપા કરીને તમારું નામ દાખલ કરો';

  @override
  String get errorMobileInvalid =>
      '6 થી 9 થી શરૂ થતો 10 અંકનો મોબાઇલ નંબર દાખલ કરો';

  @override
  String get errorEmailInvalid => 'માન્ય ઇમેઇલ સરનામું દાખલ કરો';

  @override
  String get navHome => 'હોમ';

  @override
  String get navCustomers => 'ગ્રાહકો';

  @override
  String get navLoans => 'લોન';

  @override
  String get navProfile => 'પ્રોફાઇલ';

  @override
  String get welcomeBack => 'ફરી સ્વાગત છે,';

  @override
  String get openMenuTooltip => 'મેનૂ ખોલો';

  @override
  String get openProfileTooltip => 'પ્રોફાઇલ ખોલો';

  @override
  String get totalLentLabel => 'કુલ આપેલી લોન';

  @override
  String get availableToCollect => 'વસૂલાત માટે ઉપલબ્ધ';

  @override
  String get activeLoansLabel => 'સક્રિય લોન';

  @override
  String get customersLabel => 'ગ્રાહકો';

  @override
  String get emisDueThisMonthLabel => 'આ મહિને બાકી EMI';

  @override
  String get quickActionsHeading => 'ઝડપી ક્રિયાઓ';

  @override
  String get actionAddCustomer => 'ગ્રાહક ઉમેરો';

  @override
  String get actionCreateLoan => 'લોન બનાવો';

  @override
  String get actionLoans => 'લોન';

  @override
  String get actionDocuments => 'દસ્તાવેજો';

  @override
  String get actionAllCustomers => 'બધા ગ્રાહકો';

  @override
  String get actionProfile => 'પ્રોફાઇલ';

  @override
  String get thisMonthHeading => 'આ મહિને';

  @override
  String get viewAll => 'બધું જુઓ';

  @override
  String get collectedThisMonth => 'આ મહિને વસૂલ';

  @override
  String get pendingThisMonth => 'આ મહિને બાકી';

  @override
  String get recentLoansHeading => 'તાજેતરની લોન';

  @override
  String get overdueEmisHeading => 'મુદત વીતેલી EMI';

  @override
  String get statusActive => 'સક્રિય';

  @override
  String get statusCompleted => 'પૂર્ણ';

  @override
  String get statusOverdue => 'મુદત વીતેલી';

  @override
  String get statusPending => 'બાકી';

  @override
  String get statusPaid => 'ચૂકવેલ';

  @override
  String nextEmiLabel(String date) {
    return 'આગામી EMI: $date';
  }

  @override
  String dueSinceLabel(String date) {
    return 'બાકી: $date';
  }

  @override
  String get emptyRecentLoans =>
      'હજી કોઈ તાજેતરની લોન નથી. શરૂ કરવા માટે લોન બનાવો.';

  @override
  String get emptyOverdueEmis => 'બધું અપડેટ છે. હાલ કોઈ મુદત વીતેલી EMI નથી.';

  @override
  String get drawerBackupRestore => 'બેકઅપ અને રિસ્ટોર';

  @override
  String get drawerChangeTheme => 'થીમ બદલો';

  @override
  String get drawerChooseLanguage => 'ભાષા પસંદ કરો';

  @override
  String get themeLight => 'લાઇટ';

  @override
  String get themeDark => 'ડાર્ક';

  @override
  String get themeSystem => 'સિસ્ટમ';

  @override
  String get backupDialogMessage => 'તમારા ઉપકરણ માટે સ્થાનિક બેકઅપ અપડેટ છે.';

  @override
  String get closeAction => 'બંધ કરો';

  @override
  String featureQueuedMessage(String feature) {
    return '$feature તૈયાર છે.';
  }

  @override
  String get tabCustomersSubtitle =>
      'ગ્રાહકો, સંપર્ક વિગતો અને સક્રિય લોન મેનેજ કરો.';

  @override
  String get tabLoansSubtitle => 'સક્રિય લોન, વ્યાજ અને EMI શેડ્યૂલ ટ્રૅક કરો.';

  @override
  String get tabProfileSubtitle => 'તમારી નોંધાયેલ લોનદાતા વિગતો અને પસંદગીઓ.';

  @override
  String get signOutAction => 'સાઇન આઉટ';

  @override
  String get addCustomerTitle => 'ગ્રાહક ઉમેરો';

  @override
  String get editCustomerTitle => 'ગ્રાહક સંપાદિત કરો';

  @override
  String get customerNameLabel => 'ગ્રાહકનું નામ';

  @override
  String get customerEmailLabel => 'ગ્રાહક ઇમેઇલ';

  @override
  String get customerMobileLabel => 'મોબાઇલ નંબર';

  @override
  String get customerLocationLabel => 'સ્થળ';

  @override
  String get locationRequiredError => 'કૃપા કરીને સ્થળ દાખલ કરો';

  @override
  String get saveCustomerButton => 'ગ્રાહક સાચવો';

  @override
  String get updateCustomerButton => 'ગ્રાહક અપડેટ કરો';

  @override
  String get customerAddedTitle => 'ગ્રાહક સફળતાપૂર્વક ઉમેરાયો';

  @override
  String customerAddedMessage(String name) {
    return 'શું તમે હમણાં $name માટે લોન બનાવવા માંગો છો?';
  }

  @override
  String get laterButton => 'પછી';

  @override
  String get searchCustomersHint => 'નામ અથવા મોબાઇલથી શોધો';

  @override
  String get noCustomersTitle => 'કોઈ ગ્રાહક મળ્યો નથી';

  @override
  String get noCustomersSubtitle => 'પ્રથમ ગ્રાહક ઉમેરવા + દબાવો.';

  @override
  String get editCustomerMenu => 'વિગતો સંપાદિત કરો';

  @override
  String get deleteCustomerMenu => 'ગ્રાહક કાઢી નાખો';

  @override
  String get createLoanMenu => 'લોન બનાવો';

  @override
  String get deleteCustomerConfirmTitle => 'ગ્રાહક કાઢી નાખવો?';

  @override
  String deleteCustomerConfirmMessage(String name) {
    return 'આ $name ને સક્રિય ગ્રાહક યાદીમાંથી દૂર કરશે.';
  }

  @override
  String get deleteAction => 'કાઢી નાખો';

  @override
  String get cancelAction => 'રદ કરો';

  @override
  String get activeLoanDeleteBlocked =>
      'સક્રિય લોન ધરાવતા ગ્રાહકને કાઢી શકાતા નથી.';

  @override
  String get duplicateMobileError => 'આ મોબાઇલ નંબર સાથે ગ્રાહક પહેલેથી જ છે.';

  @override
  String get customerDetailTitle => 'ગ્રાહક વિગતો';

  @override
  String get callAction => 'કૉલ';

  @override
  String get smsAction => 'SMS';

  @override
  String get customerLoansHeading => 'ગ્રાહકની લોન';

  @override
  String get mobileLockedHelper => 'લોન બન્યા પછી મોબાઇલ નંબર બદલી શકાતો નથી.';

  @override
  String activeLoansCountLabel(int count) {
    return '$count સક્રિય';
  }

  @override
  String get createLoanTitle => 'લોન બનાવો';

  @override
  String get searchCustomerMobileHint => '10 અંકનો ગ્રાહક મોબાઇલ દાખલ કરો';

  @override
  String get noCustomerWithMobile => 'આ મોબાઇલ સાથે કોઈ ગ્રાહક નથી';

  @override
  String get addCustomerShortcut => 'ગ્રાહક ઉમેરો';

  @override
  String get principalLabel => 'મૂળ રકમ (₹)';

  @override
  String get monthlyRateLabel => 'વ્યાજ દર (દર મહિને %)';

  @override
  String get tenureMonthsLabel => 'મુદત (મહિના)';

  @override
  String get loanTypeLabel => 'વ્યાજ પ્રકાર';

  @override
  String get loanTypeSimple => 'સાદું';

  @override
  String get loanTypeCompound => 'ચક્રવૃદ્ધિ';

  @override
  String get startDateLabel => 'શરૂઆતની તારીખ';

  @override
  String get livePreviewHeading => 'લાઇવ EMI પૂર્વાવલોકન';

  @override
  String get monthlyEmiLabel => 'માસિક EMI';

  @override
  String get totalInterestLabel => 'કુલ વ્યાજ';

  @override
  String get totalPayableLabel => 'કુલ ચૂકવવાપાત્ર';

  @override
  String get createLoanButton => 'લોન બનાવો';

  @override
  String get loanCreatedTitle => 'લોન સફળતાપૂર્વક બનાવાઈ';

  @override
  String loanCreatedMessage(int count) {
    return '$count માસિક EMI તૈયાર કરવામાં આવી છે.';
  }

  @override
  String get viewLoanOverview => 'લોન વિગતો ખોલો';

  @override
  String get allLoansFilter => 'બધી';

  @override
  String get activeLoansFilter => 'સક્રિય';

  @override
  String get completedLoansFilter => 'પૂર્ણ';

  @override
  String get noLoansTitle => 'હજી કોઈ લોન નથી';

  @override
  String get noLoansSubtitle => 'EMI શેડ્યૂલ બનાવવા માટે લોન ઉમેરો.';

  @override
  String get selectCustomerError => 'પ્રથમ 10 અંકના મોબાઇલથી ગ્રાહક પસંદ કરો.';

  @override
  String get invalidPrincipalError => '0 થી વધુ મૂળ રકમ દાખલ કરો.';

  @override
  String get invalidRateError => '0 થી 100 વચ્ચે માસિક દર દાખલ કરો.';

  @override
  String get invalidTenureError => '1 થી 600 મહિના વચ્ચે મુદત દાખલ કરો.';

  @override
  String get loanOverviewTitle => 'લોન વિગત';

  @override
  String get emiScheduleHeading => 'EMI શેડ્યૂલ';

  @override
  String get payButton => 'ચૂકવો';

  @override
  String get payAllPendingButton => 'બધી બાકી EMI ચૂકવો';

  @override
  String confirmPayEmiTitle(int no) {
    return 'EMI #$no ચૂકવેલ તરીકે નોંધવી?';
  }

  @override
  String confirmPayEmiMessage(String amount) {
    return '$amount ની ચુકવણીની પુષ્ટિ કરો.';
  }

  @override
  String get paymentDateLabel => 'ચુકવણીની તારીખ';

  @override
  String get confirmPayAllTitle => 'બધી બાકી EMI ચૂકવવી?';

  @override
  String confirmPayAllMessage(int count, String amount) {
    return 'બાકીની $count EMI ($amount) ચૂકવાશે અને લોન કરાર PDF બનશે.';
  }

  @override
  String installmentLabel(int no) {
    return 'હપ્તો #$no';
  }

  @override
  String paidOnLabel(String date) {
    return 'ચૂકવેલ: $date';
  }

  @override
  String get outOfOrderEmiError =>
      'કૃપા કરીને પહેલા અગાઉના બાકી હપ્તા ક્રમ પ્રમાણે ચૂકવો.';

  @override
  String emiPaidSuccess(int no) {
    return 'હપ્તો #$no ચૂકવેલ નોંધાયો.';
  }

  @override
  String get loanCompletedPdfGenerated =>
      'લોન પૂર્ણ! લોન કરાર PDF દસ્તાવેજોમાં સાચવવામાં આવી.';

  @override
  String get viewPdfAction => 'PDF જુઓ';

  @override
  String get openDocumentsAction => 'દસ્તાવેજો ખોલો';

  @override
  String progressPaidLabel(int paid, int total) {
    return '$total માંથી $paid EMI ચૂકવાઈ';
  }

  @override
  String get ledgerHeading => 'ખાતાવહી ઇતિહાસ';

  @override
  String get ledgerDebitLabel => 'ઉધાર';

  @override
  String get ledgerCreditLabel => 'જમા';

  @override
  String get ledgerBalanceLabel => 'બાકી';

  @override
  String get documentsTitle => 'દસ્તાવેજો';

  @override
  String get noDocumentsTitle => 'હજી કોઈ PDF દસ્તાવેજ નથી';

  @override
  String get noDocumentsSubtitle =>
      'લોન પૂર્ણ ચૂકવાયા બાદ લોન કરાર આપમેળે અહીં દેખાશે.';

  @override
  String get viewPdfMenu => 'PDF જુઓ';

  @override
  String get sharePdfMenu => 'PDF શેર કરો';

  @override
  String get deletePdfMenu => 'PDF કાઢી નાખો';

  @override
  String get editPdfMenu => 'PDF સંપાદિત કરો';

  @override
  String get deletePdfConfirmTitle => 'દસ્તાવેજ કાઢી નાખવો?';

  @override
  String get deletePdfConfirmMessage =>
      'આ દસ્તાવેજોમાંથી જનરેટ થયેલો લોન કરાર દૂર કરશે.';

  @override
  String pagesCountLabel(int count) {
    return '$count પાનાં';
  }

  @override
  String get documentViewerTitle => 'લોન કરાર દર્શક';

  @override
  String get loanAgreementHeadline => 'લોન કરાર';

  @override
  String get lenderDetailsHeading => 'લોનદાતા વિગતો';

  @override
  String get borrowerDetailsHeading => 'લોન લેનારની વિગતો';

  @override
  String get installmentScheduleHeading => 'હપ્તા શેડ્યૂલ';

  @override
  String get generatedOnLabel => 'બનાવ્યાની તારીખ';

  @override
  String get documentIdLabel => 'દસ્તાવેજ ID';

  @override
  String pageOfLabel(int current, int total) {
    return 'પાનું $current / $total';
  }

  @override
  String get signatureLender => 'લોનદાતાની સહી';

  @override
  String get signatureBorrower => 'લોન લેનારની સહી';

  @override
  String get editPdfTitle => 'PDF સંપાદિત કરો';

  @override
  String get snapshotNotice =>
      'ફેરફારો ફક્ત આ PDF સ્નેપશોટને અપડેટ કરે છે; મૂળ લોન કે ખાતાવહીને નહીં.';

  @override
  String get pdfLanguageLabel => 'દસ્તાવેજ ભાષા';

  @override
  String get statusTextLabel => 'સ્થિતિ લેબલ';

  @override
  String get previewButton => 'પૂર્વાવલોકન';

  @override
  String get regeneratePdfButton => 'PDF ફરી બનાવો';

  @override
  String get pdfRegeneratedSuccess => 'દસ્તાવેજ સફળતાપૂર્વક ફરી બનાવાયો.';

  @override
  String shareReadyMessage(String title, int pages) {
    return '$title ($pages પાનાં) શેર કરવા માટે તૈયાર છે.';
  }

  @override
  String get copyHtmlAction => 'HTML કૉપિ કરો';

  @override
  String get htmlCopiedMessage => 'A4 HTML ક્લિપબોર્ડ પર કૉપિ થયું.';

  @override
  String get saveChangesButton => 'ફેરફારો સાચવો';

  @override
  String get profileUpdatedSuccess => 'પ્રોફાઇલ સફળતાપૂર્વક અપડેટ થયું.';

  @override
  String get signOutConfirmTitle => 'સાઇન આઉટ કરવું?';

  @override
  String get signOutConfirmMessage =>
      'તમારી વિગતો સાથે તમે ગમે ત્યારે ફરી સાઇન ઇન કરી શકો છો.';

  @override
  String get totalLoansStatLabel => 'કુલ લોન';

  @override
  String get documentsStatLabel => 'દસ્તાવેજો';

  @override
  String get backupTitle => 'બેકઅપ અને રિસ્ટોર';

  @override
  String get backupSubtitle =>
      'તમારા લોન ખાતાનો સ્થાનિક સ્નેપશોટ નિકાસ અથવા રિસ્ટોર કરો.';

  @override
  String get exportBackupButton => 'સ્થાનિક બેકઅપ બનાવો';

  @override
  String get restoreBackupButton => 'સ્નેપશોટ રિસ્ટોર કરો';

  @override
  String get backupGeneratedMessage =>
      'બેકઅપ સ્નેપશોટ બનાવીને ક્લિપબોર્ડ પર કૉપિ કરાયો.';

  @override
  String get restoreSuccessMessage => 'બેકઅપ સ્નેપશોટ સફળતાપૂર્વક રિસ્ટોર થયો.';

  @override
  String get restoreInvalidError => 'અમાન્ય બેકઅપ સ્નેપશોટ JSON.';

  @override
  String get pasteBackupHint =>
      'રિસ્ટોર કરવા માટે નિકાસ કરેલો બેકઅપ JSON અહીં પેસ્ટ કરો';

  @override
  String get driveComingSoonNote =>
      'Google Drive એન્ક્રિપ્ટેડ સિંક તબક્કા 6 માં ઉમેરાશે.';

  @override
  String get emiPdfButton => 'EMI PDF';

  @override
  String get viewCompletePdfButton => 'સંપૂર્ણ લોન PDF';

  @override
  String emiPdfGeneratedMessage(int no) {
    return 'હપ્તો #$no ચૂકવાયો અને PDF દસ્તાવેજોમાં સાચવ્યો.';
  }

  @override
  String emiReceiptTag(int no) {
    return 'EMI #$no રસીદ';
  }

  @override
  String get completeLoanPdfTag => 'સંપૂર્ણ લોન PDF';

  @override
  String get emiCalculatorTitle => 'EMI કેલ્ક્યુલેટર';

  @override
  String get emiCalculatorSubtitle =>
      'લોન બનાવતા પહેલા માસિક હપ્તો, કુલ વ્યાજ અને ચુકવણીનું સમયપત્રક અંદાજો.';

  @override
  String get principalShareLabel => 'મૂળધન હિસ્સો';

  @override
  String get interestShareLabel => 'વ્યાજ હિસ્સો';

  @override
  String get resetFieldsButton => 'રીસેટ';

  @override
  String get proceedToCreateLoanButton => 'આ શરતો સાથે લોન બનાવો';

  @override
  String get schedulePreviewHeading => 'સમયપત્રક પૂર્વાવલોકન';

  @override
  String get enterTermsForEstimate =>
      'EMI અંદાજ જોવા માટે મૂળધન, માસિક દર અને મુદત દાખલ કરો.';

  @override
  String get systemDefaultLanguage => 'સિસ્ટમ ડિફોલ્ટ';

  @override
  String get choosePhotoTitle => 'પ્રોફાઇલ ફોટો';

  @override
  String get pickFromGallery => 'ગેલેરીમાંથી પસંદ કરો';

  @override
  String get takePhoto => 'ફોટો પાડો';

  @override
  String get removePhoto => 'ફોટો દૂર કરો';

  @override
  String get changeAvatarColor => 'બેજ રંગ બદલો';

  @override
  String get photoPickFailedError => 'પસંદ કરેલી છબી લોડ કરી શકાઈ નથી.';

  @override
  String get databaseError =>
      'ડેટા સ્થાનિક રીતે સાચવી શકાયો નથી. કૃપા કરીને ફરી પ્રયાસ કરો.';

  @override
  String get onboardingSkip => 'છોડો';

  @override
  String get onboardingStart => 'શરૂ કરો';

  @override
  String get onboardingNext => 'આગળ';

  @override
  String get onboardingTitle1 => 'સ્માર્ટ ધિરાણ હબ';

  @override
  String get onboardingSubtitle1 =>
      'ગ્રાહકોનું સંચાલન કરો, સાદું કે ચક્રવૃદ્ધિ લોન બનાવો અને ઓફલાઇન વ્યવસ્થિત રહો.';

  @override
  String get onboardingTitle2 => 'EMI અને ખાતાવહી ટ્રેક કરો';

  @override
  String get onboardingSubtitle2 =>
      'માસિક હપ્તા, નિયત તારીખો અને વસૂલાત એક નજરમાં જુઓ.';

  @override
  String get onboardingTitle3 => 'ત્વરિત લોન કરાર PDF';

  @override
  String get onboardingSubtitle3 =>
      'સંપૂર્ણ ચુકવણી પછી 13 ભાષાઓમાં આપમેળે A4 લોન કરાર PDF બનાવો.';
}
