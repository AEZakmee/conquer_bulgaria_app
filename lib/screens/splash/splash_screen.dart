import 'components/body.dart';
import 'package:flutter/material.dart';
import '../../size_config.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = '/splash_screen';
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
