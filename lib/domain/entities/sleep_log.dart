import '../../core/value_object/value_object.dart';

class SleepLog {
  final int id;
  final DateTime day;
  final OfTime bedtime;
  final OfTime sleepLatency;
  final OfTime sleepDuration;
  final int awakeningsCount;
  final bool isSent;

  SleepLog({
    required this.id,
    required this.day,
    required this.bedtime,
    required this.sleepLatency,
    required this.sleepDuration,
    required this.awakeningsCount,
    required this.isSent,
  });
}
