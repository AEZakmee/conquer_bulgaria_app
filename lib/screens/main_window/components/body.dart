import 'package:cached_network_image/cached_network_image.dart';
import 'package:conquer_bulgaria_app/constants.dart';
import 'package:conquer_bulgaria_app/model/data.dart';
import 'package:conquer_bulgaria_app/size_config.dart';
import 'package:conquer_bulgaria_app/strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bot_part.dart';
import 'search_field.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/images/main_window_background2.jpg',
              ),
              SearchField(),
            ],
          ),
          SizedBox(
            height: getProportionateScreenHeight(55),
          ),
          TitleSeeAll(
            text: sPlacesMainScreen,
            onClick: () {
              print('see all');
            },
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...List.generate(
                  Provider.of<Data>(context).placesLength,
                  (index) => Padding(
                    padding: EdgeInsets.only(
                      left: getProportionateScreenWidth(12),
                    ),
                    child: PlacesCard(
                        travelLocation:
                            Provider.of<Data>(context).demoPlaces[index],
                        onClick: () {}),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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
              child: CachedNetworkImage(
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
              ),
            ),
            Container(
              width: getProportionateScreenWidth(100),
              padding: EdgeInsets.all(
                getProportionateScreenWidth(15),
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
                      fontSize: getProportionateScreenWidth(12),
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
}
