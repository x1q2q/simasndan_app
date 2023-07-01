import 'package:flutter/material.dart';
import '../../core/styles.dart';

class BaseAlert extends StatelessWidget {
  final Color bgColor;
  final String title;
  final String msg;
  final void Function()? onTap;
  const BaseAlert(
      {Key? key,
      required this.bgColor,
      required this.title,
      this.msg = '',
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: bgColor,
        title: Container(
            padding: const EdgeInsets.only(bottom: 15),
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 0.4, color: Colors.white))),
            child: Text(title, style: Styles.bodyStyle)),
        content: Text(msg, style: Styles.smallStyle),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        actions: <Widget>[
          TextButton(
            child: Text(
              'OK',
              style: TextStyle(fontFamily: 'Poppins', color: Colors.white),
            ),
            onPressed: onTap,
          ),
        ]);
  }
}

// by rafiknurf