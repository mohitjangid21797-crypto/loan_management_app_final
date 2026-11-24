import 'package:loan_management_app/core/error/failures.dart';
import 'package:loan_management_app/core/theme/app_theme.dart';
import 'package:loan_management_app/core/utils/date_utils.dart';
import 'package:loan_management_app/core/utils/emi_calculator.dart';
import 'package:loan_management_app/core/utils/indian_currency_formatter.dart';
import 'package:loan_management_app/core/utils/validators.dart';
import 'package:loan_management_app/domain/models/loan_models.dart';
import 'package:loan_management_app/l10n/app_localizations.dart';
import 'package:loan_management_app/l10n/l10n_failure_resolver.dart';
import 'package:loan_management_app/presentation/screens/loans/loan_overview_screen.dart';
import 'package:loan_management_app/presentation/widgets/common/fintech_ui.dart';
import 'package:loan_management_app/state/app_state.dart';
import 'package:material_ui/material_ui.dart';

class CreateLoanScreen extends StatefulWidget {
  const CreateLoanScreen({
    super.key,
    required this.appState,
    this.preselectedCustomer,
    this.onAddCustomerRequested,
    this.initialPrincipalText,
    this.initialRateText,
    this.initialTenureText,
    this.initialLoanType,
  });

  final AppState appState;
  final Customer? preselectedCustomer;
  final Future<Customer?> Function(String prefilledMobile)?
      onAddCustomerRequested;
  final String? initialPrincipalText;
  final String? initialRateText;
  final String? initialTenureText;
  final LoanType? initialLoanType;

  @override
  State<CreateLoanScreen> createState() => _CreateLoanScreenState();
}

class _CreateLoanScreenState extends State<CreateLoanScreen> {
  late final TextEditingController _mobileSearchController;
  late final TextEditingController _principalController;
  late final TextEditingController _rateController;
  late final TextEditingController _tenureController;

  Customer? _selectedCustomer;
  late LoanType _loanType;
  DateTime _startDate = LoanDateUtils.toUtcMidnight(DateTime.now().toUtc());
  String? _formError;

  @override
  void initState() {
    super.initState();
    _selectedCustomer = widget.preselectedCustomer;
    _loanType = widget.initialLoanType ?? LoanType.compound;
    _mobileSearchController = TextEditingController(
      text: widget.preselectedCustomer?.mobile ?? '',
    );
    _principalController = TextEditingController(
      text: widget.initialPrincipalText ?? '',
    );
    _rateController = TextEditingController(
      text: widget.initialRateText ?? '',
    );
    _tenureController = TextEditingController(
      text: widget.initialTenureText ?? '',
    );
    _mobileSearchController.addListener(_onMobileSearchChanged);
    _principalController.addListener(_refreshPreview);
    _rateController.addListener(_refreshPreview);
    _tenureController.addListener(_refreshPreview);
  }

  @override
  void dispose() {
    _mobileSearchController.removeListener(_onMobileSearchChanged);
    _principalController.removeListener(_refreshPreview);
    _rateController.removeListener(_refreshPreview);
    _tenureController.removeListener(_refreshPreview);
    _mobileSearchController.dispose();
    _principalController.dispose();
    _rateController.dispose();
    _tenureController.dispose();
    super.dispose();
  }

  void _refreshPreview() {
    setState(() {});
  }

  void _onMobileSearchChanged() {
    final clean = _mobileSearchController.text.trim();
    if (clean.length == 10) {
      final matched = widget.appState.store.findCustomerByMobile(clean);
      setState(() {
        _selectedCustomer = matched;
        _formError = null;
      });
    } else if (_selectedCustomer != null &&
        _selectedCustomer!.mobile != clean) {
      setState(() => _selectedCustomer = null);
    } else {
      setState(() {});
    }
  }

  EmiCalculationResult? _computePreview() {
    final principal = LoanValidators.parsePrincipalPaise(
      _principalController.text,
    );
    final rate = LoanValidators.parseRatePercent(_rateController.text);
    final tenure = LoanValidators.parseTenureMonths(_tenureController.text);
    if (principal == null || rate == null || tenure == null) {
      return null;
    }
    return EmiCalculator.calculate(
      principalPaise: principal,
      monthlyRatePercent: rate,
      tenureMonths: tenure,
      loanType: _loanType,
      startDate: _startDate,
    );
  }

  Future<void> _pickStartDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => _startDate = LoanDateUtils.toUtcMidnight(picked));
    }
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    final customer = _selectedCustomer;
    if (customer == null) {
      setState(() => _formError = l10n.selectCustomerError);
      return;
    }
    final principalPaise = LoanValidators.parsePrincipalPaise(
      _principalController.text,
    );
    if (principalPaise == null) {
      setState(() => _formError = l10n.invalidPrincipalError);
      return;
    }
    final ratePercent = LoanValidators.parseRatePercent(_rateController.text);
    if (ratePercent == null) {
      setState(() => _formError = l10n.invalidRateError);
      return;
    }
    final tenureMonths =
        LoanValidators.parseTenureMonths(_tenureController.text);
    if (tenureMonths == null) {
      setState(() => _formError = l10n.invalidTenureError);
      return;
    }

    setState(() => _formError = null);
    final result = widget.appState.createLoan(
      customerId: customer.id,
      principalPaise: principalPaise,
      monthlyRatePercent: ratePercent,
      tenureMonths: tenureMonths,
      type: _loanType,
      startDate: _startDate,
    );

    if (!mounted) return;
    switch (result) {
      case Err<Loan>(:final failure):
        setState(() => _formError = resolveFailureMessage(l10n, failure));
      case Success<Loan>(:final data):
        await showDialog<void>(
          context: context,
          builder: (dialogContext) => AlertDialog(
            icon: CircleAvatar(
              radius: 26,
              backgroundColor:
                  LoanWiseColors.emeraldAccent.withValues(alpha: 0.14),
              child: const Icon(
                Icons.check_circle_rounded,
                color: LoanWiseColors.emeraldAccent,
                size: 30,
              ),
            ),
            title: Text(l10n.loanCreatedTitle),
            content: Text(l10n.loanCreatedMessage(data.tenureMonths)),
            actions: [
              FilledButton(
                key: const ValueKey('dialog_open_loan_overview'),
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute<void>(
                      builder: (_) => LoanOverviewScreen(
                        appState: widget.appState,
                        loanId: data.id,
                      ),
                    ),
                  );
                },
                child: Text(l10n.viewLoanOverview),
              ),
            ],
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.lwColors;
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final preview = _computePreview();
    final typedMobile = _mobileSearchController.text.trim();
    final showNotFound =
        typedMobile.length == 10 && _selectedCustomer == null;

    final principalPaise = preview != null
        ? (LoanValidators.parsePrincipalPaise(_principalController.text) ??
            (preview.totalPayablePaise - preview.totalInterestPaise))
        : 0;
    final payablePaise = preview?.totalPayablePaise ?? 0;
    final interestPaise = preview?.totalInterestPaise ?? 0;
    final principalShare =
        payablePaise > 0 ? principalPaise / payablePaise : 0.0;
    final interestShare = payablePaise > 0 ? interestPaise / payablePaise : 0.0;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: Text(l10n.createLoanTitle),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FintechSurfaceCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FintechSectionHeader(
                      title: l10n.borrowerDetailsHeading,
                      icon: Icons.person_search_rounded,
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      key: const ValueKey('create_loan_mobile_search'),
                      controller: _mobileSearchController,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      decoration: InputDecoration(
                        counterText: '',
                        labelText: l10n.searchCustomerMobileHint,
                        prefixIcon: const Icon(Icons.search_rounded),
                        suffixIcon: _mobileSearchController.text.isNotEmpty
                            ? IconButton(
                                tooltip: l10n.closeAction,
                                onPressed: () {
                                  _mobileSearchController.clear();
                                  setState(() => _selectedCustomer = null);
                                },
                                icon: const Icon(Icons.close_rounded),
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (_selectedCustomer != null)
                      Container(
                        key: const ValueKey('selected_customer_card'),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: colors.success.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(AppRadius.tile),
                          border: Border.all(
                            color: colors.success.withValues(alpha: 0.45),
                          ),
                        ),
                        child: Row(
                          children: [
                            FintechInitialsAvatar(
                              initials: _selectedCustomer!.initials,
                              seed: _selectedCustomer!.name,
                              radius: 21,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _selectedCustomer!.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: textTheme.titleSmall,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    '${_selectedCustomer!.mobile} · ${_selectedCustomer!.location}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.check_circle_rounded,
                              color: colors.success,
                            ),
                          ],
                        ),
                      )
                    else if (showNotFound)
                      Container(
                        key: const ValueKey('customer_mobile_not_found'),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: colors.fieldFill,
                          borderRadius: BorderRadius.circular(AppRadius.tile),
                          border: Border.all(color: colors.fieldBorder),
                        ),
                        child: Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            Text(
                              l10n.noCustomerWithMobile,
                              style: textTheme.bodyMedium?.copyWith(
                                color: colors.textMuted,
                              ),
                            ),
                            if (widget.onAddCustomerRequested != null)
                              FilledButton.tonalIcon(
                                key: const ValueKey('shortcut_add_customer'),
                                onPressed: () async {
                                  final added =
                                      await widget.onAddCustomerRequested!(
                                    typedMobile,
                                  );
                                  if (added != null && mounted) {
                                    _mobileSearchController.text = added.mobile;
                                    setState(() => _selectedCustomer = added);
                                  }
                                },
                                icon: const Icon(
                                  Icons.person_add_alt_1_rounded,
                                  size: 18,
                                ),
                                label: Text(l10n.addCustomerShortcut),
                              ),
                          ],
                        ),
                      )
                    else if (typedMobile.isEmpty &&
                        widget.appState.customers.isNotEmpty)
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: widget.appState.customers
                            .take(5)
                            .map(
                              (c) => ActionChip(
                                key: ValueKey('quick_pick_customer_${c.id}'),
                                avatar: FintechInitialsAvatar(
                                  initials: c.initials,
                                  seed: c.name,
                                  radius: 12,
                                ),
                                label: Text(
                                  '${c.name} · ${c.mobile}',
                                  overflow: TextOverflow.ellipsis,
                                ),
                                onPressed: () {
                                  _mobileSearchController.text = c.mobile;
                                  setState(() {
                                    _selectedCustomer = c;
                                    _formError = null;
                                  });
                                },
                              ),
                            )
                            .toList(),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              FintechSurfaceCard(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FintechSectionHeader(
                      title: l10n.loanOverviewTitle,
                      icon: Icons.tune_rounded,
                      accentColor: colors.success,
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      key: const ValueKey('create_loan_principal'),
                      controller: _principalController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: l10n.principalLabel,
                        prefixIcon: const Icon(Icons.currency_rupee_rounded),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      key: const ValueKey('create_loan_rate'),
                      controller: _rateController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: l10n.monthlyRateLabel,
                        prefixIcon: const Icon(Icons.percent_rounded),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      key: const ValueKey('create_loan_tenure'),
                      controller: _tenureController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        labelText: l10n.tenureMonthsLabel,
                        prefixIcon: const Icon(Icons.calendar_month_outlined),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(l10n.loanTypeLabel, style: textTheme.labelMedium),
                    const SizedBox(height: 8),
                    SegmentedButton<LoanType>(
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
                    const SizedBox(height: 14),
                    InkWell(
                      onTap: _pickStartDate,
                      borderRadius: BorderRadius.circular(AppRadius.field),
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: l10n.startDateLabel,
                          prefixIcon: const Icon(Icons.event_outlined),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                LoanDateUtils.formatShortDate(_startDate),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Icon(
                              Icons.chevron_right_rounded,
                              color: colors.textMuted,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (preview != null) ...[
                const SizedBox(height: 16),
                FintechHeroBanner(
                  key: const ValueKey('live_emi_preview_card'),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.auto_graph_rounded,
                            size: 18,
                            color: Colors.white.withValues(alpha: 0.9),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              l10n.livePreviewHeading,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.titleSmall?.copyWith(
                                color: Colors.white.withValues(alpha: 0.9),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        l10n.monthlyEmiLabel,
                        style: textTheme.bodySmall?.copyWith(
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                      ),
                      const SizedBox(height: 2),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          IndianCurrencyFormatter.formatPaise(
                            preview.monthlyEmiPaise,
                          ),
                          style: textTheme.headlineMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: SizedBox(
                          height: 7,
                          child: Row(
                            children: [
                              Expanded(
                                flex: payablePaise > 0
                                    ? (principalShare * 1000)
                                        .round()
                                        .clamp(1, 1000)
                                    : 1,
                                child: Container(
                                  color: Colors.white.withValues(alpha: 0.92),
                                ),
                              ),
                              if (payablePaise > 0 && interestPaise > 0)
                                Expanded(
                                  flex: (interestShare * 1000)
                                      .round()
                                      .clamp(1, 1000),
                                  child: Container(
                                    color: Colors.amberAccent.withValues(
                                      alpha: 0.92,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Container(
                        padding: const EdgeInsets.only(top: 12),
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: Colors.white.withValues(alpha: 0.18),
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            _HeroBreakdownRow(
                              label: l10n.totalInterestLabel,
                              value: IndianCurrencyFormatter.formatPaise(
                                preview.totalInterestPaise,
                              ),
                            ),
                            const SizedBox(height: 6),
                            _HeroBreakdownRow(
                              label: l10n.totalPayableLabel,
                              value: IndianCurrencyFormatter.formatPaise(
                                preview.totalPayablePaise,
                              ),
                              emphasize: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              if (_formError != null) ...[
                const SizedBox(height: 14),
                FintechErrorBanner(message: _formError!),
              ],
              const SizedBox(height: 20),
              FilledButton.icon(
                key: const ValueKey('create_loan_submit_button'),
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(52),
                  backgroundColor: colors.primary,
                ),
                onPressed: _submit,
                icon: const Icon(Icons.add_card_rounded),
                label: Text(l10n.createLoanButton),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroBreakdownRow extends StatelessWidget {
  const _HeroBreakdownRow({
    required this.label,
    required this.value,
    this.emphasize = false,
  });

  final String label;
  final String value;
  final bool emphasize;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.84),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          value,
          style: (emphasize ? textTheme.titleMedium : textTheme.titleSmall)
              ?.copyWith(
            color: Colors.white,
            fontWeight: emphasize ? FontWeight.w800 : FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
