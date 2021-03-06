import 'package:conquer_bulgaria_app/screens/sign_in/sign_up_screen.dart';

import '../../size_config.dart';
import 'components/body.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = '/sign_in';
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
