import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conquer_bulgaria_app/constants.dart';
import 'package:conquer_bulgaria_app/model/data.dart';
import 'package:conquer_bulgaria_app/model/travel_location.dart';
import 'package:conquer_bulgaria_app/model/user_profile.dart';
import 'package:conquer_bulgaria_app/screens/main_window/main_window_screen.dart';
import 'package:conquer_bulgaria_app/screens/splash/splash_screen.dart';
import 'package:conquer_bulgaria_app/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _db = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedUser;
  void initFirebaseListeners() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedUser = user;
        _db
            .collection('users')
            .document(loggedUser.email)
            .snapshots()
            .listen((snapshot) {
          print('listening for current User');
          User loggedUserData = User.fromJson(snapshot.data);
          Provider.of<Data>(context, listen: false)
              .changeCurrentUser(loggedUserData);
        });
        _db
            .collection('users')
            .orderBy('totalPlaces')
            .limit(10)
            .snapshots()
            .listen((querySnapshot) {
          print('listening for top users');
          Provider.of<Data>(context, listen: false).changeTopUsers(querySnapshot
              .documents
              .map((element) => User.fromJson(element.data))
              .toList());
        });

        _db.collection('places').snapshots().listen((querySnapshot) {
          print('listening for places');
          Provider.of<Data>(context, listen: false).loadPlaces(querySnapshot
              .documents
              .map((element) => TravelLocation.fromJson(element.data))
              .toList());
        });
        await Future.delayed(Duration(seconds: 1));
        Navigator.pushNamed(context, MainWindow.routeName);
        //print(loggedUser.email);
      } else {
        try {
          _auth.signOut();
        } catch (e) {
          print('cant signout, no sign in;/');
        }
        Navigator.popAndPushNamed(context, SplashScreen.routeName);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    initFirebaseListeners();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Conquer',
              style: TextStyle(
                fontFamily: kCoolFont,
                color: kPrimaryColor,
                fontSize: getProportionateScreenWidth(80),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            Image.asset('assets/images/loading_flag.png'),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            Text(
              'Bulgaria',
              style: TextStyle(
                fontFamily: kCoolFont,
                color: kPrimaryColor,
                fontSize: getProportionateScreenWidth(80),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
