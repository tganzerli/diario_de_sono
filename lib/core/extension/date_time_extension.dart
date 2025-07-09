extension DateTimeExtension on DateTime {
  DateTime get startOfDay {
    return DateTime(year, month, day);
  }

  DateTime dayBefore(int days) {
    return startOfDay.subtract(Duration(days: days));
  }

  String getFormattedDate() {
    return '${day}_${month}_$year';
  }
}
