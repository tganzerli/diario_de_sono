import 'package:auto_injector/auto_injector.dart';
import 'package:diario_de_sono/core/services/services.dart';
import 'package:diario_de_sono/data/repositories/sleep_log_repository.dart';
import 'package:diario_de_sono/domain/repositories/sleep_log_repository.dart';
import 'package:diario_de_sono/ui/pages/daily_sleep_log/daily_sleep_log_viewmodel.dart';

final injector = AutoInjector();

void setupInjection() {
  ServicesInjector.add(injector);

  // Repositories
  injector.add<SleepLogRepository>(SleepLogRepositoryImpl.new);

  // Viewmodel
  injector.add<DailySleepLogViewmodel>(DailySleepLogViewmodel.new);

  injector.commit();
}
