import 'package:permission_handler/permission_handler.dart';
import 'package:bot_toast/bot_toast.dart';
import '../../core/ui_helper.dart';
import 'package:flutter/material.dart';

class GeneralService {
  showNotif(bool isSuccess, String body) async {
    return BotToast.showNotification(
        margin: const EdgeInsets.all(10),
        title: (_) => Text(isSuccess ? "Success" : "Error",
            style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 17,
                color: Colors.black54,
                fontWeight: FontWeight.bold)),
        subtitle: (_) => Text(body,
            style: const TextStyle(
                fontFamily: 'Poppins', color: Colors.black45, fontSize: 14)),
        trailing: (cancel) => IconButton(
              icon: const Icon(Icons.cancel, color: Colors.black45),
              onPressed: cancel,
            ),
        backgroundColor: isSuccess ? lightv2 : Colors.redAccent[100],
        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        onlyOne: true,
        duration: const Duration(seconds: 10));
  }

  showNotifTitle(String title, String body) async {
    return BotToast.showNotification(
        margin: const EdgeInsets.all(10),
        leading: (cancel) => SizedBox.fromSize(
            size: const Size(60, 60),
            child: IconButton(
              icon: const Icon(Icons.notifications_active,
                  size: 40, color: Colors.teal),
              onPressed: cancel,
            )),
        title: (_) => Text(title,
            style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 17,
                color: Colors.black45,
                fontWeight: FontWeight.bold)),
        subtitle: (_) => Text(body,
            style: const TextStyle(
                fontFamily: 'Poppins', color: Colors.black45, fontSize: 14)),
        trailing: (cancel) => IconButton(
              icon: const Icon(
                Icons.cancel,
                color: Colors.teal,
              ),
              onPressed: cancel,
            ),
        onTap: () {
          BotToast.showText(text: title);
        },
        onLongPress: () {
          BotToast.showText(text: body);
        },
        backgroundColor: Colors.tealAccent[100],
        enableSlideOff: true,
        backButtonBehavior: BackButtonBehavior.close,
        crossPage: true,
        contentPadding: EdgeInsets.all(3),
        onlyOne: true,
        animationDuration: Duration(milliseconds: 200),
        animationReverseDuration: Duration(milliseconds: 200),
        duration: const Duration(seconds: 10));
  }

  Future<bool> checkPermission(String tipe) async {
    Permission permission =
        (tipe == 'lokasi') ? Permission.location : Permission.notification;
    final status = await permission.request();
    if (!status.isGranted) {
      showNotif(false, "User tidak memberikan ijin akses $tipe");
      return false;
    }
    return true;
  }

  bool checkisNoValidImage(dynamic foto) {
    return (foto == null || foto == '-' || foto == '');
  }
}
