import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportCenter extends StatelessWidget {
  const SupportCenter({super.key});
  _launchDialer(String phoneNumber) async {
    String url = 'tel:$phoneNumber';
    if (await canLaunchUrl(Uri.parse(phoneNumber))) {
      await launchUrl(Uri.parse(phoneNumber));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe8e8e8),
      appBar: AppBar(
        title: Text("help".tr.capitalizeFirst!),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(children: [
          InkWell(
            onTap: (){
              _launchDialer('+998 88 531 22 22');
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12)
              ),
              child: ListTile(
                leading: Icon(Icons.phone),
                iconColor: Colors.green,
                title: Text("+998 88 531 22 22"),
              ),
            ),
          )
        ],),
      ),
    );
  }
}
