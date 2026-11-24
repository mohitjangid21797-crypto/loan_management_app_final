import 'dart:math' as math;
import 'package:material_ui/material_ui.dart';

class WaveClipper extends CustomClipper<Path> {
  WaveClipper({required this.phase});

  final double phase;

  @override
  Path getClip(Size size) {
    final path = Path();
    final w = size.width;
    final h = size.height;

    // Gentle S-curve ripple along the bottom edge of the gradient header.
    final rippleA = math.sin(phase) * 7.0;
    final rippleB = math.cos(phase) * 7.0;

    final startY = h - 34.0 + rippleA;
    final endY = h - 24.0 - rippleA;

    path.lineTo(0, startY);
    path.cubicTo(
      w * 0.28,
      h + 6.0 + rippleB,
      w * 0.66,
      h - 68.0 - rippleB,
      w,
      endY,
    );
    path.lineTo(w, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant WaveClipper oldClipper) {
    return oldClipper.phase != phase;
  }
}
