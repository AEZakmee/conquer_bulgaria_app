import 'package:conquer_bulgaria_app/model/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class LocationInformation extends StatelessWidget {
  const LocationInformation({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 8,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: getProportionateScreenWidth(280),
            child: Text(
              Provider.of<Data>(context).chosenLocation.name,
              style: TextStyle(
                fontSize: getProportionateScreenWidth(25),
                color: kBoldTextColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(
              right: 8,
            ),
            child: Text(
              (Provider.of<Data>(context).chosenLocation.range != null)
                  ? Provider.of<Data>(context)
                          .chosenLocation
                          .range
                          .toStringAsFixed(1) +
                      'км'
                  : '',
              style: TextStyle(
                fontSize: getProportionateScreenWidth(18),
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LocationStory extends StatelessWidget {
  const LocationStory({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        (Provider.of<Data>(context).chosenLocation.info != null)
            ? Provider.of<Data>(context).chosenLocation.info
            : '',
        style: TextStyle(
          fontSize: getProportionateScreenWidth(15),
          color: Colors.black87,
        ),
      ),
    );
  }
}
