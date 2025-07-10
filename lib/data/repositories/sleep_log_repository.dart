import 'dart:async';

import 'package:diario_de_sono/core/extension/date_time_extension.dart';
import 'package:result_dart/result_dart.dart';

import 'package:diario_de_sono/domain/dto/sleep_log_dto.dart';
import 'package:diario_de_sono/domain/entities/sleep_log.dart';

import '../../core/services/services.dart';
import '../../domain/repositories/sleep_log_repository.dart';
import '../adapters/sleep_log.dart';
import '../adapters/sleep_log_dto.dart';

class SleepLogRepositoryImpl implements SleepLogRepository {
  final StorageService _storageService;

  SleepLogRepositoryImpl(this._storageService);

  final _streamController = StreamController<List<SleepLog>>.broadcast();

  @override
  void dispose() => _streamController.close();

  @override
  Stream<List<SleepLog>> logsObserver() => _streamController.stream;

  @override
  AsyncResult<Unit> add(SleepLogDto sleepLog) {
    return sleepLog //
        .validate()
        .mapError((e) => e.joinException())
        .map(SleepLogDtoAdapter.toMap)
        .toAsyncResult()
        .flatMap(_addLog)
        .onSuccess((_) => _updateObserver())
        .pure(unit);
  }

  @override
  AsyncResult<List<SleepLog>> get([
    int? days,
    bool updateObserver = false,
  ]) async {
    final filters = <StorageFilter>[];
    if (days != null) {
      final dateNow = DateTime.now();
      filters.add(
        StorageFilter.between(
          'date',
          dateNow.dayBefore(days).millisecondsSinceEpoch,
          dateNow.millisecondsSinceEpoch,
        ),
      );
    }

    return _getLogs(filters) //
        .map((list) => list.map(SleepLogAdapter.fromMap).toList())
        .onSuccess((_) => updateObserver ? _updateObserver() : () {});
  }

  @override
  AsyncResult<List<SleepLog>> getToSend() {
    final filters = [StorageFilter.equals('is_sent', 0)];
    return _getLogs(filters) //
        .map((list) => list.map(SleepLogAdapter.fromMap).toList());
  }

  @override
  AsyncResult<Unit> updateToSend() {
    final filters = [StorageFilter.equals('is_sent', 0)];
    final data = {'is_sent': 1};
    return _updateLogs(data, filters) //
        .onSuccess((_) => _updateObserver());
  }

  AsyncResult<Map<String, dynamic>> _addLog(Map<String, dynamic> logMap) async {
    try {
      final responser = await _storageService.create(logMap);
      return Success(responser);
    } catch (e) {
      return Failure(e is Exception ? e : Exception(e.toString()));
    }
  }

  AsyncResult<List<Map<String, dynamic>>> _getLogs(
    List<StorageFilter> filters,
  ) async {
    try {
      final responser = await _storageService.find(filters);
      return Success(responser);
    } catch (e) {
      return Failure(e is Exception ? e : Exception(e.toString()));
    }
  }

  AsyncResult<Unit> _updateLogs(
    Map<String, dynamic> data,
    List<StorageFilter> filters,
  ) async {
    try {
      await _storageService.update(data, filters);
      return Success(unit);
    } catch (e) {
      return Failure(e is Exception ? e : Exception(e.toString()));
    }
  }

  AsyncResult<Unit> _updateObserver() async {
    final days = 7;
    final dateNow = DateTime.now();
    final filters = <StorageFilter>[];
    filters.add(
      StorageFilter.between(
        'date',
        dateNow.dayBefore(days).millisecondsSinceEpoch,
        dateNow.millisecondsSinceEpoch,
      ),
    );
    return _getLogs(filters) //
        .map((list) => list.map(SleepLogAdapter.fromMap).toList())
        .onSuccess(_streamController.add)
        .pure(unit);
  }
}
