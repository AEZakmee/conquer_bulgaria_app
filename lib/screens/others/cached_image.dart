import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

import '../../constants.dart';
import '../../model/travel_location.dart';

class CustomCachedImage extends StatelessWidget {
  const CustomCachedImage({
    Key key,
    @required this.travelLocation,
    this.borderRadius,
    this.hasShadow = false,
  }) : super(key: key);

  final TravelLocation travelLocation;
  final BorderRadius borderRadius;
  final bool hasShadow;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: travelLocation.image,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          boxShadow: hasShadow ? [kBoxShadow] : [],
          borderRadius: borderRadius,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => BlurHash(hash: travelLocation.imageHash),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
