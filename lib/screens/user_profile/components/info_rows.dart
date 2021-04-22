import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class InfoBox extends StatelessWidget {
  const InfoBox({
    Key key,
    @required this.infoType,
    @required this.data,
  }) : super(key: key);
  final String infoType;
  final String data;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(14),
          ),
          child: Row(
            children: [
              Expanded(
                child: DefaultText(
                  string: infoType,
                  size: 18,
                ),
                flex: 5,
              ),
              Expanded(
                child: DefaultText(
                  string: data,
                  textAlign: TextAlign.end,
                ),
                flex: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PrivateDataInfoBox extends StatelessWidget {
  const PrivateDataInfoBox({
    Key key,
    @required this.infoType,
    @required this.data,
  }) : super(key: key);
  final String infoType;
  final String data;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(14),
          ),
          child: Row(
            children: [
              DefaultText(
                string: infoType,
                size: 18,
              ),
              SizedBox(
                width: getProportionateScreenWidth(20),
              ),
              DefaultText(
                string: data,
                textAlign: TextAlign.end,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DefaultText extends StatelessWidget {
  const DefaultText({
    Key key,
    this.string,
    this.size = 22,
    this.textAlign = TextAlign.start,
    this.color = kTextColor,
  }) : super(key: key);
  final String string;
  final double size;
  final TextAlign textAlign;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      string,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontSize: getProportionateScreenWidth(size),
        fontWeight: FontWeight.bold,
      ),
      maxLines: 1,
    );
  }
}
