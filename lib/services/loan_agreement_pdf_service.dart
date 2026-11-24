import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'package:loan_management_app/core/utils/date_utils.dart';
import 'package:loan_management_app/core/utils/indian_currency_formatter.dart';
import 'package:loan_management_app/domain/models/loan_models.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfLocalizedStrings {
  const PdfLocalizedStrings({
    required this.headline,
    required this.generatedOn,
    required this.documentId,
    required this.lenderDetails,
    required this.borrowerDetails,
    required this.name,
    required this.mobile,
    required this.email,
    required this.location,
    required this.loanId,
    required this.principal,
    required this.ratePerMonth,
    required this.tenureMonths,
    required this.loanType,
    required this.simpleType,
    required this.compoundType,
    required this.startDate,
    required this.monthlyEmi,
    required this.totalInterest,
    required this.totalPayable,
    required this.status,
    required this.installmentSchedule,
    required this.colNo,
    required this.colDueDate,
    required this.colEmi,
    required this.colPrincipal,
    required this.colInterest,
    required this.colBalance,
    required this.colStatus,
    required this.colPaidDate,
    required this.paid,
    required this.pending,
    required this.overdue,
    required this.pageLabel,
    required this.ofLabel,
    required this.lenderSignature,
    required this.borrowerSignature,
    required this.fontFamily,
  });

  final String headline;
  final String generatedOn;
  final String documentId;
  final String lenderDetails;
  final String borrowerDetails;
  final String name;
  final String mobile;
  final String email;
  final String location;
  final String loanId;
  final String principal;
  final String ratePerMonth;
  final String tenureMonths;
  final String loanType;
  final String simpleType;
  final String compoundType;
  final String startDate;
  final String monthlyEmi;
  final String totalInterest;
  final String totalPayable;
  final String status;
  final String installmentSchedule;
  final String colNo;
  final String colDueDate;
  final String colEmi;
  final String colPrincipal;
  final String colInterest;
  final String colBalance;
  final String colStatus;
  final String colPaidDate;
  final String paid;
  final String pending;
  final String overdue;
  final String pageLabel;
  final String ofLabel;
  final String lenderSignature;
  final String borrowerSignature;
  final String fontFamily;
}

class LoanAgreementPdfService {
  const LoanAgreementPdfService._();

  static const int firstPageRowLimit = 60;
  static const int laterPageRowLimit = 70;

  static List<List<EmiScheduleItem>> paginateInstallments(
    List<EmiScheduleItem> schedule,
  ) {
    if (schedule.isEmpty) {
      return const [[]];
    }
    if (schedule.length <= firstPageRowLimit) {
      return [List<EmiScheduleItem>.from(schedule)];
    }
    final pages = <List<EmiScheduleItem>>[
      schedule.sublist(0, firstPageRowLimit),
    ];
    int offset = firstPageRowLimit;
    while (offset < schedule.length) {
      final end = (offset + laterPageRowLimit <= schedule.length)
          ? offset + laterPageRowLimit
          : schedule.length;
      pages.add(schedule.sublist(offset, end));
      offset = end;
    }
    return pages;
  }

  static PdfLocalizedStrings stringsForLanguage(String languageCode) {
    return _strings[languageCode] ?? _strings['en']!;
  }

  static String fontForLanguage(String languageCode) {
    return stringsForLanguage(languageCode).fontFamily;
  }

  static String buildDocumentHtml({
    required String documentId,
    required LoanDocumentSnapshot snapshot,
    required String languageCode,
    required DateTime generatedAt,
    DateTime? referenceNow,
    int? emiInstallmentNo,
  }) {
    final s = stringsForLanguage(languageCode);
    final isRtl = languageCode == 'ur';
    final dir = isRtl ? 'rtl' : 'ltr';
    final pages = paginateInstallments(snapshot.schedule);
    final pageCount = pages.length;
    final esc = const HtmlEscape().convert;
    final headerTitle = emiInstallmentNo == null
        ? s.headline
        : '${s.headline} — EMI #$emiInstallmentNo';

    final generatedStr = LoanDateUtils.formatFullMonthDateTime(
      generatedAt,
      languageCode,
    );
    final startStr = LoanDateUtils.formatFullMonthDate(
      snapshot.startDate,
      languageCode,
    );
    final loanTypeLabel =
        snapshot.loanType == LoanType.simple ? s.simpleType : s.compoundType;

    final buf = StringBuffer()
      ..writeln('<!DOCTYPE html>')
      ..writeln('<html lang="${esc(languageCode)}" dir="$dir">')
      ..writeln('<head>')
      ..writeln('<meta charset="utf-8" />')
      ..writeln('<title>${esc(headerTitle)}</title>')
      ..writeln('<style>')
      ..writeln('@page { size: A4; margin: 9mm; }')
      ..writeln('''
@font-face { font-family: 'Noto Sans'; src: local('Noto Sans'); }
@font-face { font-family: 'Noto Sans Devanagari'; src: local('Noto Sans Devanagari'); }
@font-face { font-family: 'Noto Sans Tamil'; src: local('Noto Sans Tamil'); }
@font-face { font-family: 'Noto Sans Telugu'; src: local('Noto Sans Telugu'); }
@font-face { font-family: 'Noto Sans Bengali'; src: local('Noto Sans Bengali'); }
@font-face { font-family: 'Noto Sans Gujarati'; src: local('Noto Sans Gujarati'); }
@font-face { font-family: 'Noto Sans Kannada'; src: local('Noto Sans Kannada'); }
@font-face { font-family: 'Noto Sans Malayalam'; src: local('Noto Sans Malayalam'); }
@font-face { font-family: 'Noto Sans Gurmukhi'; src: local('Noto Sans Gurmukhi'); }
@font-face { font-family: 'Noto Sans Oriya'; src: local('Noto Sans Oriya'); }
@font-face { font-family: 'Noto Naskh Arabic'; src: local('Noto Naskh Arabic'); }
* { box-sizing: border-box; margin: 0; padding: 0; }
body { font-family: '${esc(s.fontFamily)}', 'Noto Sans', sans-serif; color: #0F172A; font-size: 9px; line-height: 1.25; }
section.page { page-break-after: always; padding: 6px 4px; }
section.page.last { page-break-after: auto; }
.header { display: flex; justify-content: space-between; align-items: flex-start; border-bottom: 1.5px solid #2563EB; padding-bottom: 5px; margin-bottom: 6px; }
.header h1 { font-size: 15px; color: #1E3A8A; }
.meta { font-size: 8px; color: #475569; text-align: end; }
.parties { display: flex; justify-content: space-between; gap: 10px; margin-bottom: 6px; }
.party-box { flex: 1; border: 1px solid #CBD5E1; border-radius: 6px; padding: 5px 7px; background: #F8FAFC; }
.party-box h2 { font-size: 9.5px; color: #1E3A8A; margin-bottom: 3px; }
.summary-table { width: 100%; border-collapse: collapse; margin-bottom: 6px; font-size: 8.2px; }
.summary-table td { border: 1px solid #CBD5E1; padding: 2.5px 5px; }
.summary-table td.label { font-weight: 600; background: #F1F5F9; width: 22%; }
.sched-heading { font-size: 10px; color: #1E3A8A; margin: 4px 0 3px; }
.sched-table { width: 100%; border-collapse: collapse; font-size: 7.4px; }
.sched-table th { background: #1E3A8A; color: #FFFFFF; padding: 2.5px 3px; text-align: start; font-weight: 600; }
.sched-table td { border-bottom: 1px solid #E2E8F0; padding: 1.7px 3px; height: 11px; }
.sched-table tr { break-inside: avoid; page-break-inside: avoid; }
.signatures { display: flex; justify-content: space-between; margin-top: 14px; padding-top: 8px; }
.sig-box { width: 42%; border-top: 1px solid #334155; padding-top: 4px; text-align: center; font-size: 8.5px; }
.footer { margin-top: 6px; font-size: 7.5px; color: #64748B; text-align: end; }
''')
      ..writeln('</style>')
      ..writeln('</head>')
      ..writeln('<body>');

    for (int pageIndex = 0; pageIndex < pageCount; pageIndex++) {
      final isFirst = pageIndex == 0;
      final isLast = pageIndex == pageCount - 1;
      final rows = pages[pageIndex];
      buf.writeln(
        '<section class="page${isLast ? ' last' : ''}" data-page="${pageIndex + 1}" dir="$dir">',
      );

      if (isFirst) {
        buf
          ..writeln('<div class="header">')
          ..writeln('  <h1>${esc(headerTitle)}</h1>')
          ..writeln(
            '  <div class="meta"><div>${esc(s.generatedOn)}: ${esc(generatedStr)}</div><div>${esc(s.documentId)}: ${esc(documentId)}</div></div>',
          )
          ..writeln('</div>')
          ..writeln('<div class="parties">')
          ..writeln('  <div class="party-box lender-col" data-role="lender">')
          ..writeln('    <h2>${esc(s.lenderDetails)}</h2>')
          ..writeln(
            '    <div>${esc(s.name)}: ${esc(snapshot.lenderName)}</div>',
          )
          ..writeln(
            '    <div>${esc(s.mobile)}: ${esc(snapshot.lenderMobile)}</div>',
          );
        if (snapshot.lenderEmail.trim().isNotEmpty) {
          buf.writeln(
            '    <div>${esc(s.email)}: ${esc(snapshot.lenderEmail)}</div>',
          );
        }
        buf
          ..writeln('  </div>')
          ..writeln(
            '  <div class="party-box borrower-col" data-role="borrower">',
          )
          ..writeln('    <h2>${esc(s.borrowerDetails)}</h2>')
          ..writeln(
            '    <div>${esc(s.name)}: ${esc(snapshot.borrowerName)}</div>',
          )
          ..writeln(
            '    <div>${esc(s.mobile)}: ${esc(snapshot.borrowerMobile)}</div>',
          );
        if (snapshot.borrowerEmail.trim().isNotEmpty) {
          buf.writeln(
            '    <div>${esc(s.email)}: ${esc(snapshot.borrowerEmail)}</div>',
          );
        }
        buf
          ..writeln(
            '    <div>${esc(s.location)}: ${esc(snapshot.borrowerLocation)}</div>',
          )
          ..writeln('  </div>')
          ..writeln('</div>')
          ..writeln('<table class="summary-table">')
          ..writeln(
            '  <tr><td class="label">${esc(s.loanId)}</td><td>${esc(snapshot.loanId)}</td><td class="label">${esc(s.principal)}</td><td>${esc(IndianCurrencyFormatter.formatPaise(snapshot.principalPaise))}</td></tr>',
          )
          ..writeln(
            '  <tr><td class="label">${esc(s.ratePerMonth)}</td><td>${snapshot.monthlyRatePercent.toStringAsFixed(2)}%</td><td class="label">${esc(s.tenureMonths)}</td><td>${snapshot.tenureMonths}</td></tr>',
          )
          ..writeln(
            '  <tr><td class="label">${esc(s.loanType)}</td><td>${esc(loanTypeLabel)}</td><td class="label">${esc(s.startDate)}</td><td>${esc(startStr)}</td></tr>',
          )
          ..writeln(
            '  <tr><td class="label">${esc(s.monthlyEmi)}</td><td>${esc(IndianCurrencyFormatter.formatPaise(snapshot.monthlyEmiPaise))}</td><td class="label">${esc(s.totalInterest)}</td><td>${esc(IndianCurrencyFormatter.formatPaise(snapshot.totalInterestPaise))}</td></tr>',
          )
          ..writeln(
            '  <tr><td class="label">${esc(s.totalPayable)}</td><td>${esc(IndianCurrencyFormatter.formatPaise(snapshot.totalPayablePaise))}</td><td class="label">${esc(s.status)}</td><td>${esc(snapshot.statusText)}</td></tr>',
          )
          ..writeln('</table>');
      }

      buf
        ..writeln('<h3 class="sched-heading">${esc(s.installmentSchedule)}</h3>')
        ..writeln('<table class="sched-table">')
        ..writeln('  <thead>')
        ..writeln(
          '    <tr><th>${esc(s.colNo)}</th><th>${esc(s.colDueDate)}</th><th>${esc(s.colEmi)}</th><th>${esc(s.colPrincipal)}</th><th>${esc(s.colInterest)}</th><th>${esc(s.colBalance)}</th><th>${esc(s.colStatus)}</th><th>${esc(s.colPaidDate)}</th></tr>',
        )
        ..writeln('  </thead>')
        ..writeln('  <tbody>');

      for (final row in rows) {
        final dueStr =
            LoanDateUtils.formatFullMonthDate(row.dueDate, languageCode);
        final paidStr = row.paidDate != null
            ? LoanDateUtils.formatFullMonthDate(row.paidDate!, languageCode)
            : '-';
        final statusLabel = row.isPaid
            ? s.paid
            : (row.isOverdueAt(referenceNow) ? s.overdue : s.pending);
        buf.writeln(
          '    <tr><td>${row.installmentNo}</td><td>${esc(dueStr)}</td><td>${esc(IndianCurrencyFormatter.formatPaise(row.emiPaise))}</td><td>${esc(IndianCurrencyFormatter.formatPaise(row.principalPartPaise))}</td><td>${esc(IndianCurrencyFormatter.formatPaise(row.interestPartPaise))}</td><td>${esc(IndianCurrencyFormatter.formatPaise(row.remainingBalancePaise))}</td><td>${esc(statusLabel)}</td><td>${esc(paidStr)}</td></tr>',
        );
      }

      buf
        ..writeln('  </tbody>')
        ..writeln('</table>');

      if (isLast) {
        buf
          ..writeln('<div class="signatures">')
          ..writeln('  <div class="sig-box">${esc(s.lenderSignature)}</div>')
          ..writeln('  <div class="sig-box">${esc(s.borrowerSignature)}</div>')
          ..writeln('</div>');
      }

      buf
        ..writeln(
          '<div class="footer">${esc(s.pageLabel)} ${pageIndex + 1} ${esc(s.ofLabel)} $pageCount</div>',
        )
        ..writeln('</section>');
    }

    buf
      ..writeln('</body>')
      ..writeln('</html>');
    return buf.toString();
  }

  static Future<Uint8List> buildPdfBytes({
    required String documentId,
    required LoanDocumentSnapshot snapshot,
    required String languageCode,
    required DateTime generatedAt,
    DateTime? referenceNow,
    int? emiInstallmentNo,
  }) async {
    return buildVectorPdfBytes(
      documentId: documentId,
      snapshot: snapshot,
      languageCode: languageCode,
      generatedAt: generatedAt,
      referenceNow: referenceNow,
      emiInstallmentNo: emiInstallmentNo,
    );
  }

  static Future<Uint8List> buildVectorPdfBytes({
    required String documentId,
    required LoanDocumentSnapshot snapshot,
    required String languageCode,
    required DateTime generatedAt,
    DateTime? referenceNow,
    int? emiInstallmentNo,
  }) async {
    final s = stringsForLanguage(languageCode);
    final en = _strings['en']!;
    final unicodeFont = await _tryLoadSystemUnicodeFont();
    final hasUnicodeFont = unicodeFont != null;
    final textDirection =
        languageCode == 'ur' && hasUnicodeFont ? pw.TextDirection.rtl : pw.TextDirection.ltr;

    String safeText(String input, [String? asciiFallback]) {
      if (hasUnicodeFont) return input;
      final normalized = input
          .replaceAll('₹', 'Rs. ')
          .replaceAll('—', '-')
          .replaceAll('·', '-');
      final asciiOnly = normalized.replaceAll(RegExp(r'[^\x20-\x7E]'), '').trim();
      if (asciiOnly.isNotEmpty) return asciiOnly;
      if (asciiFallback != null && asciiFallback.isNotEmpty) {
        return asciiFallback
            .replaceAll('₹', 'Rs. ')
            .replaceAll('—', '-')
            .replaceAll('·', '-');
      }
      return '-';
    }

    final baseStyle = pw.TextStyle(
      font: unicodeFont ?? pw.Font.helvetica(),
      fontBold: unicodeFont ?? pw.Font.helveticaBold(),
      fontSize: 7.5,
      color: const PdfColor.fromInt(0xFF0F172A),
    );
    final boldStyle = baseStyle.copyWith(fontWeight: pw.FontWeight.bold);
    const headerBlue = PdfColor.fromInt(0xFF1E3A8A);
    const borderSlate = PdfColor.fromInt(0xFFCBD5E1);
    const bgSlate = PdfColor.fromInt(0xFFF8FAFC);

    final pages = paginateInstallments(snapshot.schedule);
    final pageCount = pages.length;
    final doc = pw.Document(title: safeText(s.headline, en.headline));
    final generatedStr = LoanDateUtils.formatFullMonthDateTime(
      generatedAt,
      hasUnicodeFont ? languageCode : 'en',
    );
    final startStr = LoanDateUtils.formatFullMonthDate(
      snapshot.startDate,
      hasUnicodeFont ? languageCode : 'en',
    );
    final titleText = emiInstallmentNo == null
        ? safeText(s.headline, en.headline)
        : '${safeText(s.headline, en.headline)} - EMI #$emiInstallmentNo';
    final loanTypeLabel = snapshot.loanType == LoanType.simple
        ? safeText(s.simpleType, en.simpleType)
        : safeText(s.compoundType, en.compoundType);

    for (int pageIndex = 0; pageIndex < pageCount; pageIndex++) {
      final isFirst = pageIndex == 0;
      final isLast = pageIndex == pageCount - 1;
      final rows = pages[pageIndex];

      doc.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(18),
          build: (pw.Context ctx) {
            return pw.Directionality(
              textDirection: textDirection,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                children: [
                  if (isFirst) ...[
                    pw.Container(
                      padding: const pw.EdgeInsets.only(bottom: 5),
                      decoration: const pw.BoxDecoration(
                        border: pw.Border(
                          bottom: pw.BorderSide(
                            color: PdfColor.fromInt(0xFF2563EB),
                            width: 1.4,
                          ),
                        ),
                      ),
                      child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            titleText,
                            style: boldStyle.copyWith(
                              fontSize: 13,
                              color: headerBlue,
                            ),
                          ),
                          pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.end,
                            children: [
                              pw.Text(
                                '${safeText(s.generatedOn, en.generatedOn)}: ${safeText(generatedStr)}',
                                style: baseStyle.copyWith(fontSize: 6.8),
                              ),
                              pw.Text(
                                '${safeText(s.documentId, en.documentId)}: $documentId',
                                style: baseStyle.copyWith(fontSize: 6.8),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Expanded(
                          child: pw.Container(
                            padding: const pw.EdgeInsets.all(5),
                            decoration: pw.BoxDecoration(
                              color: bgSlate,
                              border: pw.Border.all(color: borderSlate),
                              borderRadius: pw.BorderRadius.circular(4),
                            ),
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  safeText(s.lenderDetails, en.lenderDetails),
                                  style: boldStyle.copyWith(
                                    fontSize: 8,
                                    color: headerBlue,
                                  ),
                                ),
                                pw.SizedBox(height: 2),
                                pw.Text(
                                  '${safeText(s.name, en.name)}: ${safeText(snapshot.lenderName, snapshot.lenderName)}',
                                  style: baseStyle.copyWith(fontSize: 7),
                                ),
                                pw.Text(
                                  '${safeText(s.mobile, en.mobile)}: ${snapshot.lenderMobile}',
                                  style: baseStyle.copyWith(fontSize: 7),
                                ),
                                if (snapshot.lenderEmail.trim().isNotEmpty)
                                  pw.Text(
                                    '${safeText(s.email, en.email)}: ${safeText(snapshot.lenderEmail)}',
                                    style: baseStyle.copyWith(fontSize: 7),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        pw.SizedBox(width: 8),
                        pw.Expanded(
                          child: pw.Container(
                            padding: const pw.EdgeInsets.all(5),
                            decoration: pw.BoxDecoration(
                              color: bgSlate,
                              border: pw.Border.all(color: borderSlate),
                              borderRadius: pw.BorderRadius.circular(4),
                            ),
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  safeText(s.borrowerDetails, en.borrowerDetails),
                                  style: boldStyle.copyWith(
                                    fontSize: 8,
                                    color: headerBlue,
                                  ),
                                ),
                                pw.SizedBox(height: 2),
                                pw.Text(
                                  '${safeText(s.name, en.name)}: ${safeText(snapshot.borrowerName)}',
                                  style: baseStyle.copyWith(fontSize: 7),
                                ),
                                pw.Text(
                                  '${safeText(s.mobile, en.mobile)}: ${snapshot.borrowerMobile}',
                                  style: baseStyle.copyWith(fontSize: 7),
                                ),
                                if (snapshot.borrowerEmail.trim().isNotEmpty)
                                  pw.Text(
                                    '${safeText(s.email, en.email)}: ${safeText(snapshot.borrowerEmail)}',
                                    style: baseStyle.copyWith(fontSize: 7),
                                  ),
                                pw.Text(
                                  '${safeText(s.location, en.location)}: ${safeText(snapshot.borrowerLocation)}',
                                  style: baseStyle.copyWith(fontSize: 7),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 5),
                    pw.Table(
                      border: pw.TableBorder.all(color: borderSlate, width: 0.6),
                      children: [
                        _summaryPdfRow(
                          safeText(s.loanId, en.loanId),
                          snapshot.loanId,
                          safeText(s.principal, en.principal),
                          safeText(
                            IndianCurrencyFormatter.formatPaise(
                              snapshot.principalPaise,
                            ),
                          ),
                          baseStyle,
                          boldStyle,
                        ),
                        _summaryPdfRow(
                          safeText(s.ratePerMonth, en.ratePerMonth),
                          '${snapshot.monthlyRatePercent.toStringAsFixed(2)}%',
                          safeText(s.tenureMonths, en.tenureMonths),
                          '${snapshot.tenureMonths}',
                          baseStyle,
                          boldStyle,
                        ),
                        _summaryPdfRow(
                          safeText(s.loanType, en.loanType),
                          loanTypeLabel,
                          safeText(s.startDate, en.startDate),
                          safeText(startStr),
                          baseStyle,
                          boldStyle,
                        ),
                        _summaryPdfRow(
                          safeText(s.monthlyEmi, en.monthlyEmi),
                          safeText(
                            IndianCurrencyFormatter.formatPaise(
                              snapshot.monthlyEmiPaise,
                            ),
                          ),
                          safeText(s.totalInterest, en.totalInterest),
                          safeText(
                            IndianCurrencyFormatter.formatPaise(
                              snapshot.totalInterestPaise,
                            ),
                          ),
                          baseStyle,
                          boldStyle,
                        ),
                        _summaryPdfRow(
                          safeText(s.totalPayable, en.totalPayable),
                          safeText(
                            IndianCurrencyFormatter.formatPaise(
                              snapshot.totalPayablePaise,
                            ),
                          ),
                          safeText(s.status, en.status),
                          safeText(snapshot.statusText, en.paid),
                          baseStyle,
                          boldStyle,
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 5),
                  ],
                  pw.Text(
                    safeText(s.installmentSchedule, en.installmentSchedule),
                    style: boldStyle.copyWith(fontSize: 8.2, color: headerBlue),
                  ),
                  pw.SizedBox(height: 3),
                  pw.Table(
                    border: const pw.TableBorder(
                      horizontalInside: pw.BorderSide(
                        color: PdfColor.fromInt(0xFFE2E8F0),
                        width: 0.4,
                      ),
                      bottom: pw.BorderSide(color: borderSlate, width: 0.6),
                    ),
                    columnWidths: const {
                      0: pw.FixedColumnWidth(22),
                      1: pw.FlexColumnWidth(2.1),
                      2: pw.FlexColumnWidth(1.6),
                      3: pw.FlexColumnWidth(1.6),
                      4: pw.FlexColumnWidth(1.5),
                      5: pw.FlexColumnWidth(1.7),
                      6: pw.FlexColumnWidth(1.2),
                      7: pw.FlexColumnWidth(1.8),
                    },
                    children: [
                      pw.TableRow(
                        decoration: const pw.BoxDecoration(color: headerBlue),
                        children: [
                          _schedHeaderCell(safeText(s.colNo, en.colNo), boldStyle),
                          _schedHeaderCell(
                            safeText(s.colDueDate, en.colDueDate),
                            boldStyle,
                          ),
                          _schedHeaderCell(
                            safeText(s.colEmi, en.colEmi),
                            boldStyle,
                          ),
                          _schedHeaderCell(
                            safeText(s.colPrincipal, en.colPrincipal),
                            boldStyle,
                          ),
                          _schedHeaderCell(
                            safeText(s.colInterest, en.colInterest),
                            boldStyle,
                          ),
                          _schedHeaderCell(
                            safeText(s.colBalance, en.colBalance),
                            boldStyle,
                          ),
                          _schedHeaderCell(
                            safeText(s.colStatus, en.colStatus),
                            boldStyle,
                          ),
                          _schedHeaderCell(
                            safeText(s.colPaidDate, en.colPaidDate),
                            boldStyle,
                          ),
                        ],
                      ),
                      ...rows.map((row) {
                        final dueStr = LoanDateUtils.formatFullMonthDate(
                          row.dueDate,
                          hasUnicodeFont ? languageCode : 'en',
                        );
                        final paidStr = row.paidDate != null
                            ? LoanDateUtils.formatFullMonthDate(
                                row.paidDate!,
                                hasUnicodeFont ? languageCode : 'en',
                              )
                            : '-';
                        final statusLabel = row.isPaid
                            ? safeText(s.paid, en.paid)
                            : (row.isOverdueAt(referenceNow)
                                ? safeText(s.overdue, en.overdue)
                                : safeText(s.pending, en.pending));
                        return pw.TableRow(
                          children: [
                            _schedDataCell('${row.installmentNo}', baseStyle),
                            _schedDataCell(safeText(dueStr), baseStyle),
                            _schedDataCell(
                              safeText(
                                IndianCurrencyFormatter.formatPaise(row.emiPaise),
                              ),
                              baseStyle,
                            ),
                            _schedDataCell(
                              safeText(
                                IndianCurrencyFormatter.formatPaise(
                                  row.principalPartPaise,
                                ),
                              ),
                              baseStyle,
                            ),
                            _schedDataCell(
                              safeText(
                                IndianCurrencyFormatter.formatPaise(
                                  row.interestPartPaise,
                                ),
                              ),
                              baseStyle,
                            ),
                            _schedDataCell(
                              safeText(
                                IndianCurrencyFormatter.formatPaise(
                                  row.remainingBalancePaise,
                                ),
                              ),
                              baseStyle,
                            ),
                            _schedDataCell(statusLabel, baseStyle),
                            _schedDataCell(safeText(paidStr), baseStyle),
                          ],
                        );
                      }),
                    ],
                  ),
                  if (isLast) ...[
                    pw.SizedBox(height: 10),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Container(
                          width: 170,
                          padding: const pw.EdgeInsets.only(top: 3),
                          decoration: const pw.BoxDecoration(
                            border: pw.Border(
                              top: pw.BorderSide(
                                color: PdfColor.fromInt(0xFF334155),
                              ),
                            ),
                          ),
                          child: pw.Text(
                            safeText(s.lenderSignature, en.lenderSignature),
                            textAlign: pw.TextAlign.center,
                            style: baseStyle.copyWith(fontSize: 7),
                          ),
                        ),
                        pw.Container(
                          width: 170,
                          padding: const pw.EdgeInsets.only(top: 3),
                          decoration: const pw.BoxDecoration(
                            border: pw.Border(
                              top: pw.BorderSide(
                                color: PdfColor.fromInt(0xFF334155),
                              ),
                            ),
                          ),
                          child: pw.Text(
                            safeText(s.borrowerSignature, en.borrowerSignature),
                            textAlign: pw.TextAlign.center,
                            style: baseStyle.copyWith(fontSize: 7),
                          ),
                        ),
                      ],
                    ),
                  ],
                  pw.Spacer(),
                  pw.Align(
                    alignment: pw.Alignment.centerRight,
                    child: pw.Text(
                      '${safeText(s.pageLabel, en.pageLabel)} ${pageIndex + 1} ${safeText(s.ofLabel, en.ofLabel)} $pageCount',
                      style: baseStyle.copyWith(
                        fontSize: 6.8,
                        color: const PdfColor.fromInt(0xFF64748B),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    }

    return doc.save();
  }

  static pw.TableRow _summaryPdfRow(
    String k1,
    String v1,
    String k2,
    String v2,
    pw.TextStyle base,
    pw.TextStyle bold,
  ) {
    const labelBg = PdfColor.fromInt(0xFFF1F5F9);
    return pw.TableRow(
      children: [
        pw.Container(
          color: labelBg,
          padding: const pw.EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          child: pw.Text(k1, style: bold.copyWith(fontSize: 6.8)),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          child: pw.Text(v1, style: base.copyWith(fontSize: 6.8)),
        ),
        pw.Container(
          color: labelBg,
          padding: const pw.EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          child: pw.Text(k2, style: bold.copyWith(fontSize: 6.8)),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          child: pw.Text(v2, style: base.copyWith(fontSize: 6.8)),
        ),
      ],
    );
  }

  static pw.Widget _schedHeaderCell(String text, pw.TextStyle bold) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      child: pw.Text(
        text,
        style: bold.copyWith(fontSize: 6.2, color: PdfColors.white),
      ),
    );
  }

  static pw.Widget _schedDataCell(String text, pw.TextStyle base) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(horizontal: 2, vertical: 1.1),
      child: pw.Text(
        text,
        style: base.copyWith(fontSize: 6.0),
      ),
    );
  }

  static Future<pw.Font?> _tryLoadSystemUnicodeFont() async {
    if (kIsWeb) return null;
    const candidates = [
      '/usr/share/fonts/truetype/noto/NotoSans-Regular.ttf',
      '/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf',
      '/system/fonts/NotoSans-Regular.ttf',
      '/system/fonts/Roboto-Regular.ttf',
    ];
    for (final path in candidates) {
      try {
        final file = File(path);
        if (file.existsSync()) {
          final bytes = await file.readAsBytes();
          return pw.Font.ttf(bytes.buffer.asByteData());
        }
      } catch (_) {
        // Try next font candidate.
      }
    }
    return null;
  }

  static Future<Directory> getPdfDirectory() async {
    if (kIsWeb) {
      throw UnsupportedError('Local PDF directory is unavailable on web.');
    }
    try {
      final support = await getApplicationSupportDirectory();
      final dir = Directory(p.join(support.path, 'loanwise_pdfs'));
      if (!dir.existsSync()) {
        await dir.create(recursive: true);
      }
      return dir;
    } catch (_) {
      final dir = Directory(p.join(Directory.systemTemp.path, 'loanwise_pdfs'));
      if (!dir.existsSync()) {
        await dir.create(recursive: true);
      }
      return dir;
    }
  }

  static Future<String> generateAndSavePdfFile(LoanDocument document) async {
    if (kIsWeb) return '';
    final bytes = await buildPdfBytes(
      documentId: document.id,
      snapshot: document.snapshot,
      languageCode: document.languageCode,
      generatedAt: document.updatedAt,
      emiInstallmentNo: document.emiInstallmentNo,
    );
    final dir = await getPdfDirectory();
    final safeId = document.id.replaceAll(RegExp(r'[^a-zA-Z0-9_-]'), '_');
    final targetPath = p.join(dir.path, '$safeId.pdf');
    final file = File(targetPath);
    await file.writeAsBytes(bytes, flush: true);
    return targetPath;
  }

  static Future<void> deletePdfFileIfExists(String? filePath) async {
    if (kIsWeb || filePath == null || filePath.trim().isEmpty) return;
    try {
      final file = File(filePath);
      if (file.existsSync()) {
        await file.delete();
      }
    } catch (_) {
      // Ignore cleanup errors.
    }
  }

  static const Map<String, PdfLocalizedStrings> _strings = {
    'en': PdfLocalizedStrings(
      headline: 'Loan Agreement',
      generatedOn: 'Generated on',
      documentId: 'Document ID',
      lenderDetails: 'Lender Details',
      borrowerDetails: 'Borrower Details',
      name: 'Name',
      mobile: 'Mobile',
      email: 'Email',
      location: 'Location',
      loanId: 'Loan ID',
      principal: 'Principal',
      ratePerMonth: 'Rate / month',
      tenureMonths: 'Tenure (months)',
      loanType: 'Interest type',
      simpleType: 'Simple',
      compoundType: 'Compound',
      startDate: 'Start date',
      monthlyEmi: 'Monthly EMI',
      totalInterest: 'Total interest',
      totalPayable: 'Total payable',
      status: 'Status',
      installmentSchedule: 'Installment Schedule',
      colNo: '#',
      colDueDate: 'Due date',
      colEmi: 'EMI',
      colPrincipal: 'Principal',
      colInterest: 'Interest',
      colBalance: 'Balance',
      colStatus: 'Status',
      colPaidDate: 'Paid date',
      paid: 'Paid',
      pending: 'Pending',
      overdue: 'Overdue',
      pageLabel: 'Page',
      ofLabel: 'of',
      lenderSignature: 'Lender Signature',
      borrowerSignature: 'Borrower Signature',
      fontFamily: 'Noto Sans',
    ),
    'hi': PdfLocalizedStrings(
      headline: 'ऋण समझौता',
      generatedOn: 'तैयार करने की तिथि',
      documentId: 'दस्तावेज़ आईडी',
      lenderDetails: 'ऋणदाता का विवरण',
      borrowerDetails: 'उधारकर्ता का विवरण',
      name: 'नाम',
      mobile: 'मोबाइल',
      email: 'ईमेल',
      location: 'स्थान',
      loanId: 'ऋण आईडी',
      principal: 'मूलधन',
      ratePerMonth: 'ब्याज दर / माह',
      tenureMonths: 'अवधि (माह)',
      loanType: 'ब्याज प्रकार',
      simpleType: 'साधारण',
      compoundType: 'चक्रवृद्धि',
      startDate: 'प्रारंभ तिथि',
      monthlyEmi: 'मासिक ईएमआई',
      totalInterest: 'कुल ब्याज',
      totalPayable: 'कुल देय',
      status: 'स्थिति',
      installmentSchedule: 'किस्त अनुसूची',
      colNo: '#',
      colDueDate: 'देय तिथि',
      colEmi: 'ईएमआई',
      colPrincipal: 'मूलधन',
      colInterest: 'ब्याज',
      colBalance: 'शेष',
      colStatus: 'स्थिति',
      colPaidDate: 'भुगतान तिथि',
      paid: 'भुगतान हुआ',
      pending: 'लंबित',
      overdue: 'अतिदेय',
      pageLabel: 'पृष्ठ',
      ofLabel: '/',
      lenderSignature: 'ऋणदाता के हस्ताक्षर',
      borrowerSignature: 'उधारकर्ता के हस्ताक्षर',
      fontFamily: 'Noto Sans Devanagari',
    ),
    'ta': PdfLocalizedStrings(
      headline: 'கடன் ஒப்பந்தம்',
      generatedOn: 'உருவாக்கப்பட்ட தேதி',
      documentId: 'ஆவண ஐடி',
      lenderDetails: 'கடன் வழங்குபவர் விவரம்',
      borrowerDetails: 'கடன் வாங்குபவர் விவரம்',
      name: 'பெயர்',
      mobile: 'மொபைல்',
      email: 'மின்னஞ்சல்',
      location: 'இடம்',
      loanId: 'கடன் ஐடி',
      principal: 'அசல்',
      ratePerMonth: 'மாத வட்டி விகிதம்',
      tenureMonths: 'காலம் (மாதம்)',
      loanType: 'வட்டி வகை',
      simpleType: 'தனி வட்டி',
      compoundType: 'கூட்டு வட்டி',
      startDate: 'தொடக்க தேதி',
      monthlyEmi: 'மாதாந்திர EMI',
      totalInterest: 'மொத்த வட்டி',
      totalPayable: 'மொத்த தொகை',
      status: 'நிலை',
      installmentSchedule: 'தவணை அட்டவணை',
      colNo: '#',
      colDueDate: 'கடைசி தேதி',
      colEmi: 'EMI',
      colPrincipal: 'அசல்',
      colInterest: 'வட்டி',
      colBalance: 'மீதி',
      colStatus: 'நிலை',
      colPaidDate: 'செலுத்திய தேதி',
      paid: 'செலுத்தப்பட்டது',
      pending: 'நிலுவை',
      overdue: 'காலாவதி',
      pageLabel: 'பக்கம்',
      ofLabel: '/',
      lenderSignature: 'வழங்குபவர் கையொப்பம்',
      borrowerSignature: 'வாங்குபவர் கையொப்பம்',
      fontFamily: 'Noto Sans Tamil',
    ),
    'te': PdfLocalizedStrings(
      headline: 'రుణ ఒప్పందం',
      generatedOn: 'రూపొందించిన తేదీ',
      documentId: 'పత్రం ID',
      lenderDetails: 'రుణదాత వివరాలు',
      borrowerDetails: 'రుణగ్రహీత వివరాలు',
      name: 'పేరు',
      mobile: 'మొబైల్',
      email: 'ఇమెయిల్',
      location: 'స్థలం',
      loanId: 'రుణ ID',
      principal: 'అసలు',
      ratePerMonth: 'నెలవారీ వడ్డీ',
      tenureMonths: 'వ్యవధి (నెలలు)',
      loanType: 'వడ్డీ రకం',
      simpleType: 'సాధారణ',
      compoundType: 'చక్రవడ్డీ',
      startDate: 'ప్రారంభ తేదీ',
      monthlyEmi: 'నెలవారీ EMI',
      totalInterest: 'మొత్తం వడ్డీ',
      totalPayable: 'మొత్తం చెల్లింపు',
      status: 'స్థితి',
      installmentSchedule: 'వాయిదా పట్టిక',
      colNo: '#',
      colDueDate: 'గడువు తేదీ',
      colEmi: 'EMI',
      colPrincipal: 'అసలు',
      colInterest: 'వడ్డీ',
      colBalance: 'బ్యాలెన్స్',
      colStatus: 'స్థితి',
      colPaidDate: 'చెల్లించిన తేదీ',
      paid: 'చెల్లించారు',
      pending: 'పెండింగ్',
      overdue: 'గడువు ముగిసింది',
      pageLabel: 'పేజీ',
      ofLabel: '/',
      lenderSignature: 'రుణదాత సంతకం',
      borrowerSignature: 'రుణగ్రహీత సంతకం',
      fontFamily: 'Noto Sans Telugu',
    ),
    'bn': PdfLocalizedStrings(
      headline: 'ঋণ চুক্তি',
      generatedOn: 'তৈরির তারিখ',
      documentId: 'নথি আইডি',
      lenderDetails: 'ঋণদাতার বিবরণ',
      borrowerDetails: 'ঋণগ্রহীতার বিবরণ',
      name: 'নাম',
      mobile: 'মোবাইল',
      email: 'ইমেইল',
      location: 'অবস্থান',
      loanId: 'ঋণ আইডি',
      principal: 'আসল',
      ratePerMonth: 'মাসিক সুদ',
      tenureMonths: 'মেয়াদ (মাস)',
      loanType: 'সুদের ধরন',
      simpleType: 'সরল',
      compoundType: 'চক্রবৃদ্ধি',
      startDate: 'শুরুর তারিখ',
      monthlyEmi: 'মাসিক ইএমআই',
      totalInterest: 'মোট সুদ',
      totalPayable: 'মোট পরিশোধ্য',
      status: 'অবস্থা',
      installmentSchedule: 'কিস্তির তালিকা',
      colNo: '#',
      colDueDate: 'দেয় তারিখ',
      colEmi: 'ইএমআই',
      colPrincipal: 'আসল',
      colInterest: 'সুদ',
      colBalance: 'বাকি',
      colStatus: 'অবস্থা',
      colPaidDate: 'পরিশোধের তারিখ',
      paid: 'পরিশোধিত',
      pending: 'বকেয়া',
      overdue: 'সময় উত্তীর্ণ',
      pageLabel: 'পৃষ্ঠা',
      ofLabel: '/',
      lenderSignature: 'ঋণদাতার স্বাক্ষর',
      borrowerSignature: 'ঋণগ্রহীতার স্বাক্ষর',
      fontFamily: 'Noto Sans Bengali',
    ),
    'mr': PdfLocalizedStrings(
      headline: 'कर्ज करार',
      generatedOn: 'तयार केलेली तारीख',
      documentId: 'दस्तऐवज आयडी',
      lenderDetails: 'कर्जदात्याचा तपशील',
      borrowerDetails: 'कर्जदाराचा तपशील',
      name: 'नाव',
      mobile: 'मोबाईल',
      email: 'ईमेल',
      location: 'ठिकाण',
      loanId: 'कर्ज आयडी',
      principal: 'मुद्दल',
      ratePerMonth: 'मासिक दर',
      tenureMonths: 'कालावधी (महिने)',
      loanType: 'व्याज प्रकार',
      simpleType: 'सरळ',
      compoundType: 'चक्रवाढ',
      startDate: 'सुरुवातीची तारीख',
      monthlyEmi: 'मासिक ईएमआय',
      totalInterest: 'एकूण व्याज',
      totalPayable: 'एकूण देय',
      status: 'स्थिती',
      installmentSchedule: 'हप्त्यांचे वेळापत्रक',
      colNo: '#',
      colDueDate: 'देय तारीख',
      colEmi: 'ईएमआय',
      colPrincipal: 'मुद्दल',
      colInterest: 'व्याज',
      colBalance: 'शिल्लक',
      colStatus: 'स्थिती',
      colPaidDate: 'भरणा तारीख',
      paid: 'भरले',
      pending: 'प्रलंबित',
      overdue: 'थकीत',
      pageLabel: 'पान',
      ofLabel: '/',
      lenderSignature: 'कर्जदात्याची स्वाक्षरी',
      borrowerSignature: 'कर्जदाराची स्वाक्षरी',
      fontFamily: 'Noto Sans Devanagari',
    ),
    'gu': PdfLocalizedStrings(
      headline: 'લોન કરાર',
      generatedOn: 'બનાવેલી તારીખ',
      documentId: 'દસ્તાવેજ ID',
      lenderDetails: 'ધિરાણકર્તાની વિગતો',
      borrowerDetails: 'લેનારની વિગતો',
      name: 'નામ',
      mobile: 'મોબાઇલ',
      email: 'ઇમેઇલ',
      location: 'સ્થળ',
      loanId: 'લોન ID',
      principal: 'મૂળ રકમ',
      ratePerMonth: 'માસિક દર',
      tenureMonths: 'મુદત (મહિના)',
      loanType: 'વ્યાજ પ્રકાર',
      simpleType: 'સાદું',
      compoundType: 'ચક્રવૃદ્ધિ',
      startDate: 'શરૂઆતની તારીખ',
      monthlyEmi: 'માસિક EMI',
      totalInterest: 'કુલ વ્યાજ',
      totalPayable: 'કુલ ચુકવણી',
      status: 'સ્થિતિ',
      installmentSchedule: 'હપ્તાની સૂચિ',
      colNo: '#',
      colDueDate: 'નિયત તારીખ',
      colEmi: 'EMI',
      colPrincipal: 'મૂળ',
      colInterest: 'વ્યાજ',
      colBalance: 'બાકી',
      colStatus: 'સ્થિતિ',
      colPaidDate: 'ચુકવણી તારીખ',
      paid: 'ચુકવ્યું',
      pending: 'બાકી',
      overdue: 'મુદતવીતી',
      pageLabel: 'પાનું',
      ofLabel: '/',
      lenderSignature: 'ધિરાણકર્તાની સહી',
      borrowerSignature: 'લેનારની સહી',
      fontFamily: 'Noto Sans Gujarati',
    ),
    'kn': PdfLocalizedStrings(
      headline: 'ಸಾಲ ಒಪ್ಪಂದ',
      generatedOn: 'ರಚಿಸಿದ ದಿನಾಂಕ',
      documentId: 'ದಾಖಲೆ ID',
      lenderDetails: 'ಸಾಲಗಾರನ ವಿವರಗಳು',
      borrowerDetails: 'ಪಡೆಯುವವರ ವಿವರಗಳು',
      name: 'ಹೆಸರು',
      mobile: 'ಮೊಬೈಲ್',
      email: 'ಇಮೇಲ್',
      location: 'ಸ್ಥಳ',
      loanId: 'ಸಾಲ ID',
      principal: 'ಅಸಲು',
      ratePerMonth: 'ತಿಂಗಳ ಬಡ್ಡಿ ದರ',
      tenureMonths: 'ಅವಧಿ (ತಿಂಗಳು)',
      loanType: 'ಬಡ್ಡಿ ವಿಧ',
      simpleType: 'ಸರಳ',
      compoundType: 'ಚಕ್ರಬಡ್ಡಿ',
      startDate: 'ಪ್ರಾರಂಭ ದಿನಾಂಕ',
      monthlyEmi: 'ತಿಂಗಳ EMI',
      totalInterest: 'ಒಟ್ಟು ಬಡ್ಡಿ',
      totalPayable: 'ಒಟ್ಟು ಪಾವತಿ',
      status: 'ಸ್ಥಿತಿ',
      installmentSchedule: 'ಕಂತು ಪಟ್ಟಿ',
      colNo: '#',
      colDueDate: 'ಕೊನೆಯ ದಿನಾಂಕ',
      colEmi: 'EMI',
      colPrincipal: 'ಅಸಲು',
      colInterest: 'ಬಡ್ಡಿ',
      colBalance: 'ಬಾಕಿ',
      colStatus: 'ಸ್ಥಿತಿ',
      colPaidDate: 'ಪಾವತಿ ದಿನಾಂಕ',
      paid: 'ಪಾವತಿಸಲಾಗಿದೆ',
      pending: 'ಬಾಕಿ ಇದೆ',
      overdue: 'ಅವಧಿ ಮೀರಿದೆ',
      pageLabel: 'ಪುಟ',
      ofLabel: '/',
      lenderSignature: 'ಸಾಲಗಾರರ ಸಹಿ',
      borrowerSignature: 'ಪಡೆಯುವವರ ಸಹಿ',
      fontFamily: 'Noto Sans Kannada',
    ),
    'ml': PdfLocalizedStrings(
      headline: 'വായ്പാ കരാർ',
      generatedOn: 'തയ്യാറാക്കിയ തീയതി',
      documentId: 'രേഖാ ഐഡി',
      lenderDetails: 'വായ്പാ ദാതാവിന്റെ വിവരങ്ങൾ',
      borrowerDetails: 'വായ്പക്കാരന്റെ വിവരങ്ങൾ',
      name: 'പേര്',
      mobile: 'മൊബൈൽ',
      email: 'ഇമെയിൽ',
      location: 'സ്ഥലം',
      loanId: 'വായ്പാ ഐഡി',
      principal: 'മുതൽ',
      ratePerMonth: 'പ്രതിമാസ നിരക്ക്',
      tenureMonths: 'കാലാവധി (മാസം)',
      loanType: 'പലിശ തരം',
      simpleType: 'ലളിത പലിശ',
      compoundType: 'കൂട്ടുപലിശ',
      startDate: 'ആരംഭ തീയതി',
      monthlyEmi: 'പ്രതിമാസ ഇഎംഐ',
      totalInterest: 'ആകെ പലിശ',
      totalPayable: 'ആകെ തുക',
      status: 'സ്റ്റാറ്റസ്',
      installmentSchedule: 'തവണ ഷെഡ്യൂൾ',
      colNo: '#',
      colDueDate: 'അടയ്‌ക്കേണ്ട തീയതി',
      colEmi: 'ഇഎംഐ',
      colPrincipal: 'മുതൽ',
      colInterest: 'പലിശ',
      colBalance: 'ബാക്കി',
      colStatus: 'സ്റ്റാറ്റസ്',
      colPaidDate: 'അടച്ച തീയതി',
      paid: 'അടച്ചു',
      pending: 'തീർപ്പാകാത്തത്',
      overdue: 'കാലാവധി കഴിഞ്ഞു',
      pageLabel: 'പേജ്',
      ofLabel: '/',
      lenderSignature: 'ദാതാവിന്റെ ഒപ്പ്',
      borrowerSignature: 'വായ്പക്കാരന്റെ ഒപ്പ്',
      fontFamily: 'Noto Sans Malayalam',
    ),
    'pa': PdfLocalizedStrings(
      headline: 'ਕਰਜ਼ਾ ਸਮਝੌਤਾ',
      generatedOn: 'ਤਿਆਰ ਮਿਤੀ',
      documentId: 'ਦਸਤਾਵੇਜ਼ ID',
      lenderDetails: 'ਕਰਜ਼ਦਾਤਾ ਵੇਰਵੇ',
      borrowerDetails: 'ਕਰਜ਼ਦਾਰ ਵੇਰਵੇ',
      name: 'ਨਾਮ',
      mobile: 'ਮੋਬਾਈਲ',
      email: 'ਈਮੇਲ',
      location: 'ਟਿਕਾਣਾ',
      loanId: 'ਕਰਜ਼ਾ ID',
      principal: 'ਮੂਲ ਰਕਮ',
      ratePerMonth: 'ਮਾਸਿਕ ਦਰ',
      tenureMonths: 'ਮਿਆਦ (ਮਹੀਨੇ)',
      loanType: 'ਵਿਆਜ ਕਿਸਮ',
      simpleType: 'ਸਾਧਾਰਨ',
      compoundType: 'ਮਿਸ਼ਰਿਤ',
      startDate: 'ਸ਼ੁਰੂ ਮਿਤੀ',
      monthlyEmi: 'ਮਾਸਿਕ EMI',
      totalInterest: 'ਕੁੱਲ ਵਿਆਜ',
      totalPayable: 'ਕੁੱਲ ਭੁਗਤਾਨ',
      status: 'ਸਥਿਤੀ',
      installmentSchedule: 'ਕਿਸਤ ਸਾਰਣੀ',
      colNo: '#',
      colDueDate: 'ਮਿਤੀ',
      colEmi: 'EMI',
      colPrincipal: 'ਮੂਲ',
      colInterest: 'ਵਿਆਜ',
      colBalance: 'ਬਕਾਇਆ',
      colStatus: 'ਸਥਿਤੀ',
      colPaidDate: 'ਭੁਗਤਾਨ ਮਿਤੀ',
      paid: 'ਭੁਗਤਾਨ ਹੋਇਆ',
      pending: 'ਬਕਾਇਆ',
      overdue: 'ਮਿਆਦ ਪੁੱਗੀ',
      pageLabel: 'ਪੰਨਾ',
      ofLabel: '/',
      lenderSignature: 'ਕਰਜ਼ਦਾਤਾ ਦਸਤਖਤ',
      borrowerSignature: 'ਕਰਜ਼ਦਾਰ ਦਸਤਖਤ',
      fontFamily: 'Noto Sans Gurmukhi',
    ),
    'or': PdfLocalizedStrings(
      headline: 'ଋଣ ଚୁକ୍ତି',
      generatedOn: 'ପ୍ରସ୍ତୁତ ତାରିଖ',
      documentId: 'ଦଲିଲ ID',
      lenderDetails: 'ଋଣଦାତା ବିବରଣୀ',
      borrowerDetails: 'ଋଣଗ୍ରହୀତା ବିବରଣୀ',
      name: 'ନାମ',
      mobile: 'ମୋବାଇଲ୍',
      email: 'ଇମେଲ୍',
      location: 'ସ୍ଥାନ',
      loanId: 'ଋଣ ID',
      principal: 'ମୂଳଧନ',
      ratePerMonth: 'ମାସିକ ହାର',
      tenureMonths: 'ସମୟ (ମାସ)',
      loanType: 'ସୁଧ ପ୍ରକାର',
      simpleType: 'ସରଳ',
      compoundType: 'ଚକ୍ରବୃଦ୍ଧି',
      startDate: 'ଆରମ୍ଭ ତାରିଖ',
      monthlyEmi: 'ମାସିକ EMI',
      totalInterest: 'ମୋଟ ସୁଧ',
      totalPayable: 'ମୋଟ ଦେୟ',
      status: 'ସ୍ଥିତି',
      installmentSchedule: 'କିସ୍ତି ସୂଚୀ',
      colNo: '#',
      colDueDate: 'ଦେୟ ତାରିଖ',
      colEmi: 'EMI',
      colPrincipal: 'ମୂଳ',
      colInterest: 'ସୁଧ',
      colBalance: 'ବାକି',
      colStatus: 'ସ୍ଥିତି',
      colPaidDate: 'ପରିଶୋଧ ତାରିଖ',
      paid: 'ପରିଶୋଧିତ',
      pending: 'ବାକି',
      overdue: 'ଅତିବାହିତ',
      pageLabel: 'ପୃଷ୍ଠା',
      ofLabel: '/',
      lenderSignature: 'ଋଣଦାତା ସ୍ୱାକ୍ଷର',
      borrowerSignature: 'ଋଣଗ୍ରହୀତା ସ୍ୱାକ୍ଷର',
      fontFamily: 'Noto Sans Oriya',
    ),
    'ur': PdfLocalizedStrings(
      headline: 'قرض کا معاہدہ',
      generatedOn: 'تیاری کی تاریخ',
      documentId: 'دستاویز آئی ڈی',
      lenderDetails: 'قرض دہندہ کی تفصیلات',
      borrowerDetails: 'قرض دار کی تفصیلات',
      name: 'نام',
      mobile: 'موبائل',
      email: 'ای میل',
      location: 'مقام',
      loanId: 'قرض آئی ڈی',
      principal: 'اصل رقم',
      ratePerMonth: 'ماہانہ شرح',
      tenureMonths: 'مدت (ماہ)',
      loanType: 'سود کی قسم',
      simpleType: 'سادہ',
      compoundType: 'مرکب',
      startDate: 'شروع کی تاریخ',
      monthlyEmi: 'ماہانہ ای ایم آئی',
      totalInterest: 'کل سود',
      totalPayable: 'کل قابل ادائیگی',
      status: 'حالت',
      installmentSchedule: 'اقساط کا شیڈول',
      colNo: '#',
      colDueDate: 'مقررہ تاریخ',
      colEmi: 'ای ایم آئی',
      colPrincipal: 'اصل',
      colInterest: 'سود',
      colBalance: 'بقیہ',
      colStatus: 'حالت',
      colPaidDate: 'ادائیگی کی تاریخ',
      paid: 'ادا شدہ',
      pending: 'زیر التوا',
      overdue: 'تاخیر شدہ',
      pageLabel: 'صفحہ',
      ofLabel: 'از',
      lenderSignature: 'قرض دہندہ کے دستخط',
      borrowerSignature: 'قرض دار کے دستخط',
      fontFamily: 'Noto Naskh Arabic',
    ),
    'as': PdfLocalizedStrings(
      headline: 'ঋণ চুক্তি',
      generatedOn: 'তৈয়াৰ কৰা তাৰিখ',
      documentId: 'নথিপত্ৰ ID',
      lenderDetails: 'ঋণদাতাৰ বিৱৰণ',
      borrowerDetails: 'ঋণগ্ৰহীতাৰ বিৱৰণ',
      name: 'নাম',
      mobile: 'ম’বাইল',
      email: 'ইমেইল',
      location: 'স্থান',
      loanId: 'ঋণ ID',
      principal: 'মূলধন',
      ratePerMonth: 'মাহিলী হাৰ',
      tenureMonths: 'সময় (মাহ)',
      loanType: 'সূতৰ প্ৰকাৰ',
      simpleType: 'সৰল',
      compoundType: 'চক্ৰবৃদ্ধি',
      startDate: 'আৰম্ভণি তাৰিখ',
      monthlyEmi: 'মাহিলী EMI',
      totalInterest: 'মুঠ সূত',
      totalPayable: 'মুঠ দেয়',
      status: 'স্থিতি',
      installmentSchedule: 'কিস্তি সূচী',
      colNo: '#',
      colDueDate: 'দেয় তাৰিখ',
      colEmi: 'EMI',
      colPrincipal: 'মূল',
      colInterest: 'সূত',
      colBalance: 'বাকী',
      colStatus: 'স্থিতি',
      colPaidDate: 'পৰিশোধ তাৰিখ',
      paid: 'পৰিশোধিত',
      pending: 'বাকী',
      overdue: 'সময় উকলিছে',
      pageLabel: 'পৃষ্ঠা',
      ofLabel: '/',
      lenderSignature: 'ঋণদাতাৰ স্বাক্ষৰ',
      borrowerSignature: 'ঋণগ্ৰহীতাৰ স্বাক্ষৰ',
      fontFamily: 'Noto Sans Bengali',
    ),
  };
}
