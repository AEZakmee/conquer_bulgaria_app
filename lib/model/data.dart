import 'dart:math';

import 'package:conquer_bulgaria_app/model/travel_location.dart';
import 'package:conquer_bulgaria_app/model/user_location.dart';
import 'package:conquer_bulgaria_app/model/user_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';

class Data extends ChangeNotifier {
  User currentUser = User();
  void changeCurrentUser(User user) {
    currentUser = user;
    notifyListeners();
  }

  List<TravelLocation> _places = [];
  List<TravelLocation> get places => _places;
  void loadPlaces(List<TravelLocation> places) {
    _places = places;
    notifyListeners();
  }

  List<User> _topUsers = [];
  List<User> get topUsers => _topUsers;
  void changeTopUsers(List<User> users) {
    _topUsers = users;
    notifyListeners();
  }

  int get placesLength => _places.length ?? 0;
  int get topUsersLength => _topUsers.length ?? 0;

  void userVisitedPlace(int id) {
    currentUser.places.add(id);
    notifyListeners();
  }

  TravelLocation _chosenLocation;
  TravelLocation get chosenLocation => _chosenLocation;
  void setChosenLocation(TravelLocation place) {
    _chosenLocation = place;
    notifyListeners();
  }

  Future<List<TravelLocation>> getSuggestions(String pattern) async {
    await Future.delayed(Duration(seconds: 1));
    List<TravelLocation> searched = [];
    if (pattern.length > 3) {
      _places.forEach((e) => searched.add(e));
    }
    return searched;
  }

  UserLocation get currentUserLocation => _currentLocation;
  UserLocation _currentLocation;
  void setCurrentUserLocation(UserLocation userLocation) {
    _currentLocation = userLocation;
  }

  void calculateDistancePerTime() {
    assert(_currentLocation != null, 'current location is null');
    _places?.forEach((element) {
      element.range = calculateDistance(element.latitude, element.longitude,
          _currentLocation.latitude, _currentLocation.longitude);
    });
    notifyListeners();
  }

  static double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}

// class FirestoreService {
//   Firestore _db = Firestore.instance;
//   Stream<List<User>> getUsers() {
//     return _db.collection('users').snapshots().map((snapshot) =>
//         snapshot.documents.map((doc) => User.fromJson(doc.data)).toList());
//   }
//
//   Future<List<User>> getTopUsers() {
//     return _db
//         .collection('users')
//         .orderBy('totalPlaces')
//         .limit(10)
//         .getDocuments()
//         .then((querySnapshot) => querySnapshot.documents
//         .map((element) => User.fromJson(element.data))
//         .toList())
//         .whenComplete(() => print('all good'));
//   }
//
//   Future<User> getUserByEmail({String email}) {
//     return _db
//         .collection('users')
//         .document(email)
//         .get()
//         .then((value) => User.fromJson(value.data))
//         .onError((error, stackTrace) {
//       print(error);
//       return User(
//           places: [-1], totalPlaces: -1, picture: 'none', username: 'none');
//     });
//   }
// }
