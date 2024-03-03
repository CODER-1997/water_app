import 'package:delivery/presentation/screens/order_info/single_order_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../data/constants/utils.dart';
import '../../domain/controllers/single_order_controller.dart';
import 'FormFieldDecorator.dart';
import 'gradient_button.dart';

class OrderCard extends StatelessWidget {
  final String title;
  final String price;
  final String img;
  final String companyPhone;
  final String companyId;
  final int discountRate;

  OrderCard({
    required this.title,
    required this.price,
    required this.img,
    required this.companyId,
    required this.discountRate,
    required this.companyPhone,
  });

  SingleOrderController auth = Get.put(SingleOrderController());
  var box = GetStorage();
  TextEditingController phone = TextEditingController();
  TextEditingController userFio = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(bottom: 16),
      height: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xffd2e8ff),
            Colors.white,
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              height: 120,
              width: Get.width / 3,
              decoration: BoxDecoration(

                  //       color: Color(0xfff1f7ff),
                  borderRadius: BorderRadius.circular(12)),
              child: Image.asset(
                'assets/images/order_card/${img}.png',
              )),
          SizedBox(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: Get.width / 2,
                child: Text(
                  '${title}',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 18),
                  maxLines: 11,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                '20 L lik idish',
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w600,
                    fontSize: 14),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "${price} so'm",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 16),
              ),
              SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () {
                  if (box.read('userId') == null) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          backgroundColor: Colors.white,
                          insetPadding: EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                          //this right here
                          child: Form(
                            key: _formKey,
                            child: Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12)),
                              width: Get.width,
                              height: 420,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                              Column(children: [    Text("Login"),
                                SizedBox(
                                  height: 16,
                                ),
                                SizedBox(
                                  child: TextFormField(
                                      keyboardType: TextInputType.phone,
                                      controller: phone,
                                      inputFormatters: [
                                        MaskTextInputFormatter(
                                            mask: '+998 ## ### ## ##',
                                            filter: {"#": RegExp(r'[0-9]')},
                                            type: MaskAutoCompletionType.lazy)
                                      ],
                                      decoration: buildInputDecoratione(
                                          'phone'.tr.capitalizeFirst! ?? ''),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Maydonlar bo'sh bo'lmasligi kerak";
                                        }
                                        return null;
                                      }),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                SizedBox(
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Maydonlar bo'sh bo'lmasligi kerak";
                                      }
                                      return null;
                                    },
                                    controller: userFio,
                                    decoration: buildInputDecoratione(
                                        'F.I.O'.tr.capitalizeFirst! ?? ''),
                                  ),
                                ),
                                SizedBox(height: 16,),
                                Text('Muhim:Yuqorida kiritilgan raqamingiz orqali siz boshqa mobil qurilmadan ilovaga kirgan paytingizda sizning buyurtmalaringiz chiqadi'),],),
                                  InkWell(
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        box.write('userId', phone.text);
                                        box.write('userName', userFio.text);
                                        Get.back;
                                        Get.to(SinglOrderInfo(
                                          title: title,
                                          price: price,
                                          discountRate: discountRate,
                                          companyPhone: companyPhone,
                                        ));
                                        auth.companyId.value = companyId;
                                      }
                                    },
                                    child: CustomButton(text: 'confirm'.tr.capitalizeFirst!),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    Get.to(SinglOrderInfo(
                      title: title,
                      price: price,
                      discountRate: discountRate,
                      companyPhone: companyPhone,
                    ));
                    auth.companyId.value = companyId;
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(8),
                  height: 50,
                  width: Get.width / 2,
                  child: Text(
                    "see".tr.capitalizeFirst!,
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
          SizedBox(),
        ],
      ),
    );
  }
}
