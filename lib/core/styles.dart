import 'package:flutter/material.dart';
import 'ui_helper.dart';

class Styles {
  static const btnTxtStyle = TextStyle(
      fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 18);
  static const labelTxtStyle = TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      color: Color.fromARGB(255, 21, 185, 96),
      fontSize: 16);
  static const titleBarStyle = TextStyle(
      fontFamily: 'Poppins', fontWeight: FontWeight.bold, color: orangev3);
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

  static const bodyStyle = TextStyle(
      fontFamily: 'Poppins', fontSize: 19, fontWeight: FontWeight.w600);

  static const smallStyle = TextStyle(
      fontFamily: 'Poppins', fontSize: 14, fontWeight: FontWeight.w500);
  static const verySmallStyle = TextStyle(
      fontFamily: 'Poppins', fontSize: 11, fontWeight: FontWeight.w500);
}

// by rafiknurf