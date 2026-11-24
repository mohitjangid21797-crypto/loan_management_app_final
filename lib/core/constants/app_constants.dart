class AppConstants {
  const AppConstants._();

  static const String appName = 'LoanWise';
  static const String databaseFileName = 'loanwise.db';
  static const int databaseVersion = 2;

  static const String prefsThemeModeKey = 'loanwise_theme_mode';
  static const String prefsLocaleCodeKey = 'loanwise_locale_code';
  static const String prefsOnboardingSeenKey = 'loanwise_onboarding_seen';
  static const String profileAvatarsDirName = 'profile_avatars';

  static const String mobileRegexPattern = r'^[6-9]\d{9}$';
  static const int minTenureMonths = 1;
  static const int maxTenureMonths = 600;
  static const double minMonthlyRatePercent = 0.0;
  static const double maxMonthlyRatePercent = 100.0;
}
