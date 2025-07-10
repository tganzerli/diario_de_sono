import 'package:auto_injector/auto_injector.dart';
import 'package:diario_de_sono/core/services/services.dart';
import 'package:diario_de_sono/data/repositories/schedule_repository.dart';
import 'package:diario_de_sono/data/repositories/sleep_log_repository.dart';
import 'package:diario_de_sono/domain/repositories/schedule_repository.dart';
import 'package:diario_de_sono/domain/repositories/sleep_log_repository.dart';
import 'package:diario_de_sono/domain/usecases/sharing_sleep_logs_usecase.dart';
import 'package:diario_de_sono/ui/pages/daily_sleep_log/daily_sleep_log_viewmodel.dart';
import 'package:diario_de_sono/ui/pages/share/share_viewmodel.dart';

final injector = AutoInjector();

void setupInjection() {
  ServicesInjector.add(injector);

  // Repositories
  injector.add<SleepLogRepository>(SleepLogRepositoryImpl.new);
  injector.add<ScheduleRepository>(ScheduleRepositoryImpl.new);

  // Usecases
  injector.add<SharingSleepLogsUsecase>(SharingSleepLogsUsecase.new);

  // Viewmodel
  injector.add<DailySleepLogViewmodel>(DailySleepLogViewmodel.new);
  injector.add<ShareViewmodel>(ShareViewmodel.new);

  injector.commit();
}
