import 'dart:io';

import 'package:mime/mime.dart';
import 'package:path/path.dart' as path;
import 'package:share_plus/share_plus.dart';

import 'sharing_service.dart';

class SharePlusImpl implements SharingService {
  @override
  Future<bool> shareFile(File file, {String? text, String? subject}) async {
    try {
      final fileName = path.basename(file.path);
      final mimeType = lookupMimeType(file.path);
      final xfile = XFile(file.path, name: fileName, mimeType: mimeType);

      final result = await SharePlus.instance.share(
        ShareParams(files: [xfile], text: text, subject: subject),
      );

      return result.status == ShareResultStatus.success;
    } catch (e) {
      rethrow;
    }
  }
}
