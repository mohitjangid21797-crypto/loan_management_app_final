class IndianCurrencyFormatter {
  const IndianCurrencyFormatter._();

  static String formatPaise(
    int paise, {
    bool includeSymbol = true,
    int decimals = 2,
  }) {
    return format(
      paise / 100.0,
      includeSymbol: includeSymbol,
      decimals: decimals,
    );
  }

  static String format(
    double amount, {
    bool includeSymbol = true,
    int decimals = 2,
  }) {
    final isNegative = amount < 0;
    final absValue = amount.abs();
    final fixed = absValue.toStringAsFixed(decimals);
    final parts = fixed.split('.');
    final intPart = parts[0];
    final decPart = parts.length > 1 ? '.${parts[1]}' : '';

    final formattedInt = _formatIndianInteger(intPart);
    final sign = isNegative ? '-' : '';
    final symbol = includeSymbol ? '₹' : '';
    return '$sign$symbol$formattedInt$decPart';
  }

  static String _formatIndianInteger(String digits) {
    if (digits.length <= 3) {
      return digits;
    }
    final lastThree = digits.substring(digits.length - 3);
    final remaining = digits.substring(0, digits.length - 3);
    final buffer = StringBuffer();
    for (int i = 0; i < remaining.length; i++) {
      final posFromRight = remaining.length - i;
      buffer.write(remaining[i]);
      if (posFromRight > 1 && posFromRight % 2 == 1) {
        buffer.write(',');
      }
    }
    buffer.write(',');
    buffer.write(lastThree);
    return buffer.toString();
  }
}
