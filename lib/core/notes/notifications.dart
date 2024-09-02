import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class Noti {
  // Inisialisasi plugin notifikasi lokal
  static Future<void> initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid = const AndroidInitializationSettings(
        'mitmap/ic_launcher'); // Icon notifikasi
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin
        .initialize(initializationSettings); // Inisialisasi plugin
  }

  // Menampilkan notifikasi terjadwal
  static Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
    required FlutterLocalNotificationsPlugin fln,
  }) async {
    tz.initializeTimeZones(); // Inisialisasi zona waktu

    // Pengaturan notifikasi untuk platform Android
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'todo_app_notification_channel',
      'todo_app_notification',
      importance: Importance.max,
      priority: Priority.high,
    );

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    var currentTimeZone = tz.local; // Mendapatkan zona waktu lokal

    // Mengonversi waktu yang dijadwalkan menjadi TZDateTime
    var scheduledDateTime = tz.TZDateTime.from(scheduledTime, currentTimeZone);

    // Mengatur waktu pengingat dengan interval yang berbeda
    final interval70 = scheduledDateTime.subtract(const Duration(minutes: 70));
    final interval80 = scheduledDateTime.subtract(const Duration(minutes: 80));
    final interval90 = scheduledDateTime.subtract(const Duration(minutes: 90));

    // Menjadwalkan notifikasi pada interval yang ditentukan
    await fln.zonedSchedule(
      id,
      title,
      body,
      interval70,
      platformChannelSpecifics,
      // androidAllowWhileIdle: true,
      // karna deprecated jadi ganti ke androidscheduleMode
      androidScheduleMode: AndroidScheduleMode
          .exactAllowWhileIdle, // Mengizinkan notifikasi saat idle
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: 'notification_payload',
    );

    await fln.zonedSchedule(
      id + 1,
      title,
      body,
      interval80,
      platformChannelSpecifics,
      // androidAllowWhileIdle: true,
      // karna deprecated jadi ganti ke androidscheduleMode
      androidScheduleMode: AndroidScheduleMode
          .exactAllowWhileIdle, // Mengizinkan notifikasi saat idle
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: 'notification_payload',
    );

    await fln.zonedSchedule(
      id + 2,
      title,
      body,
      interval90,
      platformChannelSpecifics,
      // androidAllowWhileIdle: true,
      // karna deprecated jadi ganti ke androidscheduleMode
      androidScheduleMode: AndroidScheduleMode
          .exactAllowWhileIdle, // Mengizinkan notifikasi saat idle
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: 'notification_payload',
    );

    await fln.zonedSchedule(
      id + 3,
      title,
      body,
      scheduledDateTime,
      platformChannelSpecifics,
      // androidAllowWhileIdle: true,
      // karna deprecated jadi ganti ke androidscheduleMode
      androidScheduleMode: AndroidScheduleMode
          .exactAllowWhileIdle, // Mengizinkan notifikasi saat idle
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: 'notification_payload',
    );
  }
}
