import 'package:flutter/material.dart';
import 'package:flutter_app/constants/common_size.dart';

InputDecoration textInputDeco(String hint) {
  return InputDecoration(
      hintText: hint,
      enabledBorder: activeInputBorder(),
      errorBorder:  errorInputBorder(),
      focusedBorder:  activeInputBorder(),
      focusedErrorBorder: errorInputBorder(),
      filled: true,
      fillColor: Colors.grey[100]
  );
}

OutlineInputBorder errorInputBorder() {
  return OutlineInputBorder(
      borderSide: BorderSide(
          color : Colors.redAccent
      ),
      borderRadius: BorderRadius.circular(common_b_radius)
  );
}

OutlineInputBorder activeInputBorder() {
  return OutlineInputBorder(
      borderSide: BorderSide(
          color : Colors.grey[300]
      ),
      borderRadius: BorderRadius.circular(common_b_radius)
  );
}