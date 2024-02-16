import 'package:flutter/material.dart';

import '../../data/constants/theme.dart';

InputDecoration buildInputDecoratione(String hintText) {
  return InputDecoration(
    border: OutlineInputBorder(),
    hintText: hintText,
    hintStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        fontFamily: "Manrope",
        color: Colors.black.withOpacity(.3)),
    focusColor: greenColor,
    fillColor: Color(0xFFfafafa),
    filled: true,
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Color(0xffE9E9E9))),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: greenColor, width: 2)),
  );
}