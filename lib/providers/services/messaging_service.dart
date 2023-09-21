import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'general_service.dart';
import 'notification_service.dart';

class MessagingService {
  static final MessagingService _instance = MessagingService._internal();
  factory MessagingService() => _instance;

  MessagingService._internal();
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future<String?> getDeviceToken() async => await _fcm.getToken();

  Future<void> init(BuildContext context) async {
    await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      Map<String, dynamic> data = message.data;
      String judul = data["title"];
      String pesan = data["body"];

      GeneralService().showNotifTitle(judul, pesan);
      await NotificationService().pushNotification(message, false);
    });

    // FirebaseMessaging.instance.getInitialMessage().then((message) {
    //   if (message != null) {
    //     _handleNotificationClick(context, message);
    //   }
    // });

    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    //   if (message.data != null) {
    //     _handleNotificationClick(context, message);
    //   }
    // });
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await NotificationService().pushNotification(message, true);
}
