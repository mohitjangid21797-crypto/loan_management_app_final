import 'package:flutter/services.dart';
import 'package:loan_management_app/core/error/failures.dart';
import 'package:loan_management_app/core/theme/app_theme.dart';
import 'package:loan_management_app/l10n/app_localizations.dart';
import 'package:loan_management_app/l10n/l10n_failure_resolver.dart';
import 'package:loan_management_app/presentation/widgets/common/fintech_ui.dart';
import 'package:loan_management_app/state/app_state.dart';
import 'package:material_ui/material_ui.dart';

class BackupRestoreScreen extends StatefulWidget {
  const BackupRestoreScreen({
    super.key,
    required this.appState,
  });

  final AppState appState;

  @override
  State<BackupRestoreScreen> createState() => _BackupRestoreScreenState();
}

class _BackupRestoreScreenState extends State<BackupRestoreScreen> {
  final TextEditingController _jsonController = TextEditingController();
  String? _errorText;

  @override
  void dispose() {
    _jsonController.dispose();
    super.dispose();
  }

  Future<void> _exportBackup() async {
    final l10n = AppLocalizations.of(context);
    final json = widget.appState.store.exportBackupJson();
    _jsonController.text = json;
    await Clipboard.setData(ClipboardData(text: json));
    if (!mounted) return;
    setState(() => _errorText = null);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(l10n.backupGeneratedMessage),
        ),
      );
  }

  void _restoreBackup() {
    final l10n = AppLocalizations.of(context);
    final res = widget.appState.restoreBackupJson(_jsonController.text.trim());
    switch (res) {
      case Err<void>(:final failure):
        setState(() => _errorText = resolveFailureMessage(l10n, failure));
      case Success<void>():
        setState(() => _errorText = null);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text(l10n.restoreSuccessMessage),
            ),
          );
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
        title: Text(l10n.backupTitle),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
          children: [
            FintechHeroBanner(
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.shield_outlined,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      l10n.backupSubtitle,
                      style: textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.92),
                      ),
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
                    title: l10n.drawerBackupRestore,
                    icon: Icons.backup_outlined,
                  ),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: colors.primary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(AppRadius.field),
                      border: Border.all(
                        color: colors.primary.withValues(alpha: 0.22),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.cloud_done_outlined, color: colors.primary),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            l10n.driveComingSoonNote,
                            style: textTheme.bodySmall?.copyWith(
                              color: colors.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    key: const ValueKey('export_backup_button'),
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor: colors.primary,
                    ),
                    onPressed: _exportBackup,
                    icon: const Icon(Icons.download_rounded),
                    label: Text(l10n.exportBackupButton),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    key: const ValueKey('backup_json_field'),
                    controller: _jsonController,
                    maxLines: 6,
                    decoration: InputDecoration(
                      hintText: l10n.pasteBackupHint,
                    ),
                  ),
                  if (_errorText != null) ...[
                    const SizedBox(height: 10),
                    FintechErrorBanner(message: _errorText!),
                  ],
                  const SizedBox(height: 14),
                  OutlinedButton.icon(
                    key: const ValueKey('restore_backup_button'),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                    ),
                    onPressed: _restoreBackup,
                    icon: const Icon(Icons.restore_rounded),
                    label: Text(l10n.restoreBackupButton),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
