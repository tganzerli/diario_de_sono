import 'package:diario_de_sono/core/value_object/of_time_vo.dart';

import '../../core/services/services.dart';

class SleepLogDto extends ValidationService {
  final DateTime day;
  final OfTime? bedtime;
  final OfTime? sleepLatency;
  final OfTime? sleepDuration;
  final int? awakeningsCount;

  SleepLogDto._({
    required this.day,
    this.bedtime,
    this.sleepLatency,
    this.sleepDuration,
    this.awakeningsCount,
  });

  factory SleepLogDto() => SleepLogDto._(day: DateTime.now());

  SleepLogDto setBedtime(OfTime? value) {
    return SleepLogDto._(
      day: day,
      bedtime: value,
      sleepLatency: sleepLatency,
      sleepDuration: sleepDuration,
      awakeningsCount: awakeningsCount,
    );
  }

  SleepLogDto setSleepLatency(OfTime? value) {
    return SleepLogDto._(
      day: day,
      bedtime: bedtime,
      sleepLatency: value,
      sleepDuration: sleepDuration,
      awakeningsCount: awakeningsCount,
    );
  }

  SleepLogDto setSleepDuration(OfTime? value) {
    return SleepLogDto._(
      day: day,
      bedtime: bedtime,
      sleepLatency: sleepLatency,
      sleepDuration: value,
      awakeningsCount: awakeningsCount,
    );
  }

  SleepLogDto setAwakeningsCount(int? value) {
    return SleepLogDto._(
      day: day,
      bedtime: bedtime,
      sleepLatency: sleepLatency,
      sleepDuration: sleepDuration,
      awakeningsCount: value,
    );
  }

  bool bedtimeValidate() {
    if (bedtime == null) return false;
    return bedtime!.validate().isSuccess();
  }

  bool sleepLatencyValidate() {
    if (sleepLatency == null) return false;
    return sleepLatency!.validate().isSuccess();
  }

  bool sleepDurationValidate() {
    if (sleepDuration == null) return false;
    return sleepDuration!.validate().isSuccess();
  }

  bool awakeningsCountValidate() {
    return awakeningsCount != null;
  }

  Validation<SleepLogDto> validate() {
    rule(
      conditional:
          bedtime == null ||
          sleepLatency == null ||
          sleepDuration == null ||
          awakeningsCount == null,
      message: 'Campos não preenchidos.',
    );
    if (bedtime != null &&
        sleepLatency != null &&
        sleepDuration != null &&
        awakeningsCount != null) {
      add(bedtime!.validate());
      add(sleepLatency!.validate());
      add(sleepDuration!.validate());
      rule(
        conditional: awakeningsCount!.isNegative,
        message:
            'A quantinttidade de vezes que despertou não pode ser negativa.',
      );
    }

    return result<SleepLogDto>(this);
  }
}
