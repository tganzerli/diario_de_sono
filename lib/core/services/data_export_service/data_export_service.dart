import 'dart:io';

import 'file_generation_service.dart';
import 'sharing_service.dart';

class DataExportService {
  final FileGenerationService _fileGenerationService;
  final SharingService _sharingService;

  DataExportService(this._fileGenerationService, this._sharingService);

  Future<bool> exportJson(List<Map<String, dynamic>> data) async {
    File? tempFile;
    try {
      tempFile = await _fileGenerationService.generateJsonFile(data);
      final result = await _sharingService.shareFile(tempFile);
      return result;
    } catch (e, s) {
      throw DataExportException('Erro ao exportar dados', s);
    } finally {
      if (tempFile != null) {
        await tempFile.delete();
      }
    }
  }
}

class DataExportException implements Exception {
  const DataExportException(this.message, [this.stackTracing]);

  final String message;
  final dynamic stackTracing;
}
