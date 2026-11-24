import 'package:material_ui/material_ui.dart';
import 'package:loan_management_app/core/theme/app_theme.dart';
import 'package:loan_management_app/presentation/screens/customers/customers_tab.dart';
import 'package:loan_management_app/presentation/screens/dashboard/home_tab.dart';
import 'package:loan_management_app/presentation/screens/dashboard/profile_tab.dart';
import 'package:loan_management_app/presentation/screens/loans/loans_tab.dart';
import 'package:loan_management_app/presentation/widgets/dashboard/app_drawer.dart';
import 'package:loan_management_app/presentation/widgets/dashboard/floating_nav_bar.dart';
import 'package:loan_management_app/state/app_state.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    super.key,
    required this.appState,
  });

  final AppState appState;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final colors = context.lwColors;
    final reduceMotion = MediaQuery.disableAnimationsOf(context);

    return ListenableBuilder(
      listenable: widget.appState,
      builder: (context, _) {
        final selectedTab = widget.appState.selectedTabIndex;
        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: colors.background,
          extendBody: true,
          drawer: AppDrawer(appState: widget.appState),
          body: AnimatedSwitcher(
            duration: reduceMotion
                ? Duration.zero
                : const Duration(milliseconds: 200),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            child: switch (selectedTab) {
              0 => HomeTab(
                  key: const ValueKey('tab_home'),
                  appState: widget.appState,
                  profile: widget.appState.profile,
                  data: widget.appState.dashboardData,
                  onOpenDrawer: () => _scaffoldKey.currentState?.openDrawer(),
                  onSelectTab: widget.appState.setTabIndex,
                ),
              1 => CustomersTab(
                  key: const ValueKey('tab_customers'),
                  appState: widget.appState,
                  onOpenDrawer: () => _scaffoldKey.currentState?.openDrawer(),
                ),
              2 => LoansTab(
                  key: const ValueKey('tab_loans'),
                  appState: widget.appState,
                  onOpenDrawer: () => _scaffoldKey.currentState?.openDrawer(),
                ),
              _ => ProfileTab(
                  key: const ValueKey('tab_profile'),
                  appState: widget.appState,
                  onOpenDrawer: () => _scaffoldKey.currentState?.openDrawer(),
                ),
            },
          ),
          bottomNavigationBar: FloatingNavBar(
            selectedIndex: selectedTab,
            onTabSelected: widget.appState.setTabIndex,
          ),
        );
      },
    );
  }
}
