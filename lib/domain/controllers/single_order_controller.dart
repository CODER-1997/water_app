import 'dart:ffi';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/presentation/screens/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../../data/models/order_data.dart';

class SingleOrderController extends GetxController {
  Rx count = 1.obs;
  Rx<TimeOfDay> selectedTime = TimeOfDay(hour: 24, minute: 60).obs;
  RxString startTime = "".obs;
  RxString endTime = "".obs;
  RxString companyId = "".obs;
  static DateTime date = DateTime.now();
  TextEditingController where = TextEditingController(text: '');
  TextEditingController fio = TextEditingController();
  TextEditingController phone = TextEditingController(text: "+998");
  RxBool isLoading = false.obs;

  RxString createdAt = ''.obs;

  showDate() {
    Platform.isIOS
        ? Get.dialog(AlertDialog(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            backgroundColor: Colors.white,
            content: SizedBox(
              height: 350,
              width: Get.width,
              child: CupertinoDatePicker(
                initialDateTime: date,
                minimumYear: 1905,
                maximumDate: DateTime(2100),
                mode: CupertinoDatePickerMode.date,
                use24hFormat: true,
                // This is called when the user changes the date.
                onDateTimeChanged: (DateTime newDate) {
                  date = newDate;
                  createdAt.value = DateFormat('dd-MM-yyyy').format(date);
                },
              ),
            ),
          ))
        : showDatePicker(
                initialDate: date,
                firstDate: DateTime(1905),
                lastDate: DateTime(2100),
                context: Get.context!)
            .then((value) {
            date = value!;
            createdAt.value = DateFormat('dd-MM-yyyy').format(date);
          });
  }

  // select hours

// Firestore
  final CollectionReference _dataCollection = FirebaseFirestore.instance.collection('waterOrders');

  void addNewOrder(int bonus, int price,String companyPhone) async {
    Get.back();
    isLoading.value = true;
    try {


      OrderData newData = OrderData(
          count: count.value,
          day: createdAt.value,
          from: startTime.value,
          to: endTime.value,
          where: where.text,
          phone: phone.text,
          price: price,
          user: fio.text,
          when: DateTime.now().toString(),
          companyId: companyId.value,
          status: 'new',
          bonus: bonus,
          courierName: '',
          courierId: '',
          courierPhone: '', companyPhone: companyPhone, customerId: GetStorage().read('userId').toString());
      // Create a new document with an empty list
      await _dataCollection.add({
        'items': newData.toMap(),
      });
      Get.snackbar(
        "Success !",
        "Buyurtma qabul qilindi !",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      print('Data added to the list in Firestore');
      isLoading.value = false;
      Get.offAll(Home());
      where.clear();
      phone.clear();
      fio.clear();
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error:${e}',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    isLoading.value = false;

// Firestore
  }

  var box = GetStorage();

  void acceptOrder(String documentId) async {
    print('${GetStorage().read('courierName')}');
    print('${GetStorage().read('courierId')}');
    print('${GetStorage().read('courierPhone')}');
    isLoading.value = true;

    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    // Function to update a specific document field by document ID
    try {
      isLoading.value = true;

      // Reference to the document
      DocumentReference documentReference =_firestore.collection('waterOrders').doc(documentId);


      // Update the desired field
      await documentReference.update({
        'items.status': 'accepted',
        'items.courierName': box.read('courierName'),
        'items.courierId': box.read('courierId'),
        'items.courierPhone': box.read('courierPhone'),
      });
      print('Updated succesfully');
      isLoading.value = false;
    } catch (e) {
      print('Error updating document field: $e');
      isLoading.value = false;
    }
    isLoading.value = false;
  }
  void cancelOrder(String documentId) async {
    isLoading.value = true;

    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    // Function to update a specific document field by document ID
    try {
      isLoading.value = true;

      // Reference to the document
      DocumentReference documentReference =_firestore.collection('waterOrders').doc(documentId);


      // Update the desired field
      await documentReference.update({
        'items.status': 'rejected',
      });
      print('Updated succesfully');
      isLoading.value = false;
    } catch (e) {
      print('Error updating document field: $e');
      isLoading.value = false;
    }
    isLoading.value = false;
  }
}
