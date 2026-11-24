import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';

class LoanWiseLogoAnimation extends StatefulWidget {
  const LoanWiseLogoAnimation({
    super.key,
    this.size = 188,
    this.onSequenceComplete,
  });

  final double size;
  final VoidCallback? onSequenceComplete;

  @override
  State<LoanWiseLogoAnimation> createState() => _LoanWiseLogoAnimationState();
}

class _LoanWiseLogoAnimationState extends State<LoanWiseLogoAnimation>
    with TickerProviderStateMixin {
  late final AnimationController _entryController;
  late final AnimationController _idleController;
  bool _completedNotified = false;
  bool _initializedFromDeps = false;

  @override
  void initState() {
    super.initState();
    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3400),
    );
    _idleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    );

    _entryController.addStatusListener((status) {
      if (status == AnimationStatus.completed && !_completedNotified) {
        _completedNotified = true;
        if (!MediaQuery.disableAnimationsOf(context)) {
          _idleController.repeat(reverse: true);
        }
        widget.onSequenceComplete?.call();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final disableAnimations = MediaQuery.disableAnimationsOf(context);
    if (disableAnimations) {
      _entryController.value = 1.0;
      _idleController.stop();
      if (!_completedNotified) {
        _completedNotified = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) widget.onSequenceComplete?.call();
        });
      }
      _initializedFromDeps = true;
      return;
    }

    if (!_initializedFromDeps) {
      _initializedFromDeps = true;
      _entryController.forward();
    }
  }

  @override
  void dispose() {
    _entryController.dispose();
    _idleController.dispose();
    super.dispose();
  }

  double _intervalValue(double begin, double end, [Curve curve = Curves.easeOutCubic]) {
    final raw = ((_entryController.value - begin) / (end - begin)).clamp(0.0, 1.0);
    return curve.transform(raw);
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.size;
    final textTheme = Theme.of(context).textTheme;

    return Semantics(
      label: 'LoanWise',
      image: true,
      child: RepaintBoundary(
        child: AnimatedBuilder(
          animation: Listenable.merge([_entryController, _idleController]),
          builder: (context, _) {
            final tileT = _intervalValue(0.00, 0.35);
            final arrowT = _intervalValue(0.10, 0.55, Curves.easeInOutCubic);
            final bigCoinT = _intervalValue(0.20, 0.58, Curves.bounceOut);
            final smallCoinT = _intervalValue(0.30, 0.66, Curves.bounceOut);
            final lwFlipT = _intervalValue(0.55, 0.80, Curves.easeOutBack);
            final wordmarkT = _intervalValue(0.75, 1.00, Curves.easeOutCubic);

            final idleAngle = _idleController.isAnimating
                ? math.sin(_idleController.value * math.pi * 2) * 0.04
                : 0.0;

            final rotY = -0.9 * (1.0 - tileT) + idleAngle;
            final rotX = 0.5 * (1.0 - tileT);
            final tileScale = 0.6 + 0.4 * tileT;

            final matrix = Matrix4.identity()
              ..setEntry(3, 2, 0.0018)
              ..rotateY(rotY)
              ..rotateX(rotX);

            return Transform(
              alignment: Alignment.center,
              transform: matrix,
              child: Transform.scale(
                scale: tileScale,
                child: Container(
                  width: s,
                  height: s,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF1E3A8A), Color(0xFF0B1650)],
                    ),
                    borderRadius: BorderRadius.circular(s * 0.22),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF0B1650).withValues(alpha: 0.40),
                        blurRadius: 28,
                        offset: const Offset(0, 14),
                      ),
                    ],
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Green zig-zag trend arrow
                      Positioned.fill(
                        child: CustomPaint(
                          painter: _TrendArrowPainter(progress: arrowT, tileSize: s),
                        ),
                      ),
                      // Big coin stack (3 coins)
                      Positioned(
                        left: s * 0.43,
                        top: s * 0.19 - (1.0 - bigCoinT) * s * 0.24,
                        width: s * 0.22,
                        height: s * 0.22,
                        child: Opacity(
                          opacity: bigCoinT.clamp(0.0, 1.0),
                          child: Transform.rotate(
                            angle: (1.0 - bigCoinT) * 3.0 * math.pi,
                            child: CustomPaint(
                              painter: _CoinStackPainter(coinCount: 3),
                            ),
                          ),
                        ),
                      ),
                      // Small coin stack (2 coins)
                      Positioned(
                        left: s * 0.29,
                        top: s * 0.33 - (1.0 - smallCoinT) * s * 0.20,
                        width: s * 0.17,
                        height: s * 0.17,
                        child: Opacity(
                          opacity: smallCoinT.clamp(0.0, 1.0),
                          child: Transform.rotate(
                            angle: (1.0 - smallCoinT) * 3.0 * math.pi,
                            child: CustomPaint(
                              painter: _CoinStackPainter(coinCount: 2),
                            ),
                          ),
                        ),
                      ),
                      // Bold green "LW" monogram flipping up
                      Positioned(
                        left: s * 0.28,
                        top: s * 0.56,
                        width: s * 0.46,
                        height: s * 0.17,
                        child: Opacity(
                          opacity: lwFlipT.clamp(0.0, 1.0),
                          child: Transform(
                            alignment: Alignment.bottomCenter,
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.002)
                              ..rotateX((1.0 - lwFlipT) * (math.pi / 2)),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                'LW',
                                style: textTheme.displaySmall?.copyWith(
                                  color: const Color(0xFF34D399),
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // White wordmark "LoanWise"
                      Positioned(
                        left: s * 0.10,
                        right: s * 0.10,
                        top: s * 0.80 + (1.0 - wordmarkT) * 10,
                        height: s * 0.13,
                        child: Opacity(
                          opacity: wordmarkT.clamp(0.0, 1.0),
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              'LoanWise',
                              style: textTheme.titleLarge?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.4,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _TrendArrowPainter extends CustomPainter {
  _TrendArrowPainter({required this.progress, required this.tileSize});

  final double progress;
  final double tileSize;

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0) return;

    final points = [
      Offset(size.width * 0.13, size.height * 0.69),
      Offset(size.width * 0.31, size.height * 0.47),
      Offset(size.width * 0.37, size.height * 0.53),
      Offset(size.width * 0.55, size.height * 0.35),
      Offset(size.width * 0.62, size.height * 0.43),
      Offset(size.width * 0.80, size.height * 0.18),
    ];

    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }

    final metric = path.computeMetrics().first;
    final drawnPath = metric.extractPath(0, metric.length * progress);

    final strokePaint = Paint()
      ..color = const Color(0xFF34D399)
      ..style = PaintingStyle.stroke
      ..strokeWidth = tileSize * 0.07
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(drawnPath, strokePaint);

    if (progress > 0.88) {
      final tip = points.last;
      final headAlpha = ((progress - 0.88) / 0.12).clamp(0.0, 1.0);
      final headSize = tileSize * 0.08;
      final headPath = Path()
        ..moveTo(tip.dx, tip.dy - headSize * 0.35)
        ..lineTo(tip.dx - headSize * 0.85, tip.dy + headSize * 0.15)
        ..lineTo(tip.dx + headSize * 0.15, tip.dy + headSize * 0.85)
        ..close();
      canvas.drawPath(
        headPath,
        Paint()..color = const Color(0xFF34D399).withValues(alpha: headAlpha),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _TrendArrowPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.tileSize != tileSize;
  }
}

class _CoinStackPainter extends CustomPainter {
  _CoinStackPainter({required this.coinCount});

  final int coinCount;

  @override
  void paint(Canvas canvas, Size size) {
    final coinWidth = size.width * 0.92;
    final coinHeight = size.height * 0.28;
    final left = (size.width - coinWidth) / 2;
    final stepY = size.height * 0.23;

    final bodyPaint = Paint()..color = const Color(0xFFF59E0B);
    final rimPaint = Paint()..color = const Color(0xFFFFD34E);
    final innerPaint = Paint()
      ..color = const Color(0xFFB45309).withValues(alpha: 0.45)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;

    for (int i = 0; i < coinCount; i++) {
      final top = size.height - coinHeight - (i * stepY);
      final bodyRect = Rect.fromLTWH(left, top + 2, coinWidth, coinHeight);
      final faceRect = Rect.fromLTWH(left, top, coinWidth, coinHeight);
      canvas.drawOval(bodyRect, bodyPaint);
      canvas.drawOval(faceRect, rimPaint);
      canvas.drawOval(faceRect.deflate(2.5), innerPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _CoinStackPainter oldDelegate) {
    return oldDelegate.coinCount != coinCount;
  }
}
