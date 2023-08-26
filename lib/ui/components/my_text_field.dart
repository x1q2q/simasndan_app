import 'package:flutter/material.dart';
import '../../core/ui_helper.dart';

class MyTextField extends StatefulWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final Icon? icon;
  MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.icon,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool _isHidden = true;
  void togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: widget.controller,
        obscureText: widget.obscureText ? _isHidden : widget.obscureText,
        cursorColor: greenv3,
        decoration: InputDecoration(
          hintText: widget.hintText,
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
          suffixIcon: widget.obscureText
              ? IconButton(
                  icon: Icon(
                    _isHidden ? Icons.visibility_off : Icons.visibility,
                    color: lightv2,
                  ),
                  onPressed: togglePasswordView,
                )
              : widget.icon,
          suffixIconColor: lightv2,
          filled: true,
        ));
  }
}
