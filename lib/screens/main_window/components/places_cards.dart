import 'package:cached_network_image/cached_network_image.dart';
import 'package:conquer_bulgaria_app/model/data.dart';
import 'package:conquer_bulgaria_app/screens/place_info_window/place_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class PlacesCard extends StatelessWidget {
  const PlacesCard({
    Key key,
    @required this.travelLocation,
  }) : super(key: key);
  final TravelLocation travelLocation;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<Data>(context, listen: false)
            .setChosenLocation(travelLocation);
        Navigator.pushNamed(context, PlacesInfoWindow.routeName);
      },
      child: SizedBox(
        width: getProportionateScreenHeight(120),
        child: Column(
          children: [
            Hero(
              tag: travelLocation.id,
              child: AspectRatio(
                aspectRatio: 1.39,
                child: cachedImage(),
              ),
            ),
            Container(
              width: getProportionateScreenHeight(120),
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
                          10 + (6 / travelLocation.name.length) * 8),
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
