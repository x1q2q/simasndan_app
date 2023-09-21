import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'fcm_provider.dart';
// import 'package:timezone/data/latest_all.dart' as timezone;
// import 'package:timezone/timezone.dart' as timezone;

class NotificationService {
  static final _notification = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    await _notification.initialize(
        const InitializationSettings(
          android: AndroidInitializationSettings('app_icon'),
          iOS: DarwinInitializationSettings(),
        ),
        onDidReceiveNotificationResponse: FCMProvider.onTapNotification,
        onDidReceiveBackgroundNotificationResponse:
            FCMProvider.onTapNotification);
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

  Future<void> pushNotification(RemoteMessage message, bool isImportant) async {
    Map<String, dynamic> data = message.data;
    String judul = data["title"];
    String pesan = data["body"];
    String screen = data["screen"];

    String channelID =
        isImportant ? 'high_importance_channel' : 'low_importance_channel';
    String channelDesc = isImportant
        ? 'High Importance Notifications'
        : 'Low Importance Notifications';
    Importance importanceStatus = isImportant ? Importance.max : Importance.min;
    Priority priorityStatus = isImportant ? Priority.high : Priority.low;

    final int idNotification = data["id"] != null ? int.parse(data["id"]) : 1;
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        channelID, channelDesc,
        channelDescription: 'Simasndan Apps Notification',
        importance: importanceStatus,
        playSound: isImportant,
        priority: priorityStatus,
        ticker: 'ticker',
        fullScreenIntent: isImportant,
        color: Colors.green,
        enableLights: true,
        ledColor: Colors.orange,
        ledOnMs: 1000,
        ledOffMs: 500,
        visibility: NotificationVisibility.public);
    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    await _notification.show(
        idNotification, judul, pesan, platformChannelSpecifics,
        payload: screen);
  }
}
