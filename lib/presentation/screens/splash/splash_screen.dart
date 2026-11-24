import 'dart:async';
import 'dart:math' as math;

import 'package:loan_management_app/core/theme/app_theme.dart';
import 'package:loan_management_app/l10n/app_localizations.dart';
import 'package:loan_management_app/presentation/screens/dashboard/dashboard_screen.dart';
import 'package:loan_management_app/presentation/screens/login/login_screen.dart';
import 'package:loan_management_app/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:loan_management_app/presentation/widgets/splash/loanwise_logo_animation.dart';
import 'package:loan_management_app/state/app_state.dart';
import 'package:material_ui/material_ui.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
    required this.appState,
    this.holdDuration = const Duration(milliseconds: 400),
    this.onCompleted,
  });

  final AppState appState;
  final Duration holdDuration;
  final VoidCallback? onCompleted;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  bool _animationDone = false;
  bool _profileCheckDone = false;
  bool _navigated = false;
  Timer? _holdTimer;
  late final AnimationController _haloController;

  static const _emerald = Color(0xFF10B981);

  @override
  void initState() {
    super.initState();
    _haloController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..forward();
    Future<void>.microtask(() {
      if (!mounted) return;
      _profileCheckDone = true;
      _tryNavigate();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _haloController.value = 1.0;
    }
  }

  @override
  void dispose() {
    _holdTimer?.cancel();
    _haloController.dispose();
    super.dispose();
  }

  void _onAnimationFinished() {
    _animationDone = true;
    _tryNavigate();
  }

  void _tryNavigate() {
    if (_navigated || !_animationDone || !_profileCheckDone) return;
    _holdTimer?.cancel();
    final delay = MediaQuery.disableAnimationsOf(context)
        ? Duration.zero
        : widget.holdDuration;
    _holdTimer = Timer(delay, _navigateNext);
  }

  void _navigateNext() {
    if (!mounted || _navigated) return;
    _navigated = true;

    if (widget.onCompleted != null) {
      widget.onCompleted!();
      return;
    }

    final Widget destination;
    if (widget.appState.isSignedIn) {
      destination = DashboardScreen(appState: widget.appState);
    } else if (!widget.appState.hasSeenOnboarding) {
      destination = OnboardingScreen(appState: widget.appState);
    } else {
      destination = LoginScreen(appState: widget.appState);
    }

    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    Navigator.of(context).pushReplacement(
      PageRouteBuilder<void>(
        transitionDuration: reduceMotion
            ? Duration.zero
            : const Duration(milliseconds: 300),
        pageBuilder: (_, _, _) => destination,
        transitionsBuilder: (_, animation, _, child) => FadeTransition(
          opacity: animation,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.lwColors;
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? colors.surface : Colors.white;
    final primaryWordColor =
        isDark ? Colors.white : const Color(0xFF1E293B);
    final taglineColor =
        isDark ? colors.textMuted : const Color(0xFF64748B);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxHeight < 520;
            final haloSize = compact ? 220.0 : 272.0;
            final emblemSize = compact ? 116.0 : 142.0;

            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 24,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Two-tone bold uppercase brand headline matching reference splash
                    RichText(
                      key: const ValueKey('splash_brand_wordmark'),
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: compact ? 24 : 28,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.4,
                        ),
                        children: [
                          TextSpan(
                            text: 'LOAN',
                            style: TextStyle(color: primaryWordColor),
                          ),
                          const TextSpan(
                            text: 'WISE',
                            style: TextStyle(color: _emerald),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: compact ? 20 : 32),
                    SizedBox(
                      width: haloSize,
                      height: haloSize,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          AnimatedBuilder(
                            animation: _haloController,
                            builder: (context, _) {
                              final t = Curves.easeOutCubic
                                  .transform(_haloController.value);
                              return Opacity(
                                opacity: t,
                                child: Transform.scale(
                                  scale: 0.72 + 0.28 * t,
                                  child: CustomPaint(
                                    size: Size.square(haloSize),
                                    painter: _SunburstHaloPainter(
                                      rayColor: isDark
                                          ? _emerald.withValues(alpha: 0.16)
                                          : const Color(0xFFD1FAE5),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          Container(
                            width: emblemSize + 14,
                            height: emblemSize + 14,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFF34D399),
                                  Color(0xFF10B981),
                                  Color(0xFF0E7490),
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: _emerald.withValues(alpha: 0.34),
                                  blurRadius: 28,
                                  offset: const Offset(0, 12),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(6),
                            child: ClipOval(
                              child: FittedBox(
                                fit: BoxFit.cover,
                                child: LoanWiseLogoAnimation(
                                  size: 184,
                                  onSequenceComplete: _onAnimationFinished,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: compact ? 18 : 26),
                    Text(
                      l10n.splashTagline,
                      textAlign: TextAlign.center,
                      style: textTheme.bodyLarge?.copyWith(
                        color: taglineColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _SunburstHaloPainter extends CustomPainter {
  const _SunburstHaloPainter({required this.rayColor});

  final Color rayColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final outerRadius = size.width * 0.50;
    final innerRadius = size.width * 0.22;
    const rayCount = 24;
    const halfSpread = (math.pi / rayCount) * 0.56;

    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          rayColor,
          rayColor.withValues(alpha: 0.55),
          rayColor.withValues(alpha: 0.0),
        ],
        stops: const [0.35, 0.72, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: outerRadius))
      ..style = PaintingStyle.fill;

    for (int i = 0; i < rayCount; i++) {
      final angle = (i / rayCount) * math.pi * 2 - math.pi / 2;
      final tip = Offset(
        center.dx + outerRadius * math.cos(angle),
        center.dy + outerRadius * math.sin(angle),
      );
      final left = Offset(
        center.dx + innerRadius * math.cos(angle - halfSpread),
        center.dy + innerRadius * math.sin(angle - halfSpread),
      );
      final right = Offset(
        center.dx + innerRadius * math.cos(angle + halfSpread),
        center.dy + innerRadius * math.sin(angle + halfSpread),
      );

      final path = Path()
        ..moveTo(left.dx, left.dy)
        ..lineTo(tip.dx, tip.dy)
        ..lineTo(right.dx, right.dy)
        ..close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _SunburstHaloPainter oldDelegate) {
    return oldDelegate.rayColor != rayColor;
  }
}
