import 'dart:convert';
import 'dart:math' as math;

import 'package:loan_management_app/data/db/app_database.dart';
import 'package:loan_management_app/domain/models/loan_models.dart';
import 'package:loan_management_app/services/loan_agreement_pdf_service.dart';
import 'package:sqflite/sqflite.dart';

class LoanWiseDbSnapshot {
  const LoanWiseDbSnapshot({
    required this.profile,
    required this.customers,
    required this.loans,
    required this.emisByLoan,
    required this.ledger,
    required this.documents,
    required this.maxNumericId,
  });

  final LenderProfile? profile;
  final List<Customer> customers;
  final List<Loan> loans;
  final Map<String, List<EmiScheduleItem>> emisByLoan;
  final List<LedgerEntry> ledger;
  final List<LoanDocument> documents;
  final int maxNumericId;
}

class LoanWiseDao {
  const LoanWiseDao(this._appDatabase);

  final AppDatabase _appDatabase;

  Database get _db => _appDatabase.database;

  static int? tryParseNumericId(String id) {
    final direct = int.tryParse(id.trim());
    if (direct != null && direct > 0) return direct;
    final dashIdx = id.lastIndexOf('-');
    if (dashIdx != -1 && dashIdx + 1 < id.length) {
      final parsed = int.tryParse(id.substring(dashIdx + 1).trim());
      if (parsed != null && parsed > 0) return parsed;
    }
    return null;
  }

  static int requireNumericId(String id) {
    final parsed = tryParseNumericId(id);
    if (parsed != null) return parsed;
    throw ArgumentError('Expected numeric-suffixed ID, got "$id"');
  }

  Future<LoanWiseDbSnapshot> loadAll() async {
    final userRows = await _db.query('users', orderBy: 'id ASC', limit: 1);
    LenderProfile? profile;
    if (userRows.isNotEmpty) {
      final row = userRows.first;
      profile = LenderProfile(
        id: row['id'] as int?,
        name: row['name'] as String,
        mobile: row['mobile'] as String,
        email: row['email'] as String,
        photoPath: row['photo_path'] as String?,
        createdAt: DateTime.tryParse(row['created_at'] as String),
        updatedAt: DateTime.tryParse(row['updated_at'] as String),
      );
    }

    int maxId = 1000;

    final customerRows = await _db.query('customers', orderBy: 'id ASC');
    final customers = customerRows.map((row) {
      final idNum = row['id'] as int;
      maxId = math.max(maxId, idNum);
      return Customer(
        id: 'CUS-$idNum',
        name: row['name'] as String,
        email: row['email'] as String,
        mobile: row['mobile'] as String,
        location: row['location'] as String,
        createdAt: DateTime.parse(row['created_at'] as String),
        updatedAt: DateTime.parse(row['updated_at'] as String),
        deletedAt: row['deleted_at'] != null
            ? DateTime.parse(row['deleted_at'] as String)
            : null,
      );
    }).toList();

    final loanRows = await _db.query('loans', orderBy: 'id ASC');
    final loans = loanRows.map((row) {
      final idNum = row['id'] as int;
      final custNum = row['customer_id'] as int;
      maxId = math.max(maxId, idNum);
      return Loan(
        id: 'LN-$idNum',
        customerId: 'CUS-$custNum',
        principalPaise: row['principal_paise'] as int,
        monthlyRatePercent: (row['monthly_rate_percent'] as num).toDouble(),
        tenureMonths: row['tenure_months'] as int,
        type: LoanType.values.byName(row['type'] as String),
        startDate: DateTime.parse(row['start_date'] as String),
        status: LoanStatus.values.byName(row['status'] as String),
        totalPayablePaise: row['total_payable_paise'] as int,
        totalInterestPaise: row['total_interest_paise'] as int,
        monthlyEmiPaise: row['monthly_emi_paise'] as int,
        createdAt: DateTime.parse(row['created_at'] as String),
      );
    }).toList();

    final emiRows = await _db.query(
      'emis',
      orderBy: 'loan_id ASC, installment_no ASC',
    );
    final emisByLoan = <String, List<EmiScheduleItem>>{};
    for (final row in emiRows) {
      final idNum = row['id'] as int;
      final loanNum = row['loan_id'] as int;
      maxId = math.max(maxId, idNum);
      final loanId = 'LN-$loanNum';
      emisByLoan.putIfAbsent(loanId, () => []).add(
            EmiScheduleItem(
              id: 'EMI-$idNum',
              loanId: loanId,
              installmentNo: row['installment_no'] as int,
              dueDate: DateTime.parse(row['due_date'] as String),
              emiPaise: row['emi_paise'] as int,
              principalPartPaise: row['principal_part_paise'] as int,
              interestPartPaise: row['interest_part_paise'] as int,
              remainingBalancePaise: row['remaining_balance_paise'] as int,
              status: EmiStatus.values.byName(row['status'] as String),
              paidDate: row['paid_date'] != null
                  ? DateTime.parse(row['paid_date'] as String)
                  : null,
            ),
          );
    }

    final ledgerRows = await _db.query('ledger', orderBy: 'id ASC');
    final ledger = ledgerRows.map((row) {
      final idNum = row['id'] as int;
      maxId = math.max(maxId, idNum);
      return LedgerEntry(
        id: 'LDG-$idNum',
        customerId: 'CUS-${row['customer_id'] as int}',
        loanId: 'LN-${row['loan_id'] as int}',
        kind: LedgerKind.values.byName(row['kind'] as String),
        debitPaise: row['debit_paise'] as int,
        creditPaise: row['credit_paise'] as int,
        balanceAfterPaise: row['balance_after_paise'] as int,
        createdAt: DateTime.parse(row['created_at'] as String),
      );
    }).toList();

    final docRows = await _db.query('documents', orderBy: 'updated_at DESC');
    final documents = docRows.map((row) {
      final idNum = row['id'] as int;
      maxId = math.max(maxId, idNum);
      final docId = 'DOC-$idNum';
      final snapshotMap =
          jsonDecode(row['snapshot_json'] as String) as Map<String, dynamic>;
      final snapshot = LoanDocumentSnapshot.fromJson(snapshotMap);
      final languageCode = row['language_code'] as String;
      final updatedAt = DateTime.parse(row['updated_at'] as String);
      final emiInstallmentNo = row['emi_installment_no'] as int?;
      final storedHtml = (row['html_content'] as String?) ?? '';
      final html = storedHtml.isNotEmpty
          ? storedHtml
          : LoanAgreementPdfService.buildDocumentHtml(
              documentId: docId,
              snapshot: snapshot,
              languageCode: languageCode,
              generatedAt: updatedAt,
              emiInstallmentNo: emiInstallmentNo,
            );
      final filePath = (row['file_path'] as String?) ?? '';
      final storedRenderPath = (row['render_path'] as String?) ?? '';
      return LoanDocument(
        id: docId,
        loanId: 'LN-${row['loan_id'] as int}',
        customerMobile: row['customer_mobile'] as String,
        languageCode: languageCode,
        title: row['title'] as String,
        snapshot: snapshot,
        htmlContent: html,
        pageCount: row['page_count'] as int,
        renderPath: storedRenderPath.isNotEmpty
            ? storedRenderPath
            : (filePath.isNotEmpty ? filePath : 'html_a4'),
        createdAt: DateTime.parse(row['created_at'] as String),
        updatedAt: updatedAt,
        emiInstallmentNo: emiInstallmentNo,
        filePath: filePath,
      );
    }).toList();

    return LoanWiseDbSnapshot(
      profile: profile,
      customers: customers,
      loans: loans,
      emisByLoan: emisByLoan,
      ledger: ledger,
      documents: documents,
      maxNumericId: maxId,
    );
  }

  Future<void> upsertCustomer(Customer customer) async {
    final numericId = requireNumericId(customer.id);
    await _db.transaction((txn) async {
      final values = <String, Object?>{
        'name': customer.name,
        'email': customer.email,
        'mobile': customer.mobile,
        'location': customer.location,
        'created_at': customer.createdAt.toIso8601String(),
        'updated_at': customer.updatedAt.toIso8601String(),
        'deleted_at': customer.deletedAt?.toIso8601String(),
      };
      final updated = await txn.update(
        'customers',
        values,
        where: 'id = ?',
        whereArgs: [numericId],
      );
      if (updated == 0) {
        await txn.insert('customers', <String, Object?>{
          'id': numericId,
          ...values,
        });
      }
    });
  }

  Future<void> softDeleteCustomer(Customer customer) async {
    final numericId = requireNumericId(customer.id);
    await _db.update(
      'customers',
      <String, Object?>{
        'deleted_at': customer.deletedAt?.toIso8601String(),
        'updated_at': customer.updatedAt.toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [numericId],
    );
  }

  Future<void> createLoanAtomic({
    required Loan loan,
    required List<EmiScheduleItem> emis,
    required LedgerEntry disbursement,
    void Function()? beforeCommitHook,
  }) async {
    final loanId = requireNumericId(loan.id);
    final customerId = requireNumericId(loan.customerId);
    await _db.transaction((txn) async {
      final customerRows = await txn.query(
        'customers',
        columns: ['id'],
        where: 'id = ? AND deleted_at IS NULL',
        whereArgs: [customerId],
        limit: 1,
      );
      if (customerRows.isEmpty) {
        throw StateError('Customer $customerId does not exist or is deleted');
      }

      await txn.insert('loans', <String, Object?>{
        'id': loanId,
        'customer_id': customerId,
        'principal_paise': loan.principalPaise,
        'monthly_rate_percent': loan.monthlyRatePercent,
        'tenure_months': loan.tenureMonths,
        'type': loan.type.name,
        'start_date': loan.startDate.toIso8601String(),
        'status': loan.status.name,
        'total_payable_paise': loan.totalPayablePaise,
        'total_interest_paise': loan.totalInterestPaise,
        'monthly_emi_paise': loan.monthlyEmiPaise,
        'created_at': loan.createdAt.toIso8601String(),
      });

      for (final emi in emis) {
        await txn.insert('emis', <String, Object?>{
          'id': requireNumericId(emi.id),
          'loan_id': loanId,
          'installment_no': emi.installmentNo,
          'due_date': emi.dueDate.toIso8601String(),
          'emi_paise': emi.emiPaise,
          'principal_part_paise': emi.principalPartPaise,
          'interest_part_paise': emi.interestPartPaise,
          'remaining_balance_paise': emi.remainingBalancePaise,
          'status': emi.status.name,
          'paid_date': emi.paidDate?.toIso8601String(),
        });
      }

      await txn.insert('ledger', <String, Object?>{
        'id': requireNumericId(disbursement.id),
        'customer_id': customerId,
        'loan_id': loanId,
        'kind': disbursement.kind.name,
        'debit_paise': disbursement.debitPaise,
        'credit_paise': disbursement.creditPaise,
        'balance_after_paise': disbursement.balanceAfterPaise,
        'created_at': disbursement.createdAt.toIso8601String(),
      });

      beforeCommitHook?.call();
    });
  }

  Future<void> recordEmiPaymentAtomic({
    required Loan updatedLoan,
    required List<EmiScheduleItem> paidEmis,
    required List<LedgerEntry> ledgerEntries,
    void Function()? beforeCommitHook,
  }) async {
    final loanId = requireNumericId(updatedLoan.id);
    await _db.transaction((txn) async {
      for (final emi in paidEmis) {
        await txn.update(
          'emis',
          <String, Object?>{
            'status': emi.status.name,
            'paid_date': emi.paidDate?.toIso8601String(),
          },
          where: 'id = ?',
          whereArgs: [requireNumericId(emi.id)],
        );
      }

      for (final entry in ledgerEntries) {
        await txn.insert('ledger', <String, Object?>{
          'id': requireNumericId(entry.id),
          'customer_id': requireNumericId(entry.customerId),
          'loan_id': loanId,
          'kind': entry.kind.name,
          'debit_paise': entry.debitPaise,
          'credit_paise': entry.creditPaise,
          'balance_after_paise': entry.balanceAfterPaise,
          'created_at': entry.createdAt.toIso8601String(),
        });
      }

      await txn.update(
        'loans',
        <String, Object?>{'status': updatedLoan.status.name},
        where: 'id = ?',
        whereArgs: [loanId],
      );

      beforeCommitHook?.call();
    });
  }

  Future<void> upsertDocument(LoanDocument document) async {
    final docId = requireNumericId(document.id);
    final loanId = requireNumericId(document.loanId);
    final values = <String, Object?>{
      'loan_id': loanId,
      'customer_mobile': document.customerMobile,
      'file_path': document.filePath,
      'language_code': document.languageCode,
      'title': document.title,
      'snapshot_json': jsonEncode(document.snapshot.toJson()),
      'page_count': document.pageCount,
      'created_at': document.createdAt.toIso8601String(),
      'updated_at': document.updatedAt.toIso8601String(),
      'emi_installment_no': document.emiInstallmentNo,
      'render_path': document.renderPath,
      'html_content': document.htmlContent,
    };

    await _db.transaction((txn) async {
      final updated = await txn.update(
        'documents',
        values,
        where: 'id = ?',
        whereArgs: [docId],
      );
      if (updated == 0) {
        await txn.insert('documents', <String, Object?>{
          'id': docId,
          ...values,
        });
      }
    });
  }

  Future<void> deleteDocument(String documentId) async {
    final docId = requireNumericId(documentId);
    await _db.delete(
      'documents',
      where: 'id = ?',
      whereArgs: [docId],
    );
  }

  Future<void> replaceAllForRestore({
    required LenderProfile profile,
    required List<Customer> customers,
    required List<Loan> loans,
    required Map<String, List<EmiScheduleItem>> emisByLoan,
    required List<LedgerEntry> ledger,
    required List<LoanDocument> documents,
  }) async {
    await _db.transaction((txn) async {
      await txn.delete('documents');
      await txn.delete('ledger');
      await txn.delete('emis');
      await txn.delete('loans');
      await txn.delete('customers');
      await txn.delete('users');

      final nowIso = DateTime.now().toUtc().toIso8601String();
      if (profile.name.trim().isNotEmpty ||
          profile.mobile.trim().isNotEmpty ||
          profile.email.trim().isNotEmpty) {
        await txn.insert('users', <String, Object?>{
          'id': profile.id ?? 1,
          'name': profile.name,
          'mobile': profile.mobile,
          'email': profile.email,
          'photo_path': profile.photoPath,
          'created_at': (profile.createdAt ?? DateTime.now().toUtc())
              .toIso8601String(),
          'updated_at': nowIso,
        });
      }

      int nextFallbackId = 1;
      final usedCustomerIds = <int>{};
      final customerIdMap = <String, int>{};
      int allocId(String raw, Set<int> used) {
        final parsed = tryParseNumericId(raw);
        if (parsed != null && !used.contains(parsed)) {
          used.add(parsed);
          if (parsed >= nextFallbackId) nextFallbackId = parsed + 1;
          return parsed;
        }
        while (used.contains(nextFallbackId)) {
          nextFallbackId++;
        }
        final allocated = nextFallbackId++;
        used.add(allocated);
        return allocated;
      }

      for (final c in customers) {
        final idNum = allocId(c.id, usedCustomerIds);
        customerIdMap[c.id] = idNum;
        await txn.insert('customers', <String, Object?>{
          'id': idNum,
          'name': c.name,
          'email': c.email,
          'mobile': c.mobile,
          'location': c.location,
          'created_at': c.createdAt.toIso8601String(),
          'updated_at': c.updatedAt.toIso8601String(),
          'deleted_at': c.deletedAt?.toIso8601String(),
        });
      }

      final usedLoanIds = <int>{};
      final loanIdMap = <String, int>{};
      for (final l in loans) {
        final idNum = allocId(l.id, usedLoanIds);
        loanIdMap[l.id] = idNum;
        final custNum = customerIdMap[l.customerId] ??
            requireNumericId(l.customerId);
        await txn.insert('loans', <String, Object?>{
          'id': idNum,
          'customer_id': custNum,
          'principal_paise': l.principalPaise,
          'monthly_rate_percent': l.monthlyRatePercent,
          'tenure_months': l.tenureMonths,
          'type': l.type.name,
          'start_date': l.startDate.toIso8601String(),
          'status': l.status.name,
          'total_payable_paise': l.totalPayablePaise,
          'total_interest_paise': l.totalInterestPaise,
          'monthly_emi_paise': l.monthlyEmiPaise,
          'created_at': l.createdAt.toIso8601String(),
        });
      }

      final usedEmiIds = <int>{};
      for (final entry in emisByLoan.entries) {
        final mappedLoanId = loanIdMap[entry.key] ?? requireNumericId(entry.key);
        for (final emi in entry.value) {
          final idNum = allocId(emi.id, usedEmiIds);
          await txn.insert('emis', <String, Object?>{
            'id': idNum,
            'loan_id': mappedLoanId,
            'installment_no': emi.installmentNo,
            'due_date': emi.dueDate.toIso8601String(),
            'emi_paise': emi.emiPaise,
            'principal_part_paise': emi.principalPartPaise,
            'interest_part_paise': emi.interestPartPaise,
            'remaining_balance_paise': emi.remainingBalancePaise,
            'status': emi.status.name,
            'paid_date': emi.paidDate?.toIso8601String(),
          });
        }
      }

      final usedLedgerIds = <int>{};
      for (final item in ledger) {
        final idNum = allocId(item.id, usedLedgerIds);
        await txn.insert('ledger', <String, Object?>{
          'id': idNum,
          'customer_id': customerIdMap[item.customerId] ??
              requireNumericId(item.customerId),
          'loan_id': loanIdMap[item.loanId] ?? requireNumericId(item.loanId),
          'kind': item.kind.name,
          'debit_paise': item.debitPaise,
          'credit_paise': item.creditPaise,
          'balance_after_paise': item.balanceAfterPaise,
          'created_at': item.createdAt.toIso8601String(),
        });
      }

      final usedDocIds = <int>{};
      for (final doc in documents) {
        final idNum = allocId(doc.id, usedDocIds);
        await txn.insert('documents', <String, Object?>{
          'id': idNum,
          'loan_id': loanIdMap[doc.loanId] ?? requireNumericId(doc.loanId),
          'customer_mobile': doc.customerMobile,
          'file_path': doc.filePath,
          'language_code': doc.languageCode,
          'title': doc.title,
          'snapshot_json': jsonEncode(doc.snapshot.toJson()),
          'page_count': doc.pageCount,
          'created_at': doc.createdAt.toIso8601String(),
          'updated_at': doc.updatedAt.toIso8601String(),
          'emi_installment_no': doc.emiInstallmentNo,
          'render_path': doc.renderPath,
          'html_content': doc.htmlContent,
        });
      }
    });
  }
}
