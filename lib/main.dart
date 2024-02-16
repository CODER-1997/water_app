import 'package:delivery/presentation/screens/home/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:upgrader/upgrader.dart';

import 'data/constants/lang.dart';
import 'firebase_options.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await  Upgrader.clearSavedSettings();
  Platform.isAndroid
      ? await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyBIvMJ_asd3mvhRx2NFv373Yki0vrFQghU",
          appId: "1:175741921267:android:96c627c8d190c530375486",
          messagingSenderId: "175741921267",
          projectId: "waterapp-403ac"))
      : await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  var box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      home:  Home(),
      translations: LanguageTranslations(),
      locale: Locale(
          box.read("lang_code_1") ?? 'ru', box.read('lang_code_2') ?? 'UZ'),
      fallbackLocale: Locale(
          box.read("lang_code_1") ?? 'ru', box.read('lang_code_2') ?? 'UZ'),
    );
  }
}
