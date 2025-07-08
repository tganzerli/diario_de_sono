import '../services/services.dart';
import 'value_object_element.dart';

class OfTime extends ValueObject<String> {
  OfTime(super.value);

  String toMap() => value;
  factory OfTime.fromMap(String map) => OfTime(map);

  @override
  Validation<OfTime> validate() {
    final regex = RegExp(r'\d{2}:\d{2}');
    rule(conditional: !regex.hasMatch(value), message: 'Formato inválido');

    rule(
      conditional: int.parse(value.split(':').last) > 59,
      message: 'Tempo inválido',
    );

    return result<OfTime>(this);
  }
}
