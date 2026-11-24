// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malayalam (`ml`).
class AppLocalizationsMl extends AppLocalizations {
  AppLocalizationsMl([String locale = 'ml']) : super(locale);

  @override
  String get appTitle => 'LoanWise';

  @override
  String get splashTagline => 'സ്മാർട്ട് വായ്പയും ഇഎംഐ ലെഡ്ജറും';

  @override
  String get loginTitle => 'ലോഗിൻ';

  @override
  String get nameLabel => 'പേര്';

  @override
  String get nameHint => 'നിങ്ങളുടെ മുഴുവൻ പേര് നൽകുക';

  @override
  String get mobileLabel => 'മൊബൈൽ നമ്പർ';

  @override
  String get mobileHint => '10 അക്ക മൊബൈൽ നമ്പർ';

  @override
  String get emailLabel => 'ഇമെയിൽ ഐഡി';

  @override
  String get emailHint => 'name@example.com';

  @override
  String get signInButton => 'സൈൻ ഇൻ ചെയ്യുക';

  @override
  String get errorNameRequired => 'ദയവായി നിങ്ങളുടെ പേര് നൽകുക';

  @override
  String get errorMobileInvalid =>
      '6 മുതൽ 9 വരെ ആരംഭിക്കുന്ന 10 അക്ക മൊബൈൽ നമ്പർ നൽകുക';

  @override
  String get errorEmailInvalid => 'സാധുവായ ഒരു ഇമെയിൽ വിലാസം നൽകുക';

  @override
  String get navHome => 'ഹോം';

  @override
  String get navCustomers => 'ഉപഭോക്താക്കൾ';

  @override
  String get navLoans => 'വായ്പകൾ';

  @override
  String get navProfile => 'പ്രൊഫൈൽ';

  @override
  String get welcomeBack => 'വീണ്ടും സ്വാഗതം,';

  @override
  String get openMenuTooltip => 'മെനു തുറക്കുക';

  @override
  String get openProfileTooltip => 'പ്രൊഫൈൽ തുറക്കുക';

  @override
  String get totalLentLabel => 'ആകെ നൽകിയ തുക';

  @override
  String get availableToCollect => 'ശേഖരിക്കാൻ ബാക്കിയുള്ളത്';

  @override
  String get activeLoansLabel => 'സജീവ വായ്പകൾ';

  @override
  String get customersLabel => 'ഉപഭോക്താക്കൾ';

  @override
  String get emisDueThisMonthLabel => 'ഈ മാസത്തെ ഇഎംഐകൾ';

  @override
  String get quickActionsHeading => 'ദ്രുത പ്രവർത്തനങ്ങൾ';

  @override
  String get actionAddCustomer => 'ഉപഭോക്താവിനെ ചേർക്കുക';

  @override
  String get actionCreateLoan => 'വായ്പ സൃഷ്ടിക്കുക';

  @override
  String get actionLoans => 'വായ്പകൾ';

  @override
  String get actionDocuments => 'രേഖകൾ';

  @override
  String get actionAllCustomers => 'എല്ലാ ഉപഭോക്താക്കളും';

  @override
  String get actionProfile => 'പ്രൊഫൈൽ';

  @override
  String get thisMonthHeading => 'ഈ മാസം';

  @override
  String get viewAll => 'എല്ലാം കാണുക';

  @override
  String get collectedThisMonth => 'ഈ മാസം ലഭിച്ചത്';

  @override
  String get pendingThisMonth => 'ഈ മാസം ബാക്കിയുള്ളത്';

  @override
  String get recentLoansHeading => 'സമീപകാല വായ്പകൾ';

  @override
  String get overdueEmisHeading => 'കാലാവധി കഴിഞ്ഞ ഇഎംഐകൾ';

  @override
  String get statusActive => 'സജീവം';

  @override
  String get statusCompleted => 'പൂർത്തിയായി';

  @override
  String get statusOverdue => 'കാലാവധി കഴിഞ്ഞു';

  @override
  String get statusPending => 'തീർപ്പാകാത്തത്';

  @override
  String get statusPaid => 'അടച്ചു';

  @override
  String nextEmiLabel(String date) {
    return 'അടുത്ത ഇഎംഐ: $date';
  }

  @override
  String dueSinceLabel(String date) {
    return 'അടയ്‌ക്കേണ്ട തീയതി: $date';
  }

  @override
  String get emptyRecentLoans =>
      'സമീപകാല വായ്പകളൊന്നുമില്ല. ഇവിടെ കാണാൻ ഒരു വായ്പ സൃഷ്ടിക്കുക.';

  @override
  String get emptyOverdueEmis =>
      'എല്ലാം കൃത്യമാണ്. കാലാവധി കഴിഞ്ഞ ഇഎംഐകളൊന്നുമില്ല.';

  @override
  String get drawerBackupRestore => 'ബാക്കപ്പും റീസ്റ്റോറും';

  @override
  String get drawerChangeTheme => 'തീം മാറ്റുക';

  @override
  String get drawerChooseLanguage => 'ഭാഷ തിരഞ്ഞെടുക്കുക';

  @override
  String get themeLight => 'ലൈറ്റ്';

  @override
  String get themeDark => 'ഡാർക്ക്';

  @override
  String get themeSystem => 'സിസ്റ്റം';

  @override
  String get backupDialogMessage =>
      'നിങ്ങളുടെ ഉപകരണത്തിൽ ലോക്കൽ ബാക്കപ്പ് അപ്‌ഡേറ്റ് ചെയ്‌തിരിക്കുന്നു.';

  @override
  String get closeAction => 'അടയ്ക്കുക';

  @override
  String featureQueuedMessage(String feature) {
    return '$feature തയ്യാറാണ്.';
  }

  @override
  String get tabCustomersSubtitle =>
      'വായ്പക്കാരെയും ബന്ധപ്പെടാനുള്ള വിവരങ്ങളും സജീവ വായ്പകളും കൈകാര്യം ചെയ്യുക.';

  @override
  String get tabLoansSubtitle =>
      'സജീവ വായ്പകളും പലിശയും ഇഎംഐ ഷെഡ്യൂളുകളും നിരീക്ഷിക്കുക.';

  @override
  String get tabProfileSubtitle =>
      'രജിസ്റ്റർ ചെയ്ത വായ്പാ ദാതാവിന്റെ വിവരങ്ങളും ക്രമീകരണങ്ങളും.';

  @override
  String get signOutAction => 'സൈൻ ഔട്ട്';

  @override
  String get addCustomerTitle => 'ഉപഭോക്താവിനെ ചേർക്കുക';

  @override
  String get editCustomerTitle => 'ഉപഭോക്താവിനെ തിരുത്തുക';

  @override
  String get customerNameLabel => 'ഉപഭോക്താവിന്റെ പേര്';

  @override
  String get customerEmailLabel => 'ഉപഭോക്താവിന്റെ ഇമെയിൽ';

  @override
  String get customerMobileLabel => 'മൊബൈൽ നമ്പർ';

  @override
  String get customerLocationLabel => 'സ്ഥലം';

  @override
  String get locationRequiredError => 'ദയവായി സ്ഥലം നൽകുക';

  @override
  String get saveCustomerButton => 'ഉപഭോക്താവിനെ സേവ് ചെയ്യുക';

  @override
  String get updateCustomerButton => 'വിവരങ്ങൾ പുതുക്കുക';

  @override
  String get customerAddedTitle => 'ഉപഭോക്താവിനെ വിജയകരമായി ചേർത്തു';

  @override
  String customerAddedMessage(String name) {
    return '$name-ന് ഇപ്പോൾ ഒരു വായ്പ സൃഷ്ടിക്കണോ?';
  }

  @override
  String get laterButton => 'പിന്നീട്';

  @override
  String get searchCustomersHint => 'പേര് അല്ലെങ്കിൽ മൊബൈൽ വഴി തിരയുക';

  @override
  String get noCustomersTitle => 'ഉപഭോക്താക്കളെ കണ്ടെത്തിയില്ല';

  @override
  String get noCustomersSubtitle =>
      'ആദ്യ ഉപഭോക്താവിനെ ചേർക്കാൻ + ടാപ്പ് ചെയ്യുക.';

  @override
  String get editCustomerMenu => 'വിവരങ്ങൾ തിരുത്തുക';

  @override
  String get deleteCustomerMenu => 'ഉപഭോക്താവിനെ നീക്കം ചെയ്യുക';

  @override
  String get createLoanMenu => 'വായ്പ സൃഷ്ടിക്കുക';

  @override
  String get deleteCustomerConfirmTitle => 'ഉപഭോക്താവിനെ നീക്കം ചെയ്യണോ?';

  @override
  String deleteCustomerConfirmMessage(String name) {
    return '$name-നെ സജീവ ഉപഭോക്തൃ പട്ടികയിൽ നിന്ന് മാറ്റും.';
  }

  @override
  String get deleteAction => 'നീക്കം ചെയ്യുക';

  @override
  String get cancelAction => 'റദ്ദാക്കുക';

  @override
  String get activeLoanDeleteBlocked =>
      'സജീവ വായ്പയുള്ള ഉപഭോക്താവിനെ നീക്കം ചെയ്യാനാകില്ല.';

  @override
  String get duplicateMobileError =>
      'ഈ മൊബൈൽ നമ്പറിൽ ഒരു ഉപഭോക്താവ് നിലവിലുണ്ട്.';

  @override
  String get customerDetailTitle => 'ഉപഭോക്താവിന്റെ വിവരങ്ങൾ';

  @override
  String get callAction => 'വിളിക്കുക';

  @override
  String get smsAction => 'എസ്എംഎസ്';

  @override
  String get customerLoansHeading => 'ഉപഭോക്താവിന്റെ വായ്പകൾ';

  @override
  String get mobileLockedHelper =>
      'വായ്പകൾ ഉള്ളപ്പോൾ മൊബൈൽ നമ്പർ മാറ്റാനാകില്ല.';

  @override
  String activeLoansCountLabel(int count) {
    return '$count സജീവം';
  }

  @override
  String get createLoanTitle => 'വായ്പ സൃഷ്ടിക്കുക';

  @override
  String get searchCustomerMobileHint => '10 അക്ക മൊബൈൽ നമ്പർ നൽകുക';

  @override
  String get noCustomerWithMobile => 'ഈ മൊബൈൽ നമ്പറിൽ ഉപഭോക്താവില്ല';

  @override
  String get addCustomerShortcut => 'ഉപഭോക്താവിനെ ചേർക്കുക';

  @override
  String get principalLabel => 'മുതൽ തുക (₹)';

  @override
  String get monthlyRateLabel => 'പ്രതിമാസ പലിശ നിരക്ക് (%)';

  @override
  String get tenureMonthsLabel => 'കാലാവധി (മാസങ്ങൾ)';

  @override
  String get loanTypeLabel => 'പലിശ തരം';

  @override
  String get loanTypeSimple => 'ലളിത പലിശ';

  @override
  String get loanTypeCompound => 'കൂട്ടുപലിശ';

  @override
  String get startDateLabel => 'ആരംഭ തീയതി';

  @override
  String get livePreviewHeading => 'തത്സമയ ഇഎംഐ പ്രിവ്യൂ';

  @override
  String get monthlyEmiLabel => 'പ്രതിമാസ ഇഎംഐ';

  @override
  String get totalInterestLabel => 'ആകെ പലിശ';

  @override
  String get totalPayableLabel => 'ആകെ അടയ്ക്കേണ്ട തുക';

  @override
  String get createLoanButton => 'വായ്പ സൃഷ്ടിക്കുക';

  @override
  String get loanCreatedTitle => 'വായ്പ വിജയകരമായി സൃഷ്ടിച്ചു';

  @override
  String loanCreatedMessage(int count) {
    return '$count പ്രതിമാസ ഇഎംഐകൾ തയ്യാറാക്കി.';
  }

  @override
  String get viewLoanOverview => 'വായ്പാ അവലോകനം കാണുക';

  @override
  String get allLoansFilter => 'എല്ലാം';

  @override
  String get activeLoansFilter => 'സജീവം';

  @override
  String get completedLoansFilter => 'പൂർത്തിയായത്';

  @override
  String get noLoansTitle => 'വായ്പകളൊന്നുമില്ല';

  @override
  String get noLoansSubtitle =>
      'ഇഎംഐ ഷെഡ്യൂൾ തയ്യാറാക്കാൻ ഒരു വായ്പ സൃഷ്ടിക്കുക.';

  @override
  String get selectCustomerError =>
      'ആദ്യം 10 അക്ക മൊബൈൽ വഴി ഉപഭോക്താവിനെ തിരഞ്ഞെടുക്കുക.';

  @override
  String get invalidPrincipalError => '0-നേക്കാൾ വലിയ മുതൽ തുക നൽകുക.';

  @override
  String get invalidRateError =>
      '0-നും 100-നും ഇടയിലുള്ള പ്രതിമാസ നിരക്ക് നൽകുക.';

  @override
  String get invalidTenureError => '1-നും 600-നും ഇടയിലുള്ള കാലാവധി നൽകുക.';

  @override
  String get loanOverviewTitle => 'വായ്പാ അവലോകനം';

  @override
  String get emiScheduleHeading => 'ഇഎംഐ ഷെഡ്യൂൾ';

  @override
  String get payButton => 'അടയ്ക്കുക';

  @override
  String get payAllPendingButton => 'ബാക്കിയുള്ള എല്ലാ ഇഎംഐകളും അടയ്ക്കുക';

  @override
  String confirmPayEmiTitle(int no) {
    return 'ഇഎംഐ #$no അടച്ചതായി രേഖപ്പെടുത്തണോ?';
  }

  @override
  String confirmPayEmiMessage(String amount) {
    return '$amount അടവ് സ്ഥിരീകരിക്കുക.';
  }

  @override
  String get paymentDateLabel => 'അടച്ച തീയതി';

  @override
  String get confirmPayAllTitle => 'ബാക്കിയുള്ള എല്ലാ ഇഎംഐകളും അടയ്ക്കണോ?';

  @override
  String confirmPayAllMessage(int count, String amount) {
    return 'ഇത് ബാക്കിയുള്ള $count ഇഎംഐകൾ ($amount) അടച്ചതായി രേഖപ്പെടുത്തി വായ്പാ കരാർ പിഡിഎഫ് തയ്യാറാക്കും.';
  }

  @override
  String installmentLabel(int no) {
    return 'തവണ #$no';
  }

  @override
  String paidOnLabel(String date) {
    return 'അടച്ചത്: $date';
  }

  @override
  String get outOfOrderEmiError =>
      'ദയവായി മുമ്പുള്ള തീർപ്പാകാത്ത തവണകൾ ക്രമത്തിൽ അടയ്ക്കുക.';

  @override
  String emiPaidSuccess(int no) {
    return 'തവണ #$no അടച്ചതായി രേഖപ്പെടുത്തി.';
  }

  @override
  String get loanCompletedPdfGenerated =>
      'വായ്പ പൂർത്തിയായി! കരാർ പിഡിഎഫ് രേഖകളിൽ സേവ് ചെയ്തു.';

  @override
  String get viewPdfAction => 'പിഡിഎഫ് കാണുക';

  @override
  String get openDocumentsAction => 'രേഖകൾ തുറക്കുക';

  @override
  String progressPaidLabel(int paid, int total) {
    return '$total-ൽ $paid ഇഎംഐകൾ അടച്ചു';
  }

  @override
  String get ledgerHeading => 'ലെഡ്ജർ ചരിത്രം';

  @override
  String get ledgerDebitLabel => 'ഡെബിറ്റ്';

  @override
  String get ledgerCreditLabel => 'ക്രെഡിറ്റ്';

  @override
  String get ledgerBalanceLabel => 'ബാക്കി';

  @override
  String get documentsTitle => 'രേഖകൾ';

  @override
  String get noDocumentsTitle => 'പിഡിഎഫ് രേഖകളൊന്നുമില്ല';

  @override
  String get noDocumentsSubtitle =>
      'വായ്പ പൂർണ്ണമായി അടച്ചുകഴിയുമ്പോൾ കരാർ ഇവിടെ കാണാം.';

  @override
  String get viewPdfMenu => 'പിഡിഎഫ് കാണുക';

  @override
  String get sharePdfMenu => 'പിഡിഎഫ് പങ്കിടുക';

  @override
  String get deletePdfMenu => 'പിഡിഎഫ് നീക്കം ചെയ്യുക';

  @override
  String get editPdfMenu => 'പിഡിഎഫ് തിരുത്തുക';

  @override
  String get deletePdfConfirmTitle => 'രേഖ നീക്കം ചെയ്യണോ?';

  @override
  String get deletePdfConfirmMessage =>
      'ഇത് തയ്യാറാക്കിയ വായ്പാ കരാർ രേഖകളിൽ നിന്ന് നീക്കം ചെയ്യും.';

  @override
  String pagesCountLabel(int count) {
    return '$count പേജുകൾ';
  }

  @override
  String get documentViewerTitle => 'വായ്പാ കരാർ വ്യൂവർ';

  @override
  String get loanAgreementHeadline => 'വായ്പാ കരാർ';

  @override
  String get lenderDetailsHeading => 'വായ്പാ ദാതാവിന്റെ വിവരങ്ങൾ';

  @override
  String get borrowerDetailsHeading => 'വായ്പക്കാരന്റെ വിവരങ്ങൾ';

  @override
  String get installmentScheduleHeading => 'തവണ ഷെഡ്യൂൾ';

  @override
  String get generatedOnLabel => 'തയ്യാറാക്കിയ തീയതി';

  @override
  String get documentIdLabel => 'രേഖാ ഐഡി';

  @override
  String pageOfLabel(int current, int total) {
    return 'പേജ് $current / $total';
  }

  @override
  String get signatureLender => 'വായ്പാ ദാതാവിന്റെ ഒപ്പ്';

  @override
  String get signatureBorrower => 'വായ്പക്കാരന്റെ ഒപ്പ്';

  @override
  String get editPdfTitle => 'പിഡിഎഫ് തിരുത്തുക';

  @override
  String get snapshotNotice =>
      'മാറ്റങ്ങൾ ഈ പിഡിഎഫ് സ്നാപ്ഷോട്ടിൽ മാത്രമേ ബാധകമാകൂ; യഥാർത്ഥ വായ്പയോ ലെഡ്ജറോ മാറില്ല.';

  @override
  String get pdfLanguageLabel => 'രേഖയുടെ ഭാഷ';

  @override
  String get statusTextLabel => 'സ്റ്റാറ്റസ് വാചകം';

  @override
  String get previewButton => 'പ്രിവ്യൂ';

  @override
  String get regeneratePdfButton => 'പിഡിഎഫ് വീണ്ടും നിർമ്മിക്കുക';

  @override
  String get pdfRegeneratedSuccess => 'രേഖ വിജയകരമായി വീണ്ടും നിർമ്മിച്ചു.';

  @override
  String shareReadyMessage(String title, int pages) {
    return 'പങ്കിടുന്നതിനായി $title ($pages പേജുകൾ) തയ്യാറാക്കി.';
  }

  @override
  String get copyHtmlAction => 'HTML പകർത്തുക';

  @override
  String get htmlCopiedMessage => 'A4 HTML ക്ലിപ്പ്ബോർഡിലേക്ക് പകർത്തി.';

  @override
  String get saveChangesButton => 'മാറ്റങ്ങൾ സേവ് ചെയ്യുക';

  @override
  String get profileUpdatedSuccess => 'പ്രൊഫൈൽ വിജയകരമായി പുതുക്കി.';

  @override
  String get signOutConfirmTitle => 'സൈൻ ഔട്ട് ചെയ്യണോ?';

  @override
  String get signOutConfirmMessage =>
      'നിങ്ങളുടെ വിവരങ്ങൾ ഉപയോഗിച്ച് എപ്പോൾ വേണമെങ്കിലും തിരികെ പ്രവേശിക്കാം.';

  @override
  String get totalLoansStatLabel => 'ആകെ വായ്പകൾ';

  @override
  String get documentsStatLabel => 'രേഖകൾ';

  @override
  String get backupTitle => 'ബാക്കപ്പും റീസ്റ്റോറും';

  @override
  String get backupSubtitle =>
      'ലോക്കൽ സ്നാപ്ഷോട്ട് എക്‌സ്‌പോർട്ട് ചെയ്യുക അല്ലെങ്കിൽ ലെഡ്ജർ റീസ്റ്റോർ ചെയ്യുക.';

  @override
  String get exportBackupButton => 'ലോക്കൽ ബാക്കപ്പ് സൃഷ്ടിക്കുക';

  @override
  String get restoreBackupButton => 'സ്നാപ്ഷോട്ട് റീസ്റ്റോർ ചെയ്യുക';

  @override
  String get backupGeneratedMessage =>
      'ബാക്കപ്പ് സ്നാപ്ഷോട്ട് ക്ലിപ്പ്ബോർഡിലേക്ക് പകർത്തി.';

  @override
  String get restoreSuccessMessage =>
      'ബാക്കപ്പ് സ്നാപ്ഷോട്ട് വിജയകരമായി റീസ്റ്റോർ ചെയ്തു.';

  @override
  String get restoreInvalidError => 'അസാധുവായ ബാക്കപ്പ് സ്നാപ്ഷോട്ട് JSON.';

  @override
  String get pasteBackupHint =>
      'റീസ്റ്റോർ ചെയ്യാൻ ബാക്കപ്പ് JSON ഇവിടെ ഒട്ടിക്കുക';

  @override
  String get driveComingSoonNote =>
      'Google Drive എൻക്രിപ്റ്റഡ് AppData സിങ്ക് സ്റ്റേജ് 6-ൽ വരും.';

  @override
  String get emiPdfButton => 'EMI PDF';

  @override
  String get viewCompletePdfButton => 'പൂർണ്ണ വായ്പ PDF';

  @override
  String emiPdfGeneratedMessage(int no) {
    return 'തവണ #$no അടച്ചു, PDF രേഖകളിൽ സംരക്ഷിച്ചു.';
  }

  @override
  String emiReceiptTag(int no) {
    return 'EMI #$no രസീത്';
  }

  @override
  String get completeLoanPdfTag => 'പൂർണ്ണ വായ്പ PDF';

  @override
  String get emiCalculatorTitle => 'EMI കാൽക്കുലേറ്റർ';

  @override
  String get emiCalculatorSubtitle =>
      'വായ്പ സൃഷ്ടിക്കുന്നതിന് മുമ്പ് പ്രതിമാസ തവണയും ആകെ പലിശയും തിരിച്ചടവ് പട്ടികയും കണക്കാക്കുക.';

  @override
  String get principalShareLabel => 'മുതൽ വിഹിതം';

  @override
  String get interestShareLabel => 'പലിശ വിഹിതം';

  @override
  String get resetFieldsButton => 'പുനഃസജ്ജമാക്കുക';

  @override
  String get proceedToCreateLoanButton => 'ഈ വിവരങ്ങളോടെ വായ്പ സൃഷ്ടിക്കുക';

  @override
  String get schedulePreviewHeading => 'പട്ടിക പ്രിവ്യൂ';

  @override
  String get enterTermsForEstimate =>
      'EMI കണക്കാക്കാൻ മുതൽ, പ്രതിമാസ നിരക്ക്, കാലാവധി എന്നിവ നൽകുക.';

  @override
  String get systemDefaultLanguage => 'സിസ്റ്റം ഡിഫോൾട്ട്';

  @override
  String get choosePhotoTitle => 'പ്രൊഫൈൽ ഫോട്ടോ';

  @override
  String get pickFromGallery => 'ഗാലറിയിൽ നിന്ന് തിരഞ്ഞെടുക്കുക';

  @override
  String get takePhoto => 'ഫോട്ടോ എടുക്കുക';

  @override
  String get removePhoto => 'ഫോട്ടോ നീക്കം ചെയ്യുക';

  @override
  String get changeAvatarColor => 'ബാഡ്ജ് നിറം മാറ്റുക';

  @override
  String get photoPickFailedError => 'തിരഞ്ഞെടുത്ത ചിത്രം ലോഡ് ചെയ്യാനായില്ല.';

  @override
  String get databaseError =>
      'ഡാറ്റ പ്രാദേശികമായി സംരക്ഷിക്കാനായില്ല. ദയവായി വീണ്ടും ശ്രമിക്കുക.';

  @override
  String get onboardingSkip => 'ഒഴിവാക്കുക';

  @override
  String get onboardingStart => 'ആരംഭിക്കുക';

  @override
  String get onboardingNext => 'അടുത്തത്';

  @override
  String get onboardingTitle1 => 'സ്മാർട്ട് വായ്പാ ഹബ്';

  @override
  String get onboardingSubtitle1 =>
      'ഉപഭോക്താക്കളെ നിയന്ത്രിക്കുക, സാധാരണ അല്ലെങ്കിൽ കൂട്ടുപലിശ വായ്പകൾ ഓഫ്‌ലൈനിൽ സൃഷ്ടിക്കുക.';

  @override
  String get onboardingTitle2 => 'EMI & ലെഡ്ജർ ട്രാക്ക്';

  @override
  String get onboardingSubtitle2 =>
      'പ്രതിമാസ തവണകളും തീയതികളും പിരിവുകളും ഒറ്റനോട്ടത്തിൽ നിരീക്ഷിക്കുക.';

  @override
  String get onboardingTitle3 => 'ഉടനടി വായ്പാ കരാറുകൾ';

  @override
  String get onboardingSubtitle3 =>
      'മുഴുവൻ തുകയും അടച്ചുകഴിയുമ്പോൾ 13 ഭാഷകളിൽ സ്വയമേവ A4 വായ്പാ കരാർ PDF തയ്യാറാക്കുക.';
}
