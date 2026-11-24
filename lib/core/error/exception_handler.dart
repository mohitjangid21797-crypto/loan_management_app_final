import 'package:loan_management_app/core/error/failures.dart';
import 'package:sqflite/sqflite.dart';

class ExceptionHandler {
  const ExceptionHandler._();

  static Future<Result<T>> guard<T>(
    Future<T> Function() action, {
    FailureType fallbackType = FailureType.database,
    String fallbackMessageKey = 'databaseError',
  }) async {
    try {
      final result = await action();
      return Success<T>(result);
    } on DatabaseException catch (e) {
      final lower = e.toString().toLowerCase();
      if (lower.contains('unique') && lower.contains('mobile')) {
        return Err<T>(
          const AppFailure(
            type: FailureType.duplicateMobile,
            messageKey: 'duplicateMobileError',
          ),
        );
      }
      return Err<T>(
        AppFailure(
          type: FailureType.database,
          messageKey: fallbackMessageKey,
          detail: e.toString(),
        ),
      );
    } catch (e) {
      return Err<T>(
        AppFailure(
          type: fallbackType,
          messageKey: fallbackMessageKey,
          detail: e.toString(),
        ),
      );
    }
  }
}
