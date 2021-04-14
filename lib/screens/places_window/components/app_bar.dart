import 'package:conquer_bulgaria_app/constants.dart';
import 'package:conquer_bulgaria_app/model/data.dart';
import 'package:conquer_bulgaria_app/screens/main_window/components/app_bar.dart';
import 'package:conquer_bulgaria_app/size_config.dart';
import 'package:conquer_bulgaria_app/strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    centerTitle: true,
    title: Text(
      sPlacesLong,
      style: TextStyle(
        color: kPrimaryColor,
        fontSize: getProportionateScreenWidth(20),
        fontWeight: FontWeight.w700,
      ),
    ),
    elevation: 10,
    actions: [
      userIcon(context, Provider.of<Data>(context).currentUser.picture),
    ],
  );
}
