import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'package:loan_management_app/core/theme/app_theme.dart';
import 'package:loan_management_app/core/utils/date_utils.dart';
import 'package:loan_management_app/domain/models/loan_models.dart';
import 'package:loan_management_app/l10n/app_localizations.dart';
import 'package:loan_management_app/l10n/supported_languages.dart';
import 'package:loan_management_app/presentation/screens/documents/document_viewer_screen.dart';
import 'package:loan_management_app/presentation/screens/documents/edit_pdf_screen.dart';
import 'package:loan_management_app/presentation/widgets/common/fintech_ui.dart';
import 'package:loan_management_app/presentation/widgets/common/loan_status_chip.dart';
import 'package:loan_management_app/services/loan_agreement_pdf_service.dart';
import 'package:loan_management_app/state/app_state.dart';
import 'package:material_ui/material_ui.dart';
import 'package:share_plus/share_plus.dart';

enum _DocumentMenuAction { view, share, delete, edit }

class DocumentsScreen extends StatelessWidget {
  const DocumentsScreen({
    super.key,
    required this.appState,
  });

  final AppState appState;

  String _nativeLanguageName(String code) {
    for (final option in kSupportedLanguageOptions) {
      if (option.locale.languageCode == code) {
        return option.nativeName;
      }
    }
    return code;
  }

  String _initialsFromName(String name) {
    final parts = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((p) => p.isNotEmpty)
        .toList();
    if (parts.isEmpty) return 'LW';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }

  Future<void> _confirmDelete(
    BuildContext context,
    LoanDocument doc,
  ) async {
    final l10n = AppLocalizations.of(context);
    final colors = context.lwColors;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.deletePdfConfirmTitle),
        content: Text(l10n.deletePdfConfirmMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.cancelAction),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: TextButton.styleFrom(foregroundColor: colors.danger),
            child: Text(l10n.deleteAction),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      appState.deleteDocument(doc.id);
    }
  }

  Future<void> _shareDocument(BuildContext context, LoanDocument doc) async {
    final l10n = AppLocalizations.of(context);
    try {
      final XFile fileToShare;
      if (kIsWeb) {
        final bytes = await LoanAgreementPdfService.buildPdfBytes(
          documentId: doc.id,
          snapshot: doc.snapshot,
          languageCode: doc.languageCode,
          generatedAt: doc.updatedAt,
          emiInstallmentNo: doc.emiInstallmentNo,
        );
        fileToShare = XFile.fromData(
          Uint8List.fromList(bytes),
          mimeType: 'application/pdf',
          name: '${doc.id}.pdf',
        );
      } else {
        String pdfPath = doc.filePath;
        if (pdfPath.isEmpty || !File(pdfPath).existsSync()) {
          pdfPath = await LoanAgreementPdfService.generateAndSavePdfFile(doc);
          appState.store.updateDocumentPaths(
            documentId: doc.id,
            filePath: pdfPath,
            renderPath: pdfPath,
          );
        }
        fileToShare = XFile(
          pdfPath,
          mimeType: 'application/pdf',
          name: '${doc.id}.pdf',
        );
      }
      await Share.shareXFiles(
        [fileToShare],
        subject: doc.title,
        text: doc.title,
      );
    } on MissingPluginException {
      if (!context.mounted) return;
      _showShareFallback(context, l10n, doc);
    } on UnimplementedError {
      if (!context.mounted) return;
      _showShareFallback(context, l10n, doc);
    } catch (_) {
      if (!context.mounted) return;
      _showShareFallback(context, l10n, doc);
    }
  }

  void _showShareFallback(
    BuildContext context,
    AppLocalizations l10n,
    LoanDocument doc,
  ) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(l10n.shareReadyMessage(doc.title, doc.pageCount)),
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
        title: Text(l10n.documentsTitle),
      ),
      body: SafeArea(
        child: ListenableBuilder(
          listenable: appState,
          builder: (context, _) {
            final docs = appState.documents;
            if (docs.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: EmptyStateCard(
                    icon: Icons.description_outlined,
                    title: l10n.noDocumentsTitle,
                    subtitle: l10n.noDocumentsSubtitle,
                  ),
                ),
              );
            }

            // Group documents by customerMobile.
            final Map<String, List<LoanDocument>> grouped = {};
            for (final doc in docs) {
              grouped.putIfAbsent(doc.customerMobile, () => []).add(doc);
            }
            final entries = grouped.entries.toList();

            return ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
              itemCount: entries.length,
              itemBuilder: (context, groupIndex) {
                final group = entries[groupIndex];
                final mobile = group.key;
                final items = group.value;
                final borrowerName = items.first.snapshot.borrowerName;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10, top: 4),
                      child: Row(
                        children: [
                          FintechInitialsAvatar(
                            initials: _initialsFromName(borrowerName),
                            seed: borrowerName,
                            radius: 16,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              '$borrowerName · $mobile',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.titleSmall,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 9,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: colors.primary.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(9),
                            ),
                            child: Text(
                              '${items.length}',
                              style: textTheme.labelSmall?.copyWith(
                                color: colors.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ...items.map(
                      (doc) {
                        final badgeColor = doc.isEmiReceipt
                            ? colors.primary
                            : colors.success;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: FintechSurfaceCard(
                            key: ValueKey('doc_card_${doc.id}'),
                            radius: AppRadius.tile,
                            padding: EdgeInsets.zero,
                            child: InkWell(
                              borderRadius:
                                  BorderRadius.circular(AppRadius.tile),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute<void>(
                                    builder: (_) => DocumentViewerScreen(
                                      document: doc,
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(14, 14, 6, 14),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 44,
                                      height: 44,
                                      decoration: BoxDecoration(
                                        color: badgeColor.withValues(
                                          alpha: 0.12,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Icon(
                                        Icons.picture_as_pdf_rounded,
                                        color: badgeColor,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            doc.title,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: textTheme.titleSmall,
                                          ),
                                          const SizedBox(height: 6),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 3,
                                            ),
                                            decoration: BoxDecoration(
                                              color: badgeColor.withValues(
                                                alpha: 0.12,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                            ),
                                            child: Text(
                                              doc.isEmiReceipt
                                                  ? l10n.emiReceiptTag(
                                                      doc.emiInstallmentNo!,
                                                    )
                                                  : l10n.completeLoanPdfTag,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: textTheme.labelSmall
                                                  ?.copyWith(
                                                color: badgeColor,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.translate_rounded,
                                                size: 13,
                                                color: colors.textMuted,
                                              ),
                                              const SizedBox(width: 4),
                                              Expanded(
                                                child: Text(
                                                  '${doc.loanId} · ${_nativeLanguageName(doc.languageCode)}',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: textTheme.bodySmall,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 2),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.schedule_rounded,
                                                size: 13,
                                                color: colors.textMuted,
                                              ),
                                              const SizedBox(width: 4),
                                              Expanded(
                                                child: Text(
                                                  '${LoanDateUtils.formatShortDate(doc.updatedAt)} · ${l10n.pagesCountLabel(doc.pageCount)}',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: textTheme.bodySmall,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    PopupMenuButton<_DocumentMenuAction>(
                                      key: ValueKey('doc_menu_${doc.id}'),
                                      onSelected: (action) {
                                        switch (action) {
                                          case _DocumentMenuAction.view:
                                            Navigator.of(context).push(
                                              MaterialPageRoute<void>(
                                                builder: (_) =>
                                                    DocumentViewerScreen(
                                                  document: doc,
                                                ),
                                              ),
                                            );
                                          case _DocumentMenuAction.share:
                                            _shareDocument(context, doc);
                                          case _DocumentMenuAction.delete:
                                            _confirmDelete(context, doc);
                                          case _DocumentMenuAction.edit:
                                            Navigator.of(context).push(
                                              MaterialPageRoute<void>(
                                                builder: (_) => EditPdfScreen(
                                                  appState: appState,
                                                  document: doc,
                                                ),
                                              ),
                                            );
                                        }
                                      },
                                      itemBuilder: (context) => [
                                        PopupMenuItem(
                                          value: _DocumentMenuAction.view,
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.visibility_outlined,
                                                size: 18,
                                                color: colors.primary,
                                              ),
                                              const SizedBox(width: 10),
                                              Text(l10n.viewPdfMenu),
                                            ],
                                          ),
                                        ),
                                        PopupMenuItem(
                                          value: _DocumentMenuAction.share,
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.share_outlined,
                                                size: 18,
                                                color: colors.success,
                                              ),
                                              const SizedBox(width: 10),
                                              Text(l10n.sharePdfMenu),
                                            ],
                                          ),
                                        ),
                                        PopupMenuItem(
                                          value: _DocumentMenuAction.edit,
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.edit_document,
                                                size: 18,
                                                color: colors.primary,
                                              ),
                                              const SizedBox(width: 10),
                                              Text(l10n.editPdfMenu),
                                            ],
                                          ),
                                        ),
                                        PopupMenuItem(
                                          value: _DocumentMenuAction.delete,
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.delete_outline_rounded,
                                                size: 18,
                                                color: colors.danger,
                                              ),
                                              const SizedBox(width: 10),
                                              Text(
                                                l10n.deletePdfMenu,
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
                    const SizedBox(height: 6),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
