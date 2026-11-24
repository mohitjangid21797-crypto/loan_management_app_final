import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:loan_management_app/core/theme/app_theme.dart';
import 'package:loan_management_app/domain/models/loan_models.dart';
import 'package:material_ui/material_ui.dart';
import 'package:loan_management_app/l10n/app_localizations.dart';
import 'package:loan_management_app/presentation/screens/customers/add_edit_customer_screen.dart';
import 'package:loan_management_app/presentation/screens/documents/documents_screen.dart';
import 'package:loan_management_app/presentation/screens/loans/create_loan_screen.dart';
import 'package:loan_management_app/presentation/screens/loans/emi_calculator_screen.dart';
import 'package:loan_management_app/presentation/screens/loans/loan_overview_screen.dart';
import 'package:loan_management_app/presentation/widgets/dashboard/hero_balance_card.dart';
import 'package:loan_management_app/presentation/widgets/dashboard/quick_action_tile.dart';
import 'package:loan_management_app/presentation/widgets/dashboard/recent_loan_tile.dart';
import 'package:loan_management_app/presentation/widgets/dashboard/summary_card.dart';
import 'package:loan_management_app/state/app_state.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({
    super.key,
    required this.appState,
    required this.profile,
    required this.data,
    required this.onOpenDrawer,
    required this.onSelectTab,
  });

  final AppState appState;
  final LenderProfile profile;
  final DashboardSummaryData data;
  final VoidCallback onOpenDrawer;
  final ValueChanged<int> onSelectTab;

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with SingleTickerProviderStateMixin {
  late final AnimationController _staggerController;

  @override
  void initState() {
    super.initState();
    _staggerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 780),
    )..forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _staggerController.value = 1.0;
    }
  }

  @override
  void dispose() {
    _staggerController.dispose();
    super.dispose();
  }

  Widget _staggeredSection(int index, Widget child) {
    if (MediaQuery.disableAnimationsOf(context)) {
      return child;
    }
    final begin = (index * 0.077).clamp(0.0, 0.65);
    final end = (begin + 0.35).clamp(0.0, 1.0);
    final anim = CurvedAnimation(
      parent: _staggerController,
      curve: Interval(begin, end, curve: Curves.easeOutCubic),
    );
    return AnimatedBuilder(
      animation: anim,
      builder: (context, c) {
        final t = anim.value;
        return Opacity(
          opacity: t,
          child: Transform.translate(
            offset: Offset(0, 18 * (1 - t)),
            child: c,
          ),
        );
      },
      child: child,
    );
  }

  void _openAddCustomer() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => AddEditCustomerScreen(appState: widget.appState),
      ),
    );
  }

  void _openCreateLoan() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => CreateLoanScreen(
          appState: widget.appState,
          onAddCustomerRequested: (mobile) {
            return Navigator.of(context).push<Customer?>(
              MaterialPageRoute<Customer?>(
                builder: (_) => AddEditCustomerScreen(
                  appState: widget.appState,
                  prefilledMobile: mobile,
                  returnCreatedWithoutPrompt: true,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _openDocuments() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => DocumentsScreen(appState: widget.appState),
      ),
    );
  }

  void _openEmiCalculator() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => EmiCalculatorScreen(appState: widget.appState),
      ),
    );
  }

  void _openLoanOrTab(String loanId) {
    if (widget.appState.store.findLoanById(loanId) != null) {
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => LoanOverviewScreen(
            appState: widget.appState,
            loanId: loanId,
          ),
        ),
      );
    } else {
      widget.onSelectTab(2);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.lwColors;
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final textScale = MediaQuery.textScalerOf(context).scale(14) / 14;

    final quickActions = [
      (
        label: l10n.actionAddCustomer,
        icon: Icons.person_add_alt_1_rounded,
        color: const Color(0xFF2563EB),
        onTap: _openAddCustomer,
      ),
      (
        label: l10n.actionCreateLoan,
        icon: Icons.add_card_rounded,
        color: const Color(0xFF10B981),
        onTap: _openCreateLoan,
      ),
      (
        label: l10n.actionLoans,
        icon: Icons.account_balance_wallet_rounded,
        color: const Color(0xFFF59E0B),
        onTap: () => widget.onSelectTab(2),
      ),
      (
        label: l10n.actionDocuments,
        icon: Icons.folder_copy_rounded,
        color: const Color(0xFF7C3AED),
        onTap: _openDocuments,
      ),
      (
        label: l10n.actionAllCustomers,
        icon: Icons.groups_rounded,
        color: const Color(0xFF0D9488),
        onTap: () => widget.onSelectTab(1),
      ),
      (
        label: l10n.actionProfile,
        icon: Icons.manage_accounts_rounded,
        color: const Color(0xFF475569),
        onTap: () => widget.onSelectTab(3),
      ),
    ];

    final recentLoans = widget.data.recentLoans.take(5).toList();
    final tileAspectRatio =
        (screenWidth < 360 || textScale > 1.25) ? 0.86 : 1.0;

    return SafeArea(
      bottom: false,
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 112),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _staggeredSection(
                  0,
                  _DashboardHeaderRow(
                    profile: widget.profile,
                    welcomeText: l10n.welcomeBack,
                    menuTooltip: l10n.openMenuTooltip,
                    profileTooltip: l10n.openProfileTooltip,
                    onOpenDrawer: widget.onOpenDrawer,
                    onOpenProfile: () => widget.onSelectTab(3),
                  ),
                ),
                const SizedBox(height: 18),
                _staggeredSection(
                  1,
                  HeroBalanceCard(data: widget.data),
                ),
                const SizedBox(height: 22),
                _staggeredSection(
                  2,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 8,
                          runSpacing: 4,
                          children: [
                            Text(
                              l10n.quickActionsHeading,
                              style: textTheme.titleMedium,
                            ),
                            TextButton.icon(
                              key: const ValueKey('home_emi_calculator_button'),
                              onPressed: _openEmiCalculator,
                              style: TextButton.styleFrom(
                                minimumSize: const Size(48, 44),
                              ),
                              icon: const Icon(
                                Icons.calculate_outlined,
                                size: 18,
                              ),
                              label: Text(l10n.emiCalculatorTitle),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      GridView.builder(
                        key: const ValueKey('quick_actions_grid'),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: quickActions.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: tileAspectRatio,
                        ),
                        itemBuilder: (context, index) {
                          final action = quickActions[index];
                          return QuickActionTile(
                            key: ValueKey('quick_action_$index'),
                            label: action.label,
                            icon: action.icon,
                            accentColor: action.color,
                            onTap: action.onTap,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),
                _staggeredSection(
                  3,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              l10n.thisMonthHeading,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.titleMedium,
                            ),
                          ),
                          TextButton(
                            onPressed: () => widget.onSelectTab(2),
                            style: TextButton.styleFrom(
                              minimumSize: const Size(48, 48),
                            ),
                            child: Text(
                              l10n.viewAll,
                              style: textTheme.labelMedium?.copyWith(
                                color: colors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: SummaryCard(
                              label: l10n.collectedThisMonth,
                              amount: widget.data.collectedThisMonth,
                              icon: Icons.arrow_upward_rounded,
                              accentColor: colors.success,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: SummaryCard(
                              label: l10n.pendingThisMonth,
                              amount: widget.data.pendingThisMonth,
                              icon: Icons.schedule_rounded,
                              accentColor: isDark
                                  ? colors.warning
                                  : LoanWiseColors.specWarningLight,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),
                _staggeredSection(
                  4,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.recentLoansHeading,
                        style: textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      if (recentLoans.isEmpty)
                        _EmptyListCard(
                          message: l10n.emptyRecentLoans,
                          actionLabel: widget.data.customersCount == 0
                              ? l10n.actionAddCustomer
                              : l10n.actionCreateLoan,
                          actionIcon: widget.data.customersCount == 0
                              ? Icons.person_add_alt_1_rounded
                              : Icons.add_card_rounded,
                          onAction: widget.data.customersCount == 0
                              ? _openAddCustomer
                              : _openCreateLoan,
                        )
                      else
                        ...List.generate(recentLoans.length, (i) {
                          final loan = recentLoans[i];
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: i == recentLoans.length - 1 ? 0 : 10,
                            ),
                            child: RecentLoanTile(
                              loan: loan,
                              onTap: () => _openLoanOrTab(loan.id),
                            ),
                          );
                        }),
                    ],
                  ),
                ),
                const SizedBox(height: 22),
                _staggeredSection(
                  5,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.overdueEmisHeading,
                        style: textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      if (widget.data.overdueEmis.isEmpty)
                        _EmptyListCard(message: l10n.emptyOverdueEmis)
                      else
                        ...List.generate(widget.data.overdueEmis.length, (i) {
                          final overdue = widget.data.overdueEmis[i];
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: i == widget.data.overdueEmis.length - 1
                                  ? 0
                                  : 10,
                            ),
                            child: OverdueEmiTile(
                              item: overdue,
                              onTap: () => _openLoanOrTab(overdue.loanId),
                            ),
                          );
                        }),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _DashboardHeaderRow extends StatelessWidget {
  const _DashboardHeaderRow({
    required this.profile,
    required this.welcomeText,
    required this.menuTooltip,
    required this.profileTooltip,
    required this.onOpenDrawer,
    required this.onOpenProfile,
  });

  final LenderProfile profile;
  final String welcomeText;
  final String menuTooltip;
  final String profileTooltip;
  final VoidCallback onOpenDrawer;
  final VoidCallback onOpenProfile;

  @override
  Widget build(BuildContext context) {
    final colors = context.lwColors;
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        Semantics(
          button: true,
          label: menuTooltip,
          child: SizedBox(
            width: 48,
            height: 48,
            child: Center(
              child: Material(
                color: colors.surface,
                borderRadius: BorderRadius.circular(14),
                child: Ink(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: colors.fieldBorder),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(
                          alpha: isDark ? 0.25 : 0.05,
                        ),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: InkWell(
                    key: const ValueKey('dashboard_menu_button'),
                    borderRadius: BorderRadius.circular(14),
                    onTap: onOpenDrawer,
                    child: Icon(
                      Icons.menu_rounded,
                      color: colors.textPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                welcomeText,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodySmall,
              ),
              const SizedBox(height: 2),
              Text(
                profile.name.trim().isNotEmpty
                    ? profile.name
                    : AppLocalizations.of(context).appTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.titleLarge,
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Semantics(
          button: true,
          label: profileTooltip,
          child: InkWell(
            key: const ValueKey('dashboard_profile_avatar'),
            borderRadius: BorderRadius.circular(24),
            onTap: onOpenProfile,
            child: SizedBox(
              width: 48,
              height: 48,
              child: Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Builder(
                      builder: (context) {
                        final photoPath = profile.photoPath;
                        final hasPhoto = photoPath != null &&
                            photoPath.isNotEmpty &&
                            (kIsWeb || File(photoPath).existsSync());
                        final ImageProvider? imageProvider = !hasPhoto
                            ? null
                            : (kIsWeb
                                ? NetworkImage(photoPath)
                                : FileImage(File(photoPath)) as ImageProvider);
                        return CircleAvatar(
                          radius: 21,
                          backgroundColor: colors.primary,
                          backgroundImage: imageProvider,
                          child: hasPhoto
                              ? null
                              : Text(
                                  profile.initials,
                                  style: textTheme.titleSmall?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                        );
                      },
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        width: 11,
                        height: 11,
                        decoration: BoxDecoration(
                          color: colors.success,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: colors.background,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _EmptyListCard extends StatelessWidget {
  const _EmptyListCard({
    required this.message,
    this.actionLabel,
    this.actionIcon,
    this.onAction,
  });

  final String message;
  final String? actionLabel;
  final IconData? actionIcon;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final colors = context.lwColors;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.tile),
        border: Border.all(color: colors.fieldBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: textTheme.bodyMedium?.copyWith(
              color: colors.textMuted,
            ),
          ),
          if (actionLabel != null && onAction != null) ...[
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: onAction,
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(48, 44),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.button),
                ),
              ),
              icon: Icon(actionIcon ?? Icons.add_rounded, size: 18),
              label: Text(actionLabel!),
            ),
          ],
        ],
      ),
    );
  }
}
