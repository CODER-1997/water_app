import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  CustomShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return

      ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
      return

        Stack(
          alignment: Alignment.centerLeft,
          children: [

            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                margin: EdgeInsets.only(top: 5, left: 10, right: 10),
              ),
            ),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                margin: EdgeInsets.all(32),
                width: 140,
                height: 150,
                decoration: BoxDecoration(
                    color: Color(0xffdcdcdc),
                    borderRadius: BorderRadius.circular(12)),                ),
            ),
          ],
        );});
  }
}
