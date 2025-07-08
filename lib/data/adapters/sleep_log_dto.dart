import '../../domain/dto/sleep_log_dto.dart';

class SleepLogDtoAdapter {
  static Map<String, dynamic> toMap(SleepLogDto dto) {
    return {
      'date': dto.day.millisecondsSinceEpoch,
      'bedtime': dto.bedtime.toString(),
      'sleep_latency': dto.sleepLatency.toString(),
      'sleep_duration': dto.sleepDuration.toString(),
      'awakenings_count': dto.awakeningsCount,
      'is_sent': 0,
    };
  }
}
