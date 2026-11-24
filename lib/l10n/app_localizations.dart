import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_as.dart';
import 'app_localizations_bn.dart';
import 'app_localizations_en.dart';
import 'app_localizations_gu.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_kn.dart';
import 'app_localizations_ml.dart';
import 'app_localizations_mr.dart';
import 'app_localizations_or.dart';
import 'app_localizations_pa.dart';
import 'app_localizations_ta.dart';
import 'app_localizations_te.dart';
import 'app_localizations_ur.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('as'),
    Locale('bn'),
    Locale('en'),
    Locale('gu'),
    Locale('hi'),
    Locale('kn'),
    Locale('ml'),
    Locale('mr'),
    Locale('or'),
    Locale('pa'),
    Locale('ta'),
    Locale('te'),
    Locale('ur'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'LoanWise'**
  String get appTitle;

  /// No description provided for @splashTagline.
  ///
  /// In en, this message translates to:
  /// **'Smart Lending & EMI Ledger'**
  String get splashTagline;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginTitle;

  /// No description provided for @nameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nameLabel;

  /// No description provided for @nameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get nameHint;

  /// No description provided for @mobileLabel.
  ///
  /// In en, this message translates to:
  /// **'Mobile number'**
  String get mobileLabel;

  /// No description provided for @mobileHint.
  ///
  /// In en, this message translates to:
  /// **'10-digit mobile number'**
  String get mobileHint;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email ID'**
  String get emailLabel;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'name@example.com'**
  String get emailHint;

  /// No description provided for @signInButton.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signInButton;

  /// No description provided for @errorNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get errorNameRequired;

  /// No description provided for @errorMobileInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a 10 digit mobile number starting with 6 to 9'**
  String get errorMobileInvalid;

  /// No description provided for @errorEmailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address'**
  String get errorEmailInvalid;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navCustomers.
  ///
  /// In en, this message translates to:
  /// **'Customers'**
  String get navCustomers;

  /// No description provided for @navLoans.
  ///
  /// In en, this message translates to:
  /// **'Loans'**
  String get navLoans;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back,'**
  String get welcomeBack;

  /// No description provided for @openMenuTooltip.
  ///
  /// In en, this message translates to:
  /// **'Open menu'**
  String get openMenuTooltip;

  /// No description provided for @openProfileTooltip.
  ///
  /// In en, this message translates to:
  /// **'Open profile'**
  String get openProfileTooltip;

  /// No description provided for @totalLentLabel.
  ///
  /// In en, this message translates to:
  /// **'Total Lent'**
  String get totalLentLabel;

  /// No description provided for @availableToCollect.
  ///
  /// In en, this message translates to:
  /// **'Available to collect'**
  String get availableToCollect;

  /// No description provided for @activeLoansLabel.
  ///
  /// In en, this message translates to:
  /// **'Active loans'**
  String get activeLoansLabel;

  /// No description provided for @customersLabel.
  ///
  /// In en, this message translates to:
  /// **'Customers'**
  String get customersLabel;

  /// No description provided for @emisDueThisMonthLabel.
  ///
  /// In en, this message translates to:
  /// **'EMIs due this month'**
  String get emisDueThisMonthLabel;

  /// No description provided for @quickActionsHeading.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get quickActionsHeading;

  /// No description provided for @actionAddCustomer.
  ///
  /// In en, this message translates to:
  /// **'Add Customer'**
  String get actionAddCustomer;

  /// No description provided for @actionCreateLoan.
  ///
  /// In en, this message translates to:
  /// **'Create Loan'**
  String get actionCreateLoan;

  /// No description provided for @actionLoans.
  ///
  /// In en, this message translates to:
  /// **'Loans'**
  String get actionLoans;

  /// No description provided for @actionDocuments.
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get actionDocuments;

  /// No description provided for @actionAllCustomers.
  ///
  /// In en, this message translates to:
  /// **'All Customers'**
  String get actionAllCustomers;

  /// No description provided for @actionProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get actionProfile;

  /// No description provided for @thisMonthHeading.
  ///
  /// In en, this message translates to:
  /// **'This Month'**
  String get thisMonthHeading;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get viewAll;

  /// No description provided for @collectedThisMonth.
  ///
  /// In en, this message translates to:
  /// **'Collected this month'**
  String get collectedThisMonth;

  /// No description provided for @pendingThisMonth.
  ///
  /// In en, this message translates to:
  /// **'Pending this month'**
  String get pendingThisMonth;

  /// No description provided for @recentLoansHeading.
  ///
  /// In en, this message translates to:
  /// **'Recent Loans'**
  String get recentLoansHeading;

  /// No description provided for @overdueEmisHeading.
  ///
  /// In en, this message translates to:
  /// **'Overdue EMIs'**
  String get overdueEmisHeading;

  /// No description provided for @statusActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get statusActive;

  /// No description provided for @statusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get statusCompleted;

  /// No description provided for @statusOverdue.
  ///
  /// In en, this message translates to:
  /// **'Overdue'**
  String get statusOverdue;

  /// No description provided for @statusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get statusPending;

  /// No description provided for @statusPaid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get statusPaid;

  /// No description provided for @nextEmiLabel.
  ///
  /// In en, this message translates to:
  /// **'Next EMI: {date}'**
  String nextEmiLabel(String date);

  /// No description provided for @dueSinceLabel.
  ///
  /// In en, this message translates to:
  /// **'Due: {date}'**
  String dueSinceLabel(String date);

  /// No description provided for @emptyRecentLoans.
  ///
  /// In en, this message translates to:
  /// **'No recent loans yet. Create a loan to see activity here.'**
  String get emptyRecentLoans;

  /// No description provided for @emptyOverdueEmis.
  ///
  /// In en, this message translates to:
  /// **'All caught up. No overdue EMIs at the moment.'**
  String get emptyOverdueEmis;

  /// No description provided for @drawerBackupRestore.
  ///
  /// In en, this message translates to:
  /// **'Backup and restore'**
  String get drawerBackupRestore;

  /// No description provided for @drawerChangeTheme.
  ///
  /// In en, this message translates to:
  /// **'Change theme'**
  String get drawerChangeTheme;

  /// No description provided for @drawerChooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose language'**
  String get drawerChooseLanguage;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @backupDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'Local backup is up to date for your device.'**
  String get backupDialogMessage;

  /// No description provided for @closeAction.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get closeAction;

  /// No description provided for @featureQueuedMessage.
  ///
  /// In en, this message translates to:
  /// **'{feature} is ready.'**
  String featureQueuedMessage(String feature);

  /// No description provided for @tabCustomersSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage borrowers, contact details, and active loan records.'**
  String get tabCustomersSubtitle;

  /// No description provided for @tabLoansSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Track active disbursements, interest, and EMI schedules.'**
  String get tabLoansSubtitle;

  /// No description provided for @tabProfileSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your registered lender details and workspace preferences.'**
  String get tabProfileSubtitle;

  /// No description provided for @signOutAction.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOutAction;

  /// No description provided for @addCustomerTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Customer'**
  String get addCustomerTitle;

  /// No description provided for @editCustomerTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Customer'**
  String get editCustomerTitle;

  /// No description provided for @customerNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Customer name'**
  String get customerNameLabel;

  /// No description provided for @customerEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Customer email'**
  String get customerEmailLabel;

  /// No description provided for @customerMobileLabel.
  ///
  /// In en, this message translates to:
  /// **'Mobile number'**
  String get customerMobileLabel;

  /// No description provided for @customerLocationLabel.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get customerLocationLabel;

  /// No description provided for @locationRequiredError.
  ///
  /// In en, this message translates to:
  /// **'Please enter a location'**
  String get locationRequiredError;

  /// No description provided for @saveCustomerButton.
  ///
  /// In en, this message translates to:
  /// **'Save Customer'**
  String get saveCustomerButton;

  /// No description provided for @updateCustomerButton.
  ///
  /// In en, this message translates to:
  /// **'Update Customer'**
  String get updateCustomerButton;

  /// No description provided for @customerAddedTitle.
  ///
  /// In en, this message translates to:
  /// **'Customer added successfully'**
  String get customerAddedTitle;

  /// No description provided for @customerAddedMessage.
  ///
  /// In en, this message translates to:
  /// **'Would you like to create a loan for {name} now?'**
  String customerAddedMessage(String name);

  /// No description provided for @laterButton.
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get laterButton;

  /// No description provided for @searchCustomersHint.
  ///
  /// In en, this message translates to:
  /// **'Search by name or mobile'**
  String get searchCustomersHint;

  /// No description provided for @noCustomersTitle.
  ///
  /// In en, this message translates to:
  /// **'No customers found'**
  String get noCustomersTitle;

  /// No description provided for @noCustomersSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tap + to add your first borrower.'**
  String get noCustomersSubtitle;

  /// No description provided for @editCustomerMenu.
  ///
  /// In en, this message translates to:
  /// **'Edit customer details'**
  String get editCustomerMenu;

  /// No description provided for @deleteCustomerMenu.
  ///
  /// In en, this message translates to:
  /// **'Delete customer'**
  String get deleteCustomerMenu;

  /// No description provided for @createLoanMenu.
  ///
  /// In en, this message translates to:
  /// **'Create loan'**
  String get createLoanMenu;

  /// No description provided for @deleteCustomerConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete customer?'**
  String get deleteCustomerConfirmTitle;

  /// No description provided for @deleteCustomerConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'This will archive {name} from your active customer list.'**
  String deleteCustomerConfirmMessage(String name);

  /// No description provided for @deleteAction.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteAction;

  /// No description provided for @cancelAction.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelAction;

  /// No description provided for @activeLoanDeleteBlocked.
  ///
  /// In en, this message translates to:
  /// **'Cannot delete a customer who still has an active loan.'**
  String get activeLoanDeleteBlocked;

  /// No description provided for @duplicateMobileError.
  ///
  /// In en, this message translates to:
  /// **'A customer with this mobile number already exists.'**
  String get duplicateMobileError;

  /// No description provided for @customerDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Customer Details'**
  String get customerDetailTitle;

  /// No description provided for @callAction.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get callAction;

  /// No description provided for @smsAction.
  ///
  /// In en, this message translates to:
  /// **'SMS'**
  String get smsAction;

  /// No description provided for @customerLoansHeading.
  ///
  /// In en, this message translates to:
  /// **'Customer Loans'**
  String get customerLoansHeading;

  /// No description provided for @mobileLockedHelper.
  ///
  /// In en, this message translates to:
  /// **'Mobile number cannot be changed once loans exist.'**
  String get mobileLockedHelper;

  /// No description provided for @activeLoansCountLabel.
  ///
  /// In en, this message translates to:
  /// **'{count} active'**
  String activeLoansCountLabel(int count);

  /// No description provided for @createLoanTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Loan'**
  String get createLoanTitle;

  /// No description provided for @searchCustomerMobileHint.
  ///
  /// In en, this message translates to:
  /// **'Enter 10-digit customer mobile'**
  String get searchCustomerMobileHint;

  /// No description provided for @noCustomerWithMobile.
  ///
  /// In en, this message translates to:
  /// **'No customer with this mobile'**
  String get noCustomerWithMobile;

  /// No description provided for @addCustomerShortcut.
  ///
  /// In en, this message translates to:
  /// **'Add customer'**
  String get addCustomerShortcut;

  /// No description provided for @principalLabel.
  ///
  /// In en, this message translates to:
  /// **'Principal amount (₹)'**
  String get principalLabel;

  /// No description provided for @monthlyRateLabel.
  ///
  /// In en, this message translates to:
  /// **'Interest rate (% per month)'**
  String get monthlyRateLabel;

  /// No description provided for @tenureMonthsLabel.
  ///
  /// In en, this message translates to:
  /// **'Tenure (months)'**
  String get tenureMonthsLabel;

  /// No description provided for @loanTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Interest type'**
  String get loanTypeLabel;

  /// No description provided for @loanTypeSimple.
  ///
  /// In en, this message translates to:
  /// **'Simple'**
  String get loanTypeSimple;

  /// No description provided for @loanTypeCompound.
  ///
  /// In en, this message translates to:
  /// **'Compound'**
  String get loanTypeCompound;

  /// No description provided for @startDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Start date'**
  String get startDateLabel;

  /// No description provided for @livePreviewHeading.
  ///
  /// In en, this message translates to:
  /// **'Live EMI Preview'**
  String get livePreviewHeading;

  /// No description provided for @monthlyEmiLabel.
  ///
  /// In en, this message translates to:
  /// **'Monthly EMI'**
  String get monthlyEmiLabel;

  /// No description provided for @totalInterestLabel.
  ///
  /// In en, this message translates to:
  /// **'Total interest'**
  String get totalInterestLabel;

  /// No description provided for @totalPayableLabel.
  ///
  /// In en, this message translates to:
  /// **'Total payable'**
  String get totalPayableLabel;

  /// No description provided for @createLoanButton.
  ///
  /// In en, this message translates to:
  /// **'Create Loan'**
  String get createLoanButton;

  /// No description provided for @loanCreatedTitle.
  ///
  /// In en, this message translates to:
  /// **'Loan created successfully'**
  String get loanCreatedTitle;

  /// No description provided for @loanCreatedMessage.
  ///
  /// In en, this message translates to:
  /// **'{count} monthly EMIs have been generated.'**
  String loanCreatedMessage(int count);

  /// No description provided for @viewLoanOverview.
  ///
  /// In en, this message translates to:
  /// **'Open Loan Overview'**
  String get viewLoanOverview;

  /// No description provided for @allLoansFilter.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get allLoansFilter;

  /// No description provided for @activeLoansFilter.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get activeLoansFilter;

  /// No description provided for @completedLoansFilter.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completedLoansFilter;

  /// No description provided for @noLoansTitle.
  ///
  /// In en, this message translates to:
  /// **'No loans yet'**
  String get noLoansTitle;

  /// No description provided for @noLoansSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create a loan to generate its EMI schedule.'**
  String get noLoansSubtitle;

  /// No description provided for @selectCustomerError.
  ///
  /// In en, this message translates to:
  /// **'Select a customer by 10-digit mobile first.'**
  String get selectCustomerError;

  /// No description provided for @invalidPrincipalError.
  ///
  /// In en, this message translates to:
  /// **'Enter a principal amount greater than 0.'**
  String get invalidPrincipalError;

  /// No description provided for @invalidRateError.
  ///
  /// In en, this message translates to:
  /// **'Enter a monthly rate between 0 and 100.'**
  String get invalidRateError;

  /// No description provided for @invalidTenureError.
  ///
  /// In en, this message translates to:
  /// **'Enter a tenure between 1 and 600 months.'**
  String get invalidTenureError;

  /// No description provided for @loanOverviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Loan Overview'**
  String get loanOverviewTitle;

  /// No description provided for @emiScheduleHeading.
  ///
  /// In en, this message translates to:
  /// **'EMI Schedule'**
  String get emiScheduleHeading;

  /// No description provided for @payButton.
  ///
  /// In en, this message translates to:
  /// **'Pay'**
  String get payButton;

  /// No description provided for @payAllPendingButton.
  ///
  /// In en, this message translates to:
  /// **'Pay all pending EMIs'**
  String get payAllPendingButton;

  /// No description provided for @confirmPayEmiTitle.
  ///
  /// In en, this message translates to:
  /// **'Mark EMI #{no} paid?'**
  String confirmPayEmiTitle(int no);

  /// No description provided for @confirmPayEmiMessage.
  ///
  /// In en, this message translates to:
  /// **'Confirm payment of {amount}.'**
  String confirmPayEmiMessage(String amount);

  /// No description provided for @paymentDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Payment date'**
  String get paymentDateLabel;

  /// No description provided for @confirmPayAllTitle.
  ///
  /// In en, this message translates to:
  /// **'Pay all pending EMIs?'**
  String get confirmPayAllTitle;

  /// No description provided for @confirmPayAllMessage.
  ///
  /// In en, this message translates to:
  /// **'This will mark {count} remaining EMIs ({amount}) as paid and generate the Loan Agreement PDF.'**
  String confirmPayAllMessage(int count, String amount);

  /// No description provided for @installmentLabel.
  ///
  /// In en, this message translates to:
  /// **'Installment #{no}'**
  String installmentLabel(int no);

  /// No description provided for @paidOnLabel.
  ///
  /// In en, this message translates to:
  /// **'Paid: {date}'**
  String paidOnLabel(String date);

  /// No description provided for @outOfOrderEmiError.
  ///
  /// In en, this message translates to:
  /// **'Please pay earlier pending installments in order first.'**
  String get outOfOrderEmiError;

  /// No description provided for @emiPaidSuccess.
  ///
  /// In en, this message translates to:
  /// **'Installment #{no} marked as paid.'**
  String emiPaidSuccess(int no);

  /// No description provided for @loanCompletedPdfGenerated.
  ///
  /// In en, this message translates to:
  /// **'Loan completed! Loan Agreement PDF saved to Documents.'**
  String get loanCompletedPdfGenerated;

  /// No description provided for @viewPdfAction.
  ///
  /// In en, this message translates to:
  /// **'View PDF'**
  String get viewPdfAction;

  /// No description provided for @openDocumentsAction.
  ///
  /// In en, this message translates to:
  /// **'Open Documents'**
  String get openDocumentsAction;

  /// No description provided for @progressPaidLabel.
  ///
  /// In en, this message translates to:
  /// **'{paid} of {total} EMIs paid'**
  String progressPaidLabel(int paid, int total);

  /// No description provided for @ledgerHeading.
  ///
  /// In en, this message translates to:
  /// **'Ledger History'**
  String get ledgerHeading;

  /// No description provided for @ledgerDebitLabel.
  ///
  /// In en, this message translates to:
  /// **'Debit'**
  String get ledgerDebitLabel;

  /// No description provided for @ledgerCreditLabel.
  ///
  /// In en, this message translates to:
  /// **'Credit'**
  String get ledgerCreditLabel;

  /// No description provided for @ledgerBalanceLabel.
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get ledgerBalanceLabel;

  /// No description provided for @documentsTitle.
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get documentsTitle;

  /// No description provided for @noDocumentsTitle.
  ///
  /// In en, this message translates to:
  /// **'No PDF documents yet'**
  String get noDocumentsTitle;

  /// No description provided for @noDocumentsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Loan Agreements appear here automatically once a loan is fully paid.'**
  String get noDocumentsSubtitle;

  /// No description provided for @viewPdfMenu.
  ///
  /// In en, this message translates to:
  /// **'View PDF'**
  String get viewPdfMenu;

  /// No description provided for @sharePdfMenu.
  ///
  /// In en, this message translates to:
  /// **'Share PDF'**
  String get sharePdfMenu;

  /// No description provided for @deletePdfMenu.
  ///
  /// In en, this message translates to:
  /// **'Delete PDF'**
  String get deletePdfMenu;

  /// No description provided for @editPdfMenu.
  ///
  /// In en, this message translates to:
  /// **'Edit PDF'**
  String get editPdfMenu;

  /// No description provided for @deletePdfConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete document?'**
  String get deletePdfConfirmTitle;

  /// No description provided for @deletePdfConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'This removes the generated Loan Agreement from Documents.'**
  String get deletePdfConfirmMessage;

  /// No description provided for @pagesCountLabel.
  ///
  /// In en, this message translates to:
  /// **'{count} pages'**
  String pagesCountLabel(int count);

  /// No description provided for @documentViewerTitle.
  ///
  /// In en, this message translates to:
  /// **'Loan Agreement Viewer'**
  String get documentViewerTitle;

  /// No description provided for @loanAgreementHeadline.
  ///
  /// In en, this message translates to:
  /// **'Loan Agreement'**
  String get loanAgreementHeadline;

  /// No description provided for @lenderDetailsHeading.
  ///
  /// In en, this message translates to:
  /// **'Lender Details'**
  String get lenderDetailsHeading;

  /// No description provided for @borrowerDetailsHeading.
  ///
  /// In en, this message translates to:
  /// **'Borrower Details'**
  String get borrowerDetailsHeading;

  /// No description provided for @installmentScheduleHeading.
  ///
  /// In en, this message translates to:
  /// **'Installment Schedule'**
  String get installmentScheduleHeading;

  /// No description provided for @generatedOnLabel.
  ///
  /// In en, this message translates to:
  /// **'Generated on'**
  String get generatedOnLabel;

  /// No description provided for @documentIdLabel.
  ///
  /// In en, this message translates to:
  /// **'Document ID'**
  String get documentIdLabel;

  /// No description provided for @pageOfLabel.
  ///
  /// In en, this message translates to:
  /// **'Page {current} of {total}'**
  String pageOfLabel(int current, int total);

  /// No description provided for @signatureLender.
  ///
  /// In en, this message translates to:
  /// **'Lender Signature'**
  String get signatureLender;

  /// No description provided for @signatureBorrower.
  ///
  /// In en, this message translates to:
  /// **'Borrower Signature'**
  String get signatureBorrower;

  /// No description provided for @editPdfTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit PDF'**
  String get editPdfTitle;

  /// No description provided for @snapshotNotice.
  ///
  /// In en, this message translates to:
  /// **'Changes only update this PDF snapshot and never alter the original loan or ledger.'**
  String get snapshotNotice;

  /// No description provided for @pdfLanguageLabel.
  ///
  /// In en, this message translates to:
  /// **'Document language'**
  String get pdfLanguageLabel;

  /// No description provided for @statusTextLabel.
  ///
  /// In en, this message translates to:
  /// **'Status label'**
  String get statusTextLabel;

  /// No description provided for @previewButton.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get previewButton;

  /// No description provided for @regeneratePdfButton.
  ///
  /// In en, this message translates to:
  /// **'Regenerate PDF'**
  String get regeneratePdfButton;

  /// No description provided for @pdfRegeneratedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Document regenerated successfully.'**
  String get pdfRegeneratedSuccess;

  /// No description provided for @shareReadyMessage.
  ///
  /// In en, this message translates to:
  /// **'Prepared {title} ({pages} pages) for sharing.'**
  String shareReadyMessage(String title, int pages);

  /// No description provided for @copyHtmlAction.
  ///
  /// In en, this message translates to:
  /// **'Copy HTML'**
  String get copyHtmlAction;

  /// No description provided for @htmlCopiedMessage.
  ///
  /// In en, this message translates to:
  /// **'A4 HTML copied to clipboard.'**
  String get htmlCopiedMessage;

  /// No description provided for @saveChangesButton.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChangesButton;

  /// No description provided for @profileUpdatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully.'**
  String get profileUpdatedSuccess;

  /// No description provided for @signOutConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign out?'**
  String get signOutConfirmTitle;

  /// No description provided for @signOutConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'You can sign back in anytime with your lender details.'**
  String get signOutConfirmMessage;

  /// No description provided for @totalLoansStatLabel.
  ///
  /// In en, this message translates to:
  /// **'Total loans'**
  String get totalLoansStatLabel;

  /// No description provided for @documentsStatLabel.
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get documentsStatLabel;

  /// No description provided for @backupTitle.
  ///
  /// In en, this message translates to:
  /// **'Backup and Restore'**
  String get backupTitle;

  /// No description provided for @backupSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Export an encrypted-ready local snapshot or restore your lending ledger.'**
  String get backupSubtitle;

  /// No description provided for @exportBackupButton.
  ///
  /// In en, this message translates to:
  /// **'Create Local Backup'**
  String get exportBackupButton;

  /// No description provided for @restoreBackupButton.
  ///
  /// In en, this message translates to:
  /// **'Restore Snapshot'**
  String get restoreBackupButton;

  /// No description provided for @backupGeneratedMessage.
  ///
  /// In en, this message translates to:
  /// **'Backup snapshot created and copied to clipboard.'**
  String get backupGeneratedMessage;

  /// No description provided for @restoreSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Backup snapshot restored successfully.'**
  String get restoreSuccessMessage;

  /// No description provided for @restoreInvalidError.
  ///
  /// In en, this message translates to:
  /// **'Invalid backup snapshot JSON.'**
  String get restoreInvalidError;

  /// No description provided for @pasteBackupHint.
  ///
  /// In en, this message translates to:
  /// **'Paste exported backup JSON here to restore'**
  String get pasteBackupHint;

  /// No description provided for @driveComingSoonNote.
  ///
  /// In en, this message translates to:
  /// **'Google Drive encrypted AppData sync is scheduled for Stage 6.'**
  String get driveComingSoonNote;

  /// No description provided for @emiPdfButton.
  ///
  /// In en, this message translates to:
  /// **'EMI PDF'**
  String get emiPdfButton;

  /// No description provided for @viewCompletePdfButton.
  ///
  /// In en, this message translates to:
  /// **'Complete Loan PDF'**
  String get viewCompletePdfButton;

  /// No description provided for @emiPdfGeneratedMessage.
  ///
  /// In en, this message translates to:
  /// **'Installment #{no} paid and PDF saved to Documents.'**
  String emiPdfGeneratedMessage(int no);

  /// No description provided for @emiReceiptTag.
  ///
  /// In en, this message translates to:
  /// **'EMI #{no} Receipt'**
  String emiReceiptTag(int no);

  /// No description provided for @completeLoanPdfTag.
  ///
  /// In en, this message translates to:
  /// **'Complete Loan PDF'**
  String get completeLoanPdfTag;

  /// No description provided for @emiCalculatorTitle.
  ///
  /// In en, this message translates to:
  /// **'EMI Calculator'**
  String get emiCalculatorTitle;

  /// No description provided for @emiCalculatorSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Estimate monthly payments, total interest, and repayment schedule before creating a loan.'**
  String get emiCalculatorSubtitle;

  /// No description provided for @principalShareLabel.
  ///
  /// In en, this message translates to:
  /// **'Principal share'**
  String get principalShareLabel;

  /// No description provided for @interestShareLabel.
  ///
  /// In en, this message translates to:
  /// **'Interest share'**
  String get interestShareLabel;

  /// No description provided for @resetFieldsButton.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get resetFieldsButton;

  /// No description provided for @proceedToCreateLoanButton.
  ///
  /// In en, this message translates to:
  /// **'Proceed to Create Loan'**
  String get proceedToCreateLoanButton;

  /// No description provided for @schedulePreviewHeading.
  ///
  /// In en, this message translates to:
  /// **'Schedule Preview'**
  String get schedulePreviewHeading;

  /// No description provided for @enterTermsForEstimate.
  ///
  /// In en, this message translates to:
  /// **'Enter principal, monthly rate, and duration to see your EMI estimate.'**
  String get enterTermsForEstimate;

  /// No description provided for @systemDefaultLanguage.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get systemDefaultLanguage;

  /// No description provided for @choosePhotoTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile photo'**
  String get choosePhotoTitle;

  /// No description provided for @pickFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from gallery'**
  String get pickFromGallery;

  /// No description provided for @takePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take photo'**
  String get takePhoto;

  /// No description provided for @removePhoto.
  ///
  /// In en, this message translates to:
  /// **'Remove photo'**
  String get removePhoto;

  /// No description provided for @changeAvatarColor.
  ///
  /// In en, this message translates to:
  /// **'Change badge color'**
  String get changeAvatarColor;

  /// No description provided for @photoPickFailedError.
  ///
  /// In en, this message translates to:
  /// **'Could not load selected image.'**
  String get photoPickFailedError;

  /// No description provided for @databaseError.
  ///
  /// In en, this message translates to:
  /// **'Could not save data locally. Please try again.'**
  String get databaseError;

  /// No description provided for @onboardingSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onboardingSkip;

  /// No description provided for @onboardingStart.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get onboardingStart;

  /// No description provided for @onboardingNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboardingNext;

  /// No description provided for @onboardingTitle1.
  ///
  /// In en, this message translates to:
  /// **'SMART LENDING HUB'**
  String get onboardingTitle1;

  /// No description provided for @onboardingSubtitle1.
  ///
  /// In en, this message translates to:
  /// **'Manage borrowers, create simple or compound loans, and stay organized offline.'**
  String get onboardingSubtitle1;

  /// No description provided for @onboardingTitle2.
  ///
  /// In en, this message translates to:
  /// **'TRACK EMIS & LEDGER'**
  String get onboardingTitle2;

  /// No description provided for @onboardingSubtitle2.
  ///
  /// In en, this message translates to:
  /// **'Monitor monthly installments, due dates, and collections at a glance.'**
  String get onboardingSubtitle2;

  /// No description provided for @onboardingTitle3.
  ///
  /// In en, this message translates to:
  /// **'INSTANT LOAN AGREEMENTS'**
  String get onboardingTitle3;

  /// No description provided for @onboardingSubtitle3.
  ///
  /// In en, this message translates to:
  /// **'Generate A4 Loan Agreements automatically in 13 languages once paid.'**
  String get onboardingSubtitle3;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'as',
    'bn',
    'en',
    'gu',
    'hi',
    'kn',
    'ml',
    'mr',
    'or',
    'pa',
    'ta',
    'te',
    'ur',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'as':
      return AppLocalizationsAs();
    case 'bn':
      return AppLocalizationsBn();
    case 'en':
      return AppLocalizationsEn();
    case 'gu':
      return AppLocalizationsGu();
    case 'hi':
      return AppLocalizationsHi();
    case 'kn':
      return AppLocalizationsKn();
    case 'ml':
      return AppLocalizationsMl();
    case 'mr':
      return AppLocalizationsMr();
    case 'or':
      return AppLocalizationsOr();
    case 'pa':
      return AppLocalizationsPa();
    case 'ta':
      return AppLocalizationsTa();
    case 'te':
      return AppLocalizationsTe();
    case 'ur':
      return AppLocalizationsUr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
