import 'package:diario_de_sono/core/services/services.dart';
import 'package:flutter/material.dart';
import 'package:result_command/result_command.dart';
import 'package:result_dart/result_dart.dart';

import '../../../domain/dto/sleep_log_dto.dart';
import '../../../domain/repositories/sleep_log_repository.dart';

class DailySleepLogViewmodel extends ChangeNotifier {
  final SleepLogRepository _sleepLogRepository;

  DailySleepLogViewmodel(this._sleepLogRepository);

  late final sendLogCommand = Command1<Unit, SleepLogDto>(_sleepLog);

  AsyncResult<Unit> _sleepLog(SleepLogDto dto) async {
    return dto
        .validate() //
        .mapError((e) => e.joinException())
        .toAsyncResult()
        .flatMap(_sleepLogRepository.add);
  }
}
