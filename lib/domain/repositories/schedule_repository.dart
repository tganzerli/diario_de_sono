import 'package:result_dart/result_dart.dart';

import '../entities/schedule.dart';

abstract interface class ScheduleRepository {
  AsyncResult<Schedule> set(Schedule schedule);
  AsyncResult<Schedule> get();
  AsyncResult<Unit> delete();
}
