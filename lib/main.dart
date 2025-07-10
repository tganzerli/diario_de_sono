import 'package:diario_de_sono/core/services/notification/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/config/dependencies.dart';
import 'ui/app_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupInjection();
  injector.get<NotificationService>().init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const AppWidget());
}
