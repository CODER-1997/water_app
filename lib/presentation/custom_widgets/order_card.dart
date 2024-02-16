import 'package:delivery/presentation/screens/order_info/single_order_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../domain/controllers/single_order_controller.dart';

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
    required this.img, required this.companyId, required this.discountRate, required this.companyPhone,
});

  SingleOrderController auth=Get.put(SingleOrderController());

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
              width: Get.width /3 ,
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
                width: Get.width/2,
                child: Text(
                  '${title}',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 18),
                  maxLines: 11,
                ),
              ),
              SizedBox(height: 16,),
              Text(
                '20 L lik idish',
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w600,
                    fontSize: 14),
              ),
              SizedBox(height: 16,),

              Text(
                "${price} so'm",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 16),
              ),
              SizedBox(width: 20,),
              GestureDetector(
                onTap: () {
                  Get.to(SinglOrderInfo(title: title,price: price, discountRate: discountRate, companyPhone: companyPhone,));
                  auth.companyId.value=companyId;

                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(8),
                  height: 50,
                  width: Get.width/2,
                  child: Text(
                    "Ko'rish",
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
