import 'dart:async';

import 'package:diario_de_sono/core/value_object/of_time_vo.dart';
import 'package:diario_de_sono/domain/entities/sleep_log.dart';
import 'package:diario_de_sono/domain/repositories/sleep_log_repository.dart';
import 'package:flutter/material.dart';
import 'package:result_command/result_command.dart';
import 'package:result_dart/result_dart.dart';

import '../../../domain/usecases/check_and_schedule_reminder_usecase.dart';

class HomeViewmodel extends ChangeNotifier {
  final CheckAndScheduleReminder _checkAndScheduleReminder;
  final SleepLogRepository _sleepLogRepository;

  HomeViewmodel(this._checkAndScheduleReminder, this._sleepLogRepository);

  late final checkScheduleCommand = Command0<Unit>(_checkSchedule);
  late final initScheduleCommand = Command0<Unit>(_init);

  List<SleepLog> _sleepLogs = [];
  List<SleepLog> get sleepLogs => _sleepLogs;

  List<SleepLog> _showlLogs = [];
  List<SleepLog> get showLogs => _showlLogs;

  StreamSubscription? _streamLogs;
  void _listen(List<SleepLog> sleepLogs) {
    _sleepLogs = sleepLogs;
    _arrangeDates();
    notifyListeners();
  }

  AsyncResult<Unit> _checkSchedule() async {
    return _checkAndScheduleReminder();
  }

  AsyncResult<Unit> _init() async {
    return _watchLogs() //
        .flatMap((_) => _getLogs());
  }

  AsyncResult<Unit> _watchLogs() async {
    _streamLogs ??=
        _sleepLogRepository //
            .logsObserver()
            .asBroadcastStream()
            .listen(_listen);

    return Success(unit);
  }

  AsyncResult<Unit> _getLogs() async {
    return _sleepLogRepository //
        .get(7, true)
        .pure(unit);
  }

  void _arrangeDates() {
    final List<SleepLog> logsList = List.from(_sleepLogs);
    logsList.sort((a, b) => a.day.compareTo(b.day));
    final weekdayIndex = logsList.map((e) => e.day.weekday).toList();
    for (var day in weekdayIndex) {
      if (day == 1) break;
      logsList.removeAt(0);
    }
    if (logsList.isEmpty) {
      _showlLogs = _sleepLogs;
    }
    _showlLogs = logsList;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _streamLogs?.cancel();
  }

  /// Dados de teste com 7 registros de sono, de hoje até 6 dias atrás.
  // ignore: unused_element
  List<SleepLog> get _teste {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return [
      SleepLog(
        id: 1,
        day: today,
        bedtime: OfTime.fromHHMM(hour: 23, minute: 0),
        sleepLatency: OfTime.fromHHMM(minute: 20),
        sleepDuration: OfTime.fromHHMM(hour: 7, minute: 45),
        awakeningsCount: 1,
        isSent: true,
      ),
      SleepLog(
        id: 2,
        day: today.subtract(const Duration(days: 1)),
        bedtime: OfTime.fromHHMM(hour: 22, minute: 45),
        sleepLatency: OfTime.fromHHMM(minute: 10),
        sleepDuration: OfTime.fromHHMM(hour: 8),
        awakeningsCount: 0,
        isSent: true,
      ),
      SleepLog(
        id: 3,
        day: today.subtract(const Duration(days: 2)),
        bedtime: OfTime.fromHHMM(hour: 23, minute: 15),
        sleepLatency: OfTime.fromHHMM(minute: 30),
        sleepDuration: OfTime.fromHHMM(hour: 6, minute: 30),
        awakeningsCount: 2,
        isSent: true,
      ),
      SleepLog(
        id: 4,
        day: today.subtract(const Duration(days: 3)),
        bedtime: OfTime.fromHHMM(hour: 23, minute: 0),
        sleepLatency: OfTime.fromHHMM(minute: 15),
        sleepDuration: OfTime.fromHHMM(hour: 7, minute: 15),
        awakeningsCount: 1,
        isSent: true,
      ),
      SleepLog(
        id: 5,
        day: today.subtract(const Duration(days: 4)),
        bedtime: OfTime.fromHHMM(hour: 22, minute: 30),
        sleepLatency: OfTime.fromHHMM(minute: 25),
        sleepDuration: OfTime.fromHHMM(hour: 7, minute: 50),
        awakeningsCount: 1,
        isSent: true,
      ),
      SleepLog(
        id: 6,
        day: today.subtract(const Duration(days: 5)),
        bedtime: OfTime.fromHHMM(hour: 23, minute: 30),
        sleepLatency: OfTime.fromHHMM(minute: 18),
        sleepDuration: OfTime.fromHHMM(hour: 8, minute: 10),
        awakeningsCount: 0,
        isSent: true,
      ),
      SleepLog(
        id: 7,
        day: today.subtract(const Duration(days: 6)),
        bedtime: OfTime.fromHHMM(hour: 22, minute: 50),
        sleepLatency: OfTime.fromHHMM(minute: 22),
        sleepDuration: OfTime.fromHHMM(hour: 7, minute: 0),
        awakeningsCount: 2,
        isSent: true,
      ),
    ];
  }
}
