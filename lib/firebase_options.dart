// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAeCPDyCo7txBgdjJZ0Lx3SkKyGJX4h4Wg',
    appId: '1:448392791773:web:c56f400fc58be06c733d34',
    messagingSenderId: '448392791773',
    projectId: 'fooddelivery-f58a5',
    authDomain: 'fooddelivery-f58a5.firebaseapp.com',
    storageBucket: 'fooddelivery-f58a5.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDqPxMLCy626VKbYTe_QyuRjTxwOugCxl0',
    appId: '1:448392791773:android:cffd60cc6222e06c733d34',
    messagingSenderId: '448392791773',
    projectId: 'fooddelivery-f58a5',
    storageBucket: 'fooddelivery-f58a5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAp5sg_JOj7vs1y7kzOwDo5mn7TXdSgpxc',
    appId: '1:448392791773:ios:fb43ec600cfcf0a7733d34',
    messagingSenderId: '448392791773',
    projectId: 'fooddelivery-f58a5',
    storageBucket: 'fooddelivery-f58a5.appspot.com',
    iosBundleId: 'com.example.delivery',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAp5sg_JOj7vs1y7kzOwDo5mn7TXdSgpxc',
    appId: '1:448392791773:ios:0cc865bb28342ebb733d34',
    messagingSenderId: '448392791773',
    projectId: 'fooddelivery-f58a5',
    storageBucket: 'fooddelivery-f58a5.appspot.com',
    iosBundleId: 'com.example.delivery.RunnerTests',
  );
}
