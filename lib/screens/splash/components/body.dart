import 'package:conquer_bulgaria_app/screens/main_window/main_window_screen.dart';
import 'package:conquer_bulgaria_app/screens/sign_in/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../constants.dart';
import 'splash_content.dart';
import '../../../size_config.dart';
import '../../../strings.dart';
import 'package:flutter/material.dart';
import 'buttons.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentIndex = 0;
  final _btnController = new RoundedLoadingButtonController();
  //todo: get better pictures
  List<Map<String, String>> splashData = [
    {
      'text': sSplashText1,
      'image': 'assets/images/splash_screen1.svg',
    },
    {
      'text': sSplashText2,
      'image': 'assets/images/splash_screen2.svg',
    },
    {
      'text': sSplashText3,
      'image': 'assets/images/splash_screen3.svg',
    }
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: getProportionateScreenWidth(20),
                  bottom: getProportionateScreenWidth(60)),
              child: Text(
                sName, // Conquer Bulgaria
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(48),
                  fontFamily: kCoolFont,
                  color: kPrimaryColor,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: PageView.builder(
                itemCount: splashData.length,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (context, index) => SplashContent(
                  text: splashData[index]['text'],
                  image: splashData[index]['image'],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      splashData.length,
                      (index) => contentDot(index: index),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.all(getProportionateScreenHeight(30)),
                    child: DefaultLoadingButton(
                      controller: _btnController,
                      color: (currentIndex == splashData.length - 1)
                          ? kPrimaryColor
                          : Colors.grey,
                      onPress: () {
                        if (currentIndex == splashData.length - 1) {
                          Navigator.pushNamed(context, SignUpScreen.routeName);
                          _btnController.reset();
                        }
                      },
                      text: sContinue,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget contentDot({int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: (currentIndex == index) ? 18 : 6,
      decoration: BoxDecoration(
        color: (currentIndex == index) ? kPrimaryColor : Colors.grey.shade400,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
