import 'package:loan_management_app/core/error/failures.dart';
import 'package:loan_management_app/core/theme/app_theme.dart';
import 'package:loan_management_app/core/utils/date_utils.dart';
import 'package:loan_management_app/core/utils/indian_currency_formatter.dart';
import 'package:loan_management_app/data/repositories/loanwise_store.dart';
import 'package:loan_management_app/domain/models/loan_models.dart';
import 'package:loan_management_app/l10n/app_localizations.dart';
import 'package:loan_management_app/l10n/l10n_failure_resolver.dart';
import 'package:loan_management_app/presentation/screens/documents/document_viewer_screen.dart';
import 'package:loan_management_app/presentation/screens/documents/documents_screen.dart';
import 'package:loan_management_app/presentation/widgets/common/fintech_ui.dart';
import 'package:loan_management_app/presentation/widgets/common/loan_status_chip.dart';
import 'package:loan_management_app/state/app_state.dart';
import 'package:material_ui/material_ui.dart';

class LoanOverviewScreen extends StatefulWidget {
  const LoanOverviewScreen({
    super.key,
    required this.appState,
    required this.loanId,
  });

  final AppState appState;
  final String loanId;

  @override
  State<LoanOverviewScreen> createState() => _LoanOverviewScreenState();
}

class _LoanOverviewScreenState extends State<LoanOverviewScreen> {
  bool _isProcessing = false;
  bool _showLedger = false;

  Future<void> _handlePaySingleEmi(EmiScheduleItem item) async {
    final l10n = AppLocalizations.of(context);
    final colors = context.lwColors;
    DateTime selectedDate = LoanDateUtils.toUtcMidnight(DateTime.now().toUtc());

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(l10n.confirmPayEmiTitle(item.installmentNo)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.confirmPayEmiMessage(
                  IndianCurrencyFormatter.formatPaise(item.emiPaise),
                ),
              ),
              const SizedBox(height: 14),
              InkWell(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    setDialogState(() {
                      selectedDate = LoanDateUtils.toUtcMidnight(picked);
                    });
                  }
                },
                borderRadius: BorderRadius.circular(10),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: l10n.paymentDateLabel,
                    border: const OutlineInputBorder(),
                    isDense: true,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(LoanDateUtils.formatShortDate(selectedDate)),
                      const Icon(Icons.calendar_today_outlined, size: 18),
                    ],
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(l10n.cancelAction),
            ),
            FilledButton(
              key: const ValueKey('confirm_pay_emi_button'),
              onPressed: () => Navigator.of(dialogContext).pop(true),
              style: FilledButton.styleFrom(backgroundColor: colors.primary),
              child: Text(l10n.payButton),
            ),
          ],
        ),
      ),
    );

    if (confirmed != true || !mounted) return;

    final result = widget.appState.markEmiPaid(
      loanId: widget.loanId,
      emiId: item.id,
      paidDate: selectedDate,
    );

    if (!mounted) return;
    switch (result) {
      case Err<LoanPaymentOutcome>(:final failure):
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: colors.danger,
              content: Text(resolveFailureMessage(l10n, failure)),
            ),
          );
      case Success<LoanPaymentOutcome>(:final data):
        if (data.loanJustCompleted && data.generatedDocument != null) {
          _showPdfCompletedSnackBar(data.generatedDocument!);
        } else if (data.emiReceiptDocument != null) {
          _showEmiPdfSnackBar(
            data.emiReceiptDocument!,
            item.installmentNo,
          );
        } else {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text(l10n.emiPaidSuccess(item.installmentNo)),
              ),
            );
        }
    }
  }

  Future<void> _handlePayAllPending(
    List<EmiScheduleItem> pendingItems,
  ) async {
    final l10n = AppLocalizations.of(context);
    final colors = context.lwColors;
    final totalRemainingPaise = pendingItems.fold<int>(
      0,
      (sum, item) => sum + item.emiPaise,
    );

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.confirmPayAllTitle),
        content: Text(
          l10n.confirmPayAllMessage(
            pendingItems.length,
            IndianCurrencyFormatter.formatPaise(totalRemainingPaise),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.cancelAction),
          ),
          FilledButton(
            key: const ValueKey('confirm_pay_all_button'),
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: FilledButton.styleFrom(backgroundColor: colors.primary),
            child: Text(l10n.payAllPendingButton),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    setState(() => _isProcessing = true);
    final res = widget.appState.payAllPendingEmis(
      loanId: widget.loanId,
      paidDate: LoanDateUtils.toUtcMidnight(DateTime.now().toUtc()),
    );
    if (!mounted) return;
    setState(() => _isProcessing = false);

    switch (res) {
      case Err<LoanPaymentOutcome>(:final failure):
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: colors.danger,
              content: Text(resolveFailureMessage(l10n, failure)),
            ),
          );
      case Success<LoanPaymentOutcome>(:final data):
        if (data.pdfFailure != null) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: colors.danger,
                content: Text(data.pdfFailure!.detail ?? l10n.appTitle),
                action: SnackBarAction(
                  label: l10n.regeneratePdfButton,
                  textColor: Colors.white,
                  onPressed: () {
                    final retry = widget.appState.retryGeneratePdf(
                      widget.loanId,
                    );
                    if (retry is Success<LoanDocument> && mounted) {
                      _showPdfCompletedSnackBar(retry.data);
                    }
                  },
                ),
              ),
            );
        } else if (data.generatedDocument != null) {
          _showPdfCompletedSnackBar(data.generatedDocument!);
        }
    }
  }

  void _openOrGenerateEmiPdf(Loan loan, EmiScheduleItem emi) {
    final existing = widget.appState.store.findDocumentForEmi(
      loan.id,
      emi.installmentNo,
    );
    final doc = existing ??
        widget.appState
            .generateEmiPdf(loanId: loan.id, emiId: emi.id)
            .dataOrNull;
    if (doc != null && mounted) {
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => DocumentViewerScreen(document: doc),
        ),
      );
    }
  }

  void _openOrGenerateCompletePdf(Loan loan) {
    final existing = widget.appState.store.findDocumentForLoan(loan.id);
    final doc = existing ??
        widget.appState.generateCompleteLoanPdf(loan.id).dataOrNull;
    if (doc != null && mounted) {
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => DocumentViewerScreen(document: doc),
        ),
      );
    }
  }

  void _showEmiPdfSnackBar(LoanDocument doc, int installmentNo) {
    final l10n = AppLocalizations.of(context);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 5),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.emiPdfGeneratedMessage(installmentNo)),
              const SizedBox(height: 6),
              Wrap(
                spacing: 8,
                children: [
                  TextButton(
                    key: const ValueKey('snackbar_view_emi_pdf'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => DocumentViewerScreen(document: doc),
                        ),
                      );
                    },
                    child: Text(l10n.viewPdfAction),
                  ),
                  TextButton(
                    key: const ValueKey('snackbar_open_documents'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => DocumentsScreen(
                            appState: widget.appState,
                          ),
                        ),
                      );
                    },
                    child: Text(l10n.openDocumentsAction),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
  }

  void _showPdfCompletedSnackBar(LoanDocument doc) {
    final l10n = AppLocalizations.of(context);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 6),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.loanCompletedPdfGenerated),
              const SizedBox(height: 6),
              Wrap(
                spacing: 8,
                children: [
                  TextButton(
                    key: const ValueKey('snackbar_view_pdf'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => DocumentViewerScreen(document: doc),
                        ),
                      );
                    },
                    child: Text(l10n.viewPdfAction),
                  ),
                  TextButton(
                    key: const ValueKey('snackbar_open_documents'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => DocumentsScreen(
                            appState: widget.appState,
                          ),
                        ),
                      );
                    },
                    child: Text(l10n.openDocumentsAction),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.lwColors;
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: Text(l10n.loanOverviewTitle),
      ),
      body: SafeArea(
        child: ListenableBuilder(
          listenable: widget.appState,
          builder: (context, _) {
            final store = widget.appState.store;
            final loan = store.findLoanById(widget.loanId);
            if (loan == null) {
              return Center(child: Text(l10n.noLoansTitle));
            }
            final customer = store.findCustomerAnyById(loan.customerId);
            final schedule = store.emisForLoan(loan.id);
            final ledger = store.ledgerForLoan(loan.id);
            final paidCount = schedule.where((e) => e.isPaid).length;
            final pendingItems = schedule.where((e) => !e.isPaid).toList();
            final progress =
                schedule.isEmpty ? 0.0 : paidCount / schedule.length;
            final ledgerBalance = store.currentLoanLedgerBalance(loan.id);

            return CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        FintechHeroBanner(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color:
                                          Colors.white.withValues(alpha: 0.18),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color:
                                            Colors.white.withValues(alpha: 0.3),
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      customer?.initials ?? 'LW',
                                      style: textTheme.titleSmall?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          customer?.name ?? loan.customerId,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: textTheme.titleMedium?.copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          '${loan.id} · ${customer?.mobile ?? ''}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: textTheme.bodySmall?.copyWith(
                                            color: Colors.white
                                                .withValues(alpha: 0.84),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: loan.status == LoanStatus.active
                                          ? Colors.white.withValues(alpha: 0.20)
                                          : LoanWiseColors.emeraldAccent
                                              .withValues(alpha: 0.28),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      loan.status == LoanStatus.active
                                          ? l10n.statusActive
                                          : l10n.statusCompleted,
                                      style: textTheme.labelSmall?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Wrap(
                                spacing: 20,
                                runSpacing: 6,
                                children: [
                                  _HeroStatBlock(
                                    label: l10n.totalPayableLabel,
                                    value: IndianCurrencyFormatter.formatPaise(
                                      loan.totalPayablePaise,
                                    ),
                                  ),
                                  _HeroStatBlock(
                                    label: l10n.ledgerBalanceLabel,
                                    value: IndianCurrencyFormatter.formatPaise(
                                      ledgerBalance,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      l10n.progressPaidLabel(
                                        paidCount,
                                        schedule.length,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: textTheme.labelMedium?.copyWith(
                                        color: Colors.white
                                            .withValues(alpha: 0.92),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${(progress * 100).round()}%',
                                    style: textTheme.labelMedium?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: LinearProgressIndicator(
                                  value: progress,
                                  minHeight: 6,
                                  backgroundColor:
                                      Colors.white.withValues(alpha: 0.22),
                                  valueColor: const AlwaysStoppedAnimation<Color>(
                                    LoanWiseColors.emeraldAccent,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        FintechSurfaceCard(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  _LoanMetaItem(
                                    label: l10n.principalLabel,
                                    value: IndianCurrencyFormatter.formatPaise(
                                      loan.principalPaise,
                                    ),
                                  ),
                                  _LoanMetaItem(
                                    label: l10n.monthlyEmiLabel,
                                    value: IndianCurrencyFormatter.formatPaise(
                                      loan.monthlyEmiPaise,
                                    ),
                                  ),
                                  _LoanMetaItem(
                                    label: l10n.monthlyRateLabel,
                                    value:
                                        '${loan.monthlyRatePercent.toStringAsFixed(2)}%',
                                  ),
                                  _LoanMetaItem(
                                    label: l10n.tenureMonthsLabel,
                                    value: '${loan.tenureMonths}',
                                  ),
                                  _LoanMetaItem(
                                    label: l10n.loanTypeLabel,
                                    value: loan.type == LoanType.simple
                                        ? l10n.loanTypeSimple
                                        : l10n.loanTypeCompound,
                                  ),
                                  _LoanMetaItem(
                                    label: l10n.totalInterestLabel,
                                    value: IndianCurrencyFormatter.formatPaise(
                                      loan.totalInterestPaise,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              if (pendingItems.isNotEmpty)
                                SizedBox(
                                  width: double.infinity,
                                  child: FilledButton.icon(
                                    key: const ValueKey(
                                      'pay_all_pending_button',
                                    ),
                                    style: FilledButton.styleFrom(
                                      minimumSize: const Size.fromHeight(44),
                                      backgroundColor: colors.primary,
                                    ),
                                    onPressed: _isProcessing
                                        ? null
                                        : () => _handlePayAllPending(
                                              pendingItems,
                                            ),
                                    icon: _isProcessing
                                        ? const SizedBox(
                                            width: 18,
                                            height: 18,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: Colors.white,
                                            ),
                                          )
                                        : const Icon(Icons.done_all_rounded),
                                    label: Text(l10n.payAllPendingButton),
                                  ),
                                )
                              else
                                SizedBox(
                                  width: double.infinity,
                                  child: FilledButton.icon(
                                    key: const ValueKey(
                                      'view_complete_pdf_button',
                                    ),
                                    style: FilledButton.styleFrom(
                                      minimumSize: const Size.fromHeight(44),
                                      backgroundColor: colors.success,
                                    ),
                                    onPressed: () =>
                                        _openOrGenerateCompletePdf(loan),
                                    icon: const Icon(
                                      Icons.picture_as_pdf_rounded,
                                    ),
                                    label: Text(l10n.viewCompletePdfButton),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        FintechSurfaceCard(
                          radius: AppRadius.tile,
                          padding: EdgeInsets.zero,
                          child: InkWell(
                            onTap: () =>
                                setState(() => _showLedger = !_showLedger),
                            borderRadius: BorderRadius.circular(AppRadius.tile),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 10,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color:
                                          colors.primary.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(9),
                                    ),
                                    child: Icon(
                                      Icons.receipt_long_outlined,
                                      size: 17,
                                      color: colors.primary,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      '${l10n.ledgerHeading} (${ledger.length})',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: textTheme.titleSmall,
                                    ),
                                  ),
                                  Icon(
                                    _showLedger
                                        ? Icons.expand_less_rounded
                                        : Icons.expand_more_rounded,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        if (_showLedger) ...[
                          const SizedBox(height: 8),
                          FintechSurfaceCard(
                            radius: AppRadius.tile,
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              children: ledger.map((entry) {
                                final isDebit = entry.debitPaise > 0;
                                final tone =
                                    isDebit ? colors.danger : colors.success;
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 26,
                                        height: 26,
                                        decoration: BoxDecoration(
                                          color: tone.withValues(alpha: 0.12),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          isDebit
                                              ? Icons.arrow_downward_rounded
                                              : Icons.arrow_upward_rounded,
                                          size: 15,
                                          color: tone,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          isDebit
                                              ? l10n.ledgerDebitLabel
                                              : l10n.ledgerCreditLabel,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: textTheme.labelMedium?.copyWith(
                                            color: tone,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        IndianCurrencyFormatter.formatPaise(
                                          isDebit
                                              ? entry.debitPaise
                                              : entry.creditPaise,
                                        ),
                                        style: textTheme.bodyMedium?.copyWith(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Flexible(
                                        child: Text(
                                          '${l10n.ledgerBalanceLabel}: ${IndianCurrencyFormatter.formatPaise(entry.balanceAfterPaise)}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: textTheme.bodySmall,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                        const SizedBox(height: 12),
                        FintechSectionHeader(
                          title: l10n.emiScheduleHeading,
                          icon: Icons.event_repeat_rounded,
                          trailing: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 9,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: colors.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              '${schedule.length}',
                              style: textTheme.labelSmall?.copyWith(
                                color: colors.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 28),
                  sliver: SliverList.builder(
                    itemCount: schedule.length,
                    itemBuilder: (context, index) {
                      final emi = schedule[index];
                      final isOverdue = emi.isOverdueAt();
                      final chipLabel = emi.isPaid
                          ? l10n.statusPaid
                          : (isOverdue
                              ? l10n.statusOverdue
                              : l10n.statusPending);
                      final chipTone = emi.isPaid
                          ? SemanticChipTone.paid
                          : (isOverdue
                              ? SemanticChipTone.overdue
                              : SemanticChipTone.pending);
                      final badgeColor = emi.isPaid
                          ? colors.success
                          : (isOverdue ? colors.danger : colors.primary);

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: FintechSurfaceCard(
                          key: ValueKey('emi_row_${emi.installmentNo}'),
                          radius: AppRadius.tile,
                          padding: const EdgeInsets.all(14),
                          borderColor: isOverdue
                              ? colors.danger.withValues(alpha: 0.45)
                              : null,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 34,
                                height: 34,
                                decoration: BoxDecoration(
                                  color: badgeColor.withValues(alpha: 0.12),
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  '${emi.installmentNo}',
                                  style: textTheme.labelMedium?.copyWith(
                                    color: badgeColor,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Wrap(
                                      spacing: 8,
                                      runSpacing: 4,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: [
                                        Text(
                                          l10n.installmentLabel(
                                            emi.installmentNo,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: textTheme.titleSmall,
                                        ),
                                        LoanStatusChip(
                                          label: chipLabel,
                                          tone: chipTone,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      l10n.dueSinceLabel(
                                        LoanDateUtils.formatShortDate(
                                          emi.dueDate,
                                        ),
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: textTheme.bodySmall,
                                    ),
                                    if (emi.paidDate != null)
                                      Text(
                                        l10n.paidOnLabel(
                                          LoanDateUtils.formatShortDate(
                                            emi.paidDate!,
                                          ),
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: textTheme.bodySmall?.copyWith(
                                          color: colors.success,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    IndianCurrencyFormatter.formatPaise(
                                      emi.emiPaise,
                                    ),
                                    style: textTheme.titleSmall,
                                  ),
                                  const SizedBox(height: 6),
                                  if (!emi.isPaid)
                                    SizedBox(
                                      height: 36,
                                      child: FilledButton.tonal(
                                        key: ValueKey(
                                          'pay_emi_${emi.installmentNo}',
                                        ),
                                        onPressed: () =>
                                            _handlePaySingleEmi(emi),
                                        child: Text(l10n.payButton),
                                      ),
                                    )
                                  else
                                    SizedBox(
                                      height: 36,
                                      child: OutlinedButton.icon(
                                        key: ValueKey(
                                          'emi_pdf_${emi.installmentNo}',
                                        ),
                                        style: OutlinedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                        ),
                                        onPressed: () =>
                                            _openOrGenerateEmiPdf(loan, emi),
                                        icon: const Icon(
                                          Icons.picture_as_pdf_outlined,
                                          size: 16,
                                        ),
                                        label: Text(l10n.emiPdfButton),
                                      ),
                                    ),
                                ],
                              ),
                            ],
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
      ),
    );
  }
}

class _HeroStatBlock extends StatelessWidget {
  const _HeroStatBlock({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: textTheme.bodySmall?.copyWith(
            color: Colors.white.withValues(alpha: 0.78),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

class _LoanMetaItem extends StatelessWidget {
  const _LoanMetaItem({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = context.lwColors;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      width: 112,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: colors.fieldFill,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: colors.fieldBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodySmall,
          ),
          const SizedBox(height: 2),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}
