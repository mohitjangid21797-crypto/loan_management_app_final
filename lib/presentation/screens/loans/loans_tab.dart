import 'package:loan_management_app/core/theme/app_theme.dart';
import 'package:loan_management_app/core/utils/date_utils.dart';
import 'package:loan_management_app/core/utils/indian_currency_formatter.dart';
import 'package:loan_management_app/domain/models/loan_models.dart';
import 'package:loan_management_app/l10n/app_localizations.dart';
import 'package:loan_management_app/presentation/screens/customers/add_edit_customer_screen.dart';
import 'package:loan_management_app/presentation/screens/loans/create_loan_screen.dart';
import 'package:loan_management_app/presentation/screens/loans/emi_calculator_screen.dart';
import 'package:loan_management_app/presentation/screens/loans/loan_overview_screen.dart';
import 'package:loan_management_app/presentation/widgets/common/fintech_ui.dart';
import 'package:loan_management_app/presentation/widgets/common/loan_status_chip.dart';
import 'package:loan_management_app/state/app_state.dart';
import 'package:material_ui/material_ui.dart';

enum _LoansFilter { all, active, completed }

class LoansTab extends StatefulWidget {
  const LoansTab({
    super.key,
    required this.appState,
    required this.onOpenDrawer,
  });

  final AppState appState;
  final VoidCallback onOpenDrawer;

  @override
  State<LoansTab> createState() => _LoansTabState();
}

class _LoansTabState extends State<LoansTab> {
  _LoansFilter _filter = _LoansFilter.all;

  Future<void> _openCreateLoan() async {
    await Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (_) => CreateLoanScreen(
          appState: widget.appState,
          onAddCustomerRequested: (mobile) async {
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

  @override
  Widget build(BuildContext context) {
    final colors = context.lwColors;
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      bottom: false,
      child: ListenableBuilder(
        listenable: widget.appState,
        builder: (context, _) {
          final allLoans = widget.appState.loans;
          final activeLoans =
              allLoans.where((l) => l.status == LoanStatus.active).toList();
          final completedLoans =
              allLoans.where((l) => l.status == LoanStatus.completed).toList();
          final filtered = switch (_filter) {
            _LoansFilter.all => allLoans,
            _LoansFilter.active => activeLoans,
            _LoansFilter.completed => completedLoans,
          };

          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: colors.surface,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: colors.fieldBorder),
                            ),
                            child: IconButton(
                              tooltip: l10n.openMenuTooltip,
                              onPressed: widget.onOpenDrawer,
                              icon: Icon(
                                Icons.menu_rounded,
                                color: colors.textPrimary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    l10n.navLoans,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: textTheme.titleLarge,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 9,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        colors.primary.withValues(alpha: 0.12),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    '${allLoans.length}',
                                    style: textTheme.labelSmall?.copyWith(
                                      color: colors.primary,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: colors.surface,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: colors.fieldBorder),
                            ),
                            child: IconButton(
                              key: const ValueKey('loans_emi_calculator_button'),
                              tooltip: l10n.emiCalculatorTitle,
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute<void>(
                                    builder: (_) => EmiCalculatorScreen(
                                      appState: widget.appState,
                                    ),
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.calculate_outlined,
                                color: colors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        l10n.tabLoansSubtitle,
                        style: textTheme.bodyMedium?.copyWith(
                          color: colors.textMuted,
                        ),
                      ),
                      const SizedBox(height: 14),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          key: const ValueKey('loans_create_button'),
                          onPressed: _openCreateLoan,
                          style: FilledButton.styleFrom(
                            minimumSize: const Size.fromHeight(46),
                            backgroundColor: colors.primary,
                          ),
                          icon: const Icon(Icons.add_card_rounded, size: 20),
                          label: Text(l10n.actionCreateLoan),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          ChoiceChip(
                            key: const ValueKey('loans_filter_all'),
                            label: Text(
                              '${l10n.allLoansFilter} (${allLoans.length})',
                            ),
                            selected: _filter == _LoansFilter.all,
                            onSelected: (_) =>
                                setState(() => _filter = _LoansFilter.all),
                          ),
                          ChoiceChip(
                            key: const ValueKey('loans_filter_active'),
                            label: Text(
                              '${l10n.activeLoansFilter} (${activeLoans.length})',
                            ),
                            selected: _filter == _LoansFilter.active,
                            onSelected: (_) =>
                                setState(() => _filter = _LoansFilter.active),
                          ),
                          ChoiceChip(
                            key: const ValueKey('loans_filter_completed'),
                            label: Text(
                              '${l10n.completedLoansFilter} (${completedLoans.length})',
                            ),
                            selected: _filter == _LoansFilter.completed,
                            onSelected: (_) => setState(
                              () => _filter = _LoansFilter.completed,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                    ],
                  ),
                ),
              ),
              if (filtered.isEmpty)
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 112),
                  sliver: SliverToBoxAdapter(
                    child: EmptyStateCard(
                      icon: Icons.account_balance_wallet_outlined,
                      title: l10n.noLoansTitle,
                      subtitle: l10n.noLoansSubtitle,
                      action: FilledButton.icon(
                        onPressed: _openCreateLoan,
                        icon: const Icon(Icons.add_card_rounded),
                        label: Text(l10n.actionCreateLoan),
                      ),
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 112),
                  sliver: SliverList.builder(
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final loan = filtered[index];
                      final customer =
                          widget.appState.store.findCustomerAnyById(
                        loan.customerId,
                      );
                      final schedule =
                          widget.appState.store.emisForLoan(loan.id);
                      final paid = schedule.where((e) => e.isPaid).length;
                      final progress =
                          schedule.isEmpty ? 0.0 : paid / schedule.length;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: FintechSurfaceCard(
                          key: ValueKey('loan_card_${loan.id}'),
                          radius: AppRadius.tile,
                          padding: EdgeInsets.zero,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(AppRadius.tile),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                  builder: (_) => LoanOverviewScreen(
                                    appState: widget.appState,
                                    loanId: loan.id,
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FintechInitialsAvatar(
                                        initials: customer?.initials ?? 'LW',
                                        seed: customer?.name ?? loan.id,
                                        radius: 21,
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              customer?.name ?? loan.customerId,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: textTheme.titleSmall,
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              '${loan.id} · ${LoanDateUtils.formatShortDate(loan.startDate)}',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: textTheme.bodySmall,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      LoanStatusChip(
                                        label: loan.status == LoanStatus.active
                                            ? l10n.statusActive
                                            : l10n.statusCompleted,
                                        tone: loan.status == LoanStatus.active
                                            ? SemanticChipTone.active
                                            : SemanticChipTone.completed,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          IndianCurrencyFormatter.formatPaise(
                                            loan.principalPaise,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: textTheme.titleMedium,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        '${(progress * 100).round()}%',
                                        style: textTheme.labelSmall?.copyWith(
                                          color: colors.primary,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    l10n.progressPaidLabel(
                                      paid,
                                      schedule.length,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: textTheme.bodySmall,
                                  ),
                                  const SizedBox(height: 6),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: LinearProgressIndicator(
                                      value: progress,
                                      minHeight: 6,
                                      backgroundColor: colors.fieldFill,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        colors.success,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
