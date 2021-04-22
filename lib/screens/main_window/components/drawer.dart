import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conquer_bulgaria_app/model/data.dart';
import 'package:conquer_bulgaria_app/model/travel_location.dart';
import 'package:conquer_bulgaria_app/screens/user_profile/user_profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key key,
    @required String userMail,
  })  : _userMail = userMail,
        super(key: key);

  final String _userMail;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/drawer_image.jpg'),
                  fit: BoxFit.fill),
            ),
            accountName: Text(
              Provider.of<Data>(context).currentUser.username,
              style: TextStyle(
                color: Colors.white,
                fontSize: getProportionateScreenWidth(18),
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: Text(
              _userMail,
              style: TextStyle(
                color: Colors.white,
                fontSize: getProportionateScreenWidth(14),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Моят профил'),
            onTap: () {
              Navigator.pushNamed(context, UserProfile.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Изход'),
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
    );
  }
}
