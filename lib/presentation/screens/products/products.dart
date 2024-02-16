import 'package:carousel_slider/carousel_slider.dart';
import 'package:delivery/presentation/custom_widgets/FormFieldDecorator.dart';
import 'package:delivery/presentation/custom_widgets/gradient_button.dart';
import 'package:delivery/presentation/custom_widgets/order_card.dart';
import 'package:delivery/presentation/screens/courier/wrapper.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/constants/text_styles.dart';
import '../../../data/constants/theme.dart';

class Products extends StatelessWidget {
  RxDouble dotIndex = 0.0.obs;

  List titles = ['Aksiya: 4+1', 'Aksiya 5+1'];
  List subtitle = [
    'Javohir waterda 4 ta oling 1 ta tekin',
    'Fayz suvlarida 5 ta oling 1 ta tekin'
  ];
  List images = ['img_3', 'img_2'];
  List colors = [
    [Color(0xFF2495FF), Color(0xFF2B7FC9)],
    [Color(0xFF1BC27A), Color(0xFF4FE48A)]
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homePagebg,
      appBar: AppBar(
        actions: [
          GestureDetector(
              onTap: () {
                Get.to(WrapperCourier());
              },
              child: Text('Kuryerlik', style: appBarStyle)),
          SizedBox(
            width: 32,
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                    height: 200.0,
                    aspectRatio: 16 / 9,
                    viewportFraction: 1,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 500),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.2,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index, reason) {
                      dotIndex.value = index * 1.0;
                      print(index);
                    }),
                items: titles.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          padding: EdgeInsets.all(16),
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment(-1.00, -0.00),
                                end: Alignment(1, 0),
                                colors: colors[titles.indexOf(i)],
                              ),
                              borderRadius: BorderRadius.circular(12)),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '$i',
                                      style: TextStyle(
                                          fontSize: 26.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900),
                                    ),
                                    Text(
                                      '${subtitle[titles.indexOf(i)]}',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Container(
                                    width: 200,
                                    child: Image.asset(
                                      'assets/images/order_card/${images[titles.indexOf(i)]}.png',
                                    )),
                              )
                            ],
                          ));
                    },
                  );
                }).toList(),
              ),
              SizedBox(
                height: 8,
              ),
              Obx(
                () => DotsIndicator(
                  dotsCount: 2,
                  position: dotIndex.value,
                  decorator: DotsDecorator(
                    size: const Size.square(9.0),
                    activeSize: const Size(18.0, 9.0),
                    activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              OrderCard(
                title: 'Fayz suvlari',
                price: '8000',
                img: 'bottle',
                companyId: 'Fayz suvlari',
                discountRate: 5,
                companyPhone: '+998 93 319 80 04',
              ),
              OrderCard(
                title: 'Javohir water',
                price: '8000',
                img: 'bottle',
                companyId: 'Javohir water',
                discountRate: 4,
                companyPhone: '+998 94 338 77 00',
              )
            ],
          ),
        ),
      ),
    );
  }
}
