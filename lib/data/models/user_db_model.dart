import 'package:loan_management_app/domain/entities/lender_profile.dart';

class UserDbModel {
  const UserDbModel({
    this.id,
    required this.name,
    required this.mobile,
    required this.email,
    this.photoPath,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String name;
  final String mobile;
  final String email;
  final String? photoPath;
  final String createdAt;
  final String updatedAt;

  factory UserDbModel.fromMap(Map<String, Object?> map) {
    return UserDbModel(
      id: map['id'] as int?,
      name: map['name'] as String,
      mobile: map['mobile'] as String,
      email: map['email'] as String,
      photoPath: map['photo_path'] as String?,
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String,
    );
  }

  Map<String, Object?> toMap() {
    return <String, Object?>{
      if (id != null) 'id': id,
      'name': name,
      'mobile': mobile,
      'email': email,
      'photo_path': photoPath,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  LenderProfile toEntity({int avatarIndex = 0}) {
    return LenderProfile(
      id: id,
      name: name,
      mobile: mobile,
      email: email,
      photoPath: photoPath,
      avatarIndex: avatarIndex,
      createdAt: DateTime.tryParse(createdAt),
      updatedAt: DateTime.tryParse(updatedAt),
    );
  }

  factory UserDbModel.fromEntity(LenderProfile entity) {
    final nowIso = DateTime.now().toUtc().toIso8601String();
    return UserDbModel(
      id: entity.id,
      name: entity.name.trim(),
      mobile: entity.mobile.trim(),
      email: entity.email.trim(),
      photoPath: entity.photoPath,
      createdAt: entity.createdAt?.toUtc().toIso8601String() ?? nowIso,
      updatedAt: entity.updatedAt?.toUtc().toIso8601String() ?? nowIso,
    );
  }
}
