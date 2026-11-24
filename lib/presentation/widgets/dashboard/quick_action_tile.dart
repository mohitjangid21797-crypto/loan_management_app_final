import 'package:material_ui/material_ui.dart';
import 'package:loan_management_app/core/theme/app_theme.dart';

class QuickActionTile extends StatefulWidget {
  const QuickActionTile({
    super.key,
    required this.label,
    required this.icon,
    required this.accentColor,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Color accentColor;
  final VoidCallback onTap;

  @override
  State<QuickActionTile> createState() => _QuickActionTileState();
}

class _QuickActionTileState extends State<QuickActionTile> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.lwColors;
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedScale(
      scale: _isPressed ? 0.96 : 1.0,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeOut,
      child: Material(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.tile),
        child: Ink(
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
          child: InkWell(
            borderRadius: BorderRadius.circular(AppRadius.tile),
            onTap: widget.onTap,
            onHighlightChanged: (pressed) {
              setState(() => _isPressed = pressed);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: widget.accentColor.withValues(
                        alpha: isDark ? 0.22 : 0.12,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      widget.icon,
                      color: widget.accentColor,
                      size: 22,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Flexible(
                    child: Text(
                      widget.label,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.labelMedium?.copyWith(
                        color: colors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
