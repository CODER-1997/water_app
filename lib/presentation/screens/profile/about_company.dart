import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutCompany extends StatelessWidget {
  const AboutCompany({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("about_company".tr.capitalizeFirst!),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Text(
            "Navoiy shahridagi aholiga oziq ovqat mahsulotlarini yetkazib beruvchiloyiha"),
      ),
    );
  }
}
