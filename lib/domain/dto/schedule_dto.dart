import 'package:diario_de_sono/core/services/validation/validation_service.dart';
import 'package:flutter/widgets.dart';

import '../entities/schedule.dart';

class ScheduleDto extends ValidationService {
  final int? id;
  final int? hour;
  final int? minute;

  ScheduleDto({this.id, this.hour, this.minute});

  factory ScheduleDto.fronEntity(Schedule schedule) {
    return ScheduleDto(
      id: schedule.id,
      hour: schedule.hour,
      minute: schedule.minute,
    );
  }

  ScheduleDto copyWith({
    ValueGetter<int?>? id,
    ValueGetter<int?>? hour,
    ValueGetter<int?>? minute,
  }) {
    return ScheduleDto(
      id: id != null ? id() : this.id,
      hour: hour != null ? hour() : this.hour,
      minute: minute != null ? minute() : this.minute,
    );
  }

  Validation<ScheduleDto> validate() {
    rule(
      conditional: hour == null || minute == null,
      message: 'Tempo não pode ser nulo',
    );
    return result<ScheduleDto>(this);
  }
}
