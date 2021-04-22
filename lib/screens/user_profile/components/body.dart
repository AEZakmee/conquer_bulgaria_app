import 'package:auto_size_text/auto_size_text.dart';
import 'package:conquer_bulgaria_app/constants.dart';
import 'package:conquer_bulgaria_app/model/data.dart';
import 'package:conquer_bulgaria_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'info_rows.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade300,
      child: Column(
        children: [
          Container(
            //height: getProportionateScreenHeight(350),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(45),
                bottomRight: Radius.circular(45),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    DefaultText(
                      string: 'Лични данни',
                      textAlign: TextAlign.center,
                      color: kBoldTextColor,
                    ),
                    PrivateDataInfoBox(
                      infoType: 'Име: ',
                      data: Provider.of<Data>(context).currentUser.username,
                    ),
                    PrivateDataInfoBox(
                      infoType: 'Емейл: ',
                      data: Provider.of<Data>(context).userMail,
                    ),
                    Divider(),
                    DefaultText(
                      string: 'Статистика',
                      textAlign: TextAlign.center,
                      color: kBoldTextColor,
                    ),
                    InfoBox(
                      infoType: 'Брой постени обекти',
                      data: Provider.of<Data>(context)
                          .currentUser
                          .totalPlaces
                          .toString(),
                    ),
                    InfoBox(
                      infoType: 'Брой оценени обекти',
                      data: Provider.of<Data>(context)
                          .currentUser
                          .votedPlaces
                          .length
                          .toString(),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
