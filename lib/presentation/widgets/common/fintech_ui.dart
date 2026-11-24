import 'package:loan_management_app/core/theme/app_theme.dart';
import 'package:material_ui/material_ui.dart';

class FintechSurfaceCard extends StatelessWidget {
  const FintechSurfaceCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(18),
    this.radius = AppRadius.card,
    this.borderColor,
    this.backgroundColor,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;
  final Color? borderColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final colors = context.lwColors;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? colors.surface,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: borderColor ?? colors.fieldBorder),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: const Color(0xFF0F172A).withValues(alpha: 0.04),
                  blurRadius: 18,
                  offset: const Offset(0, 6),
                ),
              ],
      ),
      child: child,
    );
  }
}

class FintechSectionHeader extends StatelessWidget {
  const FintechSectionHeader({
    super.key,
    required this.title,
    this.icon,
    this.accentColor,
    this.trailing,
  });

  final String title;
  final IconData? icon;
  final Color? accentColor;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final colors = context.lwColors;
    final textTheme = Theme.of(context).textTheme;
    final effectiveAccent = accentColor ?? colors.primary;

    return Row(
      children: [
        if (icon != null) ...[
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: effectiveAccent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(icon, size: 17, color: effectiveAccent),
          ),
          const SizedBox(width: 10),
        ],
        Expanded(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.titleMedium,
          ),
        ),
        ?trailing,
      ],
    );
  }
}

class FintechErrorBanner extends StatelessWidget {
  const FintechErrorBanner({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    final colors = context.lwColors;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: colors.danger.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(AppRadius.field),
        border: Border.all(color: colors.danger.withValues(alpha: 0.35)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.error_outline_rounded, size: 18, color: colors.danger),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: textTheme.bodySmall?.copyWith(
                color: colors.danger,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FintechInitialsAvatar extends StatelessWidget {
  const FintechInitialsAvatar({
    super.key,
    required this.initials,
    this.seed = '',
    this.radius = 22,
  });

  final String initials;
  final String seed;
  final double radius;

  static const List<List<Color>> _palettes = [
    [Color(0xFF1E3A8A), Color(0xFF2563EB)],
    [Color(0xFF047857), Color(0xFF10B981)],
    [Color(0xFF0F766E), Color(0xFF14B8A6)],
    [Color(0xFF4338CA), Color(0xFF6366F1)],
    [Color(0xFFB45309), Color(0xFFF59E0B)],
  ];

  @override
  Widget build(BuildContext context) {
    final hash = seed.codeUnits.fold<int>(0, (acc, c) => acc + c);
    final pair = _palettes[hash % _palettes.length];
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: pair,
        ),
        boxShadow: [
          BoxShadow(
            color: pair.first.withValues(alpha: 0.22),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: radius * 0.68,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

class FintechHeroBanner extends StatelessWidget {
  const FintechHeroBanner({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.radius = AppRadius.card,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final colors = context.lwColors;
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colors.heroGradientStart,
            colors.heroGradientEnd,
            const Color(0xFF0D9488),
          ],
          stops: const [0.0, 0.62, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: colors.heroGradientStart.withValues(alpha: 0.24),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: child,
    );
  }
}
