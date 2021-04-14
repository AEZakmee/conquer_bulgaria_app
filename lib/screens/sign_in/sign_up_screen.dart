import 'package:conquer_bulgaria_app/screens/splash/splash_screen.dart';

import '../../size_config.dart';
import 'components/sign_up_body.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  static String routeName = '/sign_up';
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SignUpBody(),
    );
  }
}
