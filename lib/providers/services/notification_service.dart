import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:timezone/data/latest_all.dart' as timezone;
// import 'package:timezone/timezone.dart' as timezone;

class NotificationService {
  static final _notification = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    await _notification.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(),
      ),
    );
  }

  // static scheduleNotification() async {
  //   timezone.initializeTimeZones();
  //   var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
  //     'channel id',
  //     'channel name',
  //     channelDescription: 'channel description',
  //     importance: Importance.max,
  //     priority: Priority.high,
  //   );
  //   var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
  //   var platformChannelSpecifics = NotificationDetails(
  //     android: androidPlatformChannelSpecifics,
  //     iOS: iOSPlatformChannelSpecifics,
  //   );
  //   await _notification.zonedSchedule(
  //       1,
  //       "notification title",
  //       'Message goes here',
  //       timezone.TZDateTime.now(timezone.local)
  //           .add(const Duration(seconds: 10)),
  //       platformChannelSpecifics,
  //       uiLocalNotificationDateInterpretation:
  //           UILocalNotificationDateInterpretation.absoluteTime);
  // }

  Future<void> pushNotification(RemoteMessage message) async {
    Map<String, dynamic> data = message.data;
    String judul = data["title"];
    String pesan = data["body"];

    final int idNotification = data["id"] != null ? int.parse(data["id"]) : 1;
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      channelDescription: 'channel description',
      importance: Importance.max,
      priority: Priority.high,
    );
    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    await _notification.show(
        idNotification, judul, pesan, platformChannelSpecifics);
  }
}
