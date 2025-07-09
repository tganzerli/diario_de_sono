import 'package:auto_injector/auto_injector.dart';

import 'data_export/data_export_service.dart';
import 'data_export/file_generation_service.dart';
import 'data_export/share_plus.dart';
import 'data_export/sharing_service.dart';
import 'storage/database_helper.dart';
import 'storage/sqflite_impl.dart';
import 'storage/storage_service.dart';

export 'data_export/data_export_service.dart';
export 'storage/storage_service.dart';
export 'validation/validation_service.dart';

class ServicesInjector {
  static void add(AutoInjector injector) {
    injector.addSingleton(DatabaseHelper.new);
    injector.add<StorageService>(SqfliteStorageService.new);
    injector.add<FileGenerationService>(FileGenerationService.new);
    injector.add<SharingService>(SharePlusImpl.new);
    injector.add<DataExportService>(DataExportService.new);
  }
}
