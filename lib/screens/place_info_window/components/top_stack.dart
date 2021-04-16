import 'package:cached_network_image/cached_network_image.dart';
import 'package:conquer_bulgaria_app/model/cached_image.dart';
import 'package:conquer_bulgaria_app/model/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class TopStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
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
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: FittedBox(
                            child: SvgPicture.asset(
                              'assets/icons/star_fill.svg',
                            ),
                          ),
                        ),
                        FittedBox(
                          child: Text(
                            '8,4/10',
                            style: TextStyle(fontWeight: FontWeight.w800),
                          ),
                        ),
                        FittedBox(
                          child: Text('123 гласа'),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: FittedBox(
                            child: SvgPicture.asset(
                              'assets/icons/star.svg',
                            ),
                          ),
                        ),
                        FittedBox(
                          child: Text(
                            'Гласувай',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: getProportionateScreenWidth(13),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: FittedBox(
                            child: Icon(
                              Icons.navigation,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ),
                        FittedBox(
                          child: Text(
                            'Навигация',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: getProportionateScreenWidth(13),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
