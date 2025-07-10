import 'package:diario_de_sono/core/services/validation/validation_service.dart';
import 'package:diario_de_sono/domain/dto/schedule_dto.dart';
import 'package:result_dart/result_dart.dart';

import '../../core/services/notification/notification_service.dart';
import '../entities/schedule.dart';
import '../repositories/schedule_repository.dart';
import '../repositories/sleep_log_repository.dart';

class UpdateScheduleTime {
  final NotificationService _notificationService;
  final ScheduleRepository _scheduleRepository;
  final SleepLogRepository _sleepLogRepository;

  UpdateScheduleTime(
    this._notificationService,
    this._scheduleRepository,
    this._sleepLogRepository,
  );

  AsyncResult<Schedule> call(ScheduleDto dto) async {
    return dto
        .validate() //
        .mapError((e) => e.joinException())
        .toAsyncResult()
        .flatMap(_swithSchedule);
  }

  AsyncResult<Schedule> _swithSchedule(ScheduleDto dto) async {
    if (_timeIsBefore(dto)) {
      return _updateNotification(dto) //
          .flatMap(_scheduleRepository.set);
    } else {
      return _sleepLogRepository //
          .get(0)
          .flatMap(
            (list) => list.isEmpty
                ? _updateNotification(dto) //
                      .flatMap(_scheduleRepository.set)
                : _updateAndSkipNotification(dto) //
                      .flatMap(_scheduleRepository.set),
          );
    }
  }

  AsyncResult<Schedule> _updateNotification(ScheduleDto dto) async {
    try {
      final schedulId = await _notificationService.updateNotification(
        id: dto.id!,
        hour: dto.hour!,
        minute: dto.minute!,
      );
      return Success(
        Schedule(id: schedulId, hour: dto.hour!, minute: dto.minute!),
      );
    } catch (e) {
      return Failure(e is Exception ? e : Exception(e.toString()));
    }
  }

  AsyncResult<Schedule> _updateAndSkipNotification(ScheduleDto dto) async {
    try {
      final schedulId = await _notificationService.skipThisDay(
        id: dto.id,
        hour: dto.hour!,
        minute: dto.minute!,
      );
      return Success(
        Schedule(id: schedulId, hour: dto.hour!, minute: dto.minute!),
      );
    } catch (e) {
      return Failure(e is Exception ? e : Exception(e.toString()));
    }
  }

  bool _timeIsBefore(ScheduleDto dto) {
    final now = DateTime.now();
    final scheduleTime = DateTime(
      now.year,
      now.month,
      now.day,
      dto.hour!,
      dto.minute!,
    );
    return scheduleTime.isBefore(now);
  }
}
