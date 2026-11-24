import 'package:material_ui/material_ui.dart';
import 'package:loan_management_app/core/theme/app_theme.dart';
import 'package:loan_management_app/core/utils/indian_currency_formatter.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({
    super.key,
    required this.label,
    required this.amount,
    required this.icon,
    required this.accentColor,
  });

  final String label;
  final double amount;
  final IconData icon;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    final colors = context.lwColors;
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.tile),
        border: Border.all(color: colors.fieldBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.24 : 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: isDark ? 0.22 : 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              size: 20,
              color: accentColor,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodySmall?.copyWith(
              color: colors.textMuted,
            ),
          ),
          const SizedBox(height: 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              IndianCurrencyFormatter.format(amount),
              maxLines: 1,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: colors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
