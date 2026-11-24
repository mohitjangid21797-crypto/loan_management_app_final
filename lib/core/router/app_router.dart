import 'package:go_router/go_router.dart';
import 'package:loan_management_app/presentation/screens/dashboard/dashboard_screen.dart';
import 'package:loan_management_app/presentation/screens/login/login_screen.dart';
import 'package:loan_management_app/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:loan_management_app/presentation/screens/splash/splash_screen.dart';
import 'package:loan_management_app/state/app_state.dart';
import 'package:material_ui/material_ui.dart';

class AppRoutePaths {
  const AppRoutePaths._();

  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String dashboard = '/dashboard';
}

enum AuthBootstrapStatus {
  unknown,
  onboarding,
  unauthenticated,
  authenticated,
}

String? redirectFor(AuthBootstrapStatus status, String location) {
  switch (status) {
    case AuthBootstrapStatus.unknown:
      return location == AppRoutePaths.splash ? null : AppRoutePaths.splash;
    case AuthBootstrapStatus.onboarding:
      return location == AppRoutePaths.onboarding
          ? null
          : AppRoutePaths.onboarding;
    case AuthBootstrapStatus.unauthenticated:
      return location == AppRoutePaths.login ? null : AppRoutePaths.login;
    case AuthBootstrapStatus.authenticated:
      if (location == AppRoutePaths.splash ||
          location == AppRoutePaths.onboarding ||
          location == AppRoutePaths.login ||
          location == '/') {
        return AppRoutePaths.dashboard;
      }
      return null;
  }
}

class RouterSessionController extends ChangeNotifier {
  RouterSessionController({
    required this._appState,
    required this._splashCompleted,
    required this._profileLoaded,
  }) {
    _appState.addListener(notifyListeners);
  }

  final AppState _appState;
  bool _splashCompleted;
  bool _profileLoaded;

  AuthBootstrapStatus get status {
    if (!_splashCompleted || !_profileLoaded) {
      return AuthBootstrapStatus.unknown;
    }
    if (_appState.isSignedIn) {
      return AuthBootstrapStatus.authenticated;
    }
    if (!_appState.hasSeenOnboarding) {
      return AuthBootstrapStatus.onboarding;
    }
    return AuthBootstrapStatus.unauthenticated;
  }

  void markSplashCompleted() {
    if (_splashCompleted) return;
    _splashCompleted = true;
    notifyListeners();
  }

  void markProfileLoaded() {
    if (_profileLoaded) return;
    _profileLoaded = true;
    notifyListeners();
  }

  @override
  void dispose() {
    _appState.removeListener(notifyListeners);
    super.dispose();
  }
}

GoRouter createAppRouter({
  required AppState appState,
  required RouterSessionController sessionController,
}) {
  return GoRouter(
    initialLocation: AppRoutePaths.splash,
    refreshListenable: sessionController,
    redirect: (context, state) {
      return redirectFor(sessionController.status, state.matchedLocation);
    },
    routes: [
      GoRoute(
        path: AppRoutePaths.splash,
        pageBuilder: (context, state) => _fadePage(
          context: context,
          state: state,
          child: SplashScreen(
            key: const ValueKey('root_splash'),
            appState: appState,
            onCompleted: sessionController.markSplashCompleted,
          ),
        ),
      ),
      GoRoute(
        path: AppRoutePaths.onboarding,
        pageBuilder: (context, state) => _fadePage(
          context: context,
          state: state,
          child: OnboardingScreen(
            key: const ValueKey('root_onboarding'),
            appState: appState,
          ),
        ),
      ),
      GoRoute(
        path: AppRoutePaths.login,
        pageBuilder: (context, state) => _fadePage(
          context: context,
          state: state,
          child: LoginScreen(
            key: const ValueKey('root_login'),
            appState: appState,
          ),
        ),
      ),
      GoRoute(
        path: AppRoutePaths.dashboard,
        pageBuilder: (context, state) => _fadePage(
          context: context,
          state: state,
          child: DashboardScreen(
            key: const ValueKey('root_dashboard'),
            appState: appState,
          ),
        ),
      ),
    ],
  );
}

CustomTransitionPage<void> _fadePage({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  final reduceMotion = MediaQuery.disableAnimationsOf(context);
  return CustomTransitionPage<void>(
    key: state.pageKey,
    transitionDuration:
        reduceMotion ? Duration.zero : const Duration(milliseconds: 300),
    reverseTransitionDuration:
        reduceMotion ? Duration.zero : const Duration(milliseconds: 220),
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}
