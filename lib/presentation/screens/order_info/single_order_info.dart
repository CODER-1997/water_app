import 'dart:ffi';

import 'package:delivery/data/constants/text_styles.dart';
import 'package:delivery/data/constants/theme.dart';
import 'package:delivery/domain/controllers/single_order_controller.dart';
import 'package:delivery/presentation/custom_widgets/gradient_button.dart';
import 'package:delivery/presentation/screens/home/home_screen.dart';
import 'package:delivery/presentation/screens/order_info/order_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:time_range_picker/time_range_picker.dart';

import '../../custom_widgets/FormFieldDecorator.dart';

class SinglOrderInfo extends StatelessWidget {
  SingleOrderController orderController = Get.put(SingleOrderController());

  final String title;
  final String price;
  final String companyPhone;
  final int discountRate;

  SinglOrderInfo({required this.title,required this.price, required this.discountRate, required this.companyPhone});

  var phoneMaskFormatter = MaskTextInputFormatter(
      mask: '+998 ## ### ## ##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          resizeToAvoidBottomInset: true,

          body: Container(
            width: Get.width,
            height: Get.height,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xffd2e8ff),
                  Colors.white,
                ],
              ),
            ),
            child: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.topLeft,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Get.offAll(Home());
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(12)
                            ),
                            child: Icon(Icons.arrow_back,color: Colors.black26,),
                          ),
                        ),
                        
                        Container(
                          alignment: Alignment.center,
                          height: Get.height / 3,
                          child: Image.asset(
                              'assets/images/order_card/img_1.png'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${title}",
                          style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 32
                    ),
                        ),  Text(
                          "${price} so'm",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w900,
                            fontSize: 22
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "20 L lik qadoqda",
                          style: TextStyle(
                              color: Colors.black26,
                              fontWeight: FontWeight.w900,
                              fontSize: 22
                          ),
                        ),

                      ],
                    ),

                    SizedBox(
                      height: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tasnifi:",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w900,
                              fontSize: 22
                          ),
                        ),
                        Text('In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying ')

                      ],
                    ),



                  ],
                ),
              ),
            ),
          ),
       bottomNavigationBar:
      Obx(() =>  Container(
        padding: EdgeInsets.all(16),
        height: 100,
        decoration: BoxDecoration(
            color: CupertinoColors.white
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12)
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      if (orderController.count.value > 1) {
                        orderController.count.value--;
                      }
                    },
                    icon: Icon(Icons.remove)
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    '${orderController.count.value}',
                    style:
                    TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  IconButton(
                    onPressed: () {
                      orderController.count.value++;
                    },
                    icon: Icon(Icons.add)
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                Get.to(OrderDetail(count: orderController.count.value,title: title, price: int.parse(price), discountRate: discountRate, companyPhone: companyPhone,));


              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(8),
                height: 50,
                width: Get.width/2,
                child: Text(
                  "Buyurtma berish",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xff2495ff)),
              ),
            )

          ],
        ),
      ),)
        );
  }
}
