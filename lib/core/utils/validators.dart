enum NameValidationError { required }

enum MobileValidationError { invalid }

enum EmailValidationError { invalid }

enum LocationValidationError { required }

enum PrincipalValidationError { invalid }

enum RateValidationError { invalid }

enum TenureValidationError { invalid }

class LoginValidators {
  const LoginValidators._();

  static final RegExp _mobileRegex = RegExp(r'^[6-9]\d{9}$');
  static final RegExp _emailRegex = RegExp(
    r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$',
  );

  static NameValidationError? validateName(String value) {
    if (value.trim().isEmpty) {
      return NameValidationError.required;
    }
    return null;
  }

  static MobileValidationError? validateMobile(String value) {
    if (!_mobileRegex.hasMatch(value.trim())) {
      return MobileValidationError.invalid;
    }
    return null;
  }

  static EmailValidationError? validateEmail(String value) {
    if (!_emailRegex.hasMatch(value.trim())) {
      return EmailValidationError.invalid;
    }
    return null;
  }

  static bool isFormValid({
    required String name,
    required String mobile,
    required String email,
  }) {
    return validateName(name) == null &&
        validateMobile(mobile) == null &&
        validateEmail(email) == null;
  }
}

class LoanValidators {
  const LoanValidators._();

  static LocationValidationError? validateLocation(String value) {
    if (value.trim().isEmpty) {
      return LocationValidationError.required;
    }
    return null;
  }

  static PrincipalValidationError? validatePrincipalText(String value) {
    final parsed = double.tryParse(value.trim().replaceAll(',', ''));
    if (parsed == null || parsed <= 0) {
      return PrincipalValidationError.invalid;
    }
    return null;
  }

  static int? parsePrincipalPaise(String value) {
    final parsed = double.tryParse(value.trim().replaceAll(',', ''));
    if (parsed == null || parsed <= 0) return null;
    final paise = (parsed * 100).round();
    return paise > 0 ? paise : null;
  }

  static RateValidationError? validateRateText(String value) {
    final parsed = double.tryParse(value.trim());
    if (parsed == null || parsed < 0 || parsed > 100) {
      return RateValidationError.invalid;
    }
    return null;
  }

  static double? parseRatePercent(String value) {
    final parsed = double.tryParse(value.trim());
    if (parsed == null || parsed < 0 || parsed > 100) return null;
    return parsed;
  }

  static TenureValidationError? validateTenureText(String value) {
    final parsed = int.tryParse(value.trim());
    if (parsed == null || parsed < 1 || parsed > 600) {
      return TenureValidationError.invalid;
    }
    return null;
  }

  static int? parseTenureMonths(String value) {
    final parsed = int.tryParse(value.trim());
    if (parsed == null || parsed < 1 || parsed > 600) return null;
    return parsed;
  }
}
