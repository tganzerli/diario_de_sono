import 'package:diario_de_sono/core/value_object/of_time_vo.dart';

import '../../core/services/services.dart';

class SleepLogDto extends ValidationService {
  final DateTime day;
  final OfTime bedtime;
  final OfTime sleepLatency;
  final OfTime sleepDuration;
  final int awakeningsCount;

  SleepLogDto({
    required this.bedtime,
    required this.sleepLatency,
    required this.sleepDuration,
    required this.awakeningsCount,
  }) : day = DateTime.now();

  Validation<SleepLogDto> validate() {
    add(bedtime.validate());
    add(sleepLatency.validate());
    add(sleepDuration.validate());
    rule(
      conditional: awakeningsCount.isNegative,
      message: 'A quantinttidade de vezes que despertou não pode ser negativa.',
    );

    return result<SleepLogDto>(this);
  }
}
