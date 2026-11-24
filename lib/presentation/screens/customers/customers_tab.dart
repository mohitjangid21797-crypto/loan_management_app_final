import 'dart:async';

import 'package:loan_management_app/core/error/failures.dart';
import 'package:loan_management_app/core/theme/app_theme.dart';
import 'package:loan_management_app/domain/models/loan_models.dart';
import 'package:loan_management_app/l10n/app_localizations.dart';
import 'package:loan_management_app/l10n/l10n_failure_resolver.dart';
import 'package:loan_management_app/presentation/screens/customers/add_edit_customer_screen.dart';
import 'package:loan_management_app/presentation/screens/customers/customer_detail_screen.dart';
import 'package:loan_management_app/presentation/screens/loans/create_loan_screen.dart';
import 'package:loan_management_app/presentation/widgets/common/fintech_ui.dart';
import 'package:loan_management_app/presentation/widgets/common/loan_status_chip.dart';
import 'package:loan_management_app/state/app_state.dart';
import 'package:material_ui/material_ui.dart';

enum _CustomerMenuAction { edit, delete, createLoan }

class CustomersTab extends StatefulWidget {
  const CustomersTab({
    super.key,
    required this.appState,
    required this.onOpenDrawer,
  });

  final AppState appState;
  final VoidCallback onOpenDrawer;

  @override
  State<CustomersTab> createState() => _CustomersTabState();
}

class _CustomersTabState extends State<CustomersTab> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  String _query = '';

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    setState(() {});
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() => _query = value.trim().toLowerCase());
      }
    });
  }

  void _clearSearch() {
    _debounce?.cancel();
    _searchController.clear();
    setState(() => _query = '');
  }

  Future<void> _openAddCustomer() async {
    await Navigator.of(context).push<Customer?>(
      MaterialPageRoute<Customer?>(
        builder: (_) => AddEditCustomerScreen(appState: widget.appState),
      ),
    );
  }

  Future<void> _confirmDeleteCustomer(Customer customer) async {
    final l10n = AppLocalizations.of(context);
    final colors = context.lwColors;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.deleteCustomerConfirmTitle),
        content: Text(l10n.deleteCustomerConfirmMessage(customer.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.cancelAction),
          ),
          TextButton(
            key: const ValueKey('confirm_delete_customer_button'),
            style: TextButton.styleFrom(foregroundColor: colors.danger),
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(l10n.deleteAction),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;
    final res = widget.appState.deleteCustomer(customer.id);
    if (res is Err<Customer> && mounted) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: colors.danger,
            content: Text(resolveFailureMessage(l10n, res.failure)),
          ),
        );
    }
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
          final allCustomers = widget.appState.customers;
          final filtered = _query.isEmpty
              ? allCustomers
              : allCustomers
                  .where(
                    (c) =>
                        c.name.toLowerCase().contains(_query) ||
                        c.mobile.contains(_query),
                  )
                  .toList();

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
                            child: Text(
                              l10n.navCustomers,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.titleLarge,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: colors.primary.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              '${allCustomers.length}',
                              style: textTheme.labelSmall?.copyWith(
                                color: colors.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        l10n.tabCustomersSubtitle,
                        style: textTheme.bodyMedium?.copyWith(
                          color: colors.textMuted,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          key: const ValueKey('customers_add_fab'),
                          onPressed: _openAddCustomer,
                          style: FilledButton.styleFrom(
                            minimumSize: const Size.fromHeight(46),
                            backgroundColor: colors.primary,
                          ),
                          icon: const Icon(Icons.person_add_alt_1_rounded,
                              size: 20),
                          label: Text(l10n.actionAddCustomer),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        key: const ValueKey('customers_search_field'),
                        controller: _searchController,
                        onChanged: _onSearchChanged,
                        decoration: InputDecoration(
                          hintText: l10n.searchCustomersHint,
                          prefixIcon: const Icon(Icons.search_rounded),
                          suffixIcon: _searchController.text.isNotEmpty
                              ? IconButton(
                                  tooltip: l10n.closeAction,
                                  onPressed: _clearSearch,
                                  icon: const Icon(Icons.close_rounded),
                                )
                              : null,
                          filled: true,
                          fillColor: colors.surface,
                        ),
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
                      icon: Icons.groups_outlined,
                      title: l10n.noCustomersTitle,
                      subtitle: l10n.noCustomersSubtitle,
                      action: FilledButton.icon(
                        onPressed: _openAddCustomer,
                        icon: const Icon(Icons.person_add_alt_1_rounded),
                        label: Text(l10n.actionAddCustomer),
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
                      final customer = filtered[index];
                      final activeCount = widget.appState.store
                          .activeLoansCountForCustomer(customer.id);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: FintechSurfaceCard(
                          key: ValueKey('customer_card_${customer.mobile}'),
                          radius: AppRadius.tile,
                          padding: EdgeInsets.zero,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(AppRadius.tile),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                  builder: (_) => CustomerDetailScreen(
                                    appState: widget.appState,
                                    customerId: customer.id,
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(14, 14, 6, 14),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FintechInitialsAvatar(
                                    initials: customer.initials,
                                    seed: customer.name,
                                    radius: 23,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Wrap(
                                          spacing: 8,
                                          runSpacing: 4,
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          children: [
                                            Text(
                                              customer.name,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: textTheme.titleSmall,
                                            ),
                                            LoanStatusChip(
                                              label: l10n.activeLoansCountLabel(
                                                activeCount,
                                              ),
                                              tone: activeCount > 0
                                                  ? SemanticChipTone.active
                                                  : SemanticChipTone.completed,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 6),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.phone_outlined,
                                              size: 14,
                                              color: colors.textMuted,
                                            ),
                                            const SizedBox(width: 5),
                                            Expanded(
                                              child: Text(
                                                '${customer.mobile} · ${customer.location}',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: textTheme.bodySmall,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 3),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.mail_outline_rounded,
                                              size: 14,
                                              color: colors.textMuted,
                                            ),
                                            const SizedBox(width: 5),
                                            Expanded(
                                              child: Text(
                                                customer.email,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: textTheme.bodySmall,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  PopupMenuButton<_CustomerMenuAction>(
                                    key: ValueKey(
                                      'customer_menu_${customer.mobile}',
                                    ),
                                    onSelected: (action) {
                                      switch (action) {
                                        case _CustomerMenuAction.edit:
                                          Navigator.of(context).push(
                                            MaterialPageRoute<void>(
                                              builder: (_) =>
                                                  AddEditCustomerScreen(
                                                appState: widget.appState,
                                                existingCustomer: customer,
                                              ),
                                            ),
                                          );
                                        case _CustomerMenuAction.delete:
                                          _confirmDeleteCustomer(customer);
                                        case _CustomerMenuAction.createLoan:
                                          Navigator.of(context).push(
                                            MaterialPageRoute<void>(
                                              builder: (_) => CreateLoanScreen(
                                                appState: widget.appState,
                                                preselectedCustomer: customer,
                                              ),
                                            ),
                                          );
                                      }
                                    },
                                    itemBuilder: (context) => [
                                      PopupMenuItem(
                                        value: _CustomerMenuAction.edit,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.edit_outlined,
                                              size: 18,
                                              color: colors.primary,
                                            ),
                                            const SizedBox(width: 10),
                                            Text(l10n.editCustomerMenu),
                                          ],
                                        ),
                                      ),
                                      PopupMenuItem(
                                        value: _CustomerMenuAction.createLoan,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.add_card_rounded,
                                              size: 18,
                                              color: colors.success,
                                            ),
                                            const SizedBox(width: 10),
                                            Text(l10n.createLoanMenu),
                                          ],
                                        ),
                                      ),
                                      PopupMenuItem(
                                        value: _CustomerMenuAction.delete,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.delete_outline_rounded,
                                              size: 18,
                                              color: colors.danger,
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              l10n.deleteCustomerMenu,
                                              style: TextStyle(
                                                color: colors.danger,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
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
