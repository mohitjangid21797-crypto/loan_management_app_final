import 'package:loan_management_app/core/error/failures.dart';
import 'package:loan_management_app/core/theme/app_theme.dart';
import 'package:loan_management_app/core/utils/date_utils.dart';
import 'package:loan_management_app/core/utils/emi_calculator.dart';
import 'package:loan_management_app/core/utils/validators.dart';
import 'package:loan_management_app/domain/models/loan_models.dart';
import 'package:loan_management_app/l10n/app_localizations.dart';
import 'package:loan_management_app/l10n/l10n_failure_resolver.dart';
import 'package:loan_management_app/l10n/supported_languages.dart';
import 'package:loan_management_app/presentation/screens/documents/document_viewer_screen.dart';
import 'package:loan_management_app/presentation/widgets/common/fintech_ui.dart';
import 'package:loan_management_app/services/loan_agreement_pdf_service.dart';
import 'package:loan_management_app/state/app_state.dart';
import 'package:material_ui/material_ui.dart';

class EditPdfScreen extends StatefulWidget {
  const EditPdfScreen({
    super.key,
    required this.appState,
    required this.document,
  });

  final AppState appState;
  final LoanDocument document;

  @override
  State<EditPdfScreen> createState() => _EditPdfScreenState();
}

class _EditPdfScreenState extends State<EditPdfScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _mobileController;
  late final TextEditingController _emailController;
  late final TextEditingController _locationController;
  late final TextEditingController _principalController;
  late final TextEditingController _rateController;
  late final TextEditingController _tenureController;
  late final TextEditingController _statusController;

  late LoanType _loanType;
  late DateTime _startDate;
  late String _languageCode;
  String? _validationError;

  @override
  void initState() {
    super.initState();
    final snap = widget.document.snapshot;
    _nameController = TextEditingController(text: snap.borrowerName);
    _mobileController = TextEditingController(text: snap.borrowerMobile);
    _emailController = TextEditingController(text: snap.borrowerEmail);
    _locationController = TextEditingController(text: snap.borrowerLocation);
    _principalController = TextEditingController(
      text: (snap.principalPaise / 100.0).toStringAsFixed(0),
    );
    _rateController = TextEditingController(
      text: snap.monthlyRatePercent.toString(),
    );
    _tenureController = TextEditingController(
      text: snap.tenureMonths.toString(),
    );
    _statusController = TextEditingController(text: snap.statusText);
    _loanType = snap.loanType;
    _startDate = snap.startDate;
    _languageCode = widget.document.languageCode;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _locationController.dispose();
    _principalController.dispose();
    _rateController.dispose();
    _tenureController.dispose();
    _statusController.dispose();
    super.dispose();
  }

  LoanDocumentSnapshot? _buildValidatedSnapshot() {
    final l10n = AppLocalizations.of(context);
    final name = _nameController.text.trim();
    final mobile = _mobileController.text.trim();
    final email = _emailController.text.trim();
    final location = _locationController.text.trim();

    if (LoginValidators.validateName(name) != null) {
      setState(() => _validationError = l10n.errorNameRequired);
      return null;
    }
    if (LoginValidators.validateMobile(mobile) != null) {
      setState(() => _validationError = l10n.errorMobileInvalid);
      return null;
    }
    if (LoginValidators.validateEmail(email) != null) {
      setState(() => _validationError = l10n.errorEmailInvalid);
      return null;
    }
    if (LoanValidators.validateLocation(location) != null) {
      setState(() => _validationError = l10n.locationRequiredError);
      return null;
    }

    final principalPaise =
        LoanValidators.parsePrincipalPaise(_principalController.text);
    if (principalPaise == null) {
      setState(() => _validationError = l10n.invalidPrincipalError);
      return null;
    }
    final ratePercent = LoanValidators.parseRatePercent(_rateController.text);
    if (ratePercent == null) {
      setState(() => _validationError = l10n.invalidRateError);
      return null;
    }
    final tenureMonths =
        LoanValidators.parseTenureMonths(_tenureController.text);
    if (tenureMonths == null) {
      setState(() => _validationError = l10n.invalidTenureError);
      return null;
    }

    setState(() => _validationError = null);

    // Recompute schedule in snapshot while preserving paid dates for matching installment numbers.
    final oldByNo = {
      for (final item in widget.document.snapshot.schedule)
        item.installmentNo: item,
    };

    final calc = EmiCalculator.calculate(
      principalPaise: principalPaise,
      monthlyRatePercent: ratePercent,
      tenureMonths: tenureMonths,
      loanType: _loanType,
      startDate: _startDate,
    );

    final emiNo = widget.document.emiInstallmentNo;
    final filteredRows = emiNo == null
        ? calc.rows
        : calc.rows.where((row) => row.installmentNo <= emiNo);

    final rebuiltSchedule = filteredRows.map((row) {
      final previous = oldByNo[row.installmentNo];
      final preservePaid = previous != null && previous.isPaid;
      return EmiScheduleItem(
        id: previous?.id ?? 'SNAP-${row.installmentNo}',
        loanId: widget.document.loanId,
        installmentNo: row.installmentNo,
        dueDate: row.dueDate,
        emiPaise: row.emiPaise,
        principalPartPaise: row.principalPartPaise,
        interestPartPaise: row.interestPartPaise,
        remainingBalancePaise: row.remainingBalancePaise,
        status: preservePaid ? EmiStatus.paid : EmiStatus.pending,
        paidDate: preservePaid ? previous.paidDate : null,
      );
    }).toList();

    return widget.document.snapshot.copyWith(
      borrowerName: name,
      borrowerMobile: mobile,
      borrowerEmail: email,
      borrowerLocation: location,
      principalPaise: principalPaise,
      monthlyRatePercent: ratePercent,
      tenureMonths: tenureMonths,
      loanType: _loanType,
      startDate: _startDate,
      monthlyEmiPaise: calc.monthlyEmiPaise,
      totalInterestPaise: calc.totalInterestPaise,
      totalPayablePaise: calc.totalPayablePaise,
      statusText: _statusController.text.trim().isEmpty
          ? widget.document.snapshot.statusText
          : _statusController.text.trim(),
      schedule: rebuiltSchedule,
    );
  }

  void _preview() {
    final snapshot = _buildValidatedSnapshot();
    if (snapshot == null) return;
    final now = DateTime.now().toUtc();
    final html = LoanAgreementPdfService.buildDocumentHtml(
      documentId: widget.document.id,
      snapshot: snapshot,
      languageCode: _languageCode,
      generatedAt: now,
      emiInstallmentNo: widget.document.emiInstallmentNo,
    );
    final pageCount =
        LoanAgreementPdfService.paginateInstallments(snapshot.schedule).length;
    final previewDoc = widget.document.copyWith(
      languageCode: _languageCode,
      snapshot: snapshot,
      htmlContent: html,
      pageCount: pageCount,
      updatedAt: now,
    );
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => DocumentViewerScreen(document: previewDoc),
      ),
    );
  }

  void _regenerate() {
    final l10n = AppLocalizations.of(context);
    final snapshot = _buildValidatedSnapshot();
    if (snapshot == null) return;
    final res = widget.appState.regenerateDocumentSnapshot(
      documentId: widget.document.id,
      updatedSnapshot: snapshot,
      languageCode: _languageCode,
    );
    switch (res) {
      case Success<LoanDocument>():
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text(l10n.pdfRegeneratedSuccess),
            ),
          );
        Navigator.of(context).pop(true);
      case Err<LoanDocument>(:final failure):
        setState(
          () => _validationError = resolveFailureMessage(l10n, failure),
        );
    }
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

  @override
  Widget build(BuildContext context) {
    final colors = context.lwColors;
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: Text(l10n.editPdfTitle),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FintechSurfaceCard(
                radius: AppRadius.field,
                padding: const EdgeInsets.all(14),
                backgroundColor: colors.primary.withValues(alpha: 0.08),
                borderColor: colors.primary.withValues(alpha: 0.25),
                child: Row(
                  children: [
                    Icon(Icons.info_outline_rounded, color: colors.primary),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        l10n.snapshotNotice,
                        style: textTheme.bodySmall?.copyWith(
                          color: colors.textPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (_validationError != null) ...[
                const SizedBox(height: 12),
                FintechErrorBanner(message: _validationError!),
              ],
              const SizedBox(height: 16),
              FintechSurfaceCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FintechSectionHeader(
                      title: l10n.borrowerDetailsHeading,
                      icon: Icons.person_outline_rounded,
                    ),
                    const SizedBox(height: 14),
                    _SnapshotField(
                      key: const ValueKey('edit_pdf_name'),
                      controller: _nameController,
                      label: l10n.customerNameLabel,
                      icon: Icons.person_outline_rounded,
                    ),
                    const SizedBox(height: 12),
                    _SnapshotField(
                      key: const ValueKey('edit_pdf_mobile'),
                      controller: _mobileController,
                      label: l10n.customerMobileLabel,
                      icon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                    ),
                    const SizedBox(height: 12),
                    _SnapshotField(
                      key: const ValueKey('edit_pdf_email'),
                      controller: _emailController,
                      label: l10n.customerEmailLabel,
                      icon: Icons.mail_outline_rounded,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 12),
                    _SnapshotField(
                      key: const ValueKey('edit_pdf_location'),
                      controller: _locationController,
                      label: l10n.customerLocationLabel,
                      icon: Icons.location_on_outlined,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              FintechSurfaceCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FintechSectionHeader(
                      title: l10n.loanOverviewTitle,
                      icon: Icons.description_outlined,
                      accentColor: colors.success,
                    ),
                    const SizedBox(height: 14),
                    _SnapshotField(
                      key: const ValueKey('edit_pdf_principal'),
                      controller: _principalController,
                      label: l10n.principalLabel,
                      icon: Icons.currency_rupee_rounded,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 12),
                    _SnapshotField(
                      key: const ValueKey('edit_pdf_rate'),
                      controller: _rateController,
                      label: l10n.monthlyRateLabel,
                      icon: Icons.percent_rounded,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                    ),
                    const SizedBox(height: 12),
                    _SnapshotField(
                      key: const ValueKey('edit_pdf_tenure'),
                      controller: _tenureController,
                      label: l10n.tenureMonthsLabel,
                      icon: Icons.calendar_month_outlined,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<LoanType>(
                      isExpanded: true,
                      initialValue: _loanType,
                      decoration: InputDecoration(
                        labelText: l10n.loanTypeLabel,
                        prefixIcon: const Icon(Icons.tune_rounded),
                      ),
                      items: [
                        DropdownMenuItem(
                          value: LoanType.simple,
                          child: Text(
                            l10n.loanTypeSimple,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        DropdownMenuItem(
                          value: LoanType.compound,
                          child: Text(
                            l10n.loanTypeCompound,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                      onChanged: (v) {
                        if (v != null) setState(() => _loanType = v);
                      },
                    ),
                    const SizedBox(height: 12),
                    InkWell(
                      onTap: _pickStartDate,
                      borderRadius: BorderRadius.circular(AppRadius.field),
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: l10n.startDateLabel,
                          prefixIcon: const Icon(Icons.event_outlined),
                        ),
                        child: Text(LoanDateUtils.formatShortDate(_startDate)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _SnapshotField(
                      key: const ValueKey('edit_pdf_status'),
                      controller: _statusController,
                      label: l10n.statusTextLabel,
                      icon: Icons.verified_outlined,
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      key: const ValueKey('edit_pdf_language_dropdown'),
                      isExpanded: true,
                      initialValue: _languageCode,
                      decoration: InputDecoration(
                        labelText: l10n.pdfLanguageLabel,
                        prefixIcon: const Icon(Icons.translate_rounded),
                      ),
                      items: kSupportedLanguageOptions
                          .map(
                            (option) => DropdownMenuItem(
                              value: option.locale.languageCode,
                              child: Text(
                                option.nativeName,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (code) {
                        if (code != null) setState(() => _languageCode = code);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              LayoutBuilder(
                builder: (context, constraints) {
                  final textScale =
                      MediaQuery.textScalerOf(context).scale(14) / 14;
                  final stackVertically =
                      constraints.maxWidth < 360 || textScale > 1.2;
                  final previewBtn = OutlinedButton.icon(
                    key: const ValueKey('edit_pdf_preview_button'),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                    ),
                    onPressed: _preview,
                    icon: const Icon(Icons.visibility_outlined),
                    label: Text(
                      l10n.previewButton,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                  final regenerateBtn = FilledButton.icon(
                    key: const ValueKey('edit_pdf_regenerate_button'),
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor: colors.primary,
                    ),
                    onPressed: _regenerate,
                    icon: const Icon(Icons.refresh_rounded),
                    label: Text(
                      l10n.regeneratePdfButton,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                  if (stackVertically) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        previewBtn,
                        const SizedBox(height: 10),
                        regenerateBtn,
                      ],
                    );
                  }
                  return Row(
                    children: [
                      Expanded(child: previewBtn),
                      const SizedBox(width: 12),
                      Expanded(child: regenerateBtn),
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

class _SnapshotField extends StatelessWidget {
  const _SnapshotField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.keyboardType,
    this.maxLength,
  });

  final TextEditingController controller;
  final String label;
  final IconData icon;
  final TextInputType? keyboardType;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLength: maxLength,
      decoration: InputDecoration(
        labelText: label,
        counterText: '',
        prefixIcon: Icon(icon),
      ),
    );
  }
}
