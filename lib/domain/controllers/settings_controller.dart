import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingControllerCustom extends GetxController {
  RxBool isNotificationOn = true.obs;
  RxBool isDarkMode = false.obs;
  final box = GetStorage();
  Color selectColor = const Color(0xff283344);
  RxString currentlang = ''.obs;
  RxString lang_code_1 = ''.obs;
  RxString lang_code_2 = ''.obs;
  saveThemeStatus() async {
    box.write('theme', isDarkMode.value);
  }

  getThemeStatus() async {
    isDarkMode.value = (box.read('theme') ?? false);
  }

  changeLang(String langCode, String langCode2) {
    currentlang.value = langCode2;
    box.write("lang_code_1", langCode);
    box.write("lang_code_2", langCode2);
    lang_code_1.value = langCode;
    lang_code_2.value = langCode2;
    Get.updateLocale(Locale(langCode, langCode2));
    print('lang code1 ${box.read('lang_code_1')}');
    print('lang code2 ${lang_code_2.value}');


  }





}