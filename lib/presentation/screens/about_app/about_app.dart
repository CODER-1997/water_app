import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("about_app".tr),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        color: Colors.white,
        child: Text(
            "This is an just app that helps people to get deliveried water"),
      ),
    );
  }
}
