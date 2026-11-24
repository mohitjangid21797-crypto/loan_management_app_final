import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:loan_management_app/core/error/failures.dart';
import 'package:loan_management_app/core/theme/app_theme.dart';
import 'package:loan_management_app/core/utils/indian_currency_formatter.dart';
import 'package:loan_management_app/data/repositories/loanwise_store.dart';
import 'package:loan_management_app/domain/models/loan_models.dart';
import 'package:loan_management_app/l10n/app_localizations.dart';
import 'package:loan_management_app/l10n/l10n_delegates.dart';
import 'package:loan_management_app/l10n/supported_languages.dart';
import 'package:loan_management_app/main.dart';
import 'package:loan_management_app/presentation/screens/backup/backup_restore_screen.dart';
import 'package:loan_management_app/presentation/screens/customers/add_edit_customer_screen.dart';
import 'package:loan_management_app/presentation/screens/customers/customer_detail_screen.dart';
import 'package:loan_management_app/presentation/screens/customers/customers_tab.dart';
import 'package:loan_management_app/presentation/screens/dashboard/dashboard_screen.dart';
import 'package:loan_management_app/presentation/screens/dashboard/profile_tab.dart';
import 'package:loan_management_app/presentation/screens/documents/documents_screen.dart';
import 'package:loan_management_app/presentation/screens/documents/edit_pdf_screen.dart';
import 'package:loan_management_app/presentation/screens/loans/create_loan_screen.dart';
import 'package:loan_management_app/presentation/screens/loans/emi_calculator_screen.dart';
import 'package:loan_management_app/presentation/screens/loans/loan_overview_screen.dart';
import 'package:loan_management_app/presentation/screens/loans/loans_tab.dart';
import 'package:loan_management_app/presentation/screens/login/login_screen.dart';
import 'package:loan_management_app/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:loan_management_app/presentation/screens/splash/splash_screen.dart';
import 'package:loan_management_app/state/app_state.dart';

Widget _wrapScreen({
  required Widget child,
  ThemeMode themeMode = ThemeMode.light,
  Locale locale = const Locale('en'),
  double textScale = 1.0,
  bool disableAnimations = true,
}) {
  return MaterialApp(
    theme: AppTheme.light(),
    darkTheme: AppTheme.dark(),
    themeMode: themeMode,
    locale: locale,
    localizationsDelegates: loanWiseLocalizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    builder: (context, widget) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler: TextScaler.linear(textScale),
          disableAnimations: disableAnimations,
        ),
        child: widget!,
      );
    },
    home: child,
  );
}

void main() {
  group('Splash & Navigation flow', () {
    testWidgets(
      'first launch runs Splash -> 3-slide Onboarding -> Login',
      (WidgetTester tester) async {
        final appState = AppState(
          initialSignedIn: false,
          initialHasSeenOnboarding: false,
        );
        await tester.pumpWidget(LoanWiseApp(appState: appState));
        expect(find.bySemanticsLabel('LoanWise'), findsOneWidget);
        expect(
          find.byKey(const ValueKey('splash_brand_wordmark')),
          findsOneWidget,
        );

        await tester.pump(const Duration(milliseconds: 3500));
        await tester.pump(const Duration(milliseconds: 500));
        await tester.pump(const Duration(milliseconds: 400));

        // Slide 1
        expect(find.text('SMART LENDING HUB'), findsOneWidget);
        expect(
          find.byKey(const ValueKey('onboarding_skip_button')),
          findsOneWidget,
        );

        // Tap dot 2 -> Slide 2
        await tester.tap(find.byKey(const ValueKey('onboarding_dot_1')));
        await tester.pumpAndSettle();
        expect(find.text('TRACK EMIS & LEDGER'), findsOneWidget);
        expect(
          find.byKey(const ValueKey('onboarding_skip_button')),
          findsOneWidget,
        );

        // Swipe left -> Slide 3 -> shows Start pill
        await tester.drag(
          find.byKey(const ValueKey('onboarding_page_view')),
          const Offset(-400, 0),
        );
        await tester.pumpAndSettle();
        expect(find.text('INSTANT LOAN AGREEMENTS'), findsOneWidget);
        expect(
          find.byKey(const ValueKey('onboarding_start_button')),
          findsOneWidget,
        );

        await tester.tap(find.byKey(const ValueKey('onboarding_start_button')));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 400));

        expect(appState.hasSeenOnboarding, isTrue);
        expect(find.byKey(const ValueKey('login_name_field')), findsOneWidget);
      },
    );

    testWidgets(
      'subsequent unauthenticated launch skips Onboarding and opens Login',
      (WidgetTester tester) async {
        final appState = AppState(
          initialSignedIn: false,
          initialHasSeenOnboarding: true,
        );
        await tester.pumpWidget(LoanWiseApp(appState: appState));
        expect(find.bySemanticsLabel('LoanWise'), findsOneWidget);

        await tester.pump(const Duration(milliseconds: 3500));
        await tester.pump(const Duration(milliseconds: 500));
        await tester.pump(const Duration(milliseconds: 400));

        expect(find.byKey(const ValueKey('login_name_field')), findsOneWidget);
      },
    );

    testWidgets('signed-in launch skips Login and lands on Dashboard', (
      WidgetTester tester,
    ) async {
      final appState = AppState(initialSignedIn: true);
      await tester.pumpWidget(LoanWiseApp(appState: appState));
      expect(find.bySemanticsLabel('LoanWise'), findsOneWidget);

      await tester.pump(const Duration(milliseconds: 3500));
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pump(const Duration(milliseconds: 400));

      expect(find.text('Total Lent'), findsOneWidget);
      expect(find.byKey(const ValueKey('login_name_field')), findsNothing);
    });
  });

  group('LoginScreen widget tests', () {
    testWidgets('renders three fields and disabled/enabled Sign in button', (
      WidgetTester tester,
    ) async {
      final appState = AppState();
      await tester.pumpWidget(
        _wrapScreen(
          child: LoginScreen(
            appState: appState,
            saveDelay: Duration.zero,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byKey(const ValueKey('login_name_field')), findsOneWidget);
      expect(find.byKey(const ValueKey('login_mobile_field')), findsOneWidget);
      expect(find.byKey(const ValueKey('login_email_field')), findsOneWidget);
      expect(find.byKey(const ValueKey('login_sign_in_button')), findsOneWidget);
      expect(find.text('Login'), findsOneWidget);

      await tester.tap(find.byKey(const ValueKey('login_sign_in_button')));
      await tester.pump();
      expect(appState.isSignedIn, isFalse);

      await tester.enterText(
        find.byKey(const ValueKey('login_name_field')),
        'Alex Johnson',
      );
      await tester.enterText(
        find.byKey(const ValueKey('login_mobile_field')),
        '1234567890',
      );
      await tester.enterText(
        find.byKey(const ValueKey('login_email_field')),
        'invalid-email',
      );
      await tester.pump();

      await tester.tap(find.byKey(const ValueKey('login_name_field')));
      await tester.pump();
      expect(
        find.text('Enter a 10 digit mobile number starting with 6 to 9'),
        findsOneWidget,
      );
      expect(find.text('Enter a valid email address'), findsOneWidget);
      expect(appState.isSignedIn, isFalse);

      await tester.enterText(
        find.byKey(const ValueKey('login_mobile_field')),
        '9876543210',
      );
      await tester.enterText(
        find.byKey(const ValueKey('login_email_field')),
        'alex@loanwise.in',
      );
      await tester.pump();

      final buttonFinder = find.byKey(const ValueKey('login_sign_in_button'));
      await tester.ensureVisible(buttonFinder);
      await tester.tap(buttonFinder);
      await tester.pump(const Duration(milliseconds: 50));
      await tester.pumpAndSettle();
      expect(appState.isSignedIn, isTrue);
      expect(appState.profile.name, 'Alex Johnson');
    });

    for (final width in [320.0, 360.0, 412.0]) {
      testWidgets(
        'login layout reports no overflow at ${width.toInt()}dp and font scale 1.5',
        (WidgetTester tester) async {
          tester.view.physicalSize = Size(width, 760);
          tester.view.devicePixelRatio = 1.0;
          addTearDown(tester.view.reset);

          final errors = <FlutterErrorDetails>[];
          final prevOnError = FlutterError.onError;
          FlutterError.onError = (details) {
            errors.add(details);
          };
          addTearDown(() {
            FlutterError.onError = prevOnError;
          });

          final appState = AppState();
          await tester.pumpWidget(
            _wrapScreen(
              textScale: 1.5,
              child: LoginScreen(appState: appState),
            ),
          );
          await tester.pumpAndSettle();

          expect(errors, isEmpty, reason: 'No layout overflow expected');
        },
      );
    }
  });

  group('DashboardScreen widget tests', () {
    testWidgets(
      'shows live computed totals, 6 quick actions, 4 nav tabs, and drawer with 3 items',
      (WidgetTester tester) async {
        final appState = AppState(
          initialSignedIn: true,
          initialProfile: const LenderProfile(
            name: 'Sita Devi',
            mobile: '9812345678',
            email: 'sita@example.in',
          ),
        );
        await tester.pumpWidget(
          _wrapScreen(
            child: DashboardScreen(appState: appState),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Total Lent'), findsOneWidget);
        expect(find.text(IndianCurrencyFormatter.format(0)), findsAtLeastNWidgets(1));
        expect(find.text('0%'), findsOneWidget);
        expect(find.text('0'), findsAtLeastNWidgets(3));
        expect(find.text('Quick Actions'), findsOneWidget);

        // Creating a real customer and loan updates dashboard total live.
        final cRes = appState.createCustomer(
          name: 'Meera Nair',
          email: 'meera@example.in',
          mobile: '9876501234',
          location: 'Kochi',
        );
        final customer = (cRes as Success<Customer>).data;
        appState.createLoan(
          customerId: customer.id,
          principalPaise: 5000000,
          monthlyRatePercent: 2.0,
          tenureMonths: 6,
          type: LoanType.simple,
          startDate: DateTime.now().toUtc(),
        );
        await tester.pumpAndSettle();
        expect(find.text('₹50,000.00'), findsAtLeastNWidgets(1));

        for (int i = 0; i < 6; i++) {
          expect(find.byKey(ValueKey('quick_action_$i')), findsOneWidget);
        }

        for (int i = 0; i < 4; i++) {
          expect(find.byKey(ValueKey('bottom_nav_tab_$i')), findsOneWidget);
        }

        await tester.tap(find.byKey(const ValueKey('dashboard_menu_button')));
        await tester.pumpAndSettle();

        expect(find.byKey(const ValueKey('drawer_item_backup')), findsOneWidget);
        expect(find.byKey(const ValueKey('drawer_item_theme')), findsOneWidget);
        expect(
          find.byKey(const ValueKey('drawer_item_language')),
          findsOneWidget,
        );
      },
    );

    testWidgets('switching theme and language updates UI immediately', (
      WidgetTester tester,
    ) async {
      final appState = AppState(initialSignedIn: true);
      await tester.pumpWidget(
        LoanWiseApp(appState: appState, showSplash: false),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const ValueKey('dashboard_menu_button')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('drawer_item_theme')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('theme_option_dark')));
      await tester.pumpAndSettle();
      expect(appState.themeMode, ThemeMode.dark);
      await tester.tap(find.text('Close'));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const ValueKey('dashboard_menu_button')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('drawer_item_language')));
      await tester.pumpAndSettle();

      expect(kSupportedLanguageOptions.length, 13);
      await tester.tap(find.byKey(const ValueKey('lang_option_hi')));
      await tester.pumpAndSettle();

      expect(appState.locale.languageCode, 'hi');
      expect(find.text('त्वरित कार्य'), findsOneWidget);
    });

    testWidgets('shows friendly empty states when store has no loans', (
      WidgetTester tester,
    ) async {
      final appState = AppState(
        initialSignedIn: true,
        store: LoanWiseStore.empty(isSignedIn: true),
      );
      await tester.pumpWidget(
        _wrapScreen(
          child: DashboardScreen(appState: appState),
        ),
      );
      await tester.pumpAndSettle();

      final emptyRecentFinder = find.text(
        'No recent loans yet. Create a loan to see activity here.',
      );
      await tester.scrollUntilVisible(
        emptyRecentFinder,
        200,
        scrollable: find.byType(Scrollable).first,
      );
      expect(emptyRecentFinder, findsOneWidget);

      final emptyOverdueFinder = find.text(
        'All caught up. No overdue EMIs at the moment.',
      );
      await tester.scrollUntilVisible(
        emptyOverdueFinder,
        200,
        scrollable: find.byType(Scrollable).first,
      );
      expect(emptyOverdueFinder, findsOneWidget);
    });
  });

  group('End-to-end Customer -> Loan -> Pay All -> Documents -> Edit PDF', () {
    testWidgets(
      'creates customer, auto-selects on Create Loan, pays all EMIs, views & edits PDF snapshot',
      (WidgetTester tester) async {
        final appState = AppState(
          initialSignedIn: true,
          store: LoanWiseStore.empty(isSignedIn: true),
        );
        await tester.pumpWidget(
          LoanWiseApp(appState: appState, showSplash: false),
        );
        await tester.pumpAndSettle();

        // 1. Add customer from Quick Action 0 -> Create Loan suggestion dialog.
        await tester.tap(find.byKey(const ValueKey('quick_action_0')));
        await tester.pumpAndSettle();

        await tester.enterText(
          find.byKey(const ValueKey('customer_name_field')),
          'Meera Nair',
        );
        await tester.enterText(
          find.byKey(const ValueKey('customer_mobile_field')),
          '9876501234',
        );
        await tester.enterText(
          find.byKey(const ValueKey('customer_email_field')),
          'meera@example.in',
        );
        await tester.enterText(
          find.byKey(const ValueKey('customer_location_field')),
          'Kochi',
        );
        await tester.tap(find.byKey(const ValueKey('save_customer_button')));
        await tester.pumpAndSettle();

        expect(find.text('Customer added successfully'), findsOneWidget);
        await tester.tap(
          find.byKey(const ValueKey('customer_added_create_loan_button')),
        );
        await tester.pumpAndSettle();

        // 2. Customer auto-selected in CreateLoanScreen; fill principal and verify live preview.
        expect(
          find.byKey(const ValueKey('selected_customer_card')),
          findsOneWidget,
        );
        await tester.enterText(
          find.byKey(const ValueKey('create_loan_principal')),
          '10000',
        );
        await tester.enterText(
          find.byKey(const ValueKey('create_loan_rate')),
          '2',
        );
        await tester.enterText(
          find.byKey(const ValueKey('create_loan_tenure')),
          '3',
        );
        await tester.pumpAndSettle();
        expect(
          find.byKey(const ValueKey('live_emi_preview_card')),
          findsOneWidget,
        );

        await tester.ensureVisible(
          find.byKey(const ValueKey('create_loan_submit_button')),
        );
        await tester.tap(
          find.byKey(const ValueKey('create_loan_submit_button')),
        );
        await tester.pumpAndSettle();

        expect(find.text('Loan created successfully'), findsOneWidget);
        await tester.tap(
          find.byKey(const ValueKey('dialog_open_loan_overview')),
        );
        await tester.pumpAndSettle();

        // 3. Loan Overview: pay all pending EMIs -> PDF auto-generated -> Open Documents.
        expect(find.text('Loan Overview'), findsOneWidget);
        await tester.tap(find.byKey(const ValueKey('pay_all_pending_button')));
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const ValueKey('confirm_pay_all_button')));
        await tester.pumpAndSettle();

        expect(appState.documents.length, 1);
        expect(appState.loans.first.status, LoanStatus.completed);

        await tester.tap(find.byKey(const ValueKey('snackbar_open_documents')));
        await tester.pumpAndSettle();

        // 4. Documents grouped by mobile; open menu -> Edit PDF -> change borrower name & language -> Regenerate.
        expect(find.text('Meera Nair · 9876501234'), findsOneWidget);
        final docId = appState.documents.first.id;
        await tester.tap(find.byKey(ValueKey('doc_menu_$docId')));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Edit PDF'));
        await tester.pumpAndSettle();

        await tester.enterText(
          find.byKey(const ValueKey('edit_pdf_name')),
          'Meera R. Nair',
        );
        await tester.ensureVisible(
          find.byKey(const ValueKey('edit_pdf_regenerate_button')),
        );
        await tester.tap(
          find.byKey(const ValueKey('edit_pdf_regenerate_button')),
        );
        await tester.pumpAndSettle();

        // Snapshot changed, original customer record stays intact, and no duplicate doc created.
        expect(appState.documents.length, 1);
        expect(
          appState.documents.first.snapshot.borrowerName,
          'Meera R. Nair',
        );
        expect(appState.customers.first.name, 'Meera Nair');
      },
    );

    testWidgets(
      'LoanOverviewScreen generates PDF on each paid EMI and Complete PDF on pay all',
      (WidgetTester tester) async {
        final appState = AppState(
          initialSignedIn: true,
          initialProfile: const LenderProfile(
            name: 'Sita Devi',
            mobile: '9812345678',
            email: 'sita@example.in',
          ),
        );
        final customer = (appState.createCustomer(
          name: 'Meera Nair',
          email: 'meera@example.in',
          mobile: '9876501234',
          location: 'Kochi',
        ) as Success<Customer>)
            .data;
        final loan = (appState.createLoan(
          customerId: customer.id,
          principalPaise: 3000000,
          monthlyRatePercent: 2.0,
          tenureMonths: 3,
          type: LoanType.simple,
          startDate: DateTime.utc(2026, 1, 10),
        ) as Success<Loan>)
            .data;

        await tester.pumpWidget(
          _wrapScreen(
            child: LoanOverviewScreen(appState: appState, loanId: loan.id),
          ),
        );
        await tester.pumpAndSettle();

        // Pay EMI #1 individually -> EMI #1 receipt PDF generated & EMI PDF button shown.
        await tester.ensureVisible(find.byKey(const ValueKey('pay_emi_1')));
        await tester.tap(find.byKey(const ValueKey('pay_emi_1')));
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const ValueKey('confirm_pay_emi_button')));
        await tester.pumpAndSettle();

        expect(appState.documents.length, 1);
        expect(appState.documents.first.emiInstallmentNo, 1);
        expect(find.byKey(const ValueKey('emi_pdf_1')), findsOneWidget);

        // Tap EMI PDF button on row 1 -> opens DocumentViewerScreen for EMI #1.
        await tester.ensureVisible(find.byKey(const ValueKey('emi_pdf_1')));
        await tester.tap(find.byKey(const ValueKey('emi_pdf_1')));
        await tester.pumpAndSettle();
        expect(find.textContaining('EMI #1'), findsAtLeastNWidgets(1));

        // Return to LoanOverviewScreen and pay all remaining EMIs at once -> Complete Loan PDF.
        await tester.pageBack();
        await tester.pumpAndSettle();

        await tester.ensureVisible(
          find.byKey(const ValueKey('pay_all_pending_button')),
        );
        await tester.tap(find.byKey(const ValueKey('pay_all_pending_button')));
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const ValueKey('confirm_pay_all_button')));
        await tester.pumpAndSettle();

        expect(appState.loans.first.status, LoanStatus.completed);
        expect(
          appState.store.findDocumentForLoan(loan.id),
          isNotNull,
        );
        expect(
          find.byKey(const ValueKey('view_complete_pdf_button')),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'EmiCalculatorScreen starts at zero, estimates EMI live, resets, and hands off to CreateLoanScreen',
      (WidgetTester tester) async {
        final appState = AppState(initialSignedIn: true);
        await tester.pumpWidget(
          _wrapScreen(child: EmiCalculatorScreen(appState: appState)),
        );
        await tester.pumpAndSettle();

        expect(find.text('EMI Calculator'), findsOneWidget);
        expect(find.text('₹0.00'), findsAtLeastNWidgets(4));

        await tester.enterText(
          find.byKey(const ValueKey('emi_calc_principal_field')),
          '12000',
        );
        await tester.enterText(
          find.byKey(const ValueKey('emi_calc_rate_field')),
          '2',
        );
        await tester.enterText(
          find.byKey(const ValueKey('emi_calc_tenure_field')),
          '12',
        );
        await tester.pumpAndSettle();

        // Switch to Simple interest: 12000 + 2%*12 = 14880 total / 12 = 1240.00 monthly EMI.
        await tester.tap(find.text('Simple'));
        await tester.pumpAndSettle();
        expect(find.text('₹1,240.00'), findsOneWidget);
        expect(find.text('₹14,880.00'), findsOneWidget);

        // Toggle schedule preview.
        await tester.ensureVisible(
          find.byKey(const ValueKey('emi_calc_toggle_schedule')),
        );
        await tester.tap(
          find.byKey(const ValueKey('emi_calc_toggle_schedule')),
        );
        await tester.pumpAndSettle();
        expect(find.text('Installment #1'), findsOneWidget);

        // Proceed to CreateLoanScreen carries over terms cleanly.
        await tester.ensureVisible(
          find.byKey(const ValueKey('emi_calc_create_loan_button')),
        );
        await tester.tap(
          find.byKey(const ValueKey('emi_calc_create_loan_button')),
        );
        await tester.pumpAndSettle();

        expect(find.text('Create Loan'), findsAtLeastNWidgets(1));
        expect(find.text('12000'), findsOneWidget);
        expect(find.text('₹1,240.00'), findsOneWidget);

        // Back and reset returns all estimates to ₹0.00.
        await tester.pageBack();
        await tester.pumpAndSettle();
        await tester.ensureVisible(
          find.byKey(const ValueKey('emi_calc_reset_button')),
        );
        await tester.tap(find.byKey(const ValueKey('emi_calc_reset_button')));
        await tester.pumpAndSettle();
        expect(find.text('₹0.00'), findsAtLeastNWidgets(4));
      },
    );
  });

  group('Multi-screen overflow & font-scale 1.5 verification', () {
    for (final width in [320.0, 360.0, 412.0]) {
      testWidgets(
        'all key screens report no overflow at ${width.toInt()}dp and 1.5x scale',
        (WidgetTester tester) async {
          tester.view.physicalSize = Size(width, 820);
          tester.view.devicePixelRatio = 1.0;
          addTearDown(tester.view.reset);

          final errors = <FlutterErrorDetails>[];
          final prevOnError = FlutterError.onError;
          FlutterError.onError = (details) {
            errors.add(details);
          };
          addTearDown(() {
            FlutterError.onError = prevOnError;
          });

          final appState = AppState(
            initialSignedIn: true,
            initialProfile: const LenderProfile(
              name: 'Sita Devi',
              mobile: '9812345678',
              email: 'sita@example.in',
            ),
          );
          final customer = (appState.createCustomer(
            name: 'Meera Nair',
            email: 'meera@example.in',
            mobile: '9876501234',
            location: 'Kochi',
          ) as Success<Customer>)
              .data;
          final loan = (appState.createLoan(
            customerId: customer.id,
            principalPaise: 5000000,
            monthlyRatePercent: 2.0,
            tenureMonths: 3,
            type: LoanType.simple,
            startDate: DateTime.utc(2026, 1, 10),
          ) as Success<Loan>)
              .data;
          appState.payAllPendingEmis(
            loanId: loan.id,
            paidDate: DateTime.utc(2026, 1, 15),
          );
          final firstLoanId = loan.id;
          final firstDoc = appState.documents.first;

          for (final screen in [
            SplashScreen(appState: appState, onCompleted: () {}),
            OnboardingScreen(appState: appState, onFinished: () {}),
            DashboardScreen(appState: appState),
            Scaffold(
              body: CustomersTab(appState: appState, onOpenDrawer: () {}),
            ),
            CustomerDetailScreen(
              appState: appState,
              customerId: customer.id,
            ),
            AddEditCustomerScreen(appState: appState),
            Scaffold(
              body: LoansTab(appState: appState, onOpenDrawer: () {}),
            ),
            EmiCalculatorScreen(appState: appState),
            CreateLoanScreen(appState: appState),
            LoanOverviewScreen(appState: appState, loanId: firstLoanId),
            DocumentsScreen(appState: appState),
            EditPdfScreen(appState: appState, document: firstDoc),
            Scaffold(
              body: ProfileTab(appState: appState, onOpenDrawer: () {}),
            ),
            BackupRestoreScreen(appState: appState),
          ]) {
            await tester.pumpWidget(_wrapScreen(textScale: 1.5, child: screen));
            await tester.pumpAndSettle();
          }

          FlutterError.onError = prevOnError;
          expect(
            errors.map((e) => e.exceptionAsString()).toList(),
            isEmpty,
            reason: 'No overflow allowed at ${width.toInt()}dp',
          );
        },
      );
    }
  });
}
