import 'package:delivery/presentation/screens/history/active_orders.dart';
import 'package:delivery/presentation/screens/history/all_type_of_orders.dart';
import 'package:delivery/presentation/screens/history/rejected_orders.dart';
import 'package:delivery/presentation/screens/introduction_screen/introduction_screen.dart';
import 'package:delivery/presentation/screens/products/products.dart';
import 'package:delivery/presentation/screens/profile/Profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get_storage/get_storage.dart';
import 'package:upgrader/upgrader.dart';

import '../history/history_of_orders.dart';


class Home extends StatelessWidget {
  var box = GetStorage();
  RxInt _currentIndex = 0.obs;
  RxList screens = [
    Products(),
    //ActiveOrders(),
    AllTypeOfOrders(),
  //  RejectedOrders(),
    Profile()
     ].obs;

  @override
  Widget build(BuildContext context) {
    return box.read('isFirstTime') != null
        ? Obx(() => Scaffold(
              body: UpgradeAlert(

                upgrader: Upgrader(
                  minAppVersion: '1.0.0+12',
                    appcastConfig: AppcastConfiguration(
                      supportedOS: ['android'],
                      url: "",
                    )),
                child: Container(
                  // padding: EdgeInsets.only(left: 16,right: 16,top: 16),
                  child: screens[_currentIndex.value],
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                selectedItemColor: Colors.blueAccent,
                unselectedItemColor: Colors.black,
                currentIndex: _currentIndex.value,
                onTap: (int index) {
                  _currentIndex.value = index;
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.water_drop),
                    label: 'products'.tr.capitalizeFirst,
                  ),
                  // BottomNavigationBarItem(
                  //   icon: Icon(CupertinoIcons.rocket_fill),
                  //   label: 'active_orders'.tr.capitalizeFirst,
                  // ),
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.clock),
                    label: 'history'.tr.capitalizeFirst,
                  ),
                  // BottomNavigationBarItem(
                  //   icon: Icon(Icons.cancel),
                  //   label: 'rejected_orders'.tr.capitalizeFirst,
                  // ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'profile'.tr.capitalizeFirst,
                  ),
                ],
              ),
            ))
        : IntroScreenDemo();
  }
}
