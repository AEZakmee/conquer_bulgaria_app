import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import '../../../strings.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: getProportionateScreenHeight(-30),
      child: Container(
        width: getProportionateScreenWidth(300),
        height: getProportionateScreenHeight(60),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: kBoxColor),
          boxShadow: [
            BoxShadow(
              offset: Offset(3, 3),
              blurRadius: 10,
              color: Colors.black.withOpacity(0.7),
              spreadRadius: -1,
            ),
          ],
        ),
        child: TextField(
          onChanged: (v) {},
          cursorColor: kPrimaryColor,
          decoration: InputDecoration(
            enabledBorder: kSearchOutlineInputBorder,
            focusedBorder: kSearchOutlineInputBorder,
            border: kSearchOutlineInputBorder,
            hintText: sSearchPlace,
            hintStyle: TextStyle(color: kBoxColor),
            suffixIcon: GestureDetector(
              onTap: () {
                print('searched');
              },
              child: Icon(
                Icons.search,
                color: kPrimaryColor,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
              vertical: getProportionateScreenHeight(15),
            ),
          ),
        ),
      ),
    );
  }
}
