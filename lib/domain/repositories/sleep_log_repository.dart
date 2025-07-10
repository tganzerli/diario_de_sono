import 'package:result_dart/result_dart.dart';

import '../dto/sleep_log_dto.dart';
import '../entities/sleep_log.dart';

abstract interface class SleepLogRepository {
  AsyncResult<Unit> add(SleepLogDto sleepLog);
  AsyncResult<List<SleepLog>> get([int? days, bool updateObserver = false]);
  AsyncResult<List<SleepLog>> getToSend();
  AsyncResult<Unit> updateToSend();

  Stream<List<SleepLog>> logsObserver();

  void dispose();
}
