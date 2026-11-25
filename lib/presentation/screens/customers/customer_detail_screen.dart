import 'package:loan_management_app/core/theme/app_theme.dart';
import 'package:loan_management_app/core/utils/date_utils.dart';
import 'package:loan_management_app/core/utils/indian_currency_formatter.dart';
import 'package:loan_management_app/domain/models/loan_models.dart';
import 'package:loan_management_app/l10n/app_localizations.dart';
import 'package:loan_management_app/presentation/screens/customers/add_edit_customer_screen.dart';
import 'package:loan_management_app/presentation/screens/loans/create_loan_screen.dart';
import 'package:loan_management_app/presentation/screens/loans/loan_overview_screen.dart';
import 'package:loan_management_app/presentation/widgets/common/fintech_ui.dart';
import 'package:loan_management_app/presentation/widgets/common/loan_status_chip.dart';
import 'package:loan_management_app/state/app_state.dart';
import 'package:material_ui/material_ui.dart';

class CustomerDetailScreen extends StatelessWidget {
  const CustomerDetailScreen({
    super.key,
    required this.appState,
    required this.customerId,
  });

  final AppState appState;
  final String customerId;

  @override
  Widget build(BuildContext context) {
    final colors = context.lwColors;
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: Text(l10n.customerDetailTitle),
        actions: [
          IconButton(
            tooltip: l10n.editCustomerMenu,
            onPressed: () {
              final customer = appState.store.findCustomerById(customerId);
              if (customer == null) return;
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => AddEditCustomerScreen(
                    appState: appState,
                    existingCustomer: customer,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.edit_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: ListenableBuilder(
          listenable: appState,
          builder: (context, _) {
            final customer = appState.store.findCustomerById(customerId);
            if (customer == null) {
              return Center(child: Text(l10n.noCustomersTitle));
            }
            final loans = appState.store.loansForCustomer(customer.id);
            final activeCount =
                appState.store.activeLoansCountForCustomer(customer.id);

            return ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
              children: [
                FintechHeroBanner(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.18),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.35),
                                width: 1.5,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              customer.initials,
                              style: textTheme.titleLarge?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  customer.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: textTheme.titleLarge?.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${customer.mobile} · ${customer.location}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: textTheme.bodySmall?.copyWith(
                                    color: Colors.white.withValues(alpha: 0.88),
                                  ),
                                ),
                                if (customer.email.trim().isNotEmpty)
                                  Text(
                                    customer.email,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: textTheme.bodySmall?.copyWith(
                                      color:
                                          Colors.white.withValues(alpha: 0.78),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.16),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          l10n.activeLoansCountLabel(activeCount),
                          style: textTheme.labelMedium?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                FintechSurfaceCard(
                  padding: const EdgeInsets.all(14),
                  child: SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      style: FilledButton.styleFrom(
                        backgroundColor: colors.primary,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => CreateLoanScreen(
                              appState: appState,
                              preselectedCustomer: customer,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.add_card_rounded),
                      label: Text(l10n.createLoanMenu),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                FintechSectionHeader(
                  title: l10n.customerLoansHeading,
                  icon: Icons.account_balance_wallet_outlined,
                  trailing: Text(
                    '${loans.length}',
                    style: textTheme.labelMedium?.copyWith(
                      color: colors.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                if (loans.isEmpty)
                  EmptyStateCard(
                    icon: Icons.account_balance_wallet_outlined,
                    title: l10n.noLoansTitle,
                    subtitle: l10n.noLoansSubtitle,
                  )
                else
                  ...loans.map(
                    (loan) {
                      final emis = appState.store.emisForLoan(loan.id);
                      final paid = emis.where((e) => e.isPaid).length;
                      final progress = emis.isEmpty ? 0.0 : paid / emis.length;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: FintechSurfaceCard(
                          radius: AppRadius.tile,
                          padding: EdgeInsets.zero,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                  builder: (_) => LoanOverviewScreen(
                                    appState: appState,
                                    loanId: loan.id,
                                  ),
                                ),
                              );
                            },
                            borderRadius: BorderRadius.circular(AppRadius.tile),
                            child: Padding(
                              padding: const EdgeInsets.all(14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              IndianCurrencyFormatter
                                                  .formatPaise(
                                                loan.principalPaise,
                                              ),
                                              style: textTheme.titleMedium,
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              '${loan.id} · ${LoanDateUtils.formatShortDate(loan.startDate)}',
                                              style: textTheme.bodySmall,
                                            ),
                                          ],
                                        ),
                                      ),
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
                                  const SizedBox(height: 10),
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
                                  const SizedBox(height: 6),
                                  Text(
                                    l10n.progressPaidLabel(paid, emis.length),
                                    style: textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
