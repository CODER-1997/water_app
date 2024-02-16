import 'package:flutter/material.dart';

import '../../data/constants/theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final bool? isLoading;
  final Color ? color;

  CustomButton({Key? key, required this.text, this.isLoading, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 52,
      decoration: ShapeDecoration(
        gradient: LinearGradient(
          begin: Alignment(-1.00, -0.00),
          end: Alignment(1, 0),
            colors: [color == null ? Color(0xFF2495FF):color!,
              color == null ?  Color(0xFF2B7FC9):color!],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        shadows: [
          // BoxShadow(
          //   color: Color(0xFFB3DAFF),
          //   blurRadius: 16,
          //   offset: Offset(0, 4),
          //   spreadRadius: 0,
          // )
        ],
      ),      child:isLoading!= true ? Text(
        text,
        style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14,
            fontFamily: "Manrope",
            color: Colors.white),
      ): Container(
      padding: EdgeInsets.all(4),
        child: CircularProgressIndicator(color: Colors.white,)),
    );
  }
}