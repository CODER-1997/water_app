import 'package:delivery/domain/controllers/firebase_auth_for_courier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../data/constants/utils.dart';

class Login extends StatelessWidget {
  Rx isLogin = true.obs;
  Rx isVisible = false.obs;

  FireAuth auth = Get.put(FireAuth());

  TextEditingController courierName=TextEditingController();
  TextEditingController courierPhone=TextEditingController(text: '+998');
  TextEditingController companyId=TextEditingController();
  GetStorage box=GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue, Colors.indigo],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Kirish',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: auth.email,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Email:',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller:courierName,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'F.I.O',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: courierPhone,
                  style: TextStyle(color: Colors.white),
                  inputFormatters: [MaskTextInputFormatter(
                      mask: '+998 ## ### ## ##',
                      filter: {"#": RegExp(r'[0-9]')},
                      type: MaskAutoCompletionType.lazy)],
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Tel',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: companyId,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Company name',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                // Obx(() => TextFormField(
                //       controller: auth.password,
                //       obscureText: isVisible.value,
                //       style: TextStyle(color: Colors.white),
                //       decoration: InputDecoration(
                //         suffixIcon: GestureDetector(
                //           onTap: (){
                //             isVisible.value=!isVisible.value;
                //           },
                //             child: Icon(
                //           isVisible.value ?Icons.visibility:Icons.visibility_off,
                //           color: CupertinoColors.white,
                //         )),
                //         labelText: 'Parol',
                //         labelStyle: TextStyle(color: Colors.white),
                //         enabledBorder: OutlineInputBorder(
                //           borderSide: BorderSide(color: Colors.white),
                //         ),
                //         focusedBorder: OutlineInputBorder(
                //           borderSide: BorderSide(color: Colors.white),
                //         ),
                //       ),
                //     )),
                // SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    box.write('courierName', courierName.text);
                    box.write('courierPhone', courierPhone.text);
                    box.write('courierId', auth.email.text);
                    box.write('companyId',companyId.text);
                    auth.signInWithEmailAndPassword();
                  },
                  child: Text('Kirish'),
                  style: ElevatedButton.styleFrom(

                    padding: EdgeInsets.symmetric(vertical: 15.0),
                  ),
                ),
              ],
            ),
          ),
          Center(child: Visibility(visible: auth.isLoading.value,child: Lottie.asset('assets/images/order_card/loader.json',width: 155),),)

        ],
      ),
    );
  }
}
