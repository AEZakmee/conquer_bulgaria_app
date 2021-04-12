import 'package:cached_network_image/cached_network_image.dart';
import 'package:conquer_bulgaria_app/model/cached_image.dart';
import 'package:conquer_bulgaria_app/model/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class TopStack extends StatelessWidget {
  const TopStack({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: Provider.of<Data>(context).chosenLocation.id,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomRight,
        children: [
          Container(
            child: SizedBox(
              height: getProportionateScreenHeight(340),
              child: CustomCachedImage(
                travelLocation: Provider.of<Data>(context).chosenLocation,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(getProportionateScreenWidth(80)),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: getProportionateScreenHeight(-60),
            child: Container(
              height: getProportionateScreenHeight(100),
              width: getProportionateScreenWidth(290),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    getProportionateScreenWidth(25),
                  ),
                  bottomLeft: Radius.circular(
                    getProportionateScreenWidth(25),
                  ),
                ),
                boxShadow: [kBoxShadow],
              ),
            ),
          )
        ],
      ),
    );
  }
}
