import 'package:material_ui/material_ui.dart';

class AppRadius {
  const AppRadius._();

  static const double card = 22.0;
  static const double tile = 18.0;
  static const double field = 14.0;
  static const double button = 16.0;
}

@immutable
class LoanWiseColors extends ThemeExtension<LoanWiseColors> {
  const LoanWiseColors({
    required this.primary,
    required this.loginGradientStart,
    required this.loginGradientEnd,
    required this.heroGradientStart,
    required this.heroGradientEnd,
    required this.buttonGradientStart,
    required this.buttonGradientEnd,
    required this.background,
    required this.surface,
    required this.fieldFill,
    required this.fieldBorder,
    required this.textPrimary,
    required this.textMuted,
    required this.success,
    required this.warning,
    required this.danger,
  });

  final Color primary;
  final Color loginGradientStart;
  final Color loginGradientEnd;
  final Color heroGradientStart;
  final Color heroGradientEnd;
  final Color buttonGradientStart;
  final Color buttonGradientEnd;
  final Color background;
  final Color surface;
  final Color fieldFill;
  final Color fieldBorder;
  final Color textPrimary;
  final Color textMuted;
  final Color success;
  final Color warning;
  final Color danger;

  static const LoanWiseColors light = LoanWiseColors(
    primary: Color(0xFF1E3A8A),
    loginGradientStart: Color(0xFF0B1650),
    loginGradientEnd: Color(0xFF1E3A8A),
    heroGradientStart: Color(0xFF0B1650),
    heroGradientEnd: Color(0xFF1E3A8A),
    buttonGradientStart: Color(0xFF1E3A8A),
    buttonGradientEnd: Color(0xFF10B981),
    background: Color(0xFFF3F6FB),
    surface: Color(0xFFFFFFFF),
    fieldFill: Color(0xFFF8FAFC),
    fieldBorder: Color(0xFFE2E8F0),
    textPrimary: Color(0xFF0F172A),
    textMuted: Color(0xFF64748B),
    success: Color(0xFF10B981),
    warning: Color(0xFFD97706),
    danger: Color(0xFFEF4444),
  );

  static const LoanWiseColors dark = LoanWiseColors(
    primary: Color(0xFF60A5FA),
    loginGradientStart: Color(0xFF091134),
    loginGradientEnd: Color(0xFF1E3A8A),
    heroGradientStart: Color(0xFF0E1B4D),
    heroGradientEnd: Color(0xFF1E3A8A),
    buttonGradientStart: Color(0xFF2563EB),
    buttonGradientEnd: Color(0xFF10B981),
    background: Color(0xFF090F1D),
    surface: Color(0xFF111A2E),
    fieldFill: Color(0xFF17233B),
    fieldBorder: Color(0xFF273552),
    textPrimary: Color(0xFFF1F5F9),
    textMuted: Color(0xFF94A3B8),
    success: Color(0xFF34D399),
    warning: Color(0xFFFBBF24),
    danger: Color(0xFFF87171),
  );

  // Semantic accent tokens exposed for icon tints / badges.
  static const Color specSuccessLight = Color(0xFF10B981);
  static const Color specWarningLight = Color(0xFFF59E0B);
  static const Color specDangerLight = Color(0xFFEF4444);
  static const Color specMutedLight = Color(0xFF64748B);
  static const Color emeraldAccent = Color(0xFF10B981);

  @override
  LoanWiseColors copyWith({
    Color? primary,
    Color? loginGradientStart,
    Color? loginGradientEnd,
    Color? heroGradientStart,
    Color? heroGradientEnd,
    Color? buttonGradientStart,
    Color? buttonGradientEnd,
    Color? background,
    Color? surface,
    Color? fieldFill,
    Color? fieldBorder,
    Color? textPrimary,
    Color? textMuted,
    Color? success,
    Color? warning,
    Color? danger,
  }) {
    return LoanWiseColors(
      primary: primary ?? this.primary,
      loginGradientStart: loginGradientStart ?? this.loginGradientStart,
      loginGradientEnd: loginGradientEnd ?? this.loginGradientEnd,
      heroGradientStart: heroGradientStart ?? this.heroGradientStart,
      heroGradientEnd: heroGradientEnd ?? this.heroGradientEnd,
      buttonGradientStart: buttonGradientStart ?? this.buttonGradientStart,
      buttonGradientEnd: buttonGradientEnd ?? this.buttonGradientEnd,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      fieldFill: fieldFill ?? this.fieldFill,
      fieldBorder: fieldBorder ?? this.fieldBorder,
      textPrimary: textPrimary ?? this.textPrimary,
      textMuted: textMuted ?? this.textMuted,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      danger: danger ?? this.danger,
    );
  }

  @override
  LoanWiseColors lerp(ThemeExtension<LoanWiseColors>? other, double t) {
    if (other is! LoanWiseColors) return this;
    return LoanWiseColors(
      primary: Color.lerp(primary, other.primary, t)!,
      loginGradientStart: Color.lerp(
        loginGradientStart,
        other.loginGradientStart,
        t,
      )!,
      loginGradientEnd: Color.lerp(
        loginGradientEnd,
        other.loginGradientEnd,
        t,
      )!,
      heroGradientStart: Color.lerp(
        heroGradientStart,
        other.heroGradientStart,
        t,
      )!,
      heroGradientEnd: Color.lerp(heroGradientEnd, other.heroGradientEnd, t)!,
      buttonGradientStart: Color.lerp(
        buttonGradientStart,
        other.buttonGradientStart,
        t,
      )!,
      buttonGradientEnd: Color.lerp(
        buttonGradientEnd,
        other.buttonGradientEnd,
        t,
      )!,
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      fieldFill: Color.lerp(fieldFill, other.fieldFill, t)!,
      fieldBorder: Color.lerp(fieldBorder, other.fieldBorder, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
    );
  }
}

extension LoanWiseThemeContext on BuildContext {
  LoanWiseColors get lwColors =>
      Theme.of(this).extension<LoanWiseColors>() ?? LoanWiseColors.light;
}

class AppTheme {
  const AppTheme._();

  static const String _fontFamily = 'Inter';
  static const List<String> _fontFallback = ['Noto Sans', 'Roboto', 'sans-serif'];

  static TextTheme _buildTextTheme(LoanWiseColors colors) {
    return TextTheme(
      displaySmall: TextStyle(
        fontFamily: _fontFamily,
        fontFamilyFallback: _fontFallback,
        fontSize: 32,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.6,
        color: colors.textPrimary,
      ),
      headlineMedium: TextStyle(
        fontFamily: _fontFamily,
        fontFamilyFallback: _fontFallback,
        fontSize: 26,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.4,
        color: colors.textPrimary,
      ),
      titleLarge: TextStyle(
        fontFamily: _fontFamily,
        fontFamilyFallback: _fontFallback,
        fontSize: 20,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.2,
        color: colors.textPrimary,
      ),
      titleMedium: TextStyle(
        fontFamily: _fontFamily,
        fontFamilyFallback: _fontFallback,
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: colors.textPrimary,
      ),
      titleSmall: TextStyle(
        fontFamily: _fontFamily,
        fontFamilyFallback: _fontFallback,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: colors.textPrimary,
      ),
      bodyLarge: TextStyle(
        fontFamily: _fontFamily,
        fontFamilyFallback: _fontFallback,
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: colors.textPrimary,
      ),
      bodyMedium: TextStyle(
        fontFamily: _fontFamily,
        fontFamilyFallback: _fontFallback,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: colors.textPrimary,
      ),
      bodySmall: TextStyle(
        fontFamily: _fontFamily,
        fontFamilyFallback: _fontFallback,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: colors.textMuted,
      ),
      labelLarge: TextStyle(
        fontFamily: _fontFamily,
        fontFamilyFallback: _fontFallback,
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: colors.textPrimary,
      ),
      labelMedium: TextStyle(
        fontFamily: _fontFamily,
        fontFamilyFallback: _fontFallback,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: colors.textPrimary,
      ),
      labelSmall: TextStyle(
        fontFamily: _fontFamily,
        fontFamilyFallback: _fontFallback,
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: colors.textMuted,
      ),
    );
  }

  static ThemeData _build({
    required Brightness brightness,
    required LoanWiseColors colors,
  }) {
    final textTheme = _buildTextTheme(colors);
    final isDark = brightness == Brightness.dark;
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: colors.background,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: colors.primary,
        onPrimary: isDark ? const Color(0xFF091134) : Colors.white,
        secondary: colors.success,
        onSecondary: Colors.white,
        error: colors.danger,
        onError: Colors.white,
        surface: colors.surface,
        onSurface: colors.textPrimary,
      ),
      textTheme: textTheme,
      extensions: [colors],
      appBarTheme: AppBarTheme(
        backgroundColor: colors.surface,
        foregroundColor: colors.textPrimary,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 1,
        titleTextStyle: textTheme.titleLarge,
        shape: Border(
          bottom: BorderSide(
            color: colors.fieldBorder.withValues(alpha: 0.7),
            width: 1,
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: colors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.card),
          side: BorderSide(color: colors.fieldBorder),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.fieldFill,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 15,
        ),
        labelStyle: textTheme.bodyMedium?.copyWith(color: colors.textMuted),
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: colors.textMuted.withValues(alpha: 0.75),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.field),
          borderSide: BorderSide(color: colors.fieldBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.field),
          borderSide: BorderSide(color: colors.fieldBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.field),
          borderSide: BorderSide(color: colors.primary, width: 1.8),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.field),
          borderSide: BorderSide(color: colors.danger),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          elevation: 0,
          minimumSize: const Size(48, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.button),
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(48, 48),
          side: BorderSide(color: colors.fieldBorder, width: 1.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.button),
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: SegmentedButton.styleFrom(
          selectedBackgroundColor: colors.primary.withValues(alpha: 0.14),
          selectedForegroundColor: colors.primary,
          side: BorderSide(color: colors.fieldBorder),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.field),
          ),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: colors.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.card),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: colors.surface,
      ),
    );
  }

  static ThemeData light() => _build(
        brightness: Brightness.light,
        colors: LoanWiseColors.light,
      );

  static ThemeData dark() => _build(
        brightness: Brightness.dark,
        colors: LoanWiseColors.dark,
      );
}
