import 'package:delivery/presentation/screens/courier/login.dart';
import 'package:delivery/presentation/screens/courier/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

import '../../../domain/controllers/firebase_auth_for_courier.dart';

class WrapperCourier extends StatelessWidget {
  FireAuth auth = Get.put(FireAuth());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => Stack(
            children: [
              StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else {
                    if (snapshot.hasData && snapshot.data != null) {
                      // User is logged in
                      return CourierMainScreen();
                    } else {
                      // User is not logged in
                      return Login();
                    }
                  }
                },
              ),
              Center(
                child: Visibility(
                  visible: auth.isLoading.value,
                  child: Container(
                    width: 100,
                    height: 100,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: CupertinoColors.white
                    ),
                      child: Lottie.asset(
                          'assets/images/order_card/loader.json',
                          )),
                ),
              )
            ],
          )),
    );
    ;
  }
}
