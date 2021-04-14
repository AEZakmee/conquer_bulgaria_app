import 'package:conquer_bulgaria_app/screens/main_window/main_window_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'components/body.dart';
import 'package:flutter/material.dart';
import '../../size_config.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = '/splash_screen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
