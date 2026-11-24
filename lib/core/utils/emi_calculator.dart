import 'dart:math' as math;

import 'package:loan_management_app/core/utils/date_utils.dart';

enum LoanType { simple, compound }

class EmiCalculationRow {
  const EmiCalculationRow({
    required this.installmentNo,
    required this.dueDate,
    required this.emiPaise,
    required this.principalPartPaise,
    required this.interestPartPaise,
    required this.remainingBalancePaise,
  });

  final int installmentNo;
  final DateTime dueDate;
  final int emiPaise;
  final int principalPartPaise;
  final int interestPartPaise;
  final int remainingBalancePaise;
}

class EmiCalculationResult {
  const EmiCalculationResult({
    required this.monthlyEmiPaise,
    required this.totalInterestPaise,
    required this.totalPayablePaise,
    required this.rows,
  });

  final int monthlyEmiPaise;
  final int totalInterestPaise;
  final int totalPayablePaise;
  final List<EmiCalculationRow> rows;
}

class EmiCalculator {
  const EmiCalculator._();

  static EmiCalculationResult calculate({
    required int principalPaise,
    required double monthlyRatePercent,
    required int tenureMonths,
    required LoanType loanType,
    required DateTime startDate,
  }) {
    if (principalPaise <= 0) {
      throw ArgumentError.value(principalPaise, 'principalPaise', 'Must be > 0');
    }
    if (monthlyRatePercent < 0 || monthlyRatePercent > 100) {
      throw ArgumentError.value(
        monthlyRatePercent,
        'monthlyRatePercent',
        'Must be 0..100',
      );
    }
    if (tenureMonths < 1 || tenureMonths > 600) {
      throw ArgumentError.value(
        tenureMonths,
        'tenureMonths',
        'Must be 1..600',
      );
    }

    final utcStart = LoanDateUtils.toUtcMidnight(startDate);
    final r = monthlyRatePercent / 100.0;

    if (loanType == LoanType.simple || r == 0) {
      final totalInterest =
          r == 0 ? 0 : (principalPaise * r * tenureMonths).round();
      final totalPayable = principalPaise + totalInterest;

      final basePrincipal = principalPaise ~/ tenureMonths;
      final baseInterest = totalInterest ~/ tenureMonths;
      int remainingPrincipal = principalPaise;
      final rows = <EmiCalculationRow>[];

      for (int i = 1; i <= tenureMonths; i++) {
        final isLast = i == tenureMonths;
        final principalPart = isLast
            ? remainingPrincipal
            : basePrincipal;
        final interestPart = isLast
            ? totalInterest - (baseInterest * (tenureMonths - 1))
            : baseInterest;
        final emi = principalPart + interestPart;
        remainingPrincipal -= principalPart;
        if (remainingPrincipal < 0) remainingPrincipal = 0;

        rows.add(
          EmiCalculationRow(
            installmentNo: i,
            dueDate: LoanDateUtils.addMonthsClamped(utcStart, i),
            emiPaise: emi,
            principalPartPaise: principalPart,
            interestPartPaise: interestPart,
            remainingBalancePaise: remainingPrincipal,
          ),
        );
      }

      return EmiCalculationResult(
        monthlyEmiPaise: rows.first.emiPaise,
        totalInterestPaise: totalInterest,
        totalPayablePaise: totalPayable,
        rows: rows,
      );
    }

    // Compound reducing-balance EMI:
    // EMI = P * r * (1 + r)^n / ((1 + r)^n - 1)
    final factor = math.pow(1.0 + r, tenureMonths).toDouble();
    final double rawEmi = factor.isInfinite
        ? principalPaise * r
        : (principalPaise * r * factor) / (factor - 1.0);
    final baseEmi = math.max(1, rawEmi.round());

    int balance = principalPaise;
    int totalPayable = 0;
    final rows = <EmiCalculationRow>[];

    for (int i = 1; i <= tenureMonths; i++) {
      final isLast = i == tenureMonths;
      final interestPart = (balance * r).round();
      int principalPart;
      int emi;

      if (isLast) {
        principalPart = balance;
        emi = principalPart + interestPart;
      } else {
        principalPart = baseEmi - interestPart;
        if (principalPart > balance) {
          principalPart = balance;
          emi = principalPart + interestPart;
        } else if (principalPart < 0) {
          principalPart = 0;
          emi = interestPart;
        } else {
          emi = baseEmi;
        }
      }

      balance -= principalPart;
      if (balance < 0) balance = 0;
      totalPayable += emi;

      rows.add(
        EmiCalculationRow(
          installmentNo: i,
          dueDate: LoanDateUtils.addMonthsClamped(utcStart, i),
          emiPaise: emi,
          principalPartPaise: principalPart,
          interestPartPaise: interestPart,
          remainingBalancePaise: balance,
        ),
      );
    }

    return EmiCalculationResult(
      monthlyEmiPaise: baseEmi,
      totalInterestPaise: totalPayable - principalPaise,
      totalPayablePaise: totalPayable,
      rows: rows,
    );
  }
}
