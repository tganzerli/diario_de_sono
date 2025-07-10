import 'package:auto_injector/auto_injector.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'cache/cache_service.dart';
import 'cache/shared_preferences.dart';
import 'data_export/data_export_service.dart';
import 'data_export/file_generation_service.dart';
import 'data_export/share_plus.dart';
import 'data_export/sharing_service.dart';
import 'notification/flutter_local_notifications.dart';
import 'notification/notification_service.dart';
import 'storage/database_helper.dart';
import 'storage/sqflite_impl.dart';
import 'storage/storage_service.dart';

export 'cache/cache_service.dart';
export 'data_export/data_export_service.dart';
export 'notification/flutter_local_notifications.dart';
export 'storage/storage_service.dart';
export 'validation/validation_service.dart';

class ServicesInjector {
  static void add(AutoInjector injector) {
    injector.addSingleton(FlutterLocalNotificationsPlugin.new);
    injector.addSingleton(DatabaseHelper.new);
    injector.addSingleton<Cache>(SharedPreferencesImpl.new);
    injector.addSingleton<NotificationService>(FlutterLocalNotifications.new);
    injector.add<StorageService>(SqfliteStorageService.new);
    injector.add<FileGenerationService>(FileGenerationService.new);
    injector.add<SharingService>(SharePlusImpl.new);
    injector.add<DataExportService>(DataExportService.new);
  }
}
