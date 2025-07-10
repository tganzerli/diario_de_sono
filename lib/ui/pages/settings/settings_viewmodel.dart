import 'package:diario_de_sono/domain/dto/schedule_dto.dart';
import 'package:flutter/material.dart';
import 'package:result_command/result_command.dart';
import 'package:result_dart/result_dart.dart';

import 'package:diario_de_sono/core/value_object/of_time_vo.dart';
import 'package:diario_de_sono/domain/repositories/schedule_repository.dart';
import 'package:diario_de_sono/domain/usecases/update_schedule_time_usecase.dart';

class SettingsViewmodel extends ChangeNotifier {
  final ScheduleRepository _scheduleRepository;
  final UpdateScheduleTime _updateScheduleTime;

  SettingsViewmodel(this._scheduleRepository, this._updateScheduleTime);

  late final initCommand = Command0<Unit>(_init);
  late final updateScheduleCommand = Command1<Unit, OfTime?>(_updateSchedule);
  late final saveScheduleCommand = Command0<Unit>(_saveSchedule);

  ScheduleDto _schedule = ScheduleDto();

  OfTime? get scheduleTime => _schedule.hour == null || _schedule.minute == null
      ? null
      : OfTime('09:00') //
            .setHours(_schedule.hour!)
            .setMinutes(_schedule.minute!);

  AsyncResult<Unit> _init() async {
    return _scheduleRepository
        .get()
        .onFailure((e) {
          _schedule = ScheduleDto(hour: 9, minute: 0);
          notifyListeners();
        })
        .onSuccess((schedule) {
          _schedule = ScheduleDto.fronEntity(schedule);
          notifyListeners();
        })
        .pure(unit);
  }

  AsyncResult<Unit> _updateSchedule(OfTime? time) async {
    _schedule = _schedule.copyWith(
      hour: () => time?.hours,
      minute: () => time?.minutes,
    );
    notifyListeners();
    return Success(unit);
  }

  AsyncResult<Unit> _saveSchedule() async {
    return _updateScheduleTime //
        .call(_schedule)
        .pure(unit);
  }
}
