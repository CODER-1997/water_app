import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/presentation/custom_widgets/custom_shimmer.dart';
import 'package:delivery/presentation/custom_widgets/order_card.dart';
import 'package:delivery/presentation/screens/courier/wrapper.dart';
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
import '../../custom_widgets/custom_shimmer2.dart';
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
                    child: Text('courier'.tr.capitalizeFirst!,
                        style: appBarStyle))),
            SizedBox(
              width: 32,
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.only(left: 16, top: 16, right: 16),
          child: Column(
            children: [
              Expanded(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.center,
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('waterDiscounts')
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          print("${snapshot.connectionState}");
                          return CustomShimmer2();
                        }
                        if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        }
                        // If data is available
                        if (snapshot.hasData) {
                          print("${snapshot.connectionState}");

                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(horizontal: 4),
                                  child: InkWell(
                                    onTap: () {
                                      Get.bottomSheet(
                                        CustomBottomSheet(
                                          title: snapshot.data!.docs[index]
                                              ['items']['Title'],
                                        ),
                                        backgroundColor: Colors
                                            .transparent, // Make the background transparent
                                      );
                                    },
                                    child: Column(
                                      children: [
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Container(
                                              width: 70,
                                              height: 70,
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  color: Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          111),
                                                  border: Border.all(
                                                      color: Colors.blueAccent,
                                                      width: 2)),
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(16),
                                              height: 60,
                                              width: 60,
                                              decoration: BoxDecoration(
                                                  color: Colors.blueAccent,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          111)),
                                              child: Image.asset(
                                                  'assets/images/order_card/img_2.png'),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text("Aksiya")
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }
                        // If no data available

                        else {
                          return Text('No data'); // No data available
                        }
                      },
                    ),
                  )),
              Expanded(
                  flex: 8,
                  child: Container(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('waterCompanies')
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CustomShimmer();
                        }
                        if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        }
                        // If data is available
                        if (snapshot.hasData) {
                          return snapshot.data!.docs.length != 0
                              ? ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (BuildContext context, int i) {
                                    return OrderCard(
                                        title: snapshot.data!.docs[i]['items']
                                            ['companyName'],
                                        price: snapshot.data!.docs[i]['items']
                                            ['price20LWater'],
                                        img: snapshot.data!.docs[i]['items']
                                            ['companyLogo'],
                                        companyId: snapshot.data!.docs[i]
                                            ['items']['companyName'],
                                        discountRate: int.parse(snapshot.data!
                                            .docs[i]['items']['discountRate']
                                            .toString()),
                                        companyPhone: snapshot.data!.docs[i]
                                            ['items']['companyPhone']);
                                  })
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
                  ))
            ],
          ),
        ));
  }
}
