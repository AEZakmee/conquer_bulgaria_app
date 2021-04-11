import 'package:conquer_bulgaria_app/model/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import 'bot_part.dart';

class UsersRow extends StatelessWidget {
  const UsersRow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(10),
      ),
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(10),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [kBoxShadow],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ...List.generate(
              Provider.of<Data>(context).topUsersLength,
              (index) => TopUser(
                imageUrl: Provider.of<Data>(context).demoUsers[index].image,
                name: Provider.of<Data>(context).demoUsers[index].name,
                points: 12,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TopUser extends StatelessWidget {
  const TopUser({
    Key key,
    @required this.name,
    @required this.imageUrl,
    @required this.points,
  }) : super(key: key);
  final String name;
  final String imageUrl;
  final int points;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: getProportionateScreenWidth(12),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: getProportionateScreenHeight(4),
            ),
            child: Text(
              '${name[0].toUpperCase()}${name.substring(1)}',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: kBoxColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            width: getProportionateScreenWidth(45),
            height: getProportionateScreenHeight(55),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: (imageUrl == 'none')
                    ? AssetImage('assets/images/default_user_image.png')
                    : NetworkImage(imageUrl),
              ),
            ),
          ),
          Text(
            '${points.toString()} Points',
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
