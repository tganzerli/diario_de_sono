import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'notification_service.dart';

class FlutterLocalNotifications implements NotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  FlutterLocalNotifications(this._flutterLocalNotificationsPlugin);

  @override
  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIos =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );

    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIos,
        );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
    tz.initializeTimeZones();
  }

  @override
  Future<int> scheduleDailyReminderNotification({
    int? id,
    int hour = 9,
    int minute = 0,
  }) async {
    if (hour.isNegative || hour >= 24 || minute.isNegative || minute >= 60) {
      throw Exception('Invalid time');
    }
    final scheduledDate = _nextInstance(hour, minute);

    return await _scheduleDaily(id: id, scheduledDate: scheduledDate);
  }

  @override
  Future<int> skipThisDay({int? id, int hour = 9, int minute = 0}) async {
    if (id != null) {
      await _flutterLocalNotificationsPlugin.cancel(id);
    }
    final scheduledDate = _nextInstance(hour, minute, true);

    return await _scheduleDaily(id: id, scheduledDate: scheduledDate);
  }

  @override
  Future<void> cancelNotification(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<int> _scheduleDaily({
    int? id,
    required tz.TZDateTime scheduledDate,
  }) async {
    final String title = 'Registro Diário de Sono';
    final String body = 'Você já realizou seu registro hoje? Não se esqueça!';

    final int scheduledId = id ?? Random().nextInt(1000);

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      scheduledId,
      title,
      body,
      scheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_sleep_log_reminder_channel_id',
          'Lembretes Registro Diário de Sono',
          channelDescription: 'Canal para lembretes diários importantes.',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );

    return scheduledId;
  }

  tz.TZDateTime _nextInstance(
    int hour,
    int minute, [
    bool skipThisDay = false,
  ]) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    if (scheduledDate.isBefore(now) || skipThisDay) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
}
