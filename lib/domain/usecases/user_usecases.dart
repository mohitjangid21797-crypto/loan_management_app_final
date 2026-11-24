import 'package:loan_management_app/core/error/failures.dart';
import 'package:loan_management_app/core/utils/validators.dart';
import 'package:loan_management_app/data/repositories/user_repository.dart';
import 'package:loan_management_app/domain/entities/lender_profile.dart';

class GetLenderProfileUseCase {
  const GetLenderProfileUseCase(this._repository);

  final UserRepository _repository;

  Future<Result<LenderProfile?>> call() => _repository.getProfile();
}

class SaveLenderProfileUseCase {
  const SaveLenderProfileUseCase(this._repository);

  final UserRepository _repository;

  Future<Result<LenderProfile>> call(LenderProfile profile) async {
    if (LoginValidators.validateName(profile.name) != null) {
      return const Err<LenderProfile>(
        AppFailure(
          type: FailureType.validation,
          messageKey: 'errorNameRequired',
        ),
      );
    }
    if (LoginValidators.validateMobile(profile.mobile) != null) {
      return const Err<LenderProfile>(
        AppFailure(
          type: FailureType.validation,
          messageKey: 'errorMobileInvalid',
        ),
      );
    }
    if (LoginValidators.validateEmail(profile.email) != null) {
      return const Err<LenderProfile>(
        AppFailure(
          type: FailureType.validation,
          messageKey: 'errorEmailInvalid',
        ),
      );
    }
    return _repository.saveProfile(profile);
  }
}

class SignOutUseCase {
  const SignOutUseCase(this._repository);

  final UserRepository _repository;

  Future<Result<void>> call() => _repository.clearProfile();
}
