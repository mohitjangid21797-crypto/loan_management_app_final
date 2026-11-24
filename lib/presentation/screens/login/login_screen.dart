import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';
import 'package:loan_management_app/core/theme/app_theme.dart';
import 'package:loan_management_app/core/utils/validators.dart';
import 'package:loan_management_app/domain/models/loan_models.dart';
import 'package:loan_management_app/l10n/app_localizations.dart';
import 'package:loan_management_app/presentation/widgets/login/animated_login_header.dart';
import 'package:loan_management_app/state/app_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
    required this.appState,
    this.onSignedIn,
    this.saveDelay = const Duration(milliseconds: 280),
  });

  final AppState appState;
  final VoidCallback? onSignedIn;
  final Duration saveDelay;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _entranceController;
  late final TextEditingController _nameController;
  late final TextEditingController _mobileController;
  late final TextEditingController _emailController;

  late final FocusNode _nameFocus;
  late final FocusNode _mobileFocus;
  late final FocusNode _emailFocus;

  bool _nameTouched = false;
  bool _mobileTouched = false;
  bool _emailTouched = false;
  bool _submittedOnce = false;
  bool _isSaving = false;
  bool _isButtonPressed = false;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..forward();

    _nameController = TextEditingController();
    _mobileController = TextEditingController();
    _emailController = TextEditingController();

    _nameFocus = FocusNode()..addListener(_handleFocusChange);
    _mobileFocus = FocusNode()..addListener(_handleFocusChange);
    _emailFocus = FocusNode()..addListener(_handleFocusChange);

    _nameController.addListener(_onFieldChanged);
    _mobileController.addListener(_onFieldChanged);
    _emailController.addListener(_onFieldChanged);
  }

  void _handleFocusChange() {
    if (!_nameFocus.hasFocus && _nameController.text.isNotEmpty) {
      _nameTouched = true;
    }
    if (!_mobileFocus.hasFocus && _mobileController.text.isNotEmpty) {
      _mobileTouched = true;
    }
    if (!_emailFocus.hasFocus && _emailController.text.isNotEmpty) {
      _emailTouched = true;
    }
    if (mounted) setState(() {});
  }

  void _onFieldChanged() {
    if (mounted) setState(() {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _entranceController.value = 1.0;
    }
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _nameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _nameFocus
      ..removeListener(_handleFocusChange)
      ..dispose();
    _mobileFocus
      ..removeListener(_handleFocusChange)
      ..dispose();
    _emailFocus
      ..removeListener(_handleFocusChange)
      ..dispose();
    super.dispose();
  }

  bool get _isFormValid => LoginValidators.isFormValid(
        name: _nameController.text,
        mobile: _mobileController.text,
        email: _emailController.text,
      );

  String? _nameErrorText(AppLocalizations l10n) {
    if (!_nameTouched && !_submittedOnce) return null;
    final err = LoginValidators.validateName(_nameController.text);
    return err == NameValidationError.required ? l10n.errorNameRequired : null;
  }

  String? _mobileErrorText(AppLocalizations l10n) {
    if (!_mobileTouched && !_submittedOnce) return null;
    final err = LoginValidators.validateMobile(_mobileController.text);
    return err == MobileValidationError.invalid
        ? l10n.errorMobileInvalid
        : null;
  }

  String? _emailErrorText(AppLocalizations l10n) {
    if (!_emailTouched && !_submittedOnce) return null;
    final err = LoginValidators.validateEmail(_emailController.text);
    return err == EmailValidationError.invalid ? l10n.errorEmailInvalid : null;
  }

  Future<void> _submit() async {
    setState(() {
      _submittedOnce = true;
      _nameTouched = true;
      _mobileTouched = true;
      _emailTouched = true;
    });
    if (!_isFormValid || _isSaving) return;

    FocusScope.of(context).unfocus();
    setState(() {
      _isSaving = true;
    });

    await Future<void>.delayed(widget.saveDelay);
    if (!mounted) return;

    widget.appState.signIn(
      LenderProfile(
        name: _nameController.text.trim(),
        mobile: _mobileController.text.trim(),
        email: _emailController.text.trim(),
      ),
    );
    widget.onSignedIn?.call();

    if (mounted) {
      setState(() {
        _isSaving = false;
      });
    }
  }

  Widget _buildStaggered({
    required double begin,
    required double end,
    required Widget child,
  }) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    if (reduceMotion) return child;
    final anim = CurvedAnimation(
      parent: _entranceController,
      curve: Interval(begin, end, curve: Curves.easeOutCubic),
    );
    return AnimatedBuilder(
      animation: anim,
      builder: (context, c) {
        final t = anim.value;
        return Opacity(
          opacity: t,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - t)),
            child: c,
          ),
        );
      },
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.lwColors;
    final l10n = AppLocalizations.of(context);
    final screenSize = MediaQuery.sizeOf(context);
    final reduceMotion = MediaQuery.disableAnimationsOf(context);

    final headerHeight = (screenSize.height * 0.42).clamp(210.0, 340.0);
    final cardAnim = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOutCubic,
    );

    return Scaffold(
      backgroundColor: colors.surface,
      resizeToAvoidBottomInset: true,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 600;
          return SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AnimatedLoginHeader(height: headerHeight),
                  SafeArea(
                    top: false,
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: isWide ? 420 : double.infinity,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
                          child: AnimatedBuilder(
                            animation: cardAnim,
                            builder: (context, child) {
                              final t = reduceMotion ? 1.0 : cardAnim.value;
                              final matrix = Matrix4.identity()
                                ..setEntry(3, 2, 0.001)
                                ..rotateX(0.35 * (1 - t));
                              return Opacity(
                                opacity: t,
                                child: Transform.translate(
                                  offset: Offset(0, 40 * (1 - t)),
                                  child: Transform(
                                    alignment: Alignment.topCenter,
                                    transform: matrix,
                                    child: child,
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                _buildStaggered(
                                  begin: 0.10,
                                  end: 0.60,
                                  child: _LoginField(
                                    key: const ValueKey('login_name_field'),
                                    controller: _nameController,
                                    focusNode: _nameFocus,
                                    label: l10n.nameLabel,
                                    hint: l10n.nameHint,
                                    icon: Icons.person_outline_rounded,
                                    errorText: _nameErrorText(l10n),
                                    keyboardType: TextInputType.name,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    textInputAction: TextInputAction.next,
                                    onSubmitted: (_) =>
                                        _mobileFocus.requestFocus(),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                _buildStaggered(
                                  begin: 0.21,
                                  end: 0.71,
                                  child: _LoginField(
                                    key: const ValueKey('login_mobile_field'),
                                    controller: _mobileController,
                                    focusNode: _mobileFocus,
                                    label: l10n.mobileLabel,
                                    hint: l10n.mobileHint,
                                    icon: Icons.phone_outlined,
                                    errorText: _mobileErrorText(l10n),
                                    keyboardType: TextInputType.phone,
                                    textInputAction: TextInputAction.next,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(10),
                                    ],
                                    onSubmitted: (_) =>
                                        _emailFocus.requestFocus(),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                _buildStaggered(
                                  begin: 0.32,
                                  end: 0.82,
                                  child: _LoginField(
                                    key: const ValueKey('login_email_field'),
                                    controller: _emailController,
                                    focusNode: _emailFocus,
                                    label: l10n.emailLabel,
                                    hint: l10n.emailHint,
                                    icon: Icons.mail_outline_rounded,
                                    errorText: _emailErrorText(l10n),
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.done,
                                    onSubmitted: (_) => _submit(),
                                  ),
                                ),
                                const SizedBox(height: 28),
                                _buildStaggered(
                                  begin: 0.44,
                                  end: 0.94,
                                  child: _SignInButton(
                                    key: const ValueKey('login_sign_in_button'),
                                    label: l10n.signInButton,
                                    enabled: _isFormValid && !_isSaving,
                                    isLoading: _isSaving,
                                    isPressed: _isButtonPressed,
                                    onPressChanged: (pressed) {
                                      setState(
                                        () => _isButtonPressed = pressed,
                                      );
                                    },
                                    onTap: _submit,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _LoginField extends StatelessWidget {
  const _LoginField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.label,
    required this.hint,
    required this.icon,
    required this.errorText,
    required this.keyboardType,
    required this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.onSubmitted,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final String label;
  final String hint;
  final IconData icon;
  final String? errorText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    final colors = context.lwColors;
    final textTheme = Theme.of(context).textTheme;
    final isFocused = focusNode.hasFocus;
    final hasError = errorText != null && errorText!.isNotEmpty;

    final borderColor = hasError
        ? colors.danger
        : isFocused
            ? colors.primary
            : colors.fieldBorder;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          constraints: const BoxConstraints(minHeight: 56),
          decoration: BoxDecoration(
            color: colors.fieldFill,
            borderRadius: BorderRadius.circular(AppRadius.field),
            border: Border.all(
              color: borderColor,
              width: isFocused || hasError ? 1.5 : 1.0,
            ),
            boxShadow: isFocused
                ? [
                    BoxShadow(
                      color: colors.primary.withValues(alpha: 0.14),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            textCapitalization: textCapitalization,
            inputFormatters: inputFormatters,
            onSubmitted: onSubmitted,
            style: textTheme.bodyLarge,
            decoration: InputDecoration(
              labelText: label,
              hintText: hint,
              labelStyle: textTheme.bodyMedium?.copyWith(
                color: hasError
                    ? colors.danger
                    : isFocused
                        ? colors.primary
                        : colors.textMuted,
              ),
              hintStyle: textTheme.bodyMedium?.copyWith(
                color: colors.textMuted.withValues(alpha: 0.7),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              prefixIcon: Icon(
                icon,
                color: hasError
                    ? colors.danger
                    : isFocused
                        ? colors.primary
                        : colors.textMuted,
              ),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 10,
              ),
            ),
          ),
        ),
        if (hasError) ...[
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              errorText!,
              style: textTheme.bodySmall?.copyWith(
                color: colors.danger,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _SignInButton extends StatelessWidget {
  const _SignInButton({
    super.key,
    required this.label,
    required this.enabled,
    required this.isLoading,
    required this.isPressed,
    required this.onPressChanged,
    required this.onTap,
  });

  final String label;
  final bool enabled;
  final bool isLoading;
  final bool isPressed;
  final ValueChanged<bool> onPressChanged;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.lwColors;
    final textTheme = Theme.of(context).textTheme;
    final canTap = enabled && !isLoading;

    return Semantics(
      button: true,
      enabled: canTap,
      label: label,
      child: AnimatedScale(
        scale: (isPressed && canTap) ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.button),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.button),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: enabled || isLoading
                    ? [
                        colors.buttonGradientStart,
                        colors.buttonGradientEnd,
                      ]
                    : [
                        colors.buttonGradientStart.withValues(alpha: 0.42),
                        colors.buttonGradientEnd.withValues(alpha: 0.42),
                      ],
              ),
              boxShadow: enabled
                  ? [
                      BoxShadow(
                        color: colors.buttonGradientStart.withValues(alpha: 0.28),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ]
                  : null,
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(AppRadius.button),
              onTap: canTap ? onTap : null,
              onHighlightChanged: canTap ? onPressChanged : null,
              child: ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 52),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (isLoading)
                        const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      else ...[
                        Flexible(
                          child: Text(
                            label,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.labelLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
