import 'package:loan_management_app/core/utils/date_utils.dart';
import 'package:loan_management_app/domain/enums/loan_enums.dart';

export 'package:loan_management_app/domain/entities/lender_profile.dart';
export 'package:loan_management_app/domain/enums/loan_enums.dart';

class Customer {
  const Customer({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.location,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  final String id;
  final String name;
  final String email;
  final String mobile;
  final String location;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  bool get isDeleted => deletedAt != null;

  String get initials {
    final parts = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((p) => p.isNotEmpty)
        .toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return (parts.first[0] + parts.last[0]).toUpperCase();
  }

  Customer copyWith({
    String? id,
    String? name,
    String? email,
    String? mobile,
    String? location,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) {
    return Customer(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      location: location ?? this.location,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'mobile': mobile,
        'location': location,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'deletedAt': deletedAt?.toIso8601String(),
      };

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      mobile: json['mobile'] as String,
      location: json['location'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null
          ? DateTime.parse(json['deletedAt'] as String)
          : null,
    );
  }
}


class Loan {
  const Loan({
    required this.id,
    required this.customerId,
    required this.principalPaise,
    required this.monthlyRatePercent,
    required this.tenureMonths,
    required this.type,
    required this.startDate,
    required this.status,
    required this.totalPayablePaise,
    required this.totalInterestPaise,
    required this.monthlyEmiPaise,
    required this.createdAt,
  });

  final String id;
  final String customerId;
  final int principalPaise;
  final double monthlyRatePercent;
  final int tenureMonths;
  final LoanType type;
  final DateTime startDate;
  final LoanStatus status;
  final int totalPayablePaise;
  final int totalInterestPaise;
  final int monthlyEmiPaise;
  final DateTime createdAt;

  Loan copyWith({
    String? id,
    String? customerId,
    int? principalPaise,
    double? monthlyRatePercent,
    int? tenureMonths,
    LoanType? type,
    DateTime? startDate,
    LoanStatus? status,
    int? totalPayablePaise,
    int? totalInterestPaise,
    int? monthlyEmiPaise,
    DateTime? createdAt,
  }) {
    return Loan(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      principalPaise: principalPaise ?? this.principalPaise,
      monthlyRatePercent: monthlyRatePercent ?? this.monthlyRatePercent,
      tenureMonths: tenureMonths ?? this.tenureMonths,
      type: type ?? this.type,
      startDate: startDate ?? this.startDate,
      status: status ?? this.status,
      totalPayablePaise: totalPayablePaise ?? this.totalPayablePaise,
      totalInterestPaise: totalInterestPaise ?? this.totalInterestPaise,
      monthlyEmiPaise: monthlyEmiPaise ?? this.monthlyEmiPaise,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'customerId': customerId,
        'principalPaise': principalPaise,
        'monthlyRatePercent': monthlyRatePercent,
        'tenureMonths': tenureMonths,
        'type': type.name,
        'startDate': startDate.toIso8601String(),
        'status': status.name,
        'totalPayablePaise': totalPayablePaise,
        'totalInterestPaise': totalInterestPaise,
        'monthlyEmiPaise': monthlyEmiPaise,
        'createdAt': createdAt.toIso8601String(),
      };

  factory Loan.fromJson(Map<String, dynamic> json) {
    return Loan(
      id: json['id'] as String,
      customerId: json['customerId'] as String,
      principalPaise: json['principalPaise'] as int,
      monthlyRatePercent: (json['monthlyRatePercent'] as num).toDouble(),
      tenureMonths: json['tenureMonths'] as int,
      type: LoanType.values.byName(json['type'] as String),
      startDate: DateTime.parse(json['startDate'] as String),
      status: LoanStatus.values.byName(json['status'] as String),
      totalPayablePaise: json['totalPayablePaise'] as int,
      totalInterestPaise: json['totalInterestPaise'] as int,
      monthlyEmiPaise: json['monthlyEmiPaise'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}


class EmiScheduleItem {
  const EmiScheduleItem({
    required this.id,
    required this.loanId,
    required this.installmentNo,
    required this.dueDate,
    required this.emiPaise,
    required this.principalPartPaise,
    required this.interestPartPaise,
    required this.remainingBalancePaise,
    required this.status,
    this.paidDate,
  });

  final String id;
  final String loanId;
  final int installmentNo;
  final DateTime dueDate;
  final int emiPaise;
  final int principalPartPaise;
  final int interestPartPaise;
  final int remainingBalancePaise;
  final EmiStatus status;
  final DateTime? paidDate;

  bool get isPaid => status == EmiStatus.paid;

  bool isOverdueAt([DateTime? now]) {
    return LoanDateUtils.isOverdueEmi(
      dueDate: dueDate,
      isPaid: isPaid,
      now: now,
    );
  }

  EmiScheduleItem copyWith({
    String? id,
    String? loanId,
    int? installmentNo,
    DateTime? dueDate,
    int? emiPaise,
    int? principalPartPaise,
    int? interestPartPaise,
    int? remainingBalancePaise,
    EmiStatus? status,
    DateTime? paidDate,
  }) {
    return EmiScheduleItem(
      id: id ?? this.id,
      loanId: loanId ?? this.loanId,
      installmentNo: installmentNo ?? this.installmentNo,
      dueDate: dueDate ?? this.dueDate,
      emiPaise: emiPaise ?? this.emiPaise,
      principalPartPaise: principalPartPaise ?? this.principalPartPaise,
      interestPartPaise: interestPartPaise ?? this.interestPartPaise,
      remainingBalancePaise:
          remainingBalancePaise ?? this.remainingBalancePaise,
      status: status ?? this.status,
      paidDate: paidDate ?? this.paidDate,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'loanId': loanId,
        'installmentNo': installmentNo,
        'dueDate': dueDate.toIso8601String(),
        'emiPaise': emiPaise,
        'principalPartPaise': principalPartPaise,
        'interestPartPaise': interestPartPaise,
        'remainingBalancePaise': remainingBalancePaise,
        'status': status.name,
        'paidDate': paidDate?.toIso8601String(),
      };

  factory EmiScheduleItem.fromJson(Map<String, dynamic> json) {
    return EmiScheduleItem(
      id: json['id'] as String,
      loanId: json['loanId'] as String,
      installmentNo: json['installmentNo'] as int,
      dueDate: DateTime.parse(json['dueDate'] as String),
      emiPaise: json['emiPaise'] as int,
      principalPartPaise: json['principalPartPaise'] as int,
      interestPartPaise: json['interestPartPaise'] as int,
      remainingBalancePaise: json['remainingBalancePaise'] as int,
      status: EmiStatus.values.byName(json['status'] as String),
      paidDate: json['paidDate'] != null
          ? DateTime.parse(json['paidDate'] as String)
          : null,
    );
  }
}


class LedgerEntry {
  const LedgerEntry({
    required this.id,
    required this.customerId,
    required this.loanId,
    required this.kind,
    required this.debitPaise,
    required this.creditPaise,
    required this.balanceAfterPaise,
    required this.createdAt,
  });

  final String id;
  final String customerId;
  final String loanId;
  final LedgerKind kind;
  final int debitPaise;
  final int creditPaise;
  final int balanceAfterPaise;
  final DateTime createdAt;

  Map<String, dynamic> toJson() => {
        'id': id,
        'customerId': customerId,
        'loanId': loanId,
        'kind': kind.name,
        'debitPaise': debitPaise,
        'creditPaise': creditPaise,
        'balanceAfterPaise': balanceAfterPaise,
        'createdAt': createdAt.toIso8601String(),
      };

  factory LedgerEntry.fromJson(Map<String, dynamic> json) {
    return LedgerEntry(
      id: json['id'] as String,
      customerId: json['customerId'] as String,
      loanId: json['loanId'] as String,
      kind: LedgerKind.values.byName(json['kind'] as String),
      debitPaise: json['debitPaise'] as int,
      creditPaise: json['creditPaise'] as int,
      balanceAfterPaise: json['balanceAfterPaise'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}

class LoanDocumentSnapshot {
  const LoanDocumentSnapshot({
    required this.lenderName,
    required this.lenderMobile,
    required this.lenderEmail,
    required this.borrowerName,
    required this.borrowerMobile,
    required this.borrowerEmail,
    required this.borrowerLocation,
    required this.loanId,
    required this.principalPaise,
    required this.monthlyRatePercent,
    required this.tenureMonths,
    required this.loanType,
    required this.startDate,
    required this.monthlyEmiPaise,
    required this.totalInterestPaise,
    required this.totalPayablePaise,
    required this.statusText,
    required this.schedule,
  });

  final String lenderName;
  final String lenderMobile;
  final String lenderEmail;
  final String borrowerName;
  final String borrowerMobile;
  final String borrowerEmail;
  final String borrowerLocation;
  final String loanId;
  final int principalPaise;
  final double monthlyRatePercent;
  final int tenureMonths;
  final LoanType loanType;
  final DateTime startDate;
  final int monthlyEmiPaise;
  final int totalInterestPaise;
  final int totalPayablePaise;
  final String statusText;
  final List<EmiScheduleItem> schedule;

  LoanDocumentSnapshot copyWith({
    String? lenderName,
    String? lenderMobile,
    String? lenderEmail,
    String? borrowerName,
    String? borrowerMobile,
    String? borrowerEmail,
    String? borrowerLocation,
    String? loanId,
    int? principalPaise,
    double? monthlyRatePercent,
    int? tenureMonths,
    LoanType? loanType,
    DateTime? startDate,
    int? monthlyEmiPaise,
    int? totalInterestPaise,
    int? totalPayablePaise,
    String? statusText,
    List<EmiScheduleItem>? schedule,
  }) {
    return LoanDocumentSnapshot(
      lenderName: lenderName ?? this.lenderName,
      lenderMobile: lenderMobile ?? this.lenderMobile,
      lenderEmail: lenderEmail ?? this.lenderEmail,
      borrowerName: borrowerName ?? this.borrowerName,
      borrowerMobile: borrowerMobile ?? this.borrowerMobile,
      borrowerEmail: borrowerEmail ?? this.borrowerEmail,
      borrowerLocation: borrowerLocation ?? this.borrowerLocation,
      loanId: loanId ?? this.loanId,
      principalPaise: principalPaise ?? this.principalPaise,
      monthlyRatePercent: monthlyRatePercent ?? this.monthlyRatePercent,
      tenureMonths: tenureMonths ?? this.tenureMonths,
      loanType: loanType ?? this.loanType,
      startDate: startDate ?? this.startDate,
      monthlyEmiPaise: monthlyEmiPaise ?? this.monthlyEmiPaise,
      totalInterestPaise: totalInterestPaise ?? this.totalInterestPaise,
      totalPayablePaise: totalPayablePaise ?? this.totalPayablePaise,
      statusText: statusText ?? this.statusText,
      schedule: schedule ?? this.schedule,
    );
  }

  Map<String, dynamic> toJson() => {
        'lenderName': lenderName,
        'lenderMobile': lenderMobile,
        'lenderEmail': lenderEmail,
        'borrowerName': borrowerName,
        'borrowerMobile': borrowerMobile,
        'borrowerEmail': borrowerEmail,
        'borrowerLocation': borrowerLocation,
        'loanId': loanId,
        'principalPaise': principalPaise,
        'monthlyRatePercent': monthlyRatePercent,
        'tenureMonths': tenureMonths,
        'loanType': loanType.name,
        'startDate': startDate.toIso8601String(),
        'monthlyEmiPaise': monthlyEmiPaise,
        'totalInterestPaise': totalInterestPaise,
        'totalPayablePaise': totalPayablePaise,
        'statusText': statusText,
        'schedule': schedule.map((e) => e.toJson()).toList(),
      };

  factory LoanDocumentSnapshot.fromJson(Map<String, dynamic> json) {
    return LoanDocumentSnapshot(
      lenderName: json['lenderName'] as String,
      lenderMobile: json['lenderMobile'] as String,
      lenderEmail: json['lenderEmail'] as String,
      borrowerName: json['borrowerName'] as String,
      borrowerMobile: json['borrowerMobile'] as String,
      borrowerEmail: json['borrowerEmail'] as String,
      borrowerLocation: json['borrowerLocation'] as String,
      loanId: json['loanId'] as String,
      principalPaise: json['principalPaise'] as int,
      monthlyRatePercent: (json['monthlyRatePercent'] as num).toDouble(),
      tenureMonths: json['tenureMonths'] as int,
      loanType: LoanType.values.byName(json['loanType'] as String),
      startDate: DateTime.parse(json['startDate'] as String),
      monthlyEmiPaise: json['monthlyEmiPaise'] as int,
      totalInterestPaise: json['totalInterestPaise'] as int,
      totalPayablePaise: json['totalPayablePaise'] as int,
      statusText: json['statusText'] as String,
      schedule: (json['schedule'] as List<dynamic>)
          .map((e) => EmiScheduleItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class LoanDocument {
  const LoanDocument({
    required this.id,
    required this.loanId,
    required this.customerMobile,
    required this.languageCode,
    required this.title,
    required this.snapshot,
    required this.htmlContent,
    required this.pageCount,
    required this.renderPath,
    required this.createdAt,
    required this.updatedAt,
    this.emiInstallmentNo,
    this.filePath = '',
  });

  final String id;
  final String loanId;
  final String customerMobile;
  final String languageCode;
  final String title;
  final LoanDocumentSnapshot snapshot;
  final String htmlContent;
  final int pageCount;
  final String renderPath;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? emiInstallmentNo;
  final String filePath;

  bool get isEmiReceipt => emiInstallmentNo != null;

  LoanDocument copyWith({
    String? id,
    String? loanId,
    String? customerMobile,
    String? languageCode,
    String? title,
    LoanDocumentSnapshot? snapshot,
    String? htmlContent,
    int? pageCount,
    String? renderPath,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? emiInstallmentNo,
    String? filePath,
  }) {
    return LoanDocument(
      id: id ?? this.id,
      loanId: loanId ?? this.loanId,
      customerMobile: customerMobile ?? this.customerMobile,
      languageCode: languageCode ?? this.languageCode,
      title: title ?? this.title,
      snapshot: snapshot ?? this.snapshot,
      htmlContent: htmlContent ?? this.htmlContent,
      pageCount: pageCount ?? this.pageCount,
      renderPath: renderPath ?? this.renderPath,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      emiInstallmentNo: emiInstallmentNo ?? this.emiInstallmentNo,
      filePath: filePath ?? this.filePath,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'loanId': loanId,
        'customerMobile': customerMobile,
        'languageCode': languageCode,
        'title': title,
        'snapshot': snapshot.toJson(),
        'htmlContent': htmlContent,
        'pageCount': pageCount,
        'renderPath': renderPath,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'emiInstallmentNo': emiInstallmentNo,
        'filePath': filePath,
      };

  factory LoanDocument.fromJson(Map<String, dynamic> json) {
    return LoanDocument(
      id: json['id'] as String,
      loanId: json['loanId'] as String,
      customerMobile: json['customerMobile'] as String,
      languageCode: json['languageCode'] as String,
      title: json['title'] as String,
      snapshot: LoanDocumentSnapshot.fromJson(
        json['snapshot'] as Map<String, dynamic>,
      ),
      htmlContent: json['htmlContent'] as String,
      pageCount: json['pageCount'] as int,
      renderPath: json['renderPath'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      emiInstallmentNo: json['emiInstallmentNo'] as int?,
      filePath: (json['filePath'] as String?) ?? '',
    );
  }
}

class LoanItem {
  const LoanItem({
    required this.id,
    required this.customerName,
    required this.mobile,
    required this.principal,
    required this.status,
    required this.nextEmiDate,
    this.customerId = '',
  });

  final String id;
  final String customerId;
  final String customerName;
  final String mobile;
  final double principal;
  final LoanStatus status;
  final String nextEmiDate;

  String get initials {
    final parts = customerName
        .trim()
        .split(RegExp(r'\s+'))
        .where((p) => p.isNotEmpty)
        .toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return (parts.first[0] + parts.last[0]).toUpperCase();
  }
}

class OverdueEmiItem {
  const OverdueEmiItem({
    required this.id,
    required this.customerName,
    required this.mobile,
    required this.emiAmount,
    required this.dueDate,
    this.loanId = '',
  });

  final String id;
  final String loanId;
  final String customerName;
  final String mobile;
  final double emiAmount;
  final String dueDate;
}

class DashboardSummaryData {
  const DashboardSummaryData({
    required this.totalLent,
    this.monthlyGrowthPercent,
    required this.activeLoansCount,
    required this.customersCount,
    required this.emisDueThisMonth,
    required this.collectedThisMonth,
    required this.pendingThisMonth,
    required this.recentLoans,
    required this.overdueEmis,
  });

  final double totalLent;
  final int? monthlyGrowthPercent;
  final int activeLoansCount;
  final int customersCount;
  final int emisDueThisMonth;
  final double collectedThisMonth;
  final double pendingThisMonth;
  final List<LoanItem> recentLoans;
  final List<OverdueEmiItem> overdueEmis;

  factory DashboardSummaryData.empty() {
    return const DashboardSummaryData(
      totalLent: 0,
      monthlyGrowthPercent: null,
      activeLoansCount: 0,
      customersCount: 0,
      emisDueThisMonth: 0,
      collectedThisMonth: 0,
      pendingThisMonth: 0,
      recentLoans: [],
      overdueEmis: [],
    );
  }
}
