import 'package:cloud_firestore/cloud_firestore.dart';
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

class HistoryOfOrders extends StatelessWidget {
  SingleOrderController orderController = Get.put(SingleOrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homePagebg,
      appBar: AppBar(
        title: Text(''),
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
            return snapshot.data!.docs.length != 0
                ? GroupedListView(
                    elements: snapshot.data!.docs,
                    groupBy: (element) => element['items']['when'],
                    groupSeparatorBuilder: (String groupByValue) => Visibility(
                      visible: false,
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Text(DateFormat('d MMM HH:mm')
                            .format(DateTime.parse(groupByValue))),
                      ),
                    ),
                    itemComparator: (item1, item2) => item1['items']['when']
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
                              GetStorage().read('userId').toString()
                          ? Container(
                              margin: EdgeInsets.all(8),
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: CupertinoColors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: CupertinoColors.systemGrey3)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Item(
                                    title: '${'company'.tr.capitalizeFirst}:',
                                    value: element['items']['companyId'],
                                  ),
                                  Item(
                                    title:
                                        '${'company_phone'.tr.capitalizeFirst}:',
                                    value: element['items']['companyPhone'],
                                  ),
                                  Item(
                                    title:
                                        '${'delivery_day'.tr.capitalizeFirst}:',
                                    value: element['items']['day'],
                                  ),
                                  Item(
                                    title: '${'quantity'.tr.capitalizeFirst}:',
                                    value: element['items']['count'].toString(),
                                  ),
                                  Item(
                                    title: '${'bonus'.tr.capitalizeFirst}:',
                                    value: element['items']['bonus'].toString(),
                                  ),
                                  Item(
                                    title:
                                        '${'delivery_time'.tr.capitalizeFirst} :',
                                    value: element['items']['from'] +
                                        " dan " +
                                        element['items']['to'] +
                                        " gacha ",
                                  ),
                                  Item(
                                    title:
                                        '${'delivery_place'.tr.capitalizeFirst}:',
                                    value: element['items']['where'],
                                  ),
                                  Item(
                                    title: '${'status'.tr.capitalizeFirst}:',
                                    value: "_${element['items']['status']}".tr,
                                    color: Utils.getColor(
                                        element['items']['status']),
                                  ),
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
                                              "Buyurtma allaqachon yo'lga chiqdi !",
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