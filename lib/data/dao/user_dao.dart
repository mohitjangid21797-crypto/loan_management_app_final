import 'package:loan_management_app/data/db/app_database.dart';
import 'package:loan_management_app/data/models/user_db_model.dart';

class UserDao {
  const UserDao(this._appDatabase);

  final AppDatabase _appDatabase;

  Future<UserDbModel?> getUser() async {
    final rows = await _appDatabase.database.query(
      'users',
      orderBy: 'id ASC',
      limit: 1,
    );
    if (rows.isEmpty) return null;
    return UserDbModel.fromMap(rows.first);
  }

  Future<UserDbModel> upsertUser(UserDbModel model) async {
    return _appDatabase.database.transaction((txn) async {
      final existing = await txn.query(
        'users',
        orderBy: 'id ASC',
        limit: 1,
      );
      if (existing.isEmpty) {
        final newId = await txn.insert('users', model.toMap());
        final inserted = await txn.query(
          'users',
          where: 'id = ?',
          whereArgs: [newId],
          limit: 1,
        );
        return UserDbModel.fromMap(inserted.first);
      }

      final existingId = existing.first['id'] as int;
      final existingCreatedAt = existing.first['created_at'] as String;
      await txn.update(
        'users',
        <String, Object?>{
          'name': model.name,
          'mobile': model.mobile,
          'email': model.email,
          'photo_path': model.photoPath,
          'created_at': existingCreatedAt,
          'updated_at': model.updatedAt,
        },
        where: 'id = ?',
        whereArgs: [existingId],
      );
      final updated = await txn.query(
        'users',
        where: 'id = ?',
        whereArgs: [existingId],
        limit: 1,
      );
      return UserDbModel.fromMap(updated.first);
    });
  }

  Future<void> clearUsers() async {
    await _appDatabase.database.delete('users');
  }
}
