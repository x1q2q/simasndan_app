import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../ui/screens/notifikasi_screen.dart';
import '../../ui/screens/home_screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FCMProvider with ChangeNotifier {
  static BuildContext? _context;
  static void setContext(BuildContext context) =>
      FCMProvider._context = context;

  static void onTapNotification(NotificationResponse? response) async {
    late final Box box = Hive.box('user');
    if (FCMProvider._context == null || response!.payload == null) return;
    MaterialPageRoute? route;
    if (box.get('id') != null) {
      route = MaterialPageRoute(
          builder: (context) => NotifikasiScreen(
                idSantri: box.get('id'),
              ));
    } else {
      route = MaterialPageRoute(builder: (context) => const HomeScreen());
    }
    await Navigator.push(FCMProvider._context!, route);
  }
}
