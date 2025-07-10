import '../services/services.dart';
import 'value_object_element.dart';

class OfTime extends ValueObject<String> {
  OfTime(super.value);

  String toMap() => value;
  factory OfTime.fromMap(String map) => OfTime(map);
  factory OfTime.fromMinutes(int minutes) {
    final hour = minutes ~/ 60;
    final minute = minutes % 60;
    return OfTime('00:00').setHours(hour).setMinutes(minute);
  }
  factory OfTime.fromHHMM({int hour = 0, int minute = 0}) =>
      OfTime('00:00').setHours(hour).setMinutes(minute);

  OfTime setHours(int hours) {
    final list = value.split(':');
    list[0] = hours.toString().padLeft(2, '0');
    return OfTime(list.join(':'));
  }

  OfTime setMinutes(int minutes) {
    final list = value.split(':');
    list[1] = minutes.toString().padLeft(2, '0');
    return OfTime(list.join(':'));
  }

  int get hours => int.parse(value.split(':').first);
  int get minutes => int.parse(value.split(':').last);

  int get timeInMinutes => (hours * 60) + minutes;

  @override
  Validation<OfTime> validate() {
    rule(
      conditional: int.parse(value.split(':').first) > 23,
      message: 'Tempo inválido',
    );

    rule(
      conditional: int.parse(value.split(':').last) > 59,
      message: 'Tempo inválido',
    );
    return result<OfTime>(this);
  }
}
