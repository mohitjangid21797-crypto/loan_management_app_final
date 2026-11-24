import 'package:equatable/equatable.dart';

class LenderProfile extends Equatable {
  const LenderProfile({
    this.id,
    required this.name,
    required this.mobile,
    required this.email,
    this.photoPath,
    this.avatarIndex = 0,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String name;
  final String mobile;
  final String email;
  final String? photoPath;
  final int avatarIndex;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  String get initials {
    final parts = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((p) => p.isNotEmpty)
        .toList();
    if (parts.isEmpty) return 'LW';
    if (parts.length == 1) {
      return parts.first
          .substring(0, parts.first.length >= 2 ? 2 : 1)
          .toUpperCase();
    }
    return (parts.first[0] + parts.last[0]).toUpperCase();
  }

  LenderProfile copyWith({
    int? id,
    String? name,
    String? mobile,
    String? email,
    String? photoPath,
    bool clearPhotoPath = false,
    int? avatarIndex,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return LenderProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      mobile: mobile ?? this.mobile,
      email: email ?? this.email,
      photoPath: clearPhotoPath ? null : (photoPath ?? this.photoPath),
      avatarIndex: avatarIndex ?? this.avatarIndex,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'mobile': mobile,
        'email': email,
        'photoPath': photoPath,
        'avatarIndex': avatarIndex,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };

  factory LenderProfile.fromJson(Map<String, dynamic> json) {
    return LenderProfile(
      id: json['id'] as int?,
      name: json['name'] as String,
      mobile: json['mobile'] as String,
      email: json['email'] as String,
      photoPath: json['photoPath'] as String?,
      avatarIndex: (json['avatarIndex'] as int?) ?? 0,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        mobile,
        email,
        photoPath,
        avatarIndex,
        createdAt,
        updatedAt,
      ];
}
