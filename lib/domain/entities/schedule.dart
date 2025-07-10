class Schedule {
  final int id;
  final int hour;
  final int minute;

  Schedule({required this.id, required this.hour, required this.minute});

  Schedule copyWith({int? id, int? hour, int? minute}) {
    return Schedule(
      id: id ?? this.id,
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
    );
  }
}
