import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CustomBottomSheet extends StatelessWidget {

  final String title;
  CustomBottomSheet({required this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      constraints: BoxConstraints.expand(height: Get.height), // Set full height
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.lightBlueAccent],
          // Customize gradient colors
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                  ))
            ],
          ),
          Container(
            width: 233,
              child: Image.asset('assets/images/order_card/img_2.png')),
          Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
