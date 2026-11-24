class LoanDateUtils {
  const LoanDateUtils._();

  static DateTime toUtcMidnight(DateTime date) {
    return DateTime.utc(date.year, date.month, date.day);
  }

  static int daysInMonthUtc(int year, int month) {
    // month 1..12; day 0 of next month gives last day of `month`.
    return DateTime.utc(year, month + 1, 0).day;
  }

  /// Adds [months] calendar months to [startDate], clamping the day to the
  /// target month's last day (e.g. Jan 31 + 1 month -> Feb 28/29).
  static DateTime addMonthsClamped(DateTime startDate, int months) {
    final base = toUtcMidnight(startDate);
    final totalMonths = (base.year * 12) + (base.month - 1) + months;
    final targetYear = totalMonths ~/ 12;
    final targetMonth = (totalMonths % 12) + 1;
    final maxDay = daysInMonthUtc(targetYear, targetMonth);
    final clampedDay = base.day <= maxDay ? base.day : maxDay;
    return DateTime.utc(targetYear, targetMonth, clampedDay);
  }

  static bool isSameUtcDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  static bool isSameUtcMonth(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month;
  }

  /// Computed dynamically from [dueDate] vs [now] (UTC midnight) — never stored.
  static bool isOverdueEmi({
    required DateTime dueDate,
    required bool isPaid,
    DateTime? now,
  }) {
    if (isPaid) return false;
    final today = toUtcMidnight(now ?? DateTime.now().toUtc());
    final due = toUtcMidnight(dueDate);
    return due.isBefore(today);
  }

  static const List<String> _shortMonthsEn = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  static const Map<String, List<String>> _fullMonthsByLang = {
    'en': [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ],
    'hi': [
      'जनवरी',
      'फ़रवरी',
      'मार्च',
      'अप्रैल',
      'मई',
      'जून',
      'जुलाई',
      'अगस्त',
      'सितंबर',
      'अक्टूबर',
      'नवंबर',
      'दिसंबर',
    ],
    'ta': [
      'ஜனவரி',
      'பிப்ரவரி',
      'மார்ச்',
      'ஏப்ரல்',
      'மே',
      'ஜூன்',
      'ஜூலை',
      'ஆகஸ்ட்',
      'செப்டம்பர்',
      'அக்டோபர்',
      'நவம்பர்',
      'டிசம்பர்',
    ],
    'te': [
      'జనవరి',
      'ఫిబ్రవరి',
      'మార్చి',
      'ఏప్రిల్',
      'మే',
      'జూన్',
      'జూలై',
      'ఆగస్టు',
      'సెప్టెంబర్',
      'అక్టోబర్',
      'నవంబర్',
      'డిసెంబర్',
    ],
    'bn': [
      'জানুয়ারি',
      'ফেব্রুয়ারি',
      'মার্চ',
      'এপ্রিল',
      'মে',
      'জুন',
      'জুলাই',
      'আগস্ট',
      'সেপ্টেম্বর',
      'অক্টোবর',
      'নভেম্বর',
      'ডিসেম্বর',
    ],
    'mr': [
      'जानेवारी',
      'फेब्रुवारी',
      'मार्च',
      'एप्रिल',
      'मे',
      'जून',
      'जुलै',
      'ऑगस्ट',
      'सप्टेंबर',
      'ऑक्टोबर',
      'नोव्हेंबर',
      'डिसेंबर',
    ],
    'gu': [
      'જાન્યુઆરી',
      'ફેબ્રુઆરી',
      'માર્ચ',
      'એપ્રિલ',
      'મે',
      'જૂન',
      'જુલાઈ',
      'ઓગસ્ટ',
      'સપ્ટેમ્બર',
      'ઓક્ટોબર',
      'નવેમ્બર',
      'ડિસેમ્બર',
    ],
    'kn': [
      'ಜನವರಿ',
      'ಫೆಬ್ರವರಿ',
      'ಮಾರ್ಚ್',
      'ಏಪ್ರಿಲ್',
      'ಮೇ',
      'ಜೂನ್',
      'ಜುಲೈ',
      'ಆಗಸ್ಟ್',
      'ಸೆಪ್ಟೆಂಬರ್',
      'ಅಕ್ಟೋಬರ್',
      'ನವೆಂಬರ್',
      'ಡಿಸೆಂಬರ್',
    ],
    'ml': [
      'ജനുവരി',
      'ഫെബ്രുവരി',
      'മാർച്ച്',
      'ഏപ്രിൽ',
      'മേയ്',
      'ജൂൺ',
      'ജൂലൈ',
      'ഓഗസ്റ്റ്',
      'സെപ്റ്റംബർ',
      'ഒക്ടോബർ',
      'നവംബർ',
      'ഡിസംബർ',
    ],
    'pa': [
      'ਜਨਵਰੀ',
      'ਫ਼ਰਵਰੀ',
      'ਮਾਰਚ',
      'ਅਪ੍ਰੈਲ',
      'ਮਈ',
      'ਜੂਨ',
      'ਜੁਲਾਈ',
      'ਅਗਸਤ',
      'ਸਤੰਬਰ',
      'ਅਕਤੂਬਰ',
      'ਨਵੰਬਰ',
      'ਦਸੰਬਰ',
    ],
    'or': [
      'ଜାନୁଆରୀ',
      'ଫେବୃଆରୀ',
      'ମାର୍ଚ୍ଚ',
      'ଅପ୍ରେଲ',
      'ମେ',
      'ଜୁନ',
      'ଜୁଲାଇ',
      'ଅଗଷ୍ଟ',
      'ସେପ୍ଟେମ୍ବର',
      'ଅକ୍ଟୋବର',
      'ନଭେମ୍ବର',
      'ଡିସେମ୍ବର',
    ],
    'ur': [
      'جنوری',
      'فروری',
      'مارچ',
      'اپریل',
      'مئی',
      'جون',
      'جولائی',
      'اگست',
      'ستمبر',
      'اکتوبر',
      'نومبر',
      'دسمبر',
    ],
    'as': [
      'জানুৱাৰী',
      'ফেব্ৰুৱাৰী',
      'মাৰ্চ',
      'এপ্ৰিল',
      'মে’',
      'জুন',
      'জুলাই',
      'আগষ্ট',
      'ছেপ্টেম্বৰ',
      'অক্টোবৰ',
      'নৱেম্বৰ',
      'ডিচেম্বৰ',
    ],
  };

  static String formatShortDate(DateTime date) {
    final dd = date.day.toString().padLeft(2, '0');
    final mon = _shortMonthsEn[date.month - 1];
    return '$dd $mon ${date.year}';
  }

  static String formatFullMonthDate(DateTime date, String languageCode) {
    final months =
        _fullMonthsByLang[languageCode] ?? _fullMonthsByLang['en']!;
    final dd = date.day.toString().padLeft(2, '0');
    final monthName = months[date.month - 1];
    return '$dd $monthName ${date.year}';
  }

  static String formatFullMonthDateTime(DateTime dateTime, String languageCode) {
    final hh = dateTime.hour.toString().padLeft(2, '0');
    final mm = dateTime.minute.toString().padLeft(2, '0');
    return '${formatFullMonthDate(dateTime, languageCode)}, $hh:$mm';
  }
}
