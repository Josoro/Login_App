import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration authInputDecoration(
      {required String hintText,
      required String labelStyle,
      IconData? prefixIcon}) {
    return InputDecoration(
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black12)),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black12),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.black,
        ),
        labelText: labelStyle,
        labelStyle: const TextStyle(
            color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: Colors.black12)
            : null);
  }
}
