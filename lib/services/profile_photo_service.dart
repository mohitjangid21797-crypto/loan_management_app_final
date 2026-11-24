import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';
import 'package:loan_management_app/core/constants/app_constants.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class ProfilePhotoService {
  ProfilePhotoService({ImagePicker? picker})
      : _picker = picker ?? ImagePicker();

  final ImagePicker _picker;

  Future<String?> pickAndStorePhoto(ImageSource source) async {
    final picked = await _picker.pickImage(
      source: source,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 85,
    );
    if (picked == null) return null;
    if (kIsWeb) {
      return picked.path;
    }

    final supportDir = await getApplicationSupportDirectory();
    final avatarDir = Directory(
      p.join(supportDir.path, AppConstants.profileAvatarsDirName),
    );
    if (!avatarDir.existsSync()) {
      await avatarDir.create(recursive: true);
    }

    final ext = p.extension(picked.path).isNotEmpty
        ? p.extension(picked.path)
        : '.jpg';
    final targetPath = p.join(
      avatarDir.path,
      'lender_avatar_${DateTime.now().millisecondsSinceEpoch}$ext',
    );
    final savedFile = await File(picked.path).copy(targetPath);
    return savedFile.path;
  }
}
