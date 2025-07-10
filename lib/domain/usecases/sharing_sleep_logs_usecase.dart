import 'package:diario_de_sono/core/extension/date_time_extension.dart';
import 'package:result_dart/result_dart.dart';

import '../../core/services/services.dart';
import '../entities/sleep_log.dart';
import '../repositories/sleep_log_repository.dart';

class SharingSleepLogs {
  final DataExportService _dataExportService;
  final SleepLogRepository _sleepLogRepository;

  SharingSleepLogs(this._dataExportService, this._sleepLogRepository);

  AsyncResult<Unit> call() async {
    return _sleepLogRepository //
        .getToSend()
        .flatMap(_toMapList)
        .flatMap(_exportJson)
        .flatMap(
          (isSharing) => isSharing
              ? _sleepLogRepository.updateToSend()
              : Failure(
                  Exception('A exportação do relatório não foi finalizada'),
                ),
        );
  }

  Result<List<Map<String, dynamic>>> _toMapList(List<SleepLog> sleepLogs) {
    if (sleepLogs.isEmpty) {
      return Failure(Exception('Nenhum registro de sono para compartilhar'));
    }
    return Success(sleepLogs.map(_toMap).toList());
  }

  Map<String, dynamic> _toMap(SleepLog sleepLog) {
    return {
      'day': sleepLog.day.getDay(),
      'bedtime': sleepLog.bedtime.toMap(),
      'sleepLatency': sleepLog.sleepLatency.toMap(),
      'sleepDuration': sleepLog.sleepDuration.toMap(),
      'awakeningsCount': sleepLog.awakeningsCount,
    };
  }

  AsyncResult<bool> _exportJson(List<Map<String, dynamic>> data) async {
    try {
      final result = await _dataExportService.exportJson(data);
      return Success(result);
    } catch (e) {
      return Failure(e is Exception ? e : Exception(e.toString()));
    }
  }
}
