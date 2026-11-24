import 'dart:math' as math;
import 'package:material_ui/material_ui.dart';
import 'package:loan_management_app/core/theme/app_theme.dart';
import 'package:loan_management_app/l10n/app_localizations.dart';
import 'package:loan_management_app/presentation/widgets/login/lamp_painter.dart';
import 'package:loan_management_app/presentation/widgets/login/plant_painter.dart';
import 'package:loan_management_app/presentation/widgets/login/wave_clipper.dart';

class AnimatedLoginHeader extends StatefulWidget {
  const AnimatedLoginHeader({
    super.key,
    required this.height,
  });

  final double height;

  @override
  State<AnimatedLoginHeader> createState() => _AnimatedLoginHeaderState();
}

class _AnimatedLoginHeaderState extends State<AnimatedLoginHeader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _waveController;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final disableAnimations = MediaQuery.disableAnimationsOf(context);
    if (disableAnimations && _waveController.isAnimating) {
      _waveController.stop();
    } else if (!disableAnimations && !_waveController.isAnimating) {
      _waveController.repeat();
    }
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.lwColors;
    final l10n = AppLocalizations.of(context);
    final reduceMotion = MediaQuery.disableAnimationsOf(context);

    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _waveController,
        builder: (context, child) {
          final phase = reduceMotion
              ? 0.0
              : _waveController.value * 2 * math.pi;
          return ClipPath(
            clipper: WaveClipper(phase: phase),
            child: child,
          );
        },
        child: Container(
          width: double.infinity,
          height: widget.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                colors.loginGradientStart,
                colors.loginGradientEnd,
              ],
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Stack(
              children: [
                const Positioned.fill(
                  child: SwingingLampsOverlay(),
                ),
                const Positioned(
                  right: 12,
                  bottom: 14,
                  child: SwayingPlantIllustration(),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      l10n.loginTitle,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: Colors.white,
                          ),
                    ),
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
