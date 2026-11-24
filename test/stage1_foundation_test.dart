import 'package:flutter_test/flutter_test.dart';
import 'package:loan_management_app/app.dart';
import 'package:loan_management_app/core/error/failures.dart';
import 'package:loan_management_app/core/router/app_router.dart';
import 'package:loan_management_app/data/dao/user_dao.dart';
import 'package:loan_management_app/data/db/app_database.dart';
import 'package:loan_management_app/data/repositories/settings_repository.dart';
import 'package:loan_management_app/data/repositories/user_repository.dart';
import 'package:loan_management_app/domain/entities/lender_profile.dart';
import 'package:loan_management_app/domain/usecases/user_usecases.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _MockUserRepository extends Mock implements UserRepository {}

void main() {
  group('Router redirectFor rules', () {
    test('enforces splash -> login or dashboard redirects cleanly', () {
      expect(
        redirectFor(AuthBootstrapStatus.unknown, '/dashboard'),
        AppRoutePaths.splash,
      );
      expect(
        redirectFor(AuthBootstrapStatus.unknown, AppRoutePaths.splash),
        isNull,
      );
      expect(
        redirectFor(AuthBootstrapStatus.onboarding, AppRoutePaths.splash),
        AppRoutePaths.onboarding,
      );
      expect(
        redirectFor(AuthBootstrapStatus.onboarding, AppRoutePaths.onboarding),
        isNull,
      );
      expect(
        redirectFor(AuthBootstrapStatus.unauthenticated, AppRoutePaths.splash),
        AppRoutePaths.login,
      );
      expect(
        redirectFor(AuthBootstrapStatus.unauthenticated, AppRoutePaths.login),
        isNull,
      );
      expect(
        redirectFor(AuthBootstrapStatus.authenticated, AppRoutePaths.splash),
        AppRoutePaths.dashboard,
      );
      expect(
        redirectFor(AuthBootstrapStatus.authenticated, AppRoutePaths.onboarding),
        AppRoutePaths.dashboard,
      );
      expect(
        redirectFor(AuthBootstrapStatus.authenticated, AppRoutePaths.login),
        AppRoutePaths.dashboard,
      );
      expect(
        redirectFor(AuthBootstrapStatus.authenticated, AppRoutePaths.dashboard),
        isNull,
      );
    });
  });

  group('Sqflite AppDatabase, UserDao & UserUseCases', () {
    late AppDatabase appDb;
    late UserDao userDao;
    late SqliteUserRepository userRepo;

    setUp(() async {
      appDb = await AppDatabase.openInMemory();
      userDao = UserDao(appDb);
      userRepo = SqliteUserRepository(userDao);
    });

    tearDown(() async {
      await appDb.close();
    });

    test('creates all 6 tables, indexes, and enables PRAGMA foreign_keys',
        () async {
      final fkRows = await appDb.database.rawQuery('PRAGMA foreign_keys;');
      expect(fkRows.first.values.first, 1);

      final tableRows = await appDb.database.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%';",
      );
      final tableNames = tableRows.map((r) => r['name'] as String).toSet();
      expect(
        tableNames,
        containsAll(<String>[
          'users',
          'customers',
          'loans',
          'emis',
          'ledger',
          'documents',
        ]),
      );

      final indexRows = await appDb.database.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='index' AND name NOT LIKE 'sqlite_%';",
      );
      final indexNames = indexRows.map((r) => r['name'] as String).toSet();
      expect(
        indexNames,
        containsAll(<String>[
          'ux_customers_mobile',
          'ix_loans_customer_status',
          'ix_emis_loan_due_status',
          'ix_ledger_customer_created',
          'ix_documents_customer_mobile',
        ]),
      );
    });

    test('saves, updates as single row, and clears lender profile in users',
        () async {
      final getUseCase = GetLenderProfileUseCase(userRepo);
      final saveUseCase = SaveLenderProfileUseCase(userRepo);
      final signOutUseCase = SignOutUseCase(userRepo);

      final initial = await getUseCase();
      expect(initial.isSuccess, isTrue);
      expect(initial.dataOrNull, isNull);

      final invalidRes = await saveUseCase(
        const LenderProfile(
          name: 'Alex',
          mobile: '1234567890',
          email: 'alex@loanwise.in',
        ),
      );
      expect(invalidRes.failureOrNull?.type, FailureType.validation);

      final savedRes = await saveUseCase(
        const LenderProfile(
          name: 'Alex Johnson',
          mobile: '9876543210',
          email: 'alex@loanwise.in',
        ),
      );
      expect(savedRes.isSuccess, isTrue);
      expect(savedRes.dataOrNull?.id, 1);

      final updatedRes = await saveUseCase(
        const LenderProfile(
          name: 'Alex Updated',
          mobile: '9876543211',
          email: 'updated@loanwise.in',
          photoPath: '/tmp/avatar.jpg',
        ),
      );
      expect(updatedRes.isSuccess, isTrue);
      expect(updatedRes.dataOrNull?.id, 1);
      expect(updatedRes.dataOrNull?.photoPath, '/tmp/avatar.jpg');

      final rows = await appDb.database.query('users');
      expect(rows.length, 1);
      expect(rows.first['name'], 'Alex Updated');

      final cleared = await signOutUseCase();
      expect(cleared.isSuccess, isTrue);
      expect((await getUseCase()).dataOrNull, isNull);
    });

    test('SaveLenderProfileUseCase returns repository failure when mocked',
        () async {
      final mockRepo = _MockUserRepository();
      const profile = LenderProfile(
        name: 'Mohit Jangid',
        mobile: '9812345678',
        email: 'mohit@loanwise.in',
      );
      when(() => mockRepo.saveProfile(profile)).thenAnswer(
        (_) async => const Err<LenderProfile>(
          AppFailure(
            type: FailureType.database,
            messageKey: 'databaseError',
          ),
        ),
      );

      final useCase = SaveLenderProfileUseCase(mockRepo);
      final result = await useCase(profile);
      expect(result.failureOrNull?.type, FailureType.database);
      verify(() => mockRepo.saveProfile(profile)).called(1);
    });
  });

  group('SharedPreferencesSettingsRepository & persisted app bootstrap', () {
    test('persists theme mode and locale including System default', () async {
      SharedPreferences.setMockInitialValues(<String, Object>{});
      final prefs = await SharedPreferences.getInstance();
      final repo = SharedPreferencesSettingsRepository(prefs);

      expect(repo.loadThemeMode(), ThemeMode.light);
      expect(repo.loadLocale(), isNull);

      await repo.saveThemeMode(ThemeMode.dark);
      await repo.saveLocale(const Locale('ta'));

      expect(repo.loadThemeMode(), ThemeMode.dark);
      expect(repo.loadLocale(), const Locale('ta'));

      await repo.saveLocale(null);
      expect(repo.loadLocale(), isNull);

      expect(repo.hasSeenOnboarding(), isFalse);
      await repo.saveOnboardingSeen(true);
      expect(repo.hasSeenOnboarding(), isTrue);
    });

    testWidgets(
      'LoanWiseApp persists sign-in in SQLite, skips login on second launch, and switches theme/language',
      (WidgetTester tester) async {
        SharedPreferences.setMockInitialValues(<String, Object>{});
        final prefs = await SharedPreferences.getInstance();
        final db = await AppDatabase.openInMemory();
        addTearDown(() async => db.close());

        // First launch: no profile & onboarding unseen -> Splash -> Onboarding -> Login.
        await tester.pumpWidget(
          LoanWiseApp(
            appDatabase: db,
            sharedPreferences: prefs,
          ),
        );
        await tester.pump(const Duration(milliseconds: 3500));
        await tester.pump(const Duration(milliseconds: 500));
        await tester.pump(const Duration(milliseconds: 400));

        expect(
          find.byKey(const ValueKey('onboarding_skip_button')),
          findsOneWidget,
        );
        await tester.tap(find.byKey(const ValueKey('onboarding_skip_button')));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 400));

        expect(prefs.getBool('loanwise_onboarding_seen'), isTrue);
        expect(find.byKey(const ValueKey('login_name_field')), findsOneWidget);

        await tester.enterText(
          find.byKey(const ValueKey('login_name_field')),
          'Sita Devi',
        );
        await tester.enterText(
          find.byKey(const ValueKey('login_mobile_field')),
          '9876543210',
        );
        await tester.enterText(
          find.byKey(const ValueKey('login_email_field')),
          'sita@loanwise.in',
        );
        await tester.pump();

        final signInBtn = find.byKey(const ValueKey('login_sign_in_button'));
        await tester.ensureVisible(signInBtn);
        await tester.tap(signInBtn);
        await tester.pump(const Duration(milliseconds: 350));
        await tester.pump(const Duration(milliseconds: 400));
        await tester.pumpAndSettle();

        expect(find.text('Total Lent'), findsOneWidget);
        final userRows = await db.database.query('users');
        expect(userRows.length, 1);
        expect(userRows.first['mobile'], '9876543210');

        // Open drawer -> switch language to Hindi -> check translated string & persistence.
        await tester.tap(find.byKey(const ValueKey('dashboard_menu_button')));
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const ValueKey('drawer_item_language')));
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const ValueKey('lang_option_hi')));
        await tester.pumpAndSettle();

        expect(find.text('कुल दिया गया ऋण'), findsOneWidget);
        expect(prefs.getString('loanwise_locale_code'), 'hi');

        // Open drawer -> switch theme to Dark -> check persistence.
        await tester.tap(find.byKey(const ValueKey('dashboard_menu_button')));
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const ValueKey('drawer_item_theme')));
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const ValueKey('theme_option_dark')));
        await tester.pumpAndSettle();
        await tester.tap(find.text('बंद करें'));
        await tester.pumpAndSettle();
        expect(prefs.getString('loanwise_theme_mode'), 'dark');

        // Second launch with the same SQLite DB & prefs skips Login and lands on Dashboard in Hindi.
        await tester.pumpWidget(
          LoanWiseApp(
            key: const ValueKey('second_launch'),
            appDatabase: db,
            sharedPreferences: prefs,
          ),
        );
        await tester.pump(const Duration(milliseconds: 3500));
        await tester.pump(const Duration(milliseconds: 500));
        await tester.pump(const Duration(milliseconds: 400));

        expect(find.text('कुल दिया गया ऋण'), findsOneWidget);
        expect(find.byKey(const ValueKey('login_name_field')), findsNothing);
      },
    );
  });
}
