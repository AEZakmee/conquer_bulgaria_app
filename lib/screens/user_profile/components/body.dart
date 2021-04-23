import 'package:auto_size_text/auto_size_text.dart';
import 'package:conquer_bulgaria_app/constants.dart';
import 'package:conquer_bulgaria_app/model/data.dart';
import 'package:conquer_bulgaria_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade300,
      child: Text(Provider.of<Data>(context).chosenUser.badges.join('')),
    );
  }
}
