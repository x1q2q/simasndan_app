import 'package:flutter/material.dart';
import '../../core/ui_helper.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final Icon icon;

  const MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      cursorColor: greenv3,
      decoration: InputDecoration(
        hintText: hintText,
        hoverColor: Colors.white,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
        hintStyle:
            const TextStyle(fontFamily: 'Poppins', color: Colors.black12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: greenv1),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: greenv1)),
        suffixIcon: icon,
        suffixIconColor: lightv2,
        filled: true,
      ),
    );
  }
}
