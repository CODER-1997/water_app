import 'package:delivery/data/constants/text_styles.dart';
import 'package:delivery/data/constants/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:time_range_picker/time_range_picker.dart';

import '../../../domain/controllers/single_order_controller.dart';
import '../../custom_widgets/FormFieldDecorator.dart';
import '../../custom_widgets/gradient_button.dart';

class OrderDetail extends StatelessWidget {
  SingleOrderController orderController = Get.put(SingleOrderController());
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final int count;
  final int discountRate;
  final int price;
  final String title;
  final String companyPhone;

  OrderDetail(
      {required this.count,
      required this.title,
      required this.price,
      required this.discountRate,
      required this.companyPhone});

  RxString deliveryPalce = ''.obs;
  RxString customerPhone = ''.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Stack(
          alignment: Alignment.center,
          children: [
            Scaffold(
              backgroundColor: Color(0xffEBFDFF),
              body: Form(
                key: _key,
                child: SafeArea(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "order_details".tr.capitalizeFirst!,
                            style: appBarStyle,
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              children: [
                                OrderDetailItem(
                                  title: 'delivery_place'.tr.capitalizeFirst!,
                                  subtitle: deliveryPalce,
                                  controller: orderController.where,
                                  leftIcon: Icons.location_pin,
                                  placeholder:
                                      'delivery_place'.tr.capitalizeFirst!,
                                  color: Colors.red,
                                ),
                                OrderDetailItem(
                                  title: 'delivery_day'.tr.capitalizeFirst!,
                                  subtitle: orderController.createdAt,
                                  leftIcon: Icons.calendar_month,
                                  color: Colors.lightBlueAccent,
                                ),
                                // //soat nechida
                                GestureDetector(
                                  onTap: () async {
                                    TimeRange result =
                                        await showTimeRangePicker(
                                      fromText: "Dan",
                                      toText: "Gacha",
                                      context: context,
                                      autoAdjustLabels: true,
                                    );
                                    orderController.startTime.value = result
                                            .startTime.hour
                                            .toString() +
                                        ":" +
                                        "${result.startTime.minute < 10 ? '0' + result.startTime.minute.toString() : result.startTime.minute}";
                                    orderController.endTime.value = result
                                            .endTime.hour
                                            .toString() +
                                        ":" +
                                        "${result.endTime.minute < 10 ? '0' + result.endTime.minute.toString() : result.endTime.minute}";
                                    ;
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.access_time,
                                            color: Colors.deepPurple,
                                          ),
                                          SizedBox(
                                            width: 16,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "delivery_time"
                                                    .tr
                                                    .capitalizeFirst!,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w800),
                                              ),
                                              Text(
                                                  '${orderController.startTime.value} dan ${orderController.endTime.value} gacha')
                                            ],
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                          onPressed: () async {
                                            TimeRange result =
                                                await showTimeRangePicker(
                                              fromText: "Dan",
                                              toText: "Gacha",
                                              context: context,
                                              autoAdjustLabels: true,
                                            );
                                            orderController.startTime
                                                .value = result.startTime.hour
                                                    .toString() +
                                                ":" +
                                                "${result.startTime.minute < 10 ? '0' + result.startTime.minute.toString() : result.startTime.minute}";
                                            orderController.endTime
                                                .value = result.endTime.hour
                                                    .toString() +
                                                ":" +
                                                "${result.endTime.minute < 10 ? '0' + result.endTime.minute.toString() : result.endTime.minute}";
                                            ;
                                          },
                                          icon: Icon(
                                            orderController
                                                    .startTime.value.isEmpty
                                                ? Icons.add
                                                : Icons.edit,
                                          )),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                OrderDetailItem(
                                  title: 'phone'.tr.capitalizeFirst!,
                                  subtitle: customerPhone,
                                  controller: orderController.phone,
                                  leftIcon: Icons.phone,
                                  placeholder: 'phone'.tr.capitalizeFirst!,
                                  color: Colors.green,
                                ),

                                Row(
                                  children: [
                                    Icon(Icons.credit_card_rounded),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'payment_type'.tr.capitalizeFirst!,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w800),
                                        ),
                                        Container(
                                          width: Get.width / 2,
                                          child: Text("Naqt"),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          // Container(
                          //   padding: EdgeInsets.all(16),
                          //   decoration: BoxDecoration(
                          //       color: Colors.white,
                          //       borderRadius: BorderRadius.circular(12)),
                          //   child: Column(children: [
                          //
                          //   ],),
                          // )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              bottomNavigationBar: Container(
                  margin: EdgeInsets.all(16),
                  child: GestureDetector(
                    onTap: () {
                      if (deliveryPalce.isNotEmpty &&
                          orderController.phone.text.isNotEmpty &&
                          orderController.where.text.isNotEmpty &&
                          orderController.startTime.value.isNotEmpty) {
                        Get.bottomSheet(
                            backgroundColor: Colors.transparent,
                            isDismissible: true,
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(32),
                                      topRight: Radius.circular(32))),
                              padding: EdgeInsets.all(16),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Item(
                                        title: 'quantity'.tr.capitalizeFirst,
                                        value: count,
                                      ),
                                      Item(
                                        title:
                                            'delivery_day'.tr.capitalizeFirst!,
                                        value: orderController.createdAt.value,
                                      ),
                                      Item(
                                        title:
                                            'delivery_time'.tr.capitalizeFirst,
                                        value: orderController.startTime.value +
                                            " " +
                                            orderController.endTime.value,
                                      ),
                                      Item(
                                        title:
                                            'delivery_place'.tr.capitalizeFirst,
                                        value: orderController.where.text,
                                      ),
                                      Item(
                                        title: 'phone'.tr.capitalizeFirst,
                                        value: orderController.phone.text,
                                      ),
                                      Item(
                                        title: 'total'.tr.capitalizeFirst!,
                                        value: "${count * price} so'm",
                                      ),
                                      Item(
                                        title: 'bonuses'.tr.capitalizeFirst!,
                                        value: "${count ~/ discountRate} ta",
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {

                                          orderController.addNewOrder(
                                              count ~/ discountRate,
                                              count * price,
                                              companyPhone);

                                        },
                                        child: CustomButton(
                                            isLoading:
                                                orderController.isLoading.value,
                                            text: 'Tasdiqlash'),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            Get.back();
                                          },
                                          child: CustomButton(
                                            text: '_reject'.tr.capitalizeFirst!,
                                            color: Colors.red,
                                          ))
                                    ],
                                  )
                                ],
                              ),
                            ));

                        ///  orderController.addNewOrder();
                      } else {
                        Get.snackbar(
                          "Xatolik",
                          "Bazi maydonlar to'ldirilmagan !",
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                          snackPosition: SnackPosition.TOP,
                        );
                      }
                    },
                    child: CustomButton(
                      text: 'Buyurtma berish',
                    ),
                  )),
            ),
            Center(
              child: Visibility(
                visible: orderController.isLoading.value,
                child: Lottie.asset('assets/images/order_card/loader.json'),
              ),
            )
          ],
        ));
  }
}

class OrderDetailItem extends StatelessWidget {
  final String title;
  final RxString subtitle;
  final String? placeholder;
  final Color color;
  final TextEditingController? controller;
  final IconData leftIcon;

  OrderDetailItem(
      {required this.title,
      required this.subtitle,
      this.controller,
      required this.leftIcon,
      this.placeholder,
      required this.color});

  SingleOrderController singleOrderController =
      Get.put(SingleOrderController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
          onTap: () {
            leftIcon != Icons.calendar_month
                ? showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        backgroundColor: Colors.white,
                        insetPadding: EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                        //this right here
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)),
                          width: Get.width,
                          height: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Title"),
                              TextFormField(
                                keyboardType:
                                    placeholder == 'phone'.tr.capitalizeFirst
                                        ? TextInputType.phone
                                        : TextInputType.text,
                                controller: controller,
                                inputFormatters:
                                    placeholder == 'phone'.tr.capitalizeFirst
                                        ? [Utils.phoneMaskFormatter]
                                        : [],
                                decoration:
                                    buildInputDecoratione(placeholder ?? ''),
                                maxLines: placeholder ==
                                        'delivery_place'.tr.capitalizeFirst
                                    ? 2
                                    : 1,
                              ),
                              InkWell(
                                onTap: () {
                                  subtitle.value = controller?.text ?? "";
                                  Navigator.pop(context);
                                },
                                child: CustomButton(text: 'Tasdiqlash'),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : singleOrderController.showDate();
          },
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Icon(
                        leftIcon,
                        color: color,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800),
                          ),
                          Container(
                            width: Get.width / 2,
                            child: Text("${subtitle.value}"),
                          )
                        ],
                      )
                    ],
                  ),
                  IconButton(
                      onPressed: () {
                        leftIcon != Icons.calendar_month
                            ? showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    backgroundColor: Colors.white,
                                    insetPadding: EdgeInsets.all(16),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0)),
                                    //this right here
                                    child: Container(
                                      padding: EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      width: Get.width,
                                      height: 200,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Title"),
                                          TextFormField(
                                            keyboardType: placeholder ==
                                                    'phone'.tr.capitalizeFirst
                                                ? TextInputType.phone
                                                : TextInputType.text,
                                            controller: controller,
                                            inputFormatters: placeholder ==
                                                    'phone'.tr.capitalizeFirst
                                                ? [Utils.phoneMaskFormatter]
                                                : [],
                                            decoration: buildInputDecoratione(
                                                placeholder ?? ''),
                                            maxLines: placeholder ==
                                                    'delivery_place'
                                                        .tr
                                                        .capitalizeFirst
                                                ? 2
                                                : 1,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              subtitle.value =
                                                  controller?.text ?? "";
                                              Navigator.pop(context);
                                            },
                                            child: CustomButton(
                                                text: 'Tasdiqlash'),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )
                            : singleOrderController.showDate();
                      },
                      icon:
                          Icon(subtitle.value.isEmpty ? Icons.add : Icons.edit))
                ],
              ),
              SizedBox(
                height: 16,
              )
            ],
          ),
        ));
  }
}

class Item extends StatelessWidget {
  const Item({
    super.key,
    required this.title,
    required this.value,
  });

  final dynamic title;
  final dynamic value;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black26))),
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${title}: ',
            style: TextStyle(color: Colors.black54, fontSize: 15),
          ),
          Container(
            alignment: Alignment.bottomRight,
            width: Get.width / 2,
            child: Text(
              '${value}',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w700),
              overflow: TextOverflow.ellipsis,
            ),
            margin: EdgeInsets.only(left: 11),
          ),
        ],
      ),
    );
  }
}
