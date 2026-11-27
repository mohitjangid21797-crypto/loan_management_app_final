import 'package:loan_management_app/core/theme/app_theme.dart';
import 'package:material_ui/material_ui.dart';

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
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.lwColors;
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final borderColor = _isHovered
        ? widget.accentColor.withValues(alpha: isDark ? 0.55 : 0.42)
        : colors.fieldBorder;

    return AnimatedScale(
      scale: _isPressed ? 0.96 : (_isHovered ? 1.015 : 1.0),
      duration: const Duration(milliseconds: 120),
      curve: Curves.easeOut,
      child: Material(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.tile),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.tile),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                colors.surface,
                Color.alphaBlend(
                  widget.accentColor.withValues(alpha: isDark ? 0.08 : 0.03),
                  colors.surface,
                ),
              ],
            ),
            border: Border.all(color: borderColor),
            boxShadow: isDark
                ? null
                : [
                    BoxShadow(
                      color: (_isHovered
                              ? widget.accentColor
                              : const Color(0xFF0F172A))
                          .withValues(alpha: _isHovered ? 0.12 : 0.04),
                      blurRadius: _isHovered ? 18 : 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(AppRadius.tile),
            onTap: widget.onTap,
            onHover: (hovered) {
              if (_isHovered != hovered) {
                setState(() => _isHovered = hovered);
              }
            },
            onHighlightChanged: (pressed) {
              if (_isPressed != pressed) {
                setState(() => _isPressed = pressed);
              }
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
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          widget.accentColor.withValues(
                            alpha: isDark ? 0.26 : 0.15,
                          ),
                          widget.accentColor.withValues(
                            alpha: isDark ? 0.14 : 0.07,
                          ),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(13),
                      border: Border.all(
                        color: widget.accentColor.withValues(
                          alpha: isDark ? 0.30 : 0.18,
                        ),
                      ),
                    ),
                    child: Icon(
                      widget.icon,
                      color: widget.accentColor,
                      size: 21,
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
                        fontWeight: FontWeight.w600,
                        height: 1.2,
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
