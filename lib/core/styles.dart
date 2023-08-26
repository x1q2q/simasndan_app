import 'package:flutter/material.dart';
import 'ui_helper.dart';

class Styles {
  static const btnTxtStyle = TextStyle(
      fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 18);
  static const labelTxtStyle = TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      color: greenv1,
      fontSize: 16);

  static const labelTxtStyle2 = TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      color: orangev3,
      fontSize: 16);

  static const titleBarStyle = TextStyle(
      fontFamily: 'Poppins', fontWeight: FontWeight.bold, color: orangev3);

  static const filterStyle = TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.normal,
      color: orangev3,
      fontSize: 12);

  static const badgeStyle = TextStyle(
      fontWeight: FontWeight.normal, color: Colors.white, fontSize: 11);
  static final ButtonStyle elevBtnStyle = ElevatedButton.styleFrom(
      elevation: 0.5,
      backgroundColor: greenv3,
      minimumSize: const Size(110, 55),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      foregroundColor: greyv1,
      textStyle: btnTxtStyle);

  static final ButtonStyle outlineBtnStyle = OutlinedButton.styleFrom(
      elevation: 0,
      backgroundColor: orangev1,
      foregroundColor: orangev3,
      minimumSize: const Size(110, 55),
      side: const BorderSide(color: orangev3, width: 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: btnTxtStyle);

  static const headStyle = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: orangev3);

  static const boxCardShdStyle = BoxShadow(
      offset: Offset(0, 0),
      blurRadius: 7,
      spreadRadius: 1,
      color: Colors.black12);
  static const whiteStyle = TextStyle(
      fontSize: 15,
      color: Colors.white,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.bold);

  static const bodyStyle = TextStyle(
      fontFamily: 'Poppins', fontSize: 19, fontWeight: FontWeight.w600);

  static const smallStyle = TextStyle(
      fontFamily: 'Poppins', fontSize: 14, fontWeight: FontWeight.w500);
  static const verySmallStyle = TextStyle(
      fontFamily: 'Poppins', fontSize: 10, fontWeight: FontWeight.w500);
}

// by rafiknurf