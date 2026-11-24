import 'dart:math' as math;
import 'package:material_ui/material_ui.dart';

class PlantPainter extends CustomPainter {
  PlantPainter({
    required this.swayProgress,
    required this.reduceMotion,
    required this.leafBaseColor,
  });

  final double swayProgress;
  final bool reduceMotion;
  final Color leafBaseColor;

  static const double _maxSwayRadians = 3.0 * math.pi / 180.0;

  @override
  void paint(Canvas canvas, Size size) {
    final baseOrigin = Offset(size.width * 0.72, size.height);
    final baseAngle = reduceMotion
        ? 0.0
        : math.sin(swayProgress * 2 * math.pi) * _maxSwayRadians;

    final leaves = [
      (angle: -0.58, length: size.height * 0.68, width: 22.0, alpha: 0.20, phase: 0.0),
      (angle: -0.26, length: size.height * 0.86, width: 26.0, alpha: 0.28, phase: 0.7),
      (angle: 0.08, length: size.height * 0.94, width: 28.0, alpha: 0.34, phase: 1.4),
      (angle: 0.38, length: size.height * 0.72, width: 23.0, alpha: 0.24, phase: 2.0),
      (angle: 0.66, length: size.height * 0.54, width: 18.0, alpha: 0.18, phase: 2.6),
    ];

    for (final leaf in leaves) {
      final individualSway = reduceMotion
          ? 0.0
          : math.sin(swayProgress * 2 * math.pi + leaf.phase) *
              (_maxSwayRadians * 0.7);
      canvas.save();
      canvas.translate(baseOrigin.dx, baseOrigin.dy);
      canvas.rotate(leaf.angle + baseAngle + individualSway);

      final paint = Paint()
        ..color = leafBaseColor.withValues(alpha: leaf.alpha)
        ..style = PaintingStyle.fill;

      final tipY = -leaf.length;
      final path = Path()
        ..moveTo(0, 0)
        ..quadraticBezierTo(
          -leaf.width,
          tipY * 0.48,
          0,
          tipY,
        )
        ..quadraticBezierTo(
          leaf.width,
          tipY * 0.48,
          0,
          0,
        )
        ..close();

      canvas.drawPath(path, paint);

      // Subtle central vein line.
      final veinPaint = Paint()
        ..color = leafBaseColor.withValues(alpha: leaf.alpha * 0.7)
        ..strokeWidth = 1.1
        ..style = PaintingStyle.stroke;
      canvas.drawLine(Offset.zero, Offset(0, tipY * 0.86), veinPaint);

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant PlantPainter oldDelegate) {
    return oldDelegate.swayProgress != swayProgress ||
        oldDelegate.reduceMotion != reduceMotion ||
        oldDelegate.leafBaseColor != leafBaseColor;
  }
}

class SwayingPlantIllustration extends StatefulWidget {
  const SwayingPlantIllustration({super.key});

  @override
  State<SwayingPlantIllustration> createState() =>
      _SwayingPlantIllustrationState();
}

class _SwayingPlantIllustrationState extends State<SwayingPlantIllustration>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4400),
    )..repeat();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final disableAnimations = MediaQuery.disableAnimationsOf(context);
    if (disableAnimations && _controller.isAnimating) {
      _controller.stop();
    } else if (!disableAnimations && !_controller.isAnimating) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    return RepaintBoundary(
      child: SizedBox(
        width: 132,
        height: 120,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return CustomPaint(
              painter: PlantPainter(
                swayProgress: _controller.value,
                reduceMotion: reduceMotion,
                leafBaseColor: Colors.white,
              ),
            );
          },
        ),
      ),
    );
  }
}
