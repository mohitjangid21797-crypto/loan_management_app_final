import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';
import 'package:loan_management_app/core/theme/app_theme.dart';
import 'package:loan_management_app/core/utils/validators.dart';
import 'package:loan_management_app/domain/models/loan_models.dart';
import 'package:loan_management_app/l10n/app_localizations.dart';
import 'package:loan_management_app/presentation/widgets/common/fintech_ui.dart';
import 'package:loan_management_app/services/profile_photo_service.dart';
import 'package:loan_management_app/state/app_state.dart';
import 'package:material_ui/material_ui.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({
    super.key,
    required this.appState,
    required this.onOpenDrawer,
  });

  final AppState appState;
  final VoidCallback onOpenDrawer;

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  late final TextEditingController _nameController;
  late final TextEditingController _mobileController;
  late final TextEditingController _emailController;
  late int _avatarIndex;
  late final ProfilePhotoService _photoService;
  String? _photoPath;
  String? _errorText;

  static const List<Color> _avatarColors = [
    Color(0xFF1E3A8A),
    Color(0xFF047857),
    Color(0xFF4338CA),
    Color(0xFF0F766E),
    Color(0xFFB45309),
  ];

  late LenderProfile _lastSyncedProfile;

  @override
  void initState() {
    super.initState();
    _photoService = ProfilePhotoService();
    final p = widget.appState.profile;
    _lastSyncedProfile = p;
    _nameController = TextEditingController(text: p.name);
    _mobileController = TextEditingController(text: p.mobile);
    _emailController = TextEditingController(text: p.email);
    _avatarIndex = p.avatarIndex % _avatarColors.length;
    _photoPath = p.photoPath;
    widget.appState.addListener(_syncFromAppState);
  }

  void _syncFromAppState() {
    final p = widget.appState.profile;
    if (p.name != _lastSyncedProfile.name ||
        p.mobile != _lastSyncedProfile.mobile ||
        p.email != _lastSyncedProfile.email ||
        p.avatarIndex != _lastSyncedProfile.avatarIndex ||
        p.photoPath != _lastSyncedProfile.photoPath) {
      _lastSyncedProfile = p;
      _nameController.text = p.name;
      _mobileController.text = p.mobile;
      _emailController.text = p.email;
      _avatarIndex = p.avatarIndex % _avatarColors.length;
      _photoPath = p.photoPath;
    }
  }

  @override
  void dispose() {
    widget.appState.removeListener(_syncFromAppState);
    _nameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _cycleAvatarStyle() {
    setState(() {
      _avatarIndex = (_avatarIndex + 1) % _avatarColors.length;
    });
  }

  Future<void> _pickPhoto(ImageSource source) async {
    final l10n = AppLocalizations.of(context);
    try {
      final path = await _photoService.pickAndStorePhoto(source);
      if (path == null || !mounted) return;
      setState(() {
        _photoPath = path;
        _errorText = null;
      });
      widget.appState.updateProfile(
        widget.appState.profile.copyWith(photoPath: path),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(l10n.photoPickFailedError),
          ),
        );
    }
  }

  void _removePhoto() {
    setState(() {
      _photoPath = null;
    });
    widget.appState.updateProfile(
      widget.appState.profile.copyWith(clearPhotoPath: true),
    );
  }

  void _showAvatarOptions() {
    final l10n = AppLocalizations.of(context);
    final colors = context.lwColors;
    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(
                l10n.choosePhotoTitle,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            ListTile(
              key: const ValueKey('profile_photo_gallery_option'),
              leading: Icon(Icons.photo_library_outlined, color: colors.primary),
              title: Text(l10n.pickFromGallery),
              onTap: () {
                Navigator.of(sheetContext).pop();
                _pickPhoto(ImageSource.gallery);
              },
            ),
            ListTile(
              key: const ValueKey('profile_photo_camera_option'),
              leading: Icon(Icons.photo_camera_outlined, color: colors.primary),
              title: Text(l10n.takePhoto),
              onTap: () {
                Navigator.of(sheetContext).pop();
                _pickPhoto(ImageSource.camera);
              },
            ),
            ListTile(
              key: const ValueKey('profile_photo_color_option'),
              leading: Icon(Icons.palette_outlined, color: colors.primary),
              title: Text(l10n.changeAvatarColor),
              onTap: () {
                Navigator.of(sheetContext).pop();
                _cycleAvatarStyle();
              },
            ),
            if (_photoPath != null && _photoPath!.isNotEmpty)
              ListTile(
                key: const ValueKey('profile_photo_remove_option'),
                leading: Icon(Icons.delete_outline_rounded, color: colors.danger),
                title: Text(
                  l10n.removePhoto,
                  style: TextStyle(color: colors.danger),
                ),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  _removePhoto();
                },
              ),
          ],
        ),
      ),
    );
  }

  void _saveProfile() {
    final l10n = AppLocalizations.of(context);
    final name = _nameController.text.trim();
    final mobile = _mobileController.text.trim();
    final email = _emailController.text.trim();

    if (LoginValidators.validateName(name) != null) {
      setState(() => _errorText = l10n.errorNameRequired);
      return;
    }
    if (LoginValidators.validateMobile(mobile) != null) {
      setState(() => _errorText = l10n.errorMobileInvalid);
      return;
    }
    if (LoginValidators.validateEmail(email) != null) {
      setState(() => _errorText = l10n.errorEmailInvalid);
      return;
    }

    setState(() => _errorText = null);
    widget.appState.updateProfile(
      widget.appState.profile.copyWith(
        name: name,
        mobile: mobile,
        email: email,
        avatarIndex: _avatarIndex,
        photoPath: _photoPath,
        clearPhotoPath: _photoPath == null,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(l10n.profileUpdatedSuccess),
        ),
      );
  }

  Future<void> _confirmSignOut() async {
    final l10n = AppLocalizations.of(context);
    final colors = context.lwColors;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.signOutConfirmTitle),
        content: Text(l10n.signOutConfirmMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.cancelAction),
          ),
          TextButton(
            key: const ValueKey('confirm_sign_out_button'),
            style: TextButton.styleFrom(foregroundColor: colors.danger),
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(l10n.signOutAction),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      widget.appState.signOut();
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
          final profile = widget.appState.profile;
          final customersCount = widget.appState.customers.length;
          final totalLoansCount = widget.appState.loans.length;
          final activeLoansCount = widget.appState.loans
              .where((l) => l.status == LoanStatus.active)
              .length;
          final docsCount = widget.appState.documents.length;

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 112),
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
                      l10n.navProfile,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.titleLarge,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                l10n.tabProfileSubtitle,
                style: textTheme.bodyMedium?.copyWith(color: colors.textMuted),
              ),
              const SizedBox(height: 16),
              FintechHeroBanner(
                child: Row(
                  children: [
                    InkWell(
                      key: const ValueKey('profile_avatar_edit_button'),
                      borderRadius: BorderRadius.circular(42),
                      onTap: _showAvatarOptions,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Builder(
                            builder: (context) {
                              final photoPath = _photoPath;
                              final hasPhoto = photoPath != null &&
                                  photoPath.isNotEmpty &&
                                  (kIsWeb || File(photoPath).existsSync());
                              final ImageProvider? imageProvider = !hasPhoto
                                  ? null
                                  : (kIsWeb
                                      ? NetworkImage(photoPath)
                                      : FileImage(File(photoPath))
                                          as ImageProvider);
                              return Container(
                                padding: const EdgeInsets.all(2.5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.45),
                                    width: 1.5,
                                  ),
                                ),
                                child: CircleAvatar(
                                  radius: 34,
                                  backgroundColor: _avatarColors[_avatarIndex],
                                  backgroundImage: imageProvider,
                                  child: hasPhoto
                                      ? null
                                      : Text(
                                          profile.initials,
                                          style: textTheme.headlineSmall
                                              ?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                ),
                              );
                            },
                          ),
                          Positioned(
                            right: -2,
                            bottom: -2,
                            child: Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: colors.surface,
                                shape: BoxShape.circle,
                                border: Border.all(color: colors.fieldBorder),
                              ),
                              child: Icon(
                                Icons.photo_camera_outlined,
                                size: 15,
                                color: colors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profile.name.trim().isNotEmpty
                                ? profile.name
                                : l10n.appTitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          if (profile.mobile.trim().isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text(
                              profile.mobile,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.bodySmall?.copyWith(
                                color: Colors.white.withValues(alpha: 0.88),
                              ),
                            ),
                          ],
                          if (profile.email.trim().isNotEmpty) ...[
                            const SizedBox(height: 2),
                            Text(
                              profile.email,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.bodySmall?.copyWith(
                                color: Colors.white.withValues(alpha: 0.78),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _ProfileStatTile(
                      label: l10n.customersLabel,
                      value: '$customersCount',
                      icon: Icons.groups_outlined,
                      accentColor: const Color(0xFF2563EB),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _ProfileStatTile(
                      label: l10n.totalLoansStatLabel,
                      value: '$totalLoansCount',
                      icon: Icons.account_balance_wallet_outlined,
                      accentColor: const Color(0xFF4338CA),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _ProfileStatTile(
                      label: l10n.activeLoansLabel,
                      value: '$activeLoansCount',
                      icon: Icons.trending_up_rounded,
                      accentColor: colors.success,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _ProfileStatTile(
                      label: l10n.documentsStatLabel,
                      value: '$docsCount',
                      icon: Icons.description_outlined,
                      accentColor: const Color(0xFFD97706),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              FintechSurfaceCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FintechSectionHeader(
                      title: l10n.lenderDetailsHeading,
                      icon: Icons.manage_accounts_outlined,
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      key: const ValueKey('profile_name_field'),
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: l10n.nameLabel,
                        prefixIcon: const Icon(Icons.person_outline_rounded),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      key: const ValueKey('profile_mobile_field'),
                      controller: _mobileController,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      decoration: InputDecoration(
                        counterText: '',
                        labelText: l10n.mobileLabel,
                        prefixIcon: const Icon(Icons.phone_outlined),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      key: const ValueKey('profile_email_field'),
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: l10n.emailLabel,
                        prefixIcon: const Icon(Icons.mail_outline_rounded),
                      ),
                    ),
                    if (_errorText != null) ...[
                      const SizedBox(height: 12),
                      FintechErrorBanner(message: _errorText!),
                    ],
                    const SizedBox(height: 16),
                    FilledButton.icon(
                      key: const ValueKey('profile_save_button'),
                      style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        backgroundColor: colors.primary,
                      ),
                      onPressed: _saveProfile,
                      icon: const Icon(Icons.check_circle_outline_rounded),
                      label: Text(l10n.saveChangesButton),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              OutlinedButton.icon(
                key: const ValueKey('profile_sign_out_button'),
                onPressed: _confirmSignOut,
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  foregroundColor: colors.danger,
                  side: BorderSide(color: colors.danger.withValues(alpha: 0.45)),
                ),
                icon: const Icon(Icons.logout_rounded),
                label: Text(l10n.signOutAction),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ProfileStatTile extends StatelessWidget {
  const _ProfileStatTile({
    required this.label,
    required this.value,
    required this.icon,
    required this.accentColor,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return FintechSurfaceCard(
      radius: AppRadius.tile,
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(icon, size: 20, color: accentColor),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.titleMedium,
                ),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
