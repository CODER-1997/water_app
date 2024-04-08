import 'package:delivery/presentation/custom_widgets/settings_item.dart';
import 'package:delivery/presentation/screens/about_app/about_app.dart';
import 'package:delivery/presentation/screens/profile/about_company.dart';
import 'package:delivery/presentation/screens/settings/change_language_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:package_info_plus/package_info_plus.dart';

import '../../../data/constants/text_styles.dart';
import '../../../data/constants/theme.dart';

class Profile extends StatelessWidget {
  Rx count = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homePagebg,
      appBar: AppBar(
        title: Text(
          "profile".tr.capitalizeFirst!,
          style: appBarStyle,
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                // GestureDetector(
                //     onTap: () {
                //       Get.to(AboutApp());
                //     },
                //     child: SettingsItem(icon: Icons.info, title: 'about_app'.tr)),
                // SizedBox(height: 16,),
                GestureDetector(
                    onTap: () {
                      Get.to(ChangeLanguageScreen());
                    },
                    child: SettingsItem(
                        icon: Icons.translate, title: 'app_lang'.tr)),
                SizedBox(
                  height: 16,
                ),
                GestureDetector(
                    onTap: () {
                      Get.to(AboutCompany());
                    },
                    child: SettingsItem(
                        icon: Icons.account_balance_outlined,
                        title: 'about_company'.tr.capitalizeFirst!)),
              ],
            ),
            Column(
              children: [
                Container(
                  width: Get.width,
                  height: 100,
                  child: Image.asset('assets/images/logo.png'),
                ),
                Text('app_version'.tr.capitalizeFirst! + ' 5.2.0+21')
              ],
            )
          ],
        ),
      ),
    );
  }
}
