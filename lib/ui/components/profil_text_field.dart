import 'package:flutter/material.dart';
import '../../core/ui_helper.dart';
import 'package:intl/intl.dart';

class ProfilTextField extends StatefulWidget {
  final controller;
  final String hintText;
  final bool? textArea;
  final bool? inputDate;

  const ProfilTextField(
      {super.key,
      this.controller,
      required this.hintText,
      this.textArea,
      this.inputDate});

  @override
  State<ProfilTextField> createState() => _ProfilTextFieldState();
}

class _ProfilTextFieldState extends State<ProfilTextField> {
  static const hintTxt = TextStyle(
    fontFamily: 'Poppins',
    color: greenv2,
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: false,
      cursorColor: greenv1,
      style: hintTxt,
      maxLines: (widget.textArea == true) ? 4 : 1,
      readOnly: (widget.inputDate == true) ? true : false,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: lightv1)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: lightv1)),
        hintText: widget.hintText,
        focusColor: lightv2,
        hoverColor: lightv2,
        fillColor: lightv1,
        contentPadding: const EdgeInsets.all(10),
        hintStyle: hintTxt,
        filled: true,
      ),
      onTap: (widget.inputDate == false)
          ? null
          : () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: (widget.controller.text == '')
                      ? DateTime.now()
                      : DateTime.parse(widget.controller.text),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2101));

              if (pickedDate != null) {
                String formattedDate =
                    DateFormat('dd MMMM yyyy').format(pickedDate);
                setState(() {
                  widget.controller.text = formattedDate;
                });
              } else {}
            },
    );
  }
}
