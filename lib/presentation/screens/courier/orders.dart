import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/domain/controllers/courier_controller.dart';
import 'package:delivery/domain/controllers/single_order_controller.dart';
import 'package:delivery/presentation/custom_widgets/custom_shimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../../data/constants/theme.dart';
import '../../../data/constants/utils.dart';
import '../../custom_widgets/gradient_button.dart';
import '../history/history_of_orders.dart';

class OrdersOfCourier extends StatelessWidget {
  SingleOrderController orderController = Get.put(SingleOrderController());
  CourierController courierController = Get.put(CourierController());
  GetStorage box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: homePagebg,
          body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('waterOrders')
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SingleChildScrollView(child: CustomShimmer());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              // If data is available
              if (snapshot.hasData) {
                var list = snapshot.data!.docs
                    .where((element) =>
                        element['items']['status'] == 'new' &&
                        (element['items']['companyId'].replaceAll(" ", '').toString().toLowerCase() ==
                            box.read('companyId').replaceAll(" ", '').toString().toLowerCase())


                )
                    .toList();

                print(list);
                return list.length != 0
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
                        itemComparator: (item1, item2) => item1['items']['when']
                            .compareTo(item2['items']['when']),
                        // optional
                        floatingHeader: true,
                        // optional
                        order: GroupedListOrder.DESC,
                        itemBuilder: (c, element) {
                          return element['items']['companyId']
                                          .replaceAll(" ", '').toString().toLowerCase() ==
                                      box
                                          .read('companyId')
                                          .replaceAll(" ", '').toString().toLowerCase() &&
                                  element['items']['status'] == 'new'
                              ? Container(
                                  margin: EdgeInsets.all(8),
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                      color: CupertinoColors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          color: CupertinoColors.systemGrey3)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Item(
                                        title: '${'phone'.tr.capitalizeFirst}:',
                                        value: element['items']['phone'],
                                      ),
                                      Item(
                                        title:
                                            '${'delivery_day'.tr.capitalizeFirst} :',
                                        value: element['items']['day'],
                                      ),
                                      Item(
                                        title:
                                            '${'quantity'.tr.capitalizeFirst}:',
                                        value: element['items']['count']
                                            .toString(),
                                      ),
                                      Item(
                                        title: '${'bonuses'.tr.capitalizeFirst}:',
                                        value: element['items']['bonus']
                                            .toString(),
                                      ),
                                      Item(
                                        title:
                                            '${'delivery_time'.tr.capitalizeFirst!} :',
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
                                        value: element['items']['status'],
                                        color: Utils.getColor(
                                            element['items']['status']),
                                      ),
                                      element['items']['status'] =='new'
                                          ? GestureDetector(
                                              onTap: () {
                                                print(element.id);
                      if (element['items']['status'] =='new') {
                                                  orderController
                                                      .acceptOrder(element.id);
                                                  // courierController.addHistory(
                                                  //     box.read('courierId'),
                                                  //     element.id);
                                                } else if (element['items']
                                                        ['status'] ==
                                                    'accepted') {
                                                  orderController
                                                      .finishOrder(element.id);
                                                  courierController.addHistory(
                                                      box.read('courierId'),
                                                      element.id);
                                                }
                                              },
                                              child: CustomButton(
                                                text: element['items']
                                                            ['status'] ==
                                                        'new'
                                                    ? '_accept'
                                                        .tr
                                                        .capitalizeFirst!
                                                    : element['items']
                                                        ['status'],
                                                color: Utils.getColor(
                                                    element['items']['status']),
                                              ),
                                            )
                                          : SizedBox()
                                    ],
                                  ),
                                )
                              : Container();
                        },
                      )
                    : Center(
                        child: Container(
                            width: Get.width / 2,
                            child:
                                Image.asset('assets/images/history/empty.png')),
                      );
              }
              // If no data available

              else {
                return Text('No data'); // No data available
              }
            },
          ),
        ),
        Center(
          child: Visibility(
            visible: orderController.isLoading.value,
            child: Container(
                padding: EdgeInsets.all(8),
                width: 77,
                height: 77,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white),
                child: Lottie.asset('assets/images/order_card/loader.json')),
          ),
        )
      ],
    );
    ;
  }
}
