import 'package:flutter/material.dart';
import '../../size_config.dart';
import 'components/loading_methods.dart';

class LoadingScreen extends StatelessWidget {
  static String routeName = '/loading_window';
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
