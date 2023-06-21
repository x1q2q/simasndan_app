import 'package:flutter/material.dart';
import '../../core/styles.dart';
import '../../core/ui_helper.dart';

class MyButton extends StatelessWidget {
  final String btnText;
  final String type;
  final Function()? onTap;
  final IconData? icon;
  const MyButton({
    Key? key,
    required this.btnText,
    required this.type,
    this.onTap,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget btn = (type == 'elevicon')
        ? ElevatedButton.icon(
            icon: Icon(icon, color: lightv1),
            onPressed: onTap,
            style: Styles.elevBtnStyle,
            label: Text(btnText))
        : (type == 'outline')
            ? OutlinedButton(
                onPressed: onTap,
                style: Styles.outlineBtnStyle,
                child: Text(btnText))
            : (type == 'outlineicon')
                ? OutlinedButton.icon(
                    icon: Icon(icon, color: orangev3),
                    onPressed: onTap,
                    style: Styles.outlineBtnStyle,
                    label: Text(btnText))
                : ElevatedButton(
                    style: Styles.elevBtnStyle,
                    onPressed: onTap,
                    child: Text(btnText));
    return btn;
  }
}
