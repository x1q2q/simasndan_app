import 'package:flutter/material.dart';
import '../../core/ui_helper.dart';

class MenuButton extends StatelessWidget {
  final String btnTxt;
  final IconData? iconBtn;
  final String typeBtn;
  final Function()? onTap;

  const MenuButton(
      {super.key,
      required this.btnTxt,
      this.iconBtn,
      required this.typeBtn,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    const menuTxt = TextStyle(
        fontFamily: 'Poppins',
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: orangev2);
    const menuBtn1 = BorderRadius.only(
        topLeft: Radius.circular(30), bottomLeft: Radius.circular(30));
    const menuBtn2 = BorderRadius.all(Radius.circular(0));
    const menuBtn3 = BorderRadius.only(
        topRight: Radius.circular(30), bottomRight: Radius.circular(30));

    return SizedBox.fromSize(
      child: Material(
          borderRadius: (typeBtn == 'btn1')
              ? menuBtn1
              : (typeBtn == 'btn2')
                  ? menuBtn2
                  : menuBtn3,
          child: InkWell(
            borderRadius: (typeBtn == 'btn1')
                ? menuBtn1
                : (typeBtn == 'btn2')
                    ? menuBtn2
                    : menuBtn3,
            splashColor: orangev1,
            focusColor: orangev1,
            onTap: onTap,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(iconBtn!, color: orangev2, size: 55),
                  Text(btnTxt, style: menuTxt)
                ]),
          )),
    );
  }
}
