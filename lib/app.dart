import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loan_management_app/core/error/failures.dart';
import 'package:loan_management_app/core/router/app_router.dart';
import 'package:loan_management_app/core/theme/app_theme.dart';
import 'package:loan_management_app/data/dao/loanwise_dao.dart';
import 'package:loan_management_app/data/dao/user_dao.dart';
import 'package:loan_management_app/data/db/app_database.dart';
import 'package:loan_management_app/data/repositories/settings_repository.dart';
import 'package:loan_management_app/data/repositories/user_repository.dart';
import 'package:loan_management_app/domain/entities/lender_profile.dart';
import 'package:loan_management_app/l10n/app_localizations.dart';
import 'package:loan_management_app/l10n/l10n_delegates.dart';
import 'package:loan_management_app/presentation/providers/app_providers.dart';
import 'package:loan_management_app/state/app_state.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoanWiseApp extends StatelessWidget {
  const LoanWiseApp({
    super.key,
    this.appState,
    this.showSplash = true,
    this.appDatabase,
    this.sharedPreferences,
    this.userRepository,
    this.settingsRepository,
  });

  final AppState? appState;
  final bool showSplash;
  final AppDatabase? appDatabase;
  final SharedPreferences? sharedPreferences;
  final UserRepository? userRepository;
  final SettingsRepository? settingsRepository;

  @override
  Widget build(BuildContext context) {
    final resolvedSettingsRepo = settingsRepository ??
        (sharedPreferences != null
            ? SharedPreferencesSettingsRepository(sharedPreferences!)
            : InMemorySettingsRepository(
                initialThemeMode: appState?.themeMode ?? ThemeMode.light,
                initialLocale: appState?.localeOverride,
              ));

    final resolvedUserRepo = userRepository ??
        (appDatabase != null
            ? SqliteUserRepository(UserDao(appDatabase!))
            : InMemoryUserRepository(
                initialProfile:
                    (appState != null && appState!.isSignedIn)
                        ? appState!.profile
                        : null,
              ));

    final resolvedDao = appDatabase != null ? LoanWiseDao(appDatabase!) : null;

    final resolvedAppState = appState ??
        AppState(
          initialThemeMode: resolvedSettingsRepo.loadThemeMode(),
          initialLocale: resolvedSettingsRepo.loadLocale(),
          initialHasSeenOnboarding: resolvedSettingsRepo.hasSeenOnboarding(),
        );

    return ProviderScope(
      overrides: [
        if (appDatabase != null)
          appDatabaseProvider.overrideWithValue(appDatabase!),
        userRepositoryProvider.overrideWithValue(resolvedUserRepo),
        settingsRepositoryProvider.overrideWithValue(resolvedSettingsRepo),
        appStateProvider.overrideWith((ref) {
          resolvedAppState.onPersistProfile = (profile) async {
            final res = await resolvedUserRepo.saveProfile(profile);
            if (res is Success<LenderProfile>) {
              ref.invalidate(lenderProfileProvider);
            }
          };
          resolvedAppState.onClearProfile = () async {
            await resolvedUserRepo.clearProfile();
            ref.invalidate(lenderProfileProvider);
          };
          resolvedAppState.onPersistThemeMode = (mode) async {
            await ref.read(themeModeProvider.notifier).setThemeMode(mode);
          };
          resolvedAppState.onPersistLocale = (locale) async {
            await ref.read(localeProvider.notifier).setLocale(locale);
          };
          resolvedAppState.onPersistOnboardingSeen =
              resolvedSettingsRepo.saveOnboardingSeen;
          if (resolvedDao != null) {
            resolvedAppState.onPersistCustomerUpsert =
                resolvedDao.upsertCustomer;
            resolvedAppState.onPersistCustomerDeleted =
                resolvedDao.softDeleteCustomer;
            resolvedAppState.onPersistLoanCreated =
                (loan, emis, disbursement) => resolvedDao.createLoanAtomic(
                      loan: loan,
                      emis: emis,
                      disbursement: disbursement,
                    );
            resolvedAppState.onPersistPaymentOutcome =
                (updatedLoan, paidEmis, ledgerEntries) =>
                    resolvedDao.recordEmiPaymentAtomic(
                      updatedLoan: updatedLoan,
                      paidEmis: paidEmis,
                      ledgerEntries: ledgerEntries,
                    );
            resolvedAppState.onPersistDocumentUpsert =
                resolvedDao.upsertDocument;
            resolvedAppState.onPersistDocumentDeleted =
                resolvedDao.deleteDocument;
            resolvedAppState.onPersistRestoreAll = ({
              required profile,
              required customers,
              required loans,
              required emisByLoan,
              required ledger,
              required documents,
            }) =>
                resolvedDao.replaceAllForRestore(
                  profile: profile,
                  customers: customers,
                  loans: loans,
                  emisByLoan: emisByLoan,
                  ledger: ledger,
                  documents: documents,
                );
          } else if (sharedPreferences != null) {
            Future<void> persistWebSnapshot() async {
              await sharedPreferences!.setString(
                'loanwise_web_store_json',
                resolvedAppState.store.exportBackupJson(),
              );
              await sharedPreferences!.setBool(
                'loanwise_web_signed_in',
                resolvedAppState.isSignedIn,
              );
            }

            resolvedAppState.onPersistProfile = (profile) async {
              await resolvedUserRepo.saveProfile(profile);
              ref.invalidate(lenderProfileProvider);
              await persistWebSnapshot();
            };
            resolvedAppState.onClearProfile = () async {
              await resolvedUserRepo.clearProfile();
              ref.invalidate(lenderProfileProvider);
              await persistWebSnapshot();
            };
            resolvedAppState.onPersistCustomerUpsert =
                (_) => persistWebSnapshot();
            resolvedAppState.onPersistCustomerDeleted =
                (_) => persistWebSnapshot();
            resolvedAppState.onPersistLoanCreated =
                (_, _, _) => persistWebSnapshot();
            resolvedAppState.onPersistPaymentOutcome =
                (_, _, _) => persistWebSnapshot();
            resolvedAppState.onPersistDocumentUpsert =
                (_) => persistWebSnapshot();
            resolvedAppState.onPersistDocumentDeleted =
                (_) => persistWebSnapshot();
            resolvedAppState.onPersistRestoreAll = ({
              required profile,
              required customers,
              required loans,
              required emisByLoan,
              required ledger,
              required documents,
            }) =>
                persistWebSnapshot();
          }
          return resolvedAppState;
        }),
      ],
      child: _LoanWiseRouterView(
        appState: resolvedAppState,
        userRepository: resolvedUserRepo,
        loanWiseDao: resolvedDao,
        settingsRepository: resolvedSettingsRepo,
        sharedPreferences: sharedPreferences,
        showSplash: showSplash,
        hasInjectedAppState: appState != null,
      ),
    );
  }
}

class _LoanWiseRouterView extends ConsumerStatefulWidget {
  const _LoanWiseRouterView({
    required this.appState,
    required this.userRepository,
    required this.loanWiseDao,
    required this.settingsRepository,
    required this.sharedPreferences,
    required this.showSplash,
    required this.hasInjectedAppState,
  });

  final AppState appState;
  final UserRepository userRepository;
  final LoanWiseDao? loanWiseDao;
  final SettingsRepository settingsRepository;
  final SharedPreferences? sharedPreferences;
  final bool showSplash;
  final bool hasInjectedAppState;

  @override
  ConsumerState<_LoanWiseRouterView> createState() =>
      _LoanWiseRouterViewState();
}

class _LoanWiseRouterViewState extends ConsumerState<_LoanWiseRouterView> {
  late final RouterSessionController _sessionController;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    // Keep Riverpod appStateProvider wired immediately for persistence callbacks.
    ref.read(appStateProvider);

    _sessionController = RouterSessionController(
      appState: widget.appState,
      splashCompleted: !widget.showSplash,
      profileLoaded: widget.hasInjectedAppState,
    );
    _router = createAppRouter(
      appState: widget.appState,
      sessionController: _sessionController,
    );

    if (!widget.hasInjectedAppState) {
      _bootstrapFromStorage();
    }
  }

  Future<void> _bootstrapFromStorage() async {
    final res = await widget.userRepository.getProfile();
    final dbSnapshot = widget.loanWiseDao != null
        ? await widget.loanWiseDao!.loadAll()
        : null;
    if (!mounted) return;

    LenderProfile? profile = res.dataOrNull ?? dbSnapshot?.profile;
    if (widget.loanWiseDao == null && widget.sharedPreferences != null) {
      final rawJson =
          widget.sharedPreferences!.getString('loanwise_web_store_json');
      final signedIn =
          widget.sharedPreferences!.getBool('loanwise_web_signed_in') ?? false;
      if (rawJson != null && rawJson.isNotEmpty) {
        widget.appState.store.restoreFromBackupJson(rawJson);
      }
      if (signedIn && profile == null) {
        profile = widget.appState.store.profile;
      }
    }

    widget.appState.hydrateFromRepositories(
      profile: profile,
      themeMode: widget.settingsRepository.loadThemeMode(),
      localeOverride: widget.settingsRepository.loadLocale(),
      applyLocaleOverride: true,
      hasSeenOnboarding: widget.settingsRepository.hasSeenOnboarding(),
      customers: dbSnapshot?.customers,
      loans: dbSnapshot?.loans,
      emisByLoan: dbSnapshot?.emisByLoan,
      ledger: dbSnapshot?.ledger,
      documents: dbSnapshot?.documents,
      maxIdSeq: dbSnapshot?.maxNumericId,
    );
    _sessionController.markProfileLoaded();
  }

  @override
  void dispose() {
    _router.dispose();
    _sessionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.appState,
      builder: (context, _) {
        return MaterialApp.router(
          title: 'LoanWise',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          themeMode: widget.appState.themeMode,
          locale: widget.appState.localeOverride,
          localizationsDelegates: loanWiseLocalizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: _router,
        );
      },
    );
  }
}
