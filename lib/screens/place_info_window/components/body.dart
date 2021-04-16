import 'package:cached_network_image/cached_network_image.dart';
import 'package:conquer_bulgaria_app/constants.dart';
import 'package:conquer_bulgaria_app/model/data.dart';
import 'package:conquer_bulgaria_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'location_info.dart';
import 'top_stack.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopStack(),
          SizedBox(
            height: getProportionateScreenHeight(60),
          ),
          LocationInformation(),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          LocationStory(),
          SizedBox(
            height: getProportionateScreenHeight(80),
          ),
        ],
      ),
    );
  }
}
