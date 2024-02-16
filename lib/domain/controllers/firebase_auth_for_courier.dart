import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FireAuth extends GetxController {
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  RxBool isLoading=false.obs;


  void logOut() async{
    isLoading.value=true;
    try {
      await FirebaseAuth.instance.signOut();
      isLoading.value=true;

      // Handle successful login, navigate to next screen, etc.
    } catch (e) {
      Get.snackbar(
        "Logout",
        "Something went wrong",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      isLoading.value=false;

      // Handle sign-in errors, show error message, etc.
    }
    isLoading.value=false;
  }

  void signInWithEmailAndPassword() async {
    isLoading.value=true;
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text,
        password: '123456',
      );
      isLoading.value=true;

      // Handle successful login, navigate to next screen, etc.
    } catch (e) {
      print('Failed to sign in with Email/Password: $e');
      Get.snackbar(
        "Login Failed",
        "Foydalanuvchi topilmadi",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      isLoading.value=false;

      // Handle sign-in errors, show error message, etc.
    }
    isLoading.value=false;

  }

}
