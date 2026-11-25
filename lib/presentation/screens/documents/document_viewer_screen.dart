import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';
import 'package:loan_management_app/core/theme/app_theme.dart';
import 'package:loan_management_app/core/utils/date_utils.dart';
import 'package:loan_management_app/core/utils/indian_currency_formatter.dart';
import 'package:loan_management_app/domain/models/loan_models.dart';
import 'package:loan_management_app/l10n/app_localizations.dart';
import 'package:loan_management_app/services/loan_agreement_pdf_service.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

class DocumentViewerScreen extends StatelessWidget {
  const DocumentViewerScreen({
    super.key,
    required this.document,
  });

  final LoanDocument document;

  Future<void> _copyHtml(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    await Clipboard.setData(ClipboardData(text: document.htmlContent));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(l10n.htmlCopiedMessage),
        ),
      );
  }

  Future<void> _sharePdf(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    try {
      final XFile fileToShare;
      if (kIsWeb) {
        final bytes = await LoanAgreementPdfService.buildPdfBytes(
          documentId: document.id,
          snapshot: document.snapshot,
          languageCode: document.languageCode,
          generatedAt: document.updatedAt,
          emiInstallmentNo: document.emiInstallmentNo,
        );
        fileToShare = XFile.fromData(
          Uint8List.fromList(bytes),
          mimeType: 'application/pdf',
          name: '${document.id}.pdf',
        );
      } else {
        String pdfPath = document.filePath;
        if (pdfPath.isEmpty || !File(pdfPath).existsSync()) {
          pdfPath =
              await LoanAgreementPdfService.generateAndSavePdfFile(document);
        }
        fileToShare = XFile(
          pdfPath,
          mimeType: 'application/pdf',
          name: '${document.id}.pdf',
        );
      }
      await Share.shareXFiles(
        [fileToShare],
        subject: document.title,
        text: document.title,
      );
    } catch (_) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(
              l10n.shareReadyMessage(document.title, document.pageCount),
            ),
          ),
        );
    }
  }

  Future<void> _printPdf(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    try {
      await Printing.layoutPdf(
        name: '${document.id}.pdf',
        onLayout: (_) => LoanAgreementPdfService.buildPdfBytes(
          documentId: document.id,
          snapshot: document.snapshot,
          languageCode: document.languageCode,
          generatedAt: document.updatedAt,
          emiInstallmentNo: document.emiInstallmentNo,
        ),
      );
    } catch (_) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(
              l10n.shareReadyMessage(document.title, document.pageCount),
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.lwColors;
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final pages = LoanAgreementPdfService.paginateInstallments(
      document.snapshot.schedule,
    );
    final pdfStrings =
        LoanAgreementPdfService.stringsForLanguage(document.languageCode);
    final docDirection =
        document.languageCode == 'ur' ? TextDirection.rtl : TextDirection.ltr;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.surface,
        surfaceTintColor: Colors.transparent,
        title: Text(
          l10n.documentViewerTitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            key: const ValueKey('viewer_print_button'),
            tooltip: l10n.viewPdfAction,
            onPressed: () => _printPdf(context),
            icon: const Icon(Icons.print_outlined),
          ),
          IconButton(
            key: const ValueKey('viewer_copy_html_button'),
            tooltip: l10n.copyHtmlAction,
            onPressed: () => _copyHtml(context),
            icon: const Icon(Icons.code_rounded),
          ),
          IconButton(
            key: const ValueKey('viewer_share_button'),
            tooltip: l10n.sharePdfMenu,
            onPressed: () => _sharePdf(context),
            icon: const Icon(Icons.share_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: pages.length,
          itemBuilder: (context, pageIndex) {
            final pageRows = pages[pageIndex];
            final isFirst = pageIndex == 0;
            final isLast = pageIndex == pages.length - 1;
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Directionality(
                textDirection: docDirection,
                child: _A4PageSheet(
                  document: document,
                  pdfStrings: pdfStrings,
                  rows: pageRows,
                  pageNumber: pageIndex + 1,
                  totalPages: pages.length,
                  showHeaderAndParties: isFirst,
                  showSignatures: isLast,
                  l10n: l10n,
                  textTheme: textTheme,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _A4PageSheet extends StatelessWidget {
  const _A4PageSheet({
    required this.document,
    required this.pdfStrings,
    required this.rows,
    required this.pageNumber,
    required this.totalPages,
    required this.showHeaderAndParties,
    required this.showSignatures,
    required this.l10n,
    required this.textTheme,
  });

  final LoanDocument document;
  final PdfLocalizedStrings pdfStrings;
  final List<EmiScheduleItem> rows;
  final int pageNumber;
  final int totalPages;
  final bool showHeaderAndParties;
  final bool showSignatures;
  final AppLocalizations l10n;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    final snapshot = document.snapshot;
    final lang = document.languageCode;
    final colors = context.lwColors;

    return Container(
      key: ValueKey('a4_page_$pageNumber'),
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFCBD5E1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: DefaultTextStyle(
        style: textTheme.bodySmall?.copyWith(color: const Color(0xFF0F172A)) ??
            const TextStyle(color: Color(0xFF0F172A)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (showHeaderAndParties) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      document.emiInstallmentNo == null
                          ? pdfStrings.headline
                          : '${pdfStrings.headline} — EMI #${document.emiInstallmentNo}',
                      style: textTheme.titleLarge?.copyWith(
                        color: const Color(0xFF1E3A8A),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${pdfStrings.generatedOn}: ${LoanDateUtils.formatFullMonthDateTime(document.updatedAt, lang)}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.labelSmall?.copyWith(
                            color: const Color(0xFF475569),
                          ),
                        ),
                        Text(
                          '${pdfStrings.documentId}: ${document.id}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.labelSmall?.copyWith(
                            color: const Color(0xFF475569),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(color: Color(0xFF2563EB), thickness: 1.5),
              const SizedBox(height: 8),
              // Two columns: LEFT = Lender, RIGHT = Borrower (RTL mirrors automatically)
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: _PartyCard(
                        title: pdfStrings.lenderDetails,
                        lines: [
                          '${pdfStrings.name}: ${snapshot.lenderName}',
                          '${pdfStrings.mobile}: ${snapshot.lenderMobile}',
                          if (snapshot.lenderEmail.trim().isNotEmpty)
                            '${pdfStrings.email}: ${snapshot.lenderEmail}',
                        ],
                        textTheme: textTheme,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _PartyCard(
                        title: pdfStrings.borrowerDetails,
                        lines: [
                          '${pdfStrings.name}: ${snapshot.borrowerName}',
                          '${pdfStrings.mobile}: ${snapshot.borrowerMobile}',
                          '${pdfStrings.location}: ${snapshot.borrowerLocation}',
                        ],
                        textTheme: textTheme,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 6,
                children: [
                  _SummaryChip(
                    label: pdfStrings.loanId,
                    value: snapshot.loanId,
                    textTheme: textTheme,
                  ),
                  _SummaryChip(
                    label: pdfStrings.principal,
                    value: IndianCurrencyFormatter.formatPaise(
                      snapshot.principalPaise,
                    ),
                    textTheme: textTheme,
                  ),
                  _SummaryChip(
                    label: pdfStrings.ratePerMonth,
                    value: '${snapshot.monthlyRatePercent.toStringAsFixed(2)}%',
                    textTheme: textTheme,
                  ),
                  _SummaryChip(
                    label: pdfStrings.tenureMonths,
                    value: '${snapshot.tenureMonths}',
                    textTheme: textTheme,
                  ),
                  _SummaryChip(
                    label: pdfStrings.loanType,
                    value: snapshot.loanType == LoanType.simple
                        ? pdfStrings.simpleType
                        : pdfStrings.compoundType,
                    textTheme: textTheme,
                  ),
                  _SummaryChip(
                    label: pdfStrings.startDate,
                    value: LoanDateUtils.formatFullMonthDate(
                      snapshot.startDate,
                      lang,
                    ),
                    textTheme: textTheme,
                  ),
                  _SummaryChip(
                    label: pdfStrings.monthlyEmi,
                    value: IndianCurrencyFormatter.formatPaise(
                      snapshot.monthlyEmiPaise,
                    ),
                    textTheme: textTheme,
                  ),
                  _SummaryChip(
                    label: pdfStrings.totalInterest,
                    value: IndianCurrencyFormatter.formatPaise(
                      snapshot.totalInterestPaise,
                    ),
                    textTheme: textTheme,
                  ),
                  _SummaryChip(
                    label: pdfStrings.totalPayable,
                    value: IndianCurrencyFormatter.formatPaise(
                      snapshot.totalPayablePaise,
                    ),
                    textTheme: textTheme,
                  ),
                  _SummaryChip(
                    label: pdfStrings.status,
                    value: snapshot.statusText,
                    textTheme: textTheme,
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
            Text(
              pdfStrings.installmentSchedule,
              style: textTheme.titleSmall?.copyWith(
                color: const Color(0xFF1E3A8A),
              ),
            ),
            const SizedBox(height: 6),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 680),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: const Color(0xFF1E3A8A),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 6,
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 30,
                            child: Text(
                              pdfStrings.colNo,
                              style: textTheme.labelSmall?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 105,
                            child: Text(
                              pdfStrings.colDueDate,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.labelSmall?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 90,
                            child: Text(
                              pdfStrings.colEmi,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.labelSmall?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 90,
                            child: Text(
                              pdfStrings.colPrincipal,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.labelSmall?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 85,
                            child: Text(
                              pdfStrings.colInterest,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.labelSmall?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 95,
                            child: Text(
                              pdfStrings.colBalance,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.labelSmall?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 72,
                            child: Text(
                              pdfStrings.colStatus,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.labelSmall?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 105,
                            child: Text(
                              pdfStrings.colPaidDate,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.labelSmall?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ...rows.map((row) {
                      final dueText = LoanDateUtils.formatFullMonthDate(
                        row.dueDate,
                        lang,
                      );
                      final paidText = row.paidDate != null
                          ? LoanDateUtils.formatFullMonthDate(
                              row.paidDate!,
                              lang,
                            )
                          : '-';
                      final statusLabel = row.isPaid
                          ? pdfStrings.paid
                          : (row.isOverdueAt()
                              ? pdfStrings.overdue
                              : pdfStrings.pending);
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 5,
                        ),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Color(0xFFE2E8F0)),
                          ),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 30,
                              child: Text(
                                '${row.installmentNo}',
                                style: textTheme.labelSmall?.copyWith(
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 105,
                              child: Text(
                                dueText,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.bodySmall?.copyWith(
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 90,
                              child: Text(
                                IndianCurrencyFormatter.formatPaise(
                                  row.emiPaise,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.bodySmall?.copyWith(
                                  color: const Color(0xFF0F172A),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 90,
                              child: Text(
                                IndianCurrencyFormatter.formatPaise(
                                  row.principalPartPaise,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.bodySmall?.copyWith(
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 85,
                              child: Text(
                                IndianCurrencyFormatter.formatPaise(
                                  row.interestPartPaise,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.bodySmall?.copyWith(
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 95,
                              child: Text(
                                IndianCurrencyFormatter.formatPaise(
                                  row.remainingBalancePaise,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.bodySmall?.copyWith(
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 72,
                              child: Text(
                                statusLabel,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.labelSmall?.copyWith(
                                  color: row.isPaid
                                      ? colors.success
                                      : (row.isOverdueAt()
                                          ? colors.danger
                                          : colors.textMuted),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 105,
                              child: Text(
                                paidText,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.bodySmall?.copyWith(
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
            if (showSignatures) ...[
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const Divider(color: Color(0xFF334155)),
                        Text(
                          pdfStrings.lenderSignature,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.labelSmall?.copyWith(
                            color: const Color(0xFF334155),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      children: [
                        const Divider(color: Color(0xFF334155)),
                        Text(
                          pdfStrings.borrowerSignature,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.labelSmall?.copyWith(
                            color: const Color(0xFF334155),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 10),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Text(
                l10n.pageOfLabel(pageNumber, totalPages),
                style: textTheme.labelSmall?.copyWith(
                  color: const Color(0xFF64748B),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PartyCard extends StatelessWidget {
  const _PartyCard({
    required this.title,
    required this.lines,
    required this.textTheme,
  });

  final String title;
  final List<String> lines;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFCBD5E1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.labelMedium?.copyWith(
              color: const Color(0xFF1E3A8A),
            ),
          ),
          const SizedBox(height: 4),
          ...lines.map(
            (line) => Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Text(
                line,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodySmall?.copyWith(
                  color: const Color(0xFF1E293B),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryChip extends StatelessWidget {
  const _SummaryChip({
    required this.label,
    required this.value,
    required this.textTheme,
  });

  final String label;
  final String value;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        '$label: $value',
        style: textTheme.labelSmall?.copyWith(color: const Color(0xFF0F172A)),
      ),
    );
  }
}
