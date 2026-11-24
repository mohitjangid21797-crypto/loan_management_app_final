import 'package:loan_management_app/core/theme/app_theme.dart';
import 'package:loan_management_app/l10n/app_localizations.dart';
import 'package:loan_management_app/presentation/screens/login/login_screen.dart';
import 'package:loan_management_app/state/app_state.dart';
import 'package:material_ui/material_ui.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({
    super.key,
    required this.appState,
    this.onFinished,
  });

  final AppState appState;
  final VoidCallback? onFinished;

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _pageController;
  int _currentPage = 0;

  static const _emerald = Color(0xFF10B981);

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _finishOnboarding() {
    widget.appState.completeOnboarding();
    if (widget.onFinished != null) {
      widget.onFinished!();
      return;
    }
    if (!mounted) return;
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    Navigator.of(context).pushReplacement(
      PageRouteBuilder<void>(
        transitionDuration: reduceMotion
            ? Duration.zero
            : const Duration(milliseconds: 300),
        pageBuilder: (_, _, _) => LoginScreen(appState: widget.appState),
        transitionsBuilder: (_, animation, _, child) => FadeTransition(
          opacity: animation,
          child: child,
        ),
      ),
    );
  }

  void _goToPage(int index) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    if (reduceMotion) {
      _pageController.jumpToPage(index);
    } else {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.lwColors;
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    final bgColor = isDark ? colors.surface : Colors.white;
    final titleColor = isDark ? colors.textPrimary : const Color(0xFF1E293B);
    final subtitleColor =
        isDark ? colors.textMuted : const Color(0xFF94A3B8);

    final slides = [
      (
        asset: 'assets/images/onboarding_hub.jpg',
        title: l10n.onboardingTitle1,
        subtitle: l10n.onboardingSubtitle1,
      ),
      (
        asset: 'assets/images/onboarding_track.jpg',
        title: l10n.onboardingTitle2,
        subtitle: l10n.onboardingSubtitle2,
      ),
      (
        asset: 'assets/images/onboarding_agreements.jpg',
        title: l10n.onboardingTitle3,
        subtitle: l10n.onboardingSubtitle3,
      ),
    ];

    final isLastPage = _currentPage == slides.length - 1;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Semantics(
                    button: true,
                    label: isLastPage ? l10n.onboardingStart : l10n.onboardingSkip,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        key: ValueKey(
                          isLastPage
                              ? 'onboarding_start_button'
                              : 'onboarding_skip_button',
                        ),
                        borderRadius: BorderRadius.circular(18),
                        onTap: _finishOnboarding,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            minWidth: 64,
                            minHeight: 44,
                          ),
                          child: Center(
                            child: AnimatedContainer(
                              duration: reduceMotion
                                  ? Duration.zero
                                  : const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 7,
                              ),
                              decoration: BoxDecoration(
                                color: _emerald,
                                borderRadius: BorderRadius.circular(14),
                                boxShadow: [
                                  BoxShadow(
                                    color: _emerald.withValues(alpha: 0.28),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Text(
                                isLastPage
                                    ? l10n.onboardingStart
                                    : l10n.onboardingSkip,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                key: const ValueKey('onboarding_page_view'),
                controller: _pageController,
                itemCount: slides.length,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemBuilder: (context, index) {
                  final slide = slides[index];
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      final maxArtSize = (constraints.maxHeight * 0.48)
                          .clamp(140.0, 290.0)
                          .clamp(140.0, constraints.maxWidth - 40);
                      return SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 12,
                        ),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight - 24,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: maxArtSize,
                                height: maxArtSize,
                                decoration: isDark
                                    ? BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(28),
                                      )
                                    : null,
                                clipBehavior:
                                    isDark ? Clip.antiAlias : Clip.none,
                                padding: isDark
                                    ? const EdgeInsets.all(10)
                                    : EdgeInsets.zero,
                                child: Image.asset(
                                  slide.asset,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              const SizedBox(height: 28),
                              Text(
                                slide.title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: titleColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 0.6,
                                  height: 1.25,
                                ),
                              ),
                              const SizedBox(height: 12),
                              ConstrainedBox(
                                constraints: const BoxConstraints(maxWidth: 320),
                                child: Text(
                                  slide.subtitle,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: subtitleColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    height: 1.45,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(slides.length, (dotIdx) {
                                  final active = dotIdx == _currentPage;
                                  return GestureDetector(
                                    key: ValueKey('onboarding_dot_$dotIdx'),
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () => _goToPage(dotIdx),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 5,
                                        vertical: 10,
                                      ),
                                      child: AnimatedContainer(
                                        duration: reduceMotion
                                            ? Duration.zero
                                            : const Duration(milliseconds: 220),
                                        width: active ? 10 : 8,
                                        height: active ? 10 : 8,
                                        decoration: BoxDecoration(
                                          color: active
                                              ? _emerald
                                              : const Color(0xFFD1D5DB),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
