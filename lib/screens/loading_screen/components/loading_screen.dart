import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class LoadingScreenWidget extends StatelessWidget {
  const LoadingScreenWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Conquer',
              style: TextStyle(
                fontFamily: kCoolFont,
                color: kPrimaryColor,
                fontSize: getProportionateScreenWidth(80),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            SizedBox(
              width: getProportionateScreenWidth(150),
              child: Image.asset('assets/images/loading_flag.png'),
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            Text(
              'Bulgaria',
              style: TextStyle(
                fontFamily: kCoolFont,
                color: kPrimaryColor,
                fontSize: getProportionateScreenWidth(80),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
