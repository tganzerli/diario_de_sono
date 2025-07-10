import 'package:diario_de_sono/core/services/cache/cache_service.dart';
import 'package:diario_de_sono/domain/entities/schedule.dart';
import 'package:result_dart/result_dart.dart';

import '../../domain/repositories/schedule_repository.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  final Cache _cache;
  ScheduleRepositoryImpl(this._cache);

  final key = 'ScheduleSleepLog';

  @override
  AsyncResult<Unit> delete() async {
    try {
      final result = await _cache.removeData(key);

      return result
          ? Success(unit)
          : Failure(Exception('Erro ao deletar notificação'));
    } catch (e) {
      return Failure(e is Exception ? e : Exception(e.toString()));
    }
  }

  @override
  AsyncResult<Schedule> get() {
    return _get() //
        .map(_adapter);
  }

  @override
  AsyncResult<Schedule> set(Schedule schedule) async {
    try {
      CacheParams params = CacheParams(
        key: key,
        value: '${schedule.id}:${schedule.hour}:${schedule.minute}}',
      );
      final result = await _cache.setData(params);

      return result
          ? Success(schedule)
          : Failure(Exception('Erro ao salvar notificação'));
    } catch (e) {
      return Failure(e is Exception ? e : Exception(e.toString()));
    }
  }

  AsyncResult<String> _get() async {
    try {
      final result = await _cache.getData(key);

      return Success(result);
    } catch (e) {
      return Failure(e is Exception ? e : Exception(e.toString()));
    }
  }

  Schedule _adapter(String value) {
    final List<String> values = value.split(':');
    return Schedule(
      id: int.parse(values[0]),
      hour: int.parse(values[1]),
      minute: int.parse(values[2]),
    );
  }
}
