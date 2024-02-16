import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/constants/theme.dart';

class DisabledButton extends StatelessWidget {
  final String text;
 DisabledButton({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return       Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 52,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: unselectedColor
      ),
      child: Text(text, style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 14,
          fontFamily: "Manrope",
          color: Colors.white) ,),);
  }
}