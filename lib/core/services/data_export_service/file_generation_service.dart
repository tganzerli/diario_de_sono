import 'dart:convert';
import 'dart:io';

import 'package:diario_de_sono/core/extension/date_time_extension.dart';
import 'package:path_provider/path_provider.dart';

class FileGenerationService {
  Future<File> generateJsonFile(List<Map<String, dynamic>> data) async {
    try {
      final date = DateTime.now().getFormattedDate();

      return _writeFile('registro_do_sono_$date.json', jsonEncode(data));
    } catch (e) {
      rethrow;
    }
  }

  Future<File> _writeFile(String fileName, String content) async {
    final Directory tempDir = await getTemporaryDirectory();
    final String path = tempDir.path;
    final file = File('$path/$fileName');
    return await file.writeAsString(content);
  }
}
