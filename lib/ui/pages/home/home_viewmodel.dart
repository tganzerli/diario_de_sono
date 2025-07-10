import 'package:flutter/material.dart';
import 'package:result_command/result_command.dart';
import 'package:result_dart/result_dart.dart';

import '../../../domain/usecases/check_and_schedule_reminder_usecase.dart';

class HomeViewmodel extends ChangeNotifier {
  final CheckAndScheduleReminder _checkAndScheduleReminder;

  HomeViewmodel(this._checkAndScheduleReminder);

  late final checkScheduleCommand = Command0<Unit>(_checkSchedule);

  AsyncResult<Unit> _checkSchedule() async {
    return _checkAndScheduleReminder();
  }
}
