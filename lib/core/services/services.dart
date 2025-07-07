import 'package:auto_injector/auto_injector.dart';

import 'storage/database_helper.dart';
import 'storage/sqflite_impl.dart';
import 'storage/storage_service.dart';

export 'storage/storage_service.dart';
export 'validation/validation_service.dart';

class ServicesInjector {
  static void add(AutoInjector injector) {
    injector.addSingleton(DatabaseHelper.new);
    injector.add<StorageService>(SqfliteStorageService.new);
  }
}
