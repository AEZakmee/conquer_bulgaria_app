import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conquer_bulgaria_app/constants.dart';
import 'package:conquer_bulgaria_app/model/data.dart';
import 'package:conquer_bulgaria_app/model/travel_location.dart';
import 'package:conquer_bulgaria_app/model/user_location.dart';
import 'package:conquer_bulgaria_app/model/user_profile.dart';
import 'package:conquer_bulgaria_app/screens/main_window/main_window_screen.dart';
import 'package:conquer_bulgaria_app/screens/others/stream_canceler.dart';
import 'package:conquer_bulgaria_app/screens/splash/splash_screen.dart';
import 'package:conquer_bulgaria_app/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with DisposableWidget {
  final _db = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedUser;
  void initListeners() async {
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
        }).canceledBy(this);

        _db
            .collection('users')
            .orderBy('totalPlaces', descending: true)
            .limit(20)
            .snapshots()
            .listen((querySnapshot) {
          print('listening for top users');
          Provider.of<Data>(context, listen: false).changeTopUsers(querySnapshot
              .documents
              .map((element) => User.fromJson(element.data))
              .toList());
        }).canceledBy(this);

        _db.collection('places').snapshots().listen((querySnapshot) {
          print('listening for places');
          Provider.of<Data>(context, listen: false).loadPlaces(querySnapshot
              .documents
              .map((element) => TravelLocation.fromJson(element.data))
              .toList());
        }).canceledBy(this);

        await Future.delayed(Duration(milliseconds: 500));
        getLocation();
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

  Location _location = Location();
  void getLocation() async {
    print('checking services');
    if (await _checkServicePermission() == false) return;
    await _checkAndStartService();
    checkServiceChange();
  }

  bool _serviceStarted = false;
  Timer _serviceTimer;
  void checkServiceChange() async {
    _serviceTimer = Timer.periodic(Duration(seconds: 3), (Timer t) async {
      _serviceEnabled = await _location.serviceEnabled();
      if (_serviceEnabled && !_serviceStarted) {
        _serviceStarted = true;
        locationStreamCall();
        calculate();
        print('location stream started');
      } else if (!_serviceEnabled && _serviceStarted) {
        _serviceStarted = false;
        _locationStream?.cancel();
        _calculateTimer?.cancel();
        print('location stream stopped');
      }
    });
  }

  StreamSubscription<LocationData> _locationStream;
  void locationStreamCall() {
    try {
      _locationStream = _location.onLocationChanged().listen((event) {
        Provider.of<Data>(context, listen: false).setCurrentUserLocation(
            UserLocation(latitude: event.latitude, longitude: event.longitude));
      });
      _locationStream.canceledBy(this);
    } catch (e) {
      print('Location error ' + e.toString());
    }
  }

  Timer _calculateTimer;
  void calculate() async {
    _calculateTimer = Timer.periodic(Duration(seconds: 15), (Timer t) {
      print('recalculating distances');
      Provider.of<Data>(context, listen: false).calculateDistancePerTime();
    });
  }

  PermissionStatus _permissionGranted;
  Future<bool> _checkServicePermission() async {
    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.DENIED) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted == PermissionStatus.GRANTED) {
        return true;
      } else
        return false;
    } else
      return true;
  }

  bool _serviceEnabled;
  Future<bool> _checkAndStartService() async {
    _serviceEnabled = await _location.serviceEnabled();
    if (_serviceEnabled == false) {
      _serviceEnabled = await _location.requestService();
    }
    return _serviceEnabled;
  }

  @override
  void initState() {
    initListeners();
    super.initState();
  }

  @override
  void dispose() {
    cancelSubscriptions();
    _calculateTimer?.cancel();
    _serviceTimer?.cancel();
    super.dispose();
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
            SizedBox(
              width: getProportionateScreenWidth(150),
              child: Image.asset('assets/images/loading_flag.png'),
            ),
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
