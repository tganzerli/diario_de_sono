import 'package:diario_de_sono/core/extension/async_result_extension.dart';
import 'package:result_dart/result_dart.dart';

import '../../core/services/notification/notification_service.dart';
import '../entities/schedule.dart';
import '../repositories/schedule_repository.dart';
import '../repositories/sleep_log_repository.dart';

class CheckAndScheduleReminder {
  final NotificationService _notificationService;
  final ScheduleRepository _scheduleRepository;
  final SleepLogRepository _sleepLogRepository;

  CheckAndScheduleReminder(
    this._notificationService,
    this._scheduleRepository,
    this._sleepLogRepository,
  );

  AsyncResult<Unit> call() async {
    return _sleepLogRepository //
        .get(0)
        .flatMap((list) => list.isEmpty ? _scheduleReminder() : Success(unit));
  }

  AsyncResult<Unit> _scheduleReminder() async {
    return _scheduleRepository //
        .get()
        .flatFold(_updateNotification, (r) => _setNotification());
  }

  AsyncResult<Unit> _updateNotification(Schedule schedule) async {
    try {
      _notificationService.scheduleDailyReminderNotification(
        id: schedule.id,
        hour: schedule.hour,
        minute: schedule.minute,
      );
      return Success(unit);
    } catch (e) {
      return Failure(e is Exception ? e : Exception(e.toString()));
    }
  }

  AsyncResult<Unit> _setNotification() async {
    try {
      final notificationId = await _notificationService
          .scheduleDailyReminderNotification();
      return _scheduleRepository
          .set(Schedule(id: notificationId, hour: 9, minute: 0)) //
          .pure(unit);
    } catch (e) {
      return Failure(e is Exception ? e : Exception(e.toString()));
    }
  }
}
