import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer2 extends StatelessWidget {
  CustomShimmer2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                margin: EdgeInsets.all(32),
                width: 66,
                height: 66,
                decoration: BoxDecoration(
                    color: Color(0xffdcdcdc),
                    borderRadius: BorderRadius.circular(112)),
              ),
            );

        });


  }
}
