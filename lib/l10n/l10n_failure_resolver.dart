import 'package:loan_management_app/core/error/failures.dart';
import 'package:loan_management_app/l10n/app_localizations.dart';

String resolveFailureMessage(AppLocalizations l10n, AppFailure failure) {
  return switch (failure.messageKey) {
    'errorNameRequired' => l10n.errorNameRequired,
    'errorMobileInvalid' => l10n.errorMobileInvalid,
    'errorEmailInvalid' => l10n.errorEmailInvalid,
    'locationRequiredError' => l10n.locationRequiredError,
    'duplicateMobileError' => l10n.duplicateMobileError,
    'activeLoanDeleteBlocked' => l10n.activeLoanDeleteBlocked,
    'mobileLockedHelper' => l10n.mobileLockedHelper,
    'selectCustomerError' => l10n.selectCustomerError,
    'invalidPrincipalError' => l10n.invalidPrincipalError,
    'invalidRateError' => l10n.invalidRateError,
    'invalidTenureError' => l10n.invalidTenureError,
    'outOfOrderEmiError' => l10n.outOfOrderEmiError,
    'restoreInvalidError' => l10n.restoreInvalidError,
    'noCustomersTitle' => l10n.noCustomersTitle,
    'noLoansTitle' => l10n.noLoansTitle,
    'noDocumentsTitle' => l10n.noDocumentsTitle,
    'statusPaid' => l10n.statusPaid,
    'databaseError' => l10n.databaseError,
    _ => failure.detail ?? l10n.appTitle,
  };
}
