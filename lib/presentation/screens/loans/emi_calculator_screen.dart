import 'package:loan_management_app/core/theme/app_theme.dart';
import 'package:loan_management_app/core/utils/date_utils.dart';
import 'package:loan_management_app/core/utils/emi_calculator.dart';
import 'package:loan_management_app/core/utils/indian_currency_formatter.dart';
import 'package:loan_management_app/core/utils/validators.dart';
import 'package:loan_management_app/domain/models/loan_models.dart';
import 'package:loan_management_app/l10n/app_localizations.dart';
import 'package:loan_management_app/presentation/screens/customers/add_edit_customer_screen.dart';
import 'package:loan_management_app/presentation/screens/loans/create_loan_screen.dart';
import 'package:loan_management_app/presentation/widgets/common/fintech_ui.dart';
import 'package:loan_management_app/state/app_state.dart';
import 'package:material_ui/material_ui.dart';

class EmiCalculatorScreen extends StatefulWidget {
  const EmiCalculatorScreen({
    super.key,
    required this.appState,
  });

  final AppState appState;

  @override
  State<EmiCalculatorScreen> createState() => _EmiCalculatorScreenState();
}

class _EmiCalculatorScreenState extends State<EmiCalculatorScreen> {
  final TextEditingController _principalController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _tenureController = TextEditingController();

  LoanType _loanType = LoanType.compound;
  bool _showSchedule = false;

  @override
  void initState() {
    super.initState();
    _principalController.addListener(_recalculate);
    _rateController.addListener(_recalculate);
    _tenureController.addListener(_recalculate);
  }

  @override
  void dispose() {
    _principalController.removeListener(_recalculate);
    _rateController.removeListener(_recalculate);
    _tenureController.removeListener(_recalculate);
    _principalController.dispose();
    _rateController.dispose();
    _tenureController.dispose();
    super.dispose();
  }

  void _recalculate() {
    if (mounted) setState(() {});
  }

  void _reset() {
    _principalController.clear();
    _rateController.clear();
    _tenureController.clear();
    setState(() {
      _loanType = LoanType.compound;
      _showSchedule = false;
    });
  }

  String? _principalError(AppLocalizations l10n) {
    final text = _principalController.text.trim();
    if (text.isEmpty) return null;
    return LoanValidators.validatePrincipalText(text) != null
        ? l10n.invalidPrincipalError
        : null;
  }

  String? _rateError(AppLocalizations l10n) {
    final text = _rateController.text.trim();
    if (text.isEmpty) return null;
    return LoanValidators.validateRateText(text) != null
        ? l10n.invalidRateError
        : null;
  }

  String? _tenureError(AppLocalizations l10n) {
    final text = _tenureController.text.trim();
    if (text.isEmpty) return null;
    return LoanValidators.validateTenureText(text) != null
        ? l10n.invalidTenureError
        : null;
  }

  EmiCalculationResult? _computeResult() {
    final principalPaise = LoanValidators.parsePrincipalPaise(
      _principalController.text,
    );
    final ratePercent = LoanValidators.parseRatePercent(_rateController.text);
    final tenureMonths = LoanValidators.parseTenureMonths(
      _tenureController.text,
    );
    if (principalPaise == null || ratePercent == null || tenureMonths == null) {
      return null;
    }
    return EmiCalculator.calculate(
      principalPaise: principalPaise,
      monthlyRatePercent: ratePercent,
      tenureMonths: tenureMonths,
      loanType: _loanType,
      startDate: LoanDateUtils.toUtcMidnight(DateTime.now().toUtc()),
    );
  }

  void _proceedToCreateLoan() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => CreateLoanScreen(
          appState: widget.appState,
          initialPrincipalText: _principalController.text.trim(),
          initialRateText: _rateController.text.trim(),
          initialTenureText: _tenureController.text.trim(),
          initialLoanType: _loanType,
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

  @override
  Widget build(BuildContext context) {
    final colors = context.lwColors;
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final result = _computeResult();

    final principalPaise = result != null
        ? (LoanValidators.parsePrincipalPaise(_principalController.text) ??
            (result.totalPayablePaise - result.totalInterestPaise))
        : 0;
    final interestPaise = result?.totalInterestPaise ?? 0;
    final payablePaise = result?.totalPayablePaise ?? 0;
    final monthlyEmiPaise = result?.monthlyEmiPaise ?? 0;

    final principalShare =
        payablePaise > 0 ? principalPaise / payablePaise : 0.0;
    final interestShare = payablePaise > 0 ? interestPaise / payablePaise : 0.0;

    final principalErr = _principalError(l10n);
    final rateErr = _rateError(l10n);
    final tenureErr = _tenureError(l10n);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: Text(l10n.emiCalculatorTitle),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.emiCalculatorSubtitle,
                style: textTheme.bodySmall?.copyWith(color: colors.textMuted),
              ),
              const SizedBox(height: 10),
              FintechHeroBanner(
                key: const ValueKey('emi_calc_summary_card'),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.monthlyEmiLabel,
                      style: textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.85),
                      ),
                    ),
                    const SizedBox(height: 4),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        IndianCurrencyFormatter.formatPaise(monthlyEmiPaise),
                        key: const ValueKey('emi_calc_monthly_value'),
                        style: textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    if (result == null) ...[
                      const SizedBox(height: 4),
                      Text(
                        l10n.enterTermsForEstimate,
                        style: textTheme.bodySmall?.copyWith(
                          color: Colors.white.withValues(alpha: 0.82),
                        ),
                      ),
                    ],
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: SizedBox(
                        height: 6,
                        child: Row(
                          children: [
                            Expanded(
                              flex: payablePaise > 0
                                  ? (principalShare * 1000)
                                      .round()
                                      .clamp(1, 1000)
                                  : 1,
                              child: Container(
                                color: Colors.white.withValues(
                                  alpha: payablePaise > 0 ? 0.95 : 0.25,
                                ),
                              ),
                            ),
                            if (payablePaise > 0 && interestPaise > 0)
                              Expanded(
                                flex: (interestShare * 1000)
                                    .round()
                                    .clamp(1, 1000),
                                child: Container(
                                  color:
                                      Colors.amberAccent.withValues(alpha: 0.9),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 14,
                      runSpacing: 6,
                      children: [
                        _CalcHeroMetric(
                          label:
                              '${l10n.principalShareLabel} (${(principalShare * 100).round()}%)',
                          value: IndianCurrencyFormatter.formatPaise(
                            principalPaise,
                          ),
                        ),
                        _CalcHeroMetric(
                          label:
                              '${l10n.interestShareLabel} (${(interestShare * 100).round()}%)',
                          value: IndianCurrencyFormatter.formatPaise(
                            interestPaise,
                          ),
                        ),
                        _CalcHeroMetric(
                          label: l10n.totalPayableLabel,
                          value: IndianCurrencyFormatter.formatPaise(
                            payablePaise,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              FintechSurfaceCard(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      key: const ValueKey('emi_calc_principal_field'),
                      controller: _principalController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        isDense: true,
                        labelText: l10n.principalLabel,
                        errorText: principalErr,
                        prefixIcon: const Icon(Icons.currency_rupee_rounded),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      key: const ValueKey('emi_calc_rate_field'),
                      controller: _rateController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        isDense: true,
                        labelText: l10n.monthlyRateLabel,
                        errorText: rateErr,
                        prefixIcon: const Icon(Icons.percent_rounded),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      key: const ValueKey('emi_calc_tenure_field'),
                      controller: _tenureController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        isDense: true,
                        labelText: l10n.tenureMonthsLabel,
                        errorText: tenureErr,
                        prefixIcon: const Icon(Icons.calendar_month_outlined),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(l10n.loanTypeLabel, style: textTheme.labelMedium),
                    const SizedBox(height: 6),
                    SegmentedButton<LoanType>(
                      key: const ValueKey('emi_calc_type_selector'),
                      segments: [
                        ButtonSegment(
                          value: LoanType.simple,
                          label: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(l10n.loanTypeSimple),
                          ),
                        ),
                        ButtonSegment(
                          value: LoanType.compound,
                          label: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(l10n.loanTypeCompound),
                          ),
                        ),
                      ],
                      selected: {_loanType},
                      onSelectionChanged: (set) {
                        setState(() => _loanType = set.first);
                      },
                    ),
                  ],
                ),
              ),
              if (result != null) ...[
                const SizedBox(height: 14),
                FintechSurfaceCard(
                  radius: AppRadius.tile,
                  padding: EdgeInsets.zero,
                  child: InkWell(
                    key: const ValueKey('emi_calc_toggle_schedule'),
                    onTap: () => setState(() => _showSchedule = !_showSchedule),
                    borderRadius: BorderRadius.circular(AppRadius.tile),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.table_rows_outlined, color: colors.primary),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              '${l10n.schedulePreviewHeading} (${result.rows.length})',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.titleSmall,
                            ),
                          ),
                          Icon(
                            _showSchedule
                                ? Icons.expand_less_rounded
                                : Icons.expand_more_rounded,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (_showSchedule) ...[
                  const SizedBox(height: 8),
                  FintechSurfaceCard(
                    radius: AppRadius.tile,
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      children: result.rows.take(24).map((row) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  l10n.installmentLabel(row.installmentNo),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: textTheme.labelMedium,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  LoanDateUtils.formatShortDate(row.dueDate),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: textTheme.bodySmall,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  IndianCurrencyFormatter.formatPaise(
                                    row.emiPaise,
                                  ),
                                  textAlign: TextAlign.end,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: textTheme.titleSmall,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ],
              const SizedBox(height: 18),
              LayoutBuilder(
                builder: (context, constraints) {
                  final textScale =
                      MediaQuery.textScalerOf(context).scale(14) / 14;
                  final stack = constraints.maxWidth < 360 || textScale > 1.2;
                  final resetBtn = OutlinedButton(
                    key: const ValueKey('emi_calc_reset_button'),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                    ),
                    onPressed: _reset,
                    child: Text(l10n.resetFieldsButton),
                  );
                  final createBtn = FilledButton.icon(
                    key: const ValueKey('emi_calc_create_loan_button'),
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor: colors.primary,
                    ),
                    onPressed: result != null ? _proceedToCreateLoan : null,
                    icon: const Icon(Icons.add_card_rounded),
                    label: Text(l10n.proceedToCreateLoanButton),
                  );

                  if (stack) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        createBtn,
                        const SizedBox(height: 10),
                        resetBtn,
                      ],
                    );
                  }
                  return Row(
                    children: [
                      Expanded(flex: 2, child: resetBtn),
                      const SizedBox(width: 12),
                      Expanded(flex: 4, child: createBtn),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CalcHeroMetric extends StatelessWidget {
  const _CalcHeroMetric({
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
          value,
          style: textTheme.titleSmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          label,
          style: textTheme.bodySmall?.copyWith(
            color: Colors.white.withValues(alpha: 0.80),
          ),
        ),
      ],
    );
  }
}
