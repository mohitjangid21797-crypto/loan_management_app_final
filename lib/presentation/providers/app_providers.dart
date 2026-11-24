import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loan_management_app/core/error/failures.dart';
import 'package:loan_management_app/data/dao/loanwise_dao.dart';
import 'package:loan_management_app/data/dao/user_dao.dart';
import 'package:loan_management_app/data/db/app_database.dart';
import 'package:loan_management_app/data/repositories/settings_repository.dart';
import 'package:loan_management_app/data/repositories/user_repository.dart';
import 'package:loan_management_app/domain/entities/lender_profile.dart';
import 'package:loan_management_app/domain/usecases/user_usecases.dart';
import 'package:loan_management_app/state/app_state.dart';
import 'package:material_ui/material_ui.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  throw UnimplementedError('appDatabaseProvider must be overridden');
});

final userDaoProvider = Provider<UserDao>((ref) {
  return UserDao(ref.watch(appDatabaseProvider));
});

final loanWiseDaoProvider = Provider<LoanWiseDao>((ref) {
  return LoanWiseDao(ref.watch(appDatabaseProvider));
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return SqliteUserRepository(ref.watch(userDaoProvider));
});

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return InMemorySettingsRepository();
});

final getLenderProfileUseCaseProvider = Provider<GetLenderProfileUseCase>((ref) {
  return GetLenderProfileUseCase(ref.watch(userRepositoryProvider));
});

final saveLenderProfileUseCaseProvider = Provider<SaveLenderProfileUseCase>((ref) {
  return SaveLenderProfileUseCase(ref.watch(userRepositoryProvider));
});

final signOutUseCaseProvider = Provider<SignOutUseCase>((ref) {
  return SignOutUseCase(ref.watch(userRepositoryProvider));
});

class LenderProfileNotifier extends AsyncNotifier<LenderProfile?> {
  @override
  Future<LenderProfile?> build() async {
    final res = await ref.read(getLenderProfileUseCaseProvider).call();
    return switch (res) {
      Success<LenderProfile?>(:final data) => data,
      Err<LenderProfile?>(:final failure) => throw failure,
    };
  }

  Future<Result<LenderProfile>> saveProfile(LenderProfile profile) async {
    final res = await ref.read(saveLenderProfileUseCaseProvider).call(profile);
    if (res case Success<LenderProfile>(:final data)) {
      state = AsyncData<LenderProfile?>(data);
    }
    return res;
  }

  Future<Result<void>> signOut() async {
    final res = await ref.read(signOutUseCaseProvider).call();
    if (res.isSuccess) {
      state = const AsyncData<LenderProfile?>(null);
    }
    return res;
  }
}

final lenderProfileProvider =
    AsyncNotifierProvider<LenderProfileNotifier, LenderProfile?>(
  LenderProfileNotifier.new,
);

class ThemeModeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    return ref.watch(settingsRepositoryProvider).loadThemeMode();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    if (state == mode) return;
    state = mode;
    await ref.read(settingsRepositoryProvider).saveThemeMode(mode);
  }
}

final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(
  ThemeModeNotifier.new,
);

class LocaleNotifier extends Notifier<Locale?> {
  @override
  Locale? build() {
    return ref.watch(settingsRepositoryProvider).loadLocale();
  }

  Future<void> setLocale(Locale? locale) async {
    if (state == locale) return;
    state = locale;
    await ref.read(settingsRepositoryProvider).saveLocale(locale);
  }
}

final localeProvider = NotifierProvider<LocaleNotifier, Locale?>(
  LocaleNotifier.new,
);

final appStateProvider = ChangeNotifierProvider<AppState>((ref) {
  final settingsRepo = ref.watch(settingsRepositoryProvider);
  final userRepo = ref.watch(userRepositoryProvider);
  final appState = AppState(
    initialThemeMode: settingsRepo.loadThemeMode(),
    initialLocale: settingsRepo.loadLocale(),
  );

  appState.onPersistProfile = (profile) async {
    final res = await userRepo.saveProfile(profile);
    if (res is Success<LenderProfile>) {
      ref.invalidate(lenderProfileProvider);
    }
  };
  appState.onClearProfile = () async {
    await userRepo.clearProfile();
    ref.invalidate(lenderProfileProvider);
  };
  appState.onPersistThemeMode = (mode) async {
    await ref.read(themeModeProvider.notifier).setThemeMode(mode);
  };
  appState.onPersistLocale = (locale) async {
    await ref.read(localeProvider.notifier).setLocale(locale);
  };

  return appState;
});
