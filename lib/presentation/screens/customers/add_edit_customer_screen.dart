import 'package:loan_management_app/core/error/failures.dart';
import 'package:loan_management_app/core/theme/app_theme.dart';
import 'package:loan_management_app/core/utils/validators.dart';
import 'package:loan_management_app/domain/models/loan_models.dart';
import 'package:loan_management_app/l10n/app_localizations.dart';
import 'package:loan_management_app/l10n/l10n_failure_resolver.dart';
import 'package:loan_management_app/presentation/screens/loans/create_loan_screen.dart';
import 'package:loan_management_app/presentation/widgets/common/fintech_ui.dart';
import 'package:loan_management_app/state/app_state.dart';
import 'package:material_ui/material_ui.dart';

class AddEditCustomerScreen extends StatefulWidget {
  const AddEditCustomerScreen({
    super.key,
    required this.appState,
    this.existingCustomer,
    this.prefilledMobile,
    this.returnCreatedWithoutPrompt = false,
  });

  final AppState appState;
  final Customer? existingCustomer;
  final String? prefilledMobile;
  final bool returnCreatedWithoutPrompt;

  @override
  State<AddEditCustomerScreen> createState() => _AddEditCustomerScreenState();
}

class _AddEditCustomerScreenState extends State<AddEditCustomerScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _mobileController;
  late final TextEditingController _locationController;

  String? _formError;
  bool get _isEdit => widget.existingCustomer != null;

  bool get _isMobileLocked {
    if (!_isEdit) return false;
    return widget.appState.store.hasAnyLoans(widget.existingCustomer!.id);
  }

  @override
  void initState() {
    super.initState();
    final existing = widget.existingCustomer;
    _nameController = TextEditingController(text: existing?.name ?? '');
    _emailController = TextEditingController(text: existing?.email ?? '');
    _mobileController = TextEditingController(
      text: existing?.mobile ?? widget.prefilledMobile ?? '',
    );
    _locationController = TextEditingController(text: existing?.location ?? '');
    _nameController.addListener(_onFieldChanged);
    _mobileController.addListener(_onFieldChanged);
  }

  void _onFieldChanged() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _nameController.removeListener(_onFieldChanged);
    _mobileController.removeListener(_onFieldChanged);
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  String _previewInitials(String name) {
    final parts = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((p) => p.isNotEmpty)
        .toList();
    if (parts.isEmpty) return 'LW';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final mobile = _mobileController.text.trim();
    final location = _locationController.text.trim();

    if (LoginValidators.validateName(name) != null) {
      setState(() => _formError = l10n.errorNameRequired);
      return;
    }
    if (LoginValidators.validateMobile(mobile) != null) {
      setState(() => _formError = l10n.errorMobileInvalid);
      return;
    }
    if (LoginValidators.validateEmail(email) != null) {
      setState(() => _formError = l10n.errorEmailInvalid);
      return;
    }
    if (LoanValidators.validateLocation(location) != null) {
      setState(() => _formError = l10n.locationRequiredError);
      return;
    }

    setState(() => _formError = null);

    if (_isEdit) {
      final res = widget.appState.updateCustomer(
        customerId: widget.existingCustomer!.id,
        name: name,
        email: email,
        mobile: mobile,
        location: location,
      );
      if (!mounted) return;
      switch (res) {
        case Err<Customer>(:final failure):
          setState(() => _formError = resolveFailureMessage(l10n, failure));
        case Success<Customer>(:final data):
          Navigator.of(context).pop(data);
      }
      return;
    }

    final res = widget.appState.createCustomer(
      name: name,
      email: email,
      mobile: mobile,
      location: location,
    );
    if (!mounted) return;

    switch (res) {
      case Err<Customer>(:final failure):
        setState(() => _formError = resolveFailureMessage(l10n, failure));
      case Success<Customer>(:final data):
        if (widget.returnCreatedWithoutPrompt) {
          Navigator.of(context).pop(data);
          return;
        }
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
            title: Text(l10n.customerAddedTitle),
            content: Text(l10n.customerAddedMessage(data.name)),
            actions: [
              TextButton(
                key: const ValueKey('customer_added_later_button'),
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  Navigator.of(context).pop(data);
                },
                child: Text(l10n.laterButton),
              ),
              FilledButton(
                key: const ValueKey('customer_added_create_loan_button'),
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute<void>(
                      builder: (_) => CreateLoanScreen(
                        appState: widget.appState,
                        preselectedCustomer: data,
                      ),
                    ),
                  );
                },
                child: Text(l10n.actionCreateLoan),
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
    final previewName = _nameController.text.trim();
    final previewMobile = _mobileController.text.trim();

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: Text(_isEdit ? l10n.editCustomerTitle : l10n.addCustomerTitle),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FintechHeroBanner(
                padding: const EdgeInsets.all(18),
                child: Row(
                  children: [
                    Container(
                      width: 54,
                      height: 54,
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
                        _previewInitials(previewName),
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
                            previewName.isEmpty
                                ? (_isEdit
                                    ? l10n.editCustomerTitle
                                    : l10n.addCustomerTitle)
                                : previewName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.titleMedium?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            previewMobile.isEmpty
                                ? l10n.mobileHint
                                : previewMobile,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.bodySmall?.copyWith(
                              color: Colors.white.withValues(alpha: 0.85),
                            ),
                          ),
                        ],
                      ),
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
                      title: l10n.borrowerDetailsHeading,
                      icon: Icons.badge_outlined,
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      key: const ValueKey('customer_name_field'),
                      controller: _nameController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: l10n.customerNameLabel,
                        hintText: l10n.nameHint,
                        prefixIcon: const Icon(Icons.person_outline_rounded),
                      ),
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      key: const ValueKey('customer_mobile_field'),
                      controller: _mobileController,
                      enabled: !_isMobileLocked,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        counterText: '',
                        labelText: l10n.customerMobileLabel,
                        hintText: l10n.mobileHint,
                        helperText:
                            _isMobileLocked ? l10n.mobileLockedHelper : null,
                        prefixIcon: const Icon(Icons.phone_outlined),
                        suffixIcon: _isMobileLocked
                            ? Icon(
                                Icons.lock_outline_rounded,
                                size: 18,
                                color: colors.textMuted,
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      key: const ValueKey('customer_email_field'),
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: l10n.customerEmailLabel,
                        hintText: l10n.emailHint,
                        prefixIcon: const Icon(Icons.mail_outline_rounded),
                      ),
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      key: const ValueKey('customer_location_field'),
                      controller: _locationController,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        labelText: l10n.customerLocationLabel,
                        prefixIcon: const Icon(Icons.location_on_outlined),
                      ),
                    ),
                  ],
                ),
              ),
              if (_formError != null) ...[
                const SizedBox(height: 14),
                FintechErrorBanner(message: _formError!),
              ],
              const SizedBox(height: 20),
              FilledButton.icon(
                key: const ValueKey('save_customer_button'),
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(52),
                  backgroundColor: colors.primary,
                ),
                onPressed: _submit,
                icon: Icon(
                  _isEdit
                      ? Icons.check_circle_outline_rounded
                      : Icons.person_add_alt_1_rounded,
                ),
                label: Text(
                  _isEdit
                      ? l10n.updateCustomerButton
                      : l10n.saveCustomerButton,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
