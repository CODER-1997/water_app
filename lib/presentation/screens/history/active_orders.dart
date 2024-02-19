import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/data/constants/text_styles.dart';
import 'package:delivery/data/constants/theme.dart';
import 'package:delivery/domain/controllers/single_order_controller.dart';
import 'package:delivery/presentation/custom_widgets/gradient_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../../data/constants/utils.dart';

class ActiveOrders extends StatelessWidget {
  SingleOrderController orderController = Get.put(SingleOrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homePagebg,
      appBar: AppBar(
        title: Text('active_orders'.tr.capitalizeFirst!,style: appBarStyle,),
      ),
      body: StreamBuilder(
        stream:
        FirebaseFirestore.instance.collection('waterOrders').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          // If data is available
          if (snapshot.hasData) {
            return snapshot.data!.docs.where((element) => element['items']['status']=='new').length != 0
                ? GroupedListView(
              elements: snapshot.data!.docs,
              groupBy: (element) => element['items']['when'],
              groupSeparatorBuilder: (String groupByValue) =>
                  Visibility(
                    visible: false,
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Text(DateFormat('d MMM HH:mm')
                          .format(DateTime.parse(groupByValue))),
                    ),
                  ),
              itemComparator: (item1, item2) =>
                  item1['items']['when']
                      .compareTo(item2['items']['when']),
              // optional
              floatingHeader: true,
              // optional
              order: GroupedListOrder.DESC,
              // Get document data
              // var doc = snapshot.data!.docs[index];
              // You can access individual fields like doc['field_name']
              itemBuilder: (c, element) {
                return element['items']['customerId'] ==
                    GetStorage().read('userId').toString() && element['items']['status']=='new'
                    ? Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: CupertinoColors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.blueAccent,
                        width: 2,
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.cube,
                            color: Colors.blueAccent,
                          ),
                          SizedBox(width: 8,),
                          Text(
                            'ready_for_shipping'.tr.capitalizeFirst!,
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                      SizedBox(height: 16,),

                      Text(
                        "${DateFormat('d MMM').format(
                            DateTime.parse(element['items']['when']))} • "
                            "${element['items']['from']} - ${element['items']['to']}"
                            "",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w800),
                      ),
                      SizedBox(height: 16,),

                      Row(
                        children: [
                          Icon(Icons.location_pin,color: Colors.black38,size: 18,),
                          SizedBox(width: 4,),
                          Text("${element['items']['where']}".capitalizeFirst!,
                            style: TextStyle(
                                color: Colors.black38,
                                fontWeight: FontWeight.w800
                            ),),
                        ],
                      ),
                      SizedBox(height: 16,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Text('quantity'.tr.capitalizeFirst! + ": " +
                            "${element['items']['count']}", style: TextStyle(
                            color: Colors.black38,
                            fontWeight: FontWeight.w800
                        )),
                        Text(
                            "${element['items']['price']} so'm", style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800
                        ))
                      ],),
                      SizedBox(height: 16,),

                      // Item(
                      //   title: '${'company'.tr.capitalizeFirst}:',
                      //   value: element['items']['companyId'],
                      // ),
                      // Item(
                      //   title:
                      //       '${'company_phone'.tr.capitalizeFirst}:',
                      //   value: element['items']['companyPhone'],
                      // ),
                      // Item(
                      //   title:
                      //       '${'delivery_day'.tr.capitalizeFirst}:',
                      //   value: element['items']['day'],
                      // ),
                      // Item(
                      //   title: '${'quantity'.tr.capitalizeFirst}:',
                      //   value: element['items']['count'].toString(),
                      // ),
                      // Item(
                      //   title: '${'bonus'.tr.capitalizeFirst}:',
                      //   value: element['items']['bonus'].toString(),
                      // ),
                      // Item(
                      //   title:
                      //       '${'delivery_time'.tr.capitalizeFirst} :',
                      //   value: element['items']['from'] +
                      //       " dan " +
                      //       element['items']['to'] +
                      //       " gacha ",
                      // ),
                      // Item(
                      //   title:
                      //       '${'delivery_place'.tr.capitalizeFirst}:',
                      //   value: element['items']['where'],
                      // ),
                      // Item(
                      //   title: '${'status'.tr.capitalizeFirst}:',
                      //   value: "_${element['items']['status']}".tr,
                      //   color: Utils.getColor(
                      //       element['items']['status']),
                      // ),
                      Visibility(
                        visible: element['items']['status'] !=
                            'rejected',
                        child: GestureDetector(
                            onTap: () {
                              if (element['items']['status'] ==
                                  'new') {
                                orderController
                                    .cancelOrder(element.id);
                              } else {
                                Get.snackbar(
                                  "Xatolik",
                                  "already_accepted_order"
                                      .tr
                                      .capitalizeFirst!,
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                  snackPosition: SnackPosition.TOP,
                                );
                              }
                            },
                            child: CustomButton(
                              text: '_reject'.tr.capitalizeFirst!,
                              color: Colors.red,
                            )),
                      ),
                    ],
                  ),
                )
                    : SizedBox();
              },
            )
                : Center(
              child: Container(
                  width: Get.width / 2,
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
  final Color? color;

  Item({required this.title, required this.value, this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${title}',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
        Text(
          "${value}",
          style: TextStyle(
              color: color ?? Colors.black,
              fontWeight: color != null ? FontWeight.w800 : FontWeight.w500),
        ),
        SizedBox(
          height: 8,
        )
      ],
    );
  }
}
