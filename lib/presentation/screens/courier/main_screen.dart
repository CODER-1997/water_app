import 'package:delivery/domain/controllers/firebase_auth_for_courier.dart';
import 'package:delivery/presentation/screens/courier/accepted_orders.dart';
import 'package:delivery/presentation/screens/courier/order_history.dart';
import 'package:delivery/presentation/screens/courier/orders.dart';
import 'package:delivery/presentation/screens/history/active_orders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:lottie/lottie.dart';

class CourierMainScreen extends StatelessWidget {
  RxInt _currentIndex = 0.obs;
  List screens = [OrdersOfCourier(),AcceptedOrders(), OrderHistoryOfCourier()];
  FireAuth auth = Get.put(FireAuth());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Stack(
          alignment: Alignment.center,
          children: [
            Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                      onPressed: () {
                        auth.logOut();
                      },
                      icon: Icon(Icons.logout))
                ],
              ),
              body: screens[_currentIndex.value],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: _currentIndex.value,
                onTap: (int index) {
                  _currentIndex.value = index;
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.rocket),
                    label: 'orders'.tr.capitalizeFirst!,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.cart_fill),
                    label: 'active_orders'.tr.capitalizeFirst!,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.time),
                    label: 'history'.tr.capitalizeFirst!,
                  ),
                ],
              ),
            ),
            Center(
              child: Visibility(
                visible: auth.isLoading.value,
                child: Lottie.asset('assets/images/order_card/loader.json',
                    width: 155),
              ),
            )
          ],
        ));
  }
}
