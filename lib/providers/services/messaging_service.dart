import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '../../ui/screens/notifikasi_screen.dart';
import 'general_service.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'notification_service.dart';

class MessagingService {
  static String? fcmToken;
  late final Box box = Hive.box('user');

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
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (message.data != null) {
        Map<String, dynamic> data = message.data;
        String judul = data["title"];
        String pesan = data["body"];
        final screen = data['screen'];

        data.containsKey('screen');
        GeneralService().showNotifTitle(judul, pesan);
      }
      // await NotificationService().pushNotification(message);
    });

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        _handleNotificationClick(context, message);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      if (message.data != null) {
        _handleNotificationClick(context, message);
      }
    });
  }

  void _handleNotificationClick(BuildContext context, RemoteMessage message) {
    Map<String, dynamic> data = message.data;
    final screen = data['screen'];
    if (data.containsKey('screen')) {
      if (screen == '/notifikasi-screen') {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NotifikasiScreen(
                      idSantri: box.get('id'),
                    )));
      }
    }
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await NotificationService().pushNotification(message);
}
