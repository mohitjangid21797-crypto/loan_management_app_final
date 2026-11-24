import 'package:material_ui/material_ui.dart';
import 'package:loan_management_app/core/theme/app_theme.dart';
import 'package:loan_management_app/l10n/app_localizations.dart';

class FloatingNavBar extends StatelessWidget {
  const FloatingNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  @override
  Widget build(BuildContext context) {
    final colors = context.lwColors;
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final items = [
      (icon: Icons.home_rounded, label: l10n.navHome),
      (icon: Icons.people_outline_rounded, label: l10n.navCustomers),
      (icon: Icons.account_balance_wallet_outlined, label: l10n.navLoans),
      (icon: Icons.person_outline_rounded, label: l10n.navProfile),
    ];

    return SafeArea(
      top: false,
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(AppRadius.card),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.42 : 0.10),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: List.generate(items.length, (index) {
            final item = items[index];
            final isActive = index == selectedIndex;
            return Expanded(
              child: _NavTabButton(
                key: ValueKey('bottom_nav_tab_$index'),
                icon: item.icon,
                label: item.label,
                isActive: isActive,
                onTap: () => onTabSelected(index),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _NavTabButton extends StatelessWidget {
  const _NavTabButton({
    super.key,
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.lwColors;
    final textTheme = Theme.of(context).textTheme;
    final activeColor = colors.primary;
    final inactiveColor = colors.textMuted;

    return Semantics(
      button: true,
      selected: isActive,
      label: label,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isActive
                        ? activeColor.withValues(alpha: 0.14)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    icon,
                    size: 22,
                    color: isActive ? activeColor : inactiveColor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.labelSmall?.copyWith(
                    color: isActive ? activeColor : inactiveColor,
                    fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
