import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/config/dependencies.dart';
import 'ui/app_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupInjection();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const AppWidget());
}
