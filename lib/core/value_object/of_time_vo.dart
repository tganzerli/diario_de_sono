import '../services/services.dart';
import 'value_object_element.dart';

class OfTime extends ValueObject<String> {
  OfTime(super.value);

  String toMap() => value;
  factory OfTime.fromMap(String map) => OfTime(map);

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
