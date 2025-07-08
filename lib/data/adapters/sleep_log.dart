import '../../core/value_object/value_object.dart';
import '../../domain/entities/sleep_log.dart';

class SleepLogAdapter {
  static SleepLog fromMap(Map<String, dynamic> map) {
    return SleepLog(
      id: map['id'],
      day: DateTime.fromMillisecondsSinceEpoch(map['date']),
      bedtime: OfTime.fromMap(map['bedtime']),
      sleepLatency: OfTime.fromMap(map['sleep_latency']),
      sleepDuration: OfTime.fromMap(map['sleep_duration']),
      awakeningsCount: map['awakenings_count'],
      isSent: map['is_sent'] == 1 ? true : false,
    );
  }
}
