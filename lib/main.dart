import 'package:delivery/presentation/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:upgrader/upgrader.dart';
import 'data/constants/lang.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await  Upgrader.clearSavedSettings();


// ...

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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

