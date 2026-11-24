import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:loan_management_app/core/theme/app_theme.dart';
import 'package:loan_management_app/l10n/app_localizations.dart';
import 'package:loan_management_app/l10n/supported_languages.dart';
import 'package:loan_management_app/presentation/screens/backup/backup_restore_screen.dart';
import 'package:loan_management_app/presentation/screens/loans/emi_calculator_screen.dart';
import 'package:loan_management_app/state/app_state.dart';
import 'package:material_ui/material_ui.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
    required this.appState,
  });

  final AppState appState;

  @override
  Widget build(BuildContext context) {
    final colors = context.lwColors;
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final profile = appState.profile;

    return Drawer(
      backgroundColor: colors.surface,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  colors.heroGradientStart,
                  colors.heroGradientEnd,
                ],
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Builder(
                    builder: (context) {
                      final photoPath = profile.photoPath;
                      final hasPhoto = photoPath != null &&
                          photoPath.isNotEmpty &&
                          (kIsWeb || File(photoPath).existsSync());
                      final ImageProvider? imageProvider = !hasPhoto
                          ? null
                          : (kIsWeb
                              ? NetworkImage(photoPath)
                              : FileImage(File(photoPath)) as ImageProvider);
                      return CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.white.withValues(alpha: 0.22),
                        backgroundImage: imageProvider,
                        child: hasPhoto
                            ? null
                            : Text(
                                profile.initials,
                                style: textTheme.titleLarge?.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                      );
                    },
                  ),
                  const SizedBox(height: 14),
                  Text(
                    profile.name.trim().isNotEmpty ? profile.name : l10n.appTitle,
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
                      style: textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.85),
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
          ),
          const SizedBox(height: 8),
          ListTile(
            key: const ValueKey('drawer_item_backup'),
            minVerticalPadding: 14,
            leading: Icon(Icons.backup_outlined, color: colors.primary),
            title: Text(
              l10n.drawerBackupRestore,
              style: textTheme.titleSmall,
            ),
            onTap: () {
              final nav = Navigator.of(context);
              nav.pop();
              nav.push(
                MaterialPageRoute<void>(
                  builder: (_) => BackupRestoreScreen(appState: appState),
                ),
              );
            },
          ),
          ListTile(
            key: const ValueKey('drawer_item_theme'),
            minVerticalPadding: 14,
            leading: Icon(Icons.palette_outlined, color: colors.primary),
            title: Text(
              l10n.drawerChangeTheme,
              style: textTheme.titleSmall,
            ),
            subtitle: Text(
              _themeLabel(l10n, appState.themeMode),
              style: textTheme.bodySmall,
            ),
            onTap: () {
              Navigator.of(context).pop();
              _showThemeDialog(context);
            },
          ),
          ListTile(
            key: const ValueKey('drawer_item_language'),
            minVerticalPadding: 14,
            leading: Icon(Icons.translate_rounded, color: colors.primary),
            title: Text(
              l10n.drawerChooseLanguage,
              style: textTheme.titleSmall,
            ),
            subtitle: Text(
              _currentLanguageNativeName(l10n, appState.localeOverride),
              style: textTheme.bodySmall,
            ),
            onTap: () {
              Navigator.of(context).pop();
              _showLanguageDialog(context);
            },
          ),
          ListTile(
            key: const ValueKey('drawer_item_calculator'),
            minVerticalPadding: 14,
            leading: Icon(Icons.calculate_outlined, color: colors.primary),
            title: Text(
              l10n.emiCalculatorTitle,
              style: textTheme.titleSmall,
            ),
            onTap: () {
              final nav = Navigator.of(context);
              nav.pop();
              nav.push(
                MaterialPageRoute<void>(
                  builder: (_) => EmiCalculatorScreen(appState: appState),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  String _themeLabel(AppLocalizations l10n, ThemeMode mode) {
    return switch (mode) {
      ThemeMode.light => l10n.themeLight,
      ThemeMode.dark => l10n.themeDark,
      ThemeMode.system => l10n.themeSystem,
    };
  }

  String _currentLanguageNativeName(
    AppLocalizations l10n,
    Locale? locale,
  ) {
    if (locale == null) {
      return l10n.systemDefaultLanguage;
    }
    for (final option in kSupportedLanguageOptions) {
      if (option.locale.languageCode == locale.languageCode) {
        return option.nativeName;
      }
    }
    return 'English';
  }

  void _showThemeDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    showDialog<void>(
      context: context,
      builder: (dialogContext) => ListenableBuilder(
        listenable: appState,
        builder: (context, _) {
          final current = appState.themeMode;
          return AlertDialog(
            title: Text(l10n.drawerChangeTheme),
            content: RadioGroup<ThemeMode>(
              groupValue: current,
              onChanged: (mode) {
                if (mode != null) appState.setThemeMode(mode);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile<ThemeMode>(
                    key: const ValueKey('theme_option_light'),
                    title: Text(l10n.themeLight),
                    value: ThemeMode.light,
                  ),
                  RadioListTile<ThemeMode>(
                    key: const ValueKey('theme_option_dark'),
                    title: Text(l10n.themeDark),
                    value: ThemeMode.dark,
                  ),
                  RadioListTile<ThemeMode>(
                    key: const ValueKey('theme_option_system'),
                    title: Text(l10n.themeSystem),
                    value: ThemeMode.system,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: Text(l10n.closeAction),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    showDialog<void>(
      context: context,
      builder: (dialogContext) => ListenableBuilder(
        listenable: appState,
        builder: (context, _) {
          final currentCode = appState.localeOverride?.languageCode;
          return AlertDialog(
            title: Text(l10n.drawerChooseLanguage),
            content: SizedBox(
              width: 320,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: kSupportedLanguageOptions.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    final isSystem = currentCode == null;
                    return ListTile(
                      key: const ValueKey('lang_option_system'),
                      title: Text(l10n.systemDefaultLanguage),
                      trailing: isSystem
                          ? Icon(
                              Icons.check_circle_rounded,
                              color: context.lwColors.primary,
                            )
                          : null,
                      onTap: () {
                        appState.setLocale(null);
                        Navigator.of(dialogContext).pop();
                      },
                    );
                  }
                  final option = kSupportedLanguageOptions[index - 1];
                  final isSelected = option.locale.languageCode == currentCode;
                  return ListTile(
                    key: ValueKey('lang_option_${option.locale.languageCode}'),
                    title: Text(option.nativeName),
                    trailing: isSelected
                        ? Icon(
                            Icons.check_circle_rounded,
                            color: context.lwColors.primary,
                          )
                        : null,
                    onTap: () {
                      appState.setLocale(option.locale);
                      Navigator.of(dialogContext).pop();
                    },
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: Text(l10n.closeAction),
              ),
            ],
          );
        },
      ),
    );
  }
}
