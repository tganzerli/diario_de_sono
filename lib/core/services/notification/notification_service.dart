/// An abstract interface for managing notifications.
abstract interface class NotificationService {
  /// Initializes the notification service.
  ///
  /// This method should be called before any other notification operations
  /// to set up necessary configurations and permissions.
  Future<void> init();

  /// Schedules a daily reminder notification.
  ///
  /// The notification will be scheduled to appear daily at the specified [hour] and [minute].
  ///
  /// - [id]: An optional unique identifier for the notification. If not provided, a random ID will be generated.
  /// - [hour]: The hour (0-23) at which the notification should appear. Defaults to 9 AM.
  /// - [minute]: The minute (0-59) at which the notification should appear. Defaults to 0 minutes.
  ///
  /// Returns the ID of the scheduled notification.
  Future<int> scheduleDailyReminderNotification({
    int? id,
    int hour = 9,
    int minute = 0,
  });

  /// Skips the daily reminder notification for the current day and reschedules it for the next day.
  ///
  /// This is useful when a user wants to temporarily disable a reminder for today
  /// but keep the daily schedule for subsequent days.
  ///
  /// - [id]: The ID of the notification to skip. If provided, the existing notification with this ID will be cancelled.
  /// - [hour]: The hour (0-23) at which the notification should appear on subsequent days. Defaults to 9 AM.
  /// - [minute]: The minute (0-59) at which the notification should appear on subsequent days. Defaults to 0 minutes.
  ///
  /// Returns the ID of the newly scheduled notification for the next day.
  Future<int> skipThisDay({int? id, int hour = 9, int minute = 0});

  /// Updates an existing scheduled notification.
  ///
  /// This method cancels the existing notification with the given [id]
  /// and schedules a new one with the updated [hour] and [minute].
  ///
  /// - [id]: The unique identifier of the notification to update.
  /// - [hour]: The new hour (0-23) for the notification.
  /// - [minute]: The new minute (0-59) for the notification.
  Future<int> updateNotification({
    required int id,
    required int hour,
    required int minute,
  });

  /// Cancels a scheduled notification.
  ///
  /// - [id]: The unique identifier of the notification to cancel.
  Future<void> cancelNotification(int id);
}
