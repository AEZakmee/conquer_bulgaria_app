import 'package:conquer_bulgaria_app/model/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    //elevation: 0,
    leading: IconButton(
      icon: Icon(
        Icons.menu,
      ),
      onPressed: () {
        //Todo menu functionality
        Provider.of<Data>(context, listen: false).changeCurrentUser(
          User(
              name: 'gosho',
              image:
                  'https://img.freepik.com/free-photo/handsome-young-businessman-shirt-eyeglasses_85574-6228.jpg?size=626&ext=jpg'),
        );
      },
    ),
    actions: [
      userIcon(context, Provider.of<Data>(context).currentUser.image),
    ],
  );
}

Padding userIcon(context, String imageUrl) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
    child: GestureDetector(
      onTap: () {
        print('cl');
      },
      child: Container(
        width: getProportionateScreenWidth(60),
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
    ),
  );
}
