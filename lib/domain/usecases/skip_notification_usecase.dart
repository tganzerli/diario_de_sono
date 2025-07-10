import 'package:result_dart/result_dart.dart';

import '../../core/services/notification/notification_service.dart';
import '../entities/schedule.dart';
import '../repositories/schedule_repository.dart';

class SkipNotification {
  final NotificationService _notificationService;
  final ScheduleRepository _scheduleRepository;

  SkipNotification(this._notificationService, this._scheduleRepository);

  AsyncResult<Schedule> call() async {
    return _scheduleRepository //
        .get()
        .flatMap(_updateAndSkipNotification);
  }

  AsyncResult<Schedule> _updateAndSkipNotification(Schedule schedule) async {
    try {
      await _notificationService.skipThisDay(
        id: schedule.id,
        hour: schedule.hour,
        minute: schedule.minute,
      );
      return Success(schedule);
    } catch (e) {
      return Failure(e is Exception ? e : Exception(e.toString()));
    }
  }
}
