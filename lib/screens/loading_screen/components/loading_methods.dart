import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conquer_bulgaria_app/model/data.dart';
import 'package:conquer_bulgaria_app/model/travel_location.dart';
import 'package:conquer_bulgaria_app/model/user_location.dart';
import 'package:conquer_bulgaria_app/model/user_profile.dart';
import 'package:conquer_bulgaria_app/screens/main_window/main_window_screen.dart';
import 'package:conquer_bulgaria_app/screens/others/stream_canceler.dart';
import 'package:conquer_bulgaria_app/screens/splash/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'loading_screen.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with DisposableWidget {
  final _db = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  FirebaseUser _loggedUser;

  // If you managed to find that file and actually know what you are doing
  // I'm so sorry :D It's my first time working with firebase and streams
  // If you don't know what you are doing - That's the best way to do it lol
  // Kris - 19.04.2020

  //This checks if the user is already signed in
  //If it is, then
  //Initializes listeners for realtime data from firebase
  //If it's not
  //The user is sent to registration screens
  void initListeners() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        _loggedUser = user;

        //Current user data
        _db
            .collection('users')
            .document(_loggedUser.email)
            .snapshots()
            .listen((snapshot) {
          print('listening for current User');
          User loggedUserData = User.fromJson(snapshot.data);
          Provider.of<Data>(context, listen: false)
              .changeCurrentUser(loggedUserData);
          //If you are wondering what canceledBy() is
          //check /screens/others/stream_canceler.dart :)
        }).canceledBy(this);

        //Top 20 users data
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

        //Travel Locations
        _db.collection('places').snapshots().listen((querySnapshot) {
          print('listening for places');
          Provider.of<Data>(context, listen: false).loadPlaces(querySnapshot
              .documents
              .map((element) => TravelLocation.fromJson(element.data))
              .toList());
        }).canceledBy(this);

        await Future.delayed(Duration(milliseconds: 750));
        //Starts the User location stream
        getLocation();
        //Proceeds to the next screen
        Navigator.pushNamed(context, MainWindow.routeName);
      } else {
        try {
          _auth.signOut();
        } catch (e) {
          print('Something went wrong signing-out');
        }
        //Sends user to registration
        Navigator.popAndPushNamed(context, SplashScreen.routeName);
      }
    } catch (e) {
      print(e);
    }
  }

  //Initialize locations
  Location _location = Location();
  void getLocation() async {
    print('checking services');
    //Checks and ask for permission
    if (await _checkServicePermission() == false) return;
    //Checks and ask for services;
    await _checkAndStartService();
    //Starts a timer that constantly check for services
    checkServiceChange();
  }

  bool _serviceStarted = false;
  Timer _serviceTimer;
  //Checks for service change every 3 seconds
  void checkServiceChange() async {
    _serviceTimer = Timer.periodic(Duration(seconds: 3), (Timer t) async {
      _serviceEnabled = await _location.serviceEnabled();
      //If service is enabled and not yet started
      //The stream for getting location is started and the calculate function is called
      if (_serviceEnabled && !_serviceStarted) {
        _serviceStarted = true;
        locationStreamCall();
        calculate();
        print('location stream started');
      }
      //If service is not enabled but it has been started
      //(This happens when the user stops the gps while using the app)
      //In that case the stream and the calculate timer are stopped
      else if (!_serviceEnabled && _serviceStarted) {
        _serviceStarted = false;
        _locationStream?.cancel();
        _calculateTimer?.cancel();
        print('location stream stopped');
      }
    });
  }

  StreamSubscription<LocationData> _locationStream;
  //Location stream gets realtime data for user location
  //Updates the user data using the provider
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
  //This function starts a timer that is ran every 15 seconds
  //to recalculate the distance between all locations and the user
  //this data is used by the UI to show how far the user is from given location
  //and also other things like when the user wants to check that he has visited a place for example
  void calculate() async {
    _calculateTimer = Timer.periodic(Duration(seconds: 15), (Timer t) {
      print('recalculating distances');
      Provider.of<Data>(context, listen: false).calculateDistancePerTime();
    });
  }

  PermissionStatus _permissionGranted;
  //Checks and asks for gps permissions, simple
  //Yes I know there is a better way then 3 returns, but that works ;d
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
  //Checks for service
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
    //cancelSubscriptions() is a method from the DisposableWidget mixin/interface
    cancelSubscriptions();
    _calculateTimer?.cancel();
    _serviceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScreenWidget();
  }
}
