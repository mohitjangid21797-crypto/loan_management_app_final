import 'dart:math' as math;
import 'package:material_ui/material_ui.dart';

class LampSpec {
  const LampSpec({
    required this.xFraction,
    required this.lengthFraction,
    required this.shadeRadius,
    required this.phaseOffset,
    required this.speedMultiplier,
  });

  final double xFraction;
  final double lengthFraction;
  final double shadeRadius;
  final double phaseOffset;
  final double speedMultiplier;
}

class LampPainter extends CustomPainter {
  LampPainter({
    required this.progress,
    required this.reduceMotion,
  });

  final double progress;
  final bool reduceMotion;

  static const List<LampSpec> _lamps = [
    LampSpec(
      xFraction: 0.16,
      lengthFraction: 0.18,
      shadeRadius: 18,
      phaseOffset: 0.0,
      speedMultiplier: 1.0,
    ),
    LampSpec(
      xFraction: 0.29,
      lengthFraction: 0.28,
      shadeRadius: 15,
      phaseOffset: 2.1,
      speedMultiplier: 1.15,
    ),
    LampSpec(
      xFraction: 0.83,
      lengthFraction: 0.14,
      shadeRadius: 17,
      phaseOffset: 4.0,
      speedMultiplier: 0.9,
    ),
  ];

  static const double _maxSwingRadians = 4.0 * math.pi / 180.0;

  @override
  void paint(Canvas canvas, Size size) {
    final cordPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.72)
      ..strokeWidth = 1.6
      ..strokeCap = StrokeCap.round;

    final shadePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.90)
      ..style = PaintingStyle.fill;

    final bulbPaint = Paint()
      ..color = const Color(0xFFFFF3B0)
      ..style = PaintingStyle.fill;

    for (final lamp in _lamps) {
      final anchorX = size.width * lamp.xFraction;
      final cordLength = (size.height * lamp.lengthFraction).clamp(24.0, 96.0);
      final angle = reduceMotion
          ? 0.0
          : math.sin(
                progress * 2 * math.pi * lamp.speedMultiplier + lamp.phaseOffset,
              ) *
              _maxSwingRadians;

      canvas.save();
      canvas.translate(anchorX, 0);
      canvas.rotate(angle);

      // Thin vertical cord from top edge.
      canvas.drawLine(Offset.zero, Offset(0, cordLength), cordPaint);

      // Soft yellow glow beneath the half-circle shade.
      final glowCenter = Offset(0, cordLength + lamp.shadeRadius * 0.55);
      final glowRadius = lamp.shadeRadius * 2.4;
      final glowPaint = Paint()
        ..shader = RadialGradient(
          colors: [
            const Color(0xFFFFE57F).withValues(alpha: 0.55),
            const Color(0xFFFFD54F).withValues(alpha: 0.18),
            const Color(0xFFFFD54F).withValues(alpha: 0.0),
          ],
          stops: const [0.0, 0.45, 1.0],
        ).createShader(Rect.fromCircle(center: glowCenter, radius: glowRadius));
      canvas.drawCircle(glowCenter, glowRadius, glowPaint);

      // Small bulb peeking under the shade.
      canvas.drawCircle(
        Offset(0, cordLength + 2),
        lamp.shadeRadius * 0.24,
        bulbPaint,
      );

      // Half-circle lamp shade (white at 90% opacity).
      final shadeRect = Rect.fromCircle(
        center: Offset(0, cordLength),
        radius: lamp.shadeRadius,
      );
      final shadePath = Path()
        ..moveTo(-lamp.shadeRadius, cordLength)
        ..arcTo(shadeRect, math.pi, math.pi, false)
        ..close();
      canvas.drawPath(shadePath, shadePaint);

      // Small mounting cap above shade.
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset(0, cordLength - lamp.shadeRadius - 1.5),
            width: 6,
            height: 4,
          ),
          const Radius.circular(2),
        ),
        shadePaint,
      );

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant LampPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.reduceMotion != reduceMotion;
  }
}

class SwingingLampsOverlay extends StatefulWidget {
  const SwingingLampsOverlay({super.key});

  @override
  State<SwingingLampsOverlay> createState() => _SwingingLampsOverlayState();
}

class _SwingingLampsOverlayState extends State<SwingingLampsOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3600),
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
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return CustomPaint(
            painter: LampPainter(
              progress: _controller.value,
              reduceMotion: reduceMotion,
            ),
            size: Size.infinite,
          );
        },
      ),
    );
  }
}
