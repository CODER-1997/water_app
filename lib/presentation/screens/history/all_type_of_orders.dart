import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/data/constants/text_styles.dart';
import 'package:delivery/data/constants/theme.dart';
import 'package:delivery/domain/controllers/single_order_controller.dart';
import 'package:delivery/presentation/custom_widgets/gradient_button.dart';
import 'package:delivery/presentation/screens/history/active_orders.dart';
import 'package:delivery/presentation/screens/history/history_of_orders.dart';
import 'package:delivery/presentation/screens/history/rejected_orders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../../data/constants/utils.dart';

class AllTypeOfOrders extends StatelessWidget {
  SingleOrderController orderController = Get.put(SingleOrderController());
  RxList pages = [ActiveOrders(), HistoryOfOrders(), RejectedOrders()].obs;
  RxInt selectedIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homePagebg,
      appBar: AppBar(
        title: Text(
          'order_history'.tr.capitalizeFirst!,
          style: appBarStyle,
        ),
      ),
      body: Obx(()=>Container(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                        child: InkWell(
                            onTap: () {
                              selectedIndex.value = 0;
                            },
                            child: Obx(() => Container(
                              alignment: Alignment.center,
                              height: 60,
                              decoration: BoxDecoration(
                                  border: Border.all( color: selectedIndex.value==0?Colors.blue:Colors.transparent),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Text("active_order".tr),
                            ),)
                        )),
                    SizedBox(
                      width: 4,
                    ),
                    Expanded(
                        child: InkWell(
                          onTap: () {
                            selectedIndex.value = 1;
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 60,
                            decoration: BoxDecoration(
                                border: Border.all( color: selectedIndex.value==1?Colors.blue:Colors.transparent),

                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12)),
                            child: Text("finished_order".tr),
                          ),
                        )),
                    SizedBox(
                      width: 4,
                    ),
                    Expanded(
                        child: InkWell(
                          onTap: () {
                            selectedIndex.value = 2;
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 60,
                            decoration: BoxDecoration(
                                border: Border.all( color: selectedIndex.value==2?Colors.blue:Colors.transparent),

                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12)),
                            child: Text("rejected_order".tr),
                          ),
                        )),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Expanded(
              flex: 8,
              child: Obx(() => Container(
                child: pages[selectedIndex.value],
              )),
            )
          ],
        ),
      )),
    );
  }
}
