import 'package:loan_management_app/core/constants/app_constants.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SettingsRepository {
  ThemeMode loadThemeMode();
  Future<void> saveThemeMode(ThemeMode mode);

  /// Returns `null` when set to System default.
  Locale? loadLocale();
  Future<void> saveLocale(Locale? locale);

  bool hasSeenOnboarding();
  Future<void> saveOnboardingSeen(bool seen);
}

class SharedPreferencesSettingsRepository implements SettingsRepository {
  const SharedPreferencesSettingsRepository(this._prefs);

  final SharedPreferences _prefs;

  @override
  ThemeMode loadThemeMode() {
    final raw = _prefs.getString(AppConstants.prefsThemeModeKey);
    return switch (raw) {
      'dark' => ThemeMode.dark,
      'system' => ThemeMode.system,
      _ => ThemeMode.light,
    };
  }

  @override
  Future<void> saveThemeMode(ThemeMode mode) async {
    await _prefs.setString(AppConstants.prefsThemeModeKey, mode.name);
  }

  @override
  Locale? loadLocale() {
    final code = _prefs.getString(AppConstants.prefsLocaleCodeKey);
    if (code == null || code.trim().isEmpty || code == 'system') {
      return null;
    }
    return Locale(code);
  }

  @override
  Future<void> saveLocale(Locale? locale) async {
    if (locale == null) {
      await _prefs.remove(AppConstants.prefsLocaleCodeKey);
    } else {
      await _prefs.setString(
        AppConstants.prefsLocaleCodeKey,
        locale.languageCode,
      );
    }
  }

  @override
  bool hasSeenOnboarding() {
    return _prefs.getBool(AppConstants.prefsOnboardingSeenKey) ?? false;
  }

  @override
  Future<void> saveOnboardingSeen(bool seen) async {
    await _prefs.setBool(AppConstants.prefsOnboardingSeenKey, seen);
  }
}

class InMemorySettingsRepository implements SettingsRepository {
  InMemorySettingsRepository({
    ThemeMode initialThemeMode = ThemeMode.light,
    Locale? initialLocale,
    bool initialOnboardingSeen = false,
  })  : _themeMode = initialThemeMode,
        _locale = initialLocale,
        _onboardingSeen = initialOnboardingSeen;

  ThemeMode _themeMode;
  Locale? _locale;
  bool _onboardingSeen;

  @override
  ThemeMode loadThemeMode() => _themeMode;

  @override
  Future<void> saveThemeMode(ThemeMode mode) async {
    _themeMode = mode;
  }

  @override
  Locale? loadLocale() => _locale;

  @override
  Future<void> saveLocale(Locale? locale) async {
    _locale = locale;
  }

  @override
  bool hasSeenOnboarding() => _onboardingSeen;

  @override
  Future<void> saveOnboardingSeen(bool seen) async {
    _onboardingSeen = seen;
  }
}
