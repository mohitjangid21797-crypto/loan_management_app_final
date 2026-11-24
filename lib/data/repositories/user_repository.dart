import 'package:loan_management_app/core/error/exception_handler.dart';
import 'package:loan_management_app/core/error/failures.dart';
import 'package:loan_management_app/data/dao/user_dao.dart';
import 'package:loan_management_app/data/models/user_db_model.dart';
import 'package:loan_management_app/domain/entities/lender_profile.dart';

abstract class UserRepository {
  Future<Result<LenderProfile?>> getProfile();
  Future<Result<LenderProfile>> saveProfile(LenderProfile profile);
  Future<Result<void>> clearProfile();
}

class SqliteUserRepository implements UserRepository {
  const SqliteUserRepository(this._userDao);

  final UserDao _userDao;

  @override
  Future<Result<LenderProfile?>> getProfile() {
    return ExceptionHandler.guard(() async {
      final row = await _userDao.getUser();
      return row?.toEntity();
    });
  }

  @override
  Future<Result<LenderProfile>> saveProfile(LenderProfile profile) {
    return ExceptionHandler.guard(() async {
      final now = DateTime.now().toUtc();
      final model = UserDbModel.fromEntity(
        profile.copyWith(
          createdAt: profile.createdAt ?? now,
          updatedAt: now,
        ),
      );
      final saved = await _userDao.upsertUser(model);
      return saved.toEntity(avatarIndex: profile.avatarIndex);
    });
  }

  @override
  Future<Result<void>> clearProfile() {
    return ExceptionHandler.guard(() async {
      await _userDao.clearUsers();
    });
  }
}

class InMemoryUserRepository implements UserRepository {
  InMemoryUserRepository({LenderProfile? initialProfile})
      : _profile = initialProfile;

  LenderProfile? _profile;

  @override
  Future<Result<LenderProfile?>> getProfile() async {
    return Success<LenderProfile?>(_profile);
  }

  @override
  Future<Result<LenderProfile>> saveProfile(LenderProfile profile) async {
    final now = DateTime.now().toUtc();
    _profile = profile.copyWith(
      id: _profile?.id ?? 1,
      createdAt: _profile?.createdAt ?? profile.createdAt ?? now,
      updatedAt: now,
    );
    return Success<LenderProfile>(_profile!);
  }

  @override
  Future<Result<void>> clearProfile() async {
    _profile = null;
    return const Success<void>(null);
  }
}
