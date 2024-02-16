import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/constants/theme.dart';
import '../../custom_widgets/gradient_button.dart';

class OrderHistoryOfCourier extends StatelessWidget {

  GetStorage box=GetStorage();
  
  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homePagebg,
      body: StreamBuilder(
        stream:
        FirebaseFirestore.instance.collection(box.read('courierId')).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          // If data is available
          if (snapshot.hasData) {
            return snapshot.data!.docs.length != 0
                ? ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                // Get document data
                var doc = snapshot.data!.docs[index];
                // You can access individual fields like doc['field_name']
                return Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: CupertinoColors.white,
                      borderRadius: BorderRadius.circular(12),
                      border:
                      Border.all(color: CupertinoColors.systemGrey3)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Item(
                        title: '${'phone'.tr.capitalizeFirst}:',
                        value: doc['items']['items']['phone'],
                      ),
                      Item(
                        title: '${'delivery_day'.tr.capitalizeFirst}:',
                        value: doc['items']['items']['day'],
                      ),
                      Item(
                        title: '${'quantity'.tr.capitalizeFirst!}:',
                        value: doc['items']['items']['count'].toString(),
                      ),
                      Item(
                        title: '${'delivery_time'.tr.capitalizeFirst} :',
                        value: doc['items']['items']['from'] +
                            " dan " +
                            doc['items']['items']['to'] +
                            " gacha ",
                      ),
                      Item(
                        title: '${'delivery_place'.tr.capitalizeFirst}:',
                        value: doc['items']['items']['where'],
                      ),
                      CustomButton(text: doc['items']['items']['status'],color: Color(
                          0xff24be66),)

                    ],
                  ),
                );
              },
            )
                : Center(
              child: Container(
                  width: Get.width/2,
                  child: Image.asset('assets/images/history/empty.png')),
            );
          }
          // If no data available

          else {
            return Text('No data'); // No data available
          }
        },
      ),
    );
  }
}

class Item extends StatelessWidget {
  final String title;
  final String value;

  Item({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${title}',
          style:
          TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
        Text("${value}"),
        SizedBox(
          height: 8,
        )
      ],
    );
  }
}