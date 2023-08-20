import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class MessagingService {
  static String? fcmToken;
  static final MessagingService _instance = MessagingService._internal();
  factory MessagingService() => _instance;

  MessagingService._internal();
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future<String?> getDeviceToken() async => await _fcm.getToken();

  Future<void> init(BuildContext context) async {
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    debugPrint(
        'User granted notifications permission: ${settings.authorizationStatus}');

    fcmToken = await _fcm.getToken();

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // debugPrint('Got a message whilst in the foreground!');
      // debugPrint('Message data: ${message.notification!.title.toString()}');

      if (message.notification != null) {
        final notificationData = message.data;
        final screen = notificationData['screen'];

        // notificationData.containsKey('screen');
        showSimpleNotification(
            Text(message.notification!.title!,
                style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    color: Colors.black45,
                    fontWeight: FontWeight.bold)),
            leading: const Icon(Icons.notifications_active,
                size: 35, color: Colors.cyan),
            subtitle: Text(message.notification!.body!,
                style: const TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.black45,
                    fontSize: 13)),
            background: Colors.cyanAccent[100],
            duration: const Duration(seconds: 5),
            slideDismissDirection: DismissDirection.horizontal,
            elevation: 2);
      }
    });

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        _handleNotificationClick(context, message);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // debugPrint(
      //     'onMessageOpenedApp: ${message.notification!.title.toString()}');
      // _handleNotificationClick(context, message);
    });
  }

  void _handleNotificationClick(BuildContext context, RemoteMessage message) {
    final notificationData = message.data;

    if (notificationData.containsKey('screen')) {
      final screen = notificationData['screen'];
      Navigator.of(context).pushNamed(screen);
    }
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // debugPrint('Handling a background message: ${message.notification!.title}');
}
