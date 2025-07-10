extension DateTimeExtension on DateTime {
  DateTime get startOfDay {
    return DateTime(year, month, day);
  }

  DateTime dayBefore(int days) {
    return startOfDay.subtract(Duration(days: days));
  }

  String getDay() {
    return toIso8601String().split('T').first;
  }

  String getFormattedDate() {
    return '${day}_${month}_$year';
  }

  bool sameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
