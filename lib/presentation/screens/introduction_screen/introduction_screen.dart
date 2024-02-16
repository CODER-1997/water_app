import 'package:delivery/presentation/screens/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreenDemo extends StatefulWidget {
  @override
  State<IntroScreenDemo> createState() => _IntroScreenDemoState();
}

class _IntroScreenDemoState extends State<IntroScreenDemo> {
  final _introKey = GlobalKey<IntroductionScreenState>();
  var box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
        globalBackgroundColor: Color(0xffe1f0ff),
        bodyPadding: EdgeInsets.only(top: Get.height / 6),
        // 2. Pass that key to the `IntroductionScreen` `key` param
        key: _introKey,
        pages: [
          PageViewModel(
            title: "Ilova orqali endi oson",
            body:
                "Bizning ilovamiz orqali o'zingizga kerakli bo'lgan mahsulotni osongina buyurtma bering",
            image: Center(
              child: Image.asset('assets/images/intro/img1.png'),
            ),
          ),
          PageViewModel(
            title: "Uydan chiqmaysiz",
            body: "Kuryerlar sizning uyingizgacha eltib berishadi",
            image: Center(
              child: Image.asset('assets/images/intro/img_1.png'),
            ),
          )
        ],
        showBackButton: true,
        showNextButton: false,
        back: const Icon(Icons.arrow_back),
        done: const Text("Keyingisi"),
        onDone: () {
          box.write('isFirstTime', false);
          Get.offAll(Home());
        });
  }
}
