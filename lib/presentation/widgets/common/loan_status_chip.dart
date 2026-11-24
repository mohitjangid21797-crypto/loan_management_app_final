import 'package:material_ui/material_ui.dart';
import 'package:loan_management_app/core/theme/app_theme.dart';

enum SemanticChipTone { active, completed, paid, pending, overdue }

class LoanStatusChip extends StatelessWidget {
  const LoanStatusChip({
    super.key,
    required this.label,
    required this.tone,
  });

  final String label;
  final SemanticChipTone tone;

  @override
  Widget build(BuildContext context) {
    final colors = context.lwColors;
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Color fgColor = switch (tone) {
      SemanticChipTone.active => colors.primary,
      SemanticChipTone.completed => colors.textMuted,
      SemanticChipTone.paid => colors.success,
      SemanticChipTone.pending => colors.textMuted,
      SemanticChipTone.overdue => colors.danger,
    };

    final Color bgColor = switch (tone) {
      SemanticChipTone.active => colors.primary.withValues(alpha: 0.12),
      SemanticChipTone.completed =>
        colors.textMuted.withValues(alpha: isDark ? 0.20 : 0.12),
      SemanticChipTone.paid => colors.success.withValues(alpha: 0.12),
      SemanticChipTone.pending =>
        colors.primary.withValues(alpha: isDark ? 0.16 : 0.08),
      SemanticChipTone.overdue => colors.danger.withValues(alpha: 0.12),
    };

    return Semantics(
      label: label,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: textTheme.labelSmall?.copyWith(
            color: fgColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class EmptyStateCard extends StatelessWidget {
  const EmptyStateCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.action,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final colors = context.lwColors;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: colors.fieldBorder),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: colors.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(icon, size: 28, color: colors.primary),
          ),
          const SizedBox(height: 14),
          Text(
            title,
            textAlign: TextAlign.center,
            style: textTheme.titleMedium,
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium?.copyWith(color: colors.textMuted),
          ),
          if (action != null) ...[
            const SizedBox(height: 16),
            action!,
          ],
        ],
      ),
    );
  }
}
