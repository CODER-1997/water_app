import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/presentation/custom_widgets/FormFieldDecorator.dart';
import 'package:delivery/presentation/custom_widgets/custom_shimmer.dart';
import 'package:delivery/presentation/custom_widgets/gradient_button.dart';
import 'package:delivery/presentation/custom_widgets/order_card.dart';
import 'package:delivery/presentation/screens/courier/wrapper.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../../data/constants/text_styles.dart';
import '../../../data/constants/theme.dart';
import '../../custom_widgets/custom_snackbar.dart';

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
              child: Shimmer.fromColors(
                  baseColor: Colors.blue,
                  highlightColor: Colors.red,
                  child:
                      Text('courier'.tr.capitalizeFirst!, style: appBarStyle))),
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
              SizedBox(height: 16,),
              Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for(int i=0;i<10;i++)

                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          child: InkWell(
                          onTap: (){
                            Get.bottomSheet(
                              CustomBottomSheet(),
                              backgroundColor: Colors.transparent, // Make the background transparent
                            );

                          },
                          child: Column(
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Shimmer.fromColors(
                                    baseColor: Colors.blue,

                                    highlightColor: Colors.red,
                                    child: Container(
                                      width: 120,
                                      height: 120,
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(111),
                                        border:Border.all(color: Colors.blueAccent,width: 6)
                                      ),

                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(16),

                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.blueAccent,
                                        borderRadius: BorderRadius.circular(111)
                                    ),
                                    child: Image.asset('assets/images/order_card/img_2.png'),
                                  ),

                                ],
                              ),
                              SizedBox(height: 4,),
                              Text("Aksiya")
                            ],
                          ),
                                                ),
                        )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16,),
              // CarouselSlider(
              //   options: CarouselOptions(
              //       height: 200.0,
              //       aspectRatio: 16 / 9,
              //       viewportFraction: 1,
              //       initialPage: 0,
              //       enableInfiniteScroll: true,
              //       reverse: false,
              //       autoPlay: true,
              //       autoPlayInterval: Duration(seconds: 3),
              //       autoPlayAnimationDuration: Duration(milliseconds: 500),
              //       autoPlayCurve: Curves.fastOutSlowIn,
              //       enlargeCenterPage: true,
              //       enlargeFactor: 0.2,
              //       scrollDirection: Axis.horizontal,
              //       onPageChanged: (index, reason) {
              //         dotIndex.value = index * 1.0;
              //         print(index);
              //       }),
              //   items: titles.map((i) {
              //     return Builder(
              //       builder: (BuildContext context) {
              //         return Container(
              //             padding: EdgeInsets.all(16),
              //             margin: EdgeInsets.symmetric(horizontal: 5.0),
              //             decoration: BoxDecoration(
              //                 gradient: LinearGradient(
              //                   begin: Alignment(-1.00, -0.00),
              //                   end: Alignment(1, 0),
              //                   colors: colors[titles.indexOf(i)],
              //                 ),
              //                 borderRadius: BorderRadius.circular(12)),
              //             child: Row(
              //               mainAxisAlignment:
              //                   MainAxisAlignment.spaceBetween,
              //               children: [
              //                 Expanded(
              //                   child: Column(
              //                     mainAxisAlignment:
              //                         MainAxisAlignment.center,
              //                     crossAxisAlignment:
              //                         CrossAxisAlignment.start,
              //                     children: [
              //                       Text(
              //                         '$i',
              //                         style: TextStyle(
              //                             fontSize: 26.0,
              //                             color: Colors.white,
              //                             fontWeight: FontWeight.w900),
              //                       ),
              //                       Text(
              //                         '${subtitle[titles.indexOf(i)]}',
              //                         style: TextStyle(
              //                             fontSize: 16.0,
              //                             color: Colors.white,
              //                             fontWeight: FontWeight.w900),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //                 Expanded(
              //                   child: Container(
              //                       width: 200,
              //                       child: Image.asset(
              //                         'assets/images/order_card/${images[titles.indexOf(i)]}.png',
              //                       )),
              //                 )
              //               ],
              //             ));
              //       },
              //     );
              //   }).toList(),
              // ),
              // SizedBox(
              //   height: 8,
              // ),
              // Obx(
              //   () => DotsIndicator(
              //     dotsCount: 2,
              //     position: dotIndex.value,
              //     decorator: DotsDecorator(
              //       size: const Size.square(9.0),
              //       activeSize: const Size(18.0, 9.0),
              //       activeShape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(5.0)),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 8,
              ),
              Container(
                height: Get.height,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('waterCompanies')
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CustomShimmer();
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    // If data is available
                    if (snapshot.hasData) {
                      print("Firmalar ${snapshot.data!.docs}");
                      return snapshot.data!.docs.length != 0
                          ? GroupedListView(
                              elements: snapshot.data!.docs,
                              groupBy: (element) =>
                                  element['items']['createdAt'],
                              groupSeparatorBuilder: (String groupByValue) =>
                                  Visibility(
                                visible: false,
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(DateFormat('d MMM HH:mm')
                                      .format(DateTime.parse(groupByValue))),
                                ),
                              ),
                              itemComparator: (item1, item2) => item1['items']
                                      ['createdAt']
                                  .compareTo(item2['items']['createdAt']),
                              floatingHeader: true,
                              order: GroupedListOrder.DESC,
                              itemBuilder: (c, element) {
                                return OrderCard(
                                    title: element['items']['companyName'],
                                    price: element['items']['price20LWater'],
                                    img: element['items']['companyLogo'],
                                    companyId: element['items']['companyName'],
                                    discountRate: int.parse(element['items']
                                            ['discountRate']
                                        .toString()),
                                    companyPhone: element['items']
                                        ['companyPhone']);
                              },
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 64,
                                ),
                                Center(
                                  child: Container(
                                      width: Get.width / 2,
                                      child: Image.asset(
                                          'assets/images/history/empty.png')),
                                ),
                              ],
                            );
                    }
                    // If no data available

                    else {
                      return Text('No data'); // No data available
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
