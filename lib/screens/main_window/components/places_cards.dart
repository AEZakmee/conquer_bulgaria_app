import 'package:cached_network_image/cached_network_image.dart';
import 'package:conquer_bulgaria_app/model/data.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class PlacesCard extends StatelessWidget {
  const PlacesCard({
    Key key,
    @required this.travelLocation,
    @required this.onClick,
  }) : super(key: key);
  final TravelLocation travelLocation;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: SizedBox(
        width: getProportionateScreenWidth(100),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1.39,
              child: cachedImage(),
            ),
            Container(
              width: getProportionateScreenWidth(100),
              padding: EdgeInsets.all(
                getProportionateScreenWidth(10),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [kBoxShadow],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    travelLocation.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(
                          8 + (6 / travelLocation.name.length) * 8),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(5),
            )
          ],
        ),
      ),
    );
  }

  CachedNetworkImage cachedImage() {
    return CachedNetworkImage(
      imageUrl: travelLocation.image,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          boxShadow: [kBoxShadow],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => LinearProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        backgroundColor: Colors.black45,
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
