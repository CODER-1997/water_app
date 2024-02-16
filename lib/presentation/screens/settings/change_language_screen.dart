import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/constants/text_styles.dart';
import '../../../data/constants/theme.dart';
import '../../../domain/controllers/settings_controller.dart';
import '../../custom_widgets/DisabledButton.dart';
import '../../custom_widgets/gradient_button.dart';



class ChangeLanguageScreen extends StatelessWidget {
  ChangeLanguageScreen({super.key});

  final langController = Get.put(SettingControllerCustom());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: homePagebg,
        appBar: AppBar(
            elevation: 0,
            leading: IconButton(
              onPressed: Get.back,
              icon: const Icon(
                CupertinoIcons.left_chevron,
                size: 30,
                color: Colors.black,
              ),
            ),
            backgroundColor: homePagebg,
            centerTitle: true,
            title: Text(
              "change_lang".tr,
              style: appBarStyle,
            )),
        body: Stack(
          children: [
            Container(
              padding:
              const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              width: Get.width,
              height: Get.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 32,
                      ),
                      langCard(
                        flag: 'uz',
                        title: "O'zbek tili",
                        lang_code: 'uz',
                        lang_code2: 'UZ',
                      ),

                      langCard(
                        flag: 'ru',
                        title: "Русский язык",
                        lang_code: 'ru',
                        lang_code2: 'RU',
                      ),
                      langCard(
                        flag: 'en',
                        title: 'English',
                        lang_code: 'en',
                        lang_code2: 'US',
                      ),
                    ],
                  ),
                  Obx(() => langController.lang_code_1.value != ""?
                  GestureDetector(
                      onTap: () async {
                        Get.updateLocale(Locale(
                            langController.lang_code_1.value,
                            langController.lang_code_2.value));
                        Get.back();
                      },
                      child: CustomButton(text: 'do'.tr))

                      :DisabledButton(text: 'do'.tr))

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class langCard extends StatelessWidget {
  final String flag;
  final String lang_code;
  final String lang_code2;
  final String title;
  final langController = Get.put(SettingControllerCustom());

  langCard({
    super.key,
    required this.flag,
    required this.title,
    required this.lang_code,
    required this.lang_code2,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        langController.changeLang(lang_code, lang_code2);
      },
      child: Obx(() => Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.only(left: 15),
        width: Get.width,
        height: 70,
        decoration: ShapeDecoration(
          color: langController.currentlang.value == lang_code2
              ? langController.selectColor
              : Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 0.50, color: Color(0xFFCCD3E0)),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/${flag}_flag.png',
              width: 40,
              height: 26,
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: langController.currentlang.value == lang_code2
                        ? Colors.white
                        : const Color(0xFF273244),
                    fontSize: 17,
                    fontFamily: 'sfpro',
                    fontWeight: FontWeight.w400,
                    height: 28 / 17,
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
