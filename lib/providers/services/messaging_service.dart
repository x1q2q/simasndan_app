import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'general_service.dart';

class MessagingService {
  late final Box box = Hive.box('user');
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

    fcmToken = await _fcm.getToken();

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null && box.get('id') != null) {
        final notificationData = message.data;
        final screen = notificationData['screen'];

        notificationData.containsKey('screen');
        GeneralService().showNotifTitle(
            message.notification!.title!, message.notification!.body!);
      }
    });

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        _handleNotificationClick(context, message);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleNotificationClick(context, message);
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
