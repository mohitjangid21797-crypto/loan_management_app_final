import 'package:flutter/widgets.dart';

class LanguageOption {
  const LanguageOption({
    required this.locale,
    required this.nativeName,
    required this.englishName,
  });

  final Locale locale;
  final String nativeName;
  final String englishName;
}

const List<LanguageOption> kSupportedLanguageOptions = [
  LanguageOption(
    locale: Locale('en'),
    nativeName: 'English',
    englishName: 'English',
  ),
  LanguageOption(
    locale: Locale('hi'),
    nativeName: 'हिन्दी',
    englishName: 'Hindi',
  ),
  LanguageOption(
    locale: Locale('bn'),
    nativeName: 'বাংলা',
    englishName: 'Bengali',
  ),
  LanguageOption(
    locale: Locale('te'),
    nativeName: 'తెలుగు',
    englishName: 'Telugu',
  ),
  LanguageOption(
    locale: Locale('mr'),
    nativeName: 'मराठी',
    englishName: 'Marathi',
  ),
  LanguageOption(
    locale: Locale('ta'),
    nativeName: 'தமிழ்',
    englishName: 'Tamil',
  ),
  LanguageOption(
    locale: Locale('gu'),
    nativeName: 'ગુજરાતી',
    englishName: 'Gujarati',
  ),
  LanguageOption(
    locale: Locale('kn'),
    nativeName: 'ಕನ್ನಡ',
    englishName: 'Kannada',
  ),
  LanguageOption(
    locale: Locale('ml'),
    nativeName: 'മലയാളം',
    englishName: 'Malayalam',
  ),
  LanguageOption(
    locale: Locale('pa'),
    nativeName: 'ਪੰਜਾਬੀ',
    englishName: 'Punjabi',
  ),
  LanguageOption(
    locale: Locale('or'),
    nativeName: 'ଓଡ଼ିଆ',
    englishName: 'Odia',
  ),
  LanguageOption(
    locale: Locale('ur'),
    nativeName: 'اردو',
    englishName: 'Urdu',
  ),
  LanguageOption(
    locale: Locale('as'),
    nativeName: 'অসমীয়া',
    englishName: 'Assamese',
  ),
];
