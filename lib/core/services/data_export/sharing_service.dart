import 'dart:io';

abstract interface class SharingService {
  Future<bool> shareFile(File file, {String? text, String? subject});
}
