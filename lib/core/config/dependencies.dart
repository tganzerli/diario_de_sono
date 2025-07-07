import 'package:auto_injector/auto_injector.dart';
import 'package:diario_de_sono/core/services/services.dart';

final injector = AutoInjector();

void setupInjection() {
  ServicesInjector.add(injector);

  injector.commit();
}
