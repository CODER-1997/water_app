import 'package:delivery/data/constants/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectUserType extends StatelessWidget {
  const SelectUserType({super.key});

  @override
  Widget build(BuildContext context) {

    return  Scaffold(

      body: Container(

        color: Colors.white,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                height: 68,
                color:Colors.white,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => {Navigator.pop(context)},
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                            color: Color(0xffF0F1F3),
                            borderRadius:
                            BorderRadius.all(Radius.circular(12))),
                        child: Icon(
                          Icons.arrow_back_ios_new_sharp,
                          size: 11,
                          color:Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),

                  ],
                ),
              ),
              SizedBox(
                height: 48,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(
                    //   'Выберите кто вы',
                    //   style: TextStyle(
                    //       fontFamily: 'Manrope',
                    //       fontSize: 24,
                    //       fontWeight: FontWeight.w700,
                    //       color: Color(0xff323232)),
                    // ),
                    // SizedBox(
                    //   height: 6,
                    // ),
                    // Text(
                    //   'Зарегистрируйтесь как клиент или маклер.',
                    //   style: TextStyle(
                    //       fontFamily: 'Manrope',
                    //       fontSize: 16,
                    //       fontWeight: FontWeight.w400,
                    //       color: titleColor.withOpacity(.5)),
                    // ),

                    GestureDetector(
                        onTap: () => {

                        },
                        child: typeCard('Xaridor',
                            'assets/images/auth/client.png')),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                        onTap: () => {

                        },
                        child: typeCard('Kuryer',
                            'assets/images/auth/kuryer.png'))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container typeCard(String title, String rasm) => Container(

    width: double.infinity,
    height: 160,
    decoration: BoxDecoration(
        color:Color(0xffF0F1F3),
        borderRadius: BorderRadius.circular(12)),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 24,
        ),
        Image.asset(
          rasm,
          width: 100,
          height: 100,
        ),
        SizedBox(
          width: 24,
        ),
        Text(
          title,
          style: TextStyle(
              color: Color(0xff323232),
              fontWeight: FontWeight.w700,
              fontSize: 16,
              fontFamily: 'Manrope'),
        )
      ],
    ),
  );
  }

