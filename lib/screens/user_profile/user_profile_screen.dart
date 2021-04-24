import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../size_config.dart';
import 'components/body.dart';

class UserProfile extends StatelessWidget {
  static String routeName = '/user_profile';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Профил',
          style: TextStyle(
            color: kPrimaryColor,
            fontSize: getProportionateScreenWidth(20),
            fontWeight: FontWeight.w700,
          ),
        ),
        elevation: 10,
      ),
      body: Body(),
    );
  }
}
