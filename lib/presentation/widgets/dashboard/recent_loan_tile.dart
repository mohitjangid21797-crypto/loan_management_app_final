import 'package:material_ui/material_ui.dart';
import 'package:loan_management_app/core/theme/app_theme.dart';
import 'package:loan_management_app/core/utils/indian_currency_formatter.dart';
import 'package:loan_management_app/domain/models/loan_models.dart';
import 'package:loan_management_app/l10n/app_localizations.dart';

class RecentLoanTile extends StatelessWidget {
  const RecentLoanTile({
    super.key,
    required this.loan,
    required this.onTap,
  });

  final LoanItem loan;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.lwColors;
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isActive = loan.status == LoanStatus.active;
    final statusColor = isActive ? colors.primary : colors.success;
    final statusLabel =
        isActive ? l10n.statusActive : l10n.statusCompleted;

    return Material(
      color: colors.surface,
      borderRadius: BorderRadius.circular(AppRadius.tile),
      child: Ink(
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(AppRadius.tile),
          border: Border.all(color: colors.fieldBorder),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.22 : 0.04),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.tile),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor:
                      colors.primary.withValues(alpha: isDark ? 0.22 : 0.12),
                  child: Text(
                    loan.initials,
                    style: textTheme.titleSmall?.copyWith(
                      color: colors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        loan.customerName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.titleSmall,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        loan.mobile,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodySmall,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        l10n.nextEmiLabel(loan.nextEmiDate),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      IndianCurrencyFormatter.format(
                        loan.principal,
                        decimals: 0,
                      ),
                      style: textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(
                          alpha: isDark ? 0.22 : 0.12,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        statusLabel,
                        style: textTheme.labelSmall?.copyWith(
                          color: statusColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OverdueEmiTile extends StatelessWidget {
  const OverdueEmiTile({
    super.key,
    required this.item,
    required this.onTap,
  });

  final OverdueEmiItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.lwColors;
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: colors.surface,
      borderRadius: BorderRadius.circular(AppRadius.tile),
      child: Ink(
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(AppRadius.tile),
          border: Border.all(
            color: colors.danger.withValues(alpha: isDark ? 0.35 : 0.22),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.22 : 0.04),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.tile),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: colors.danger.withValues(
                      alpha: isDark ? 0.22 : 0.12,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.warning_amber_rounded,
                    color: colors.danger,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.customerName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.titleSmall,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${item.mobile} · ${l10n.dueSinceLabel(item.dueDate)}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      IndianCurrencyFormatter.format(
                        item.emiAmount,
                        decimals: 0,
                      ),
                      style: textTheme.titleSmall?.copyWith(
                        color: colors.danger,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: colors.danger.withValues(
                          alpha: isDark ? 0.22 : 0.12,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        l10n.statusOverdue,
                        style: textTheme.labelSmall?.copyWith(
                          color: colors.danger,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
