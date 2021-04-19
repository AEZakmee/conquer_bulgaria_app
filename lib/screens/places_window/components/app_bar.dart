import 'package:conquer_bulgaria_app/constants.dart';
import 'package:conquer_bulgaria_app/size_config.dart';
import 'package:conquer_bulgaria_app/strings.dart';
import 'package:flutter/material.dart';

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
    // actions: [
    //   GestureDetector(
    //     onTap: () {
    //       showModalBottomSheet(
    //         context: context,
    //         isScrollControlled: true,
    //         builder: (context) {
    //           return FilterOptions();
    //         },
    //       );
    //     },
    //     child: Padding(
    //       padding: EdgeInsets.all(getProportionateScreenHeight(10)),
    //       child: Image.asset('assets/icons/filter.png'),
    //     ),
    //   ),
    // ],
  );
}
