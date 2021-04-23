import 'dart:math';

import 'package:conquer_bulgaria_app/model/filters.dart';
import 'package:conquer_bulgaria_app/model/travel_location.dart';
import 'package:conquer_bulgaria_app/model/user_location.dart';
import 'package:conquer_bulgaria_app/model/user_profile.dart';
import 'package:flutter/cupertino.dart';

import 'chosenUser.dart';
import 'utilities.dart';

class Data extends ChangeNotifier {
  // Current User from firebase
  String userMail = '';
  void loadUserEmail(String email) {
    userMail = email;
    notifyListeners();
  }

  User currentUser = User();
  void changeCurrentUser(User user) {
    currentUser = user;
    notifyListeners();
  }

  // Current user location tracking
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

  // Top users
  List<User> _topUsers = [];
  List<User> get topUsers => _topUsers;
  int get topUsersLength => _topUsers.length ?? 0;
  void changeTopUsers(List<User> users) {
    _topUsers = users;
    notifyListeners();
  }

  //Getting places data from firebase
  List<TravelLocation> _places = [];
  List<TravelLocation> get getMainScreenPlaces =>
      mainScreenPlaces(_places, currentUser.places);
  List<TravelLocation> get places => _places;
  int get placesLength => _places.length ?? 0;
  void loadPlaces(List<TravelLocation> places) {
    if (_places.isEmpty || _places == null || _places.length < places.length)
      _places = places;
    else
      for (int i = 0; i < places.length; i++) {
        _places[i].overallRating = places[i].overallRating;
        _places[i].totalRating = places[i].totalRating;
        _places[i].numberRating = places[i].numberRating;
      }
    notifyListeners();
  }

  //This sorts the data that the user requests - filters it
  PlaceFilters placeFilters = PlaceFilters();
  List<TravelLocation> get sortedPlaces {
    switch (placeFilters.sortType) {
      case sortBy.range:
        if (_places[0].range == null) return _places;
        return sortByRange(_places);
      case sortBy.rating:
        return sortByRating(_places);
      case sortBy.number:
        return _places;
      case sortBy.numberVotes:
        return sortByNumberVotes(_places);
      default:
        return _places;
    }
  }

  //Filter toggle-rs
  void toggleFilterSortBy(sortBy value) {
    placeFilters.sortType = value;
    notifyListeners();
  }

//User chosen location, this tracks what user votes for and visits
  TravelLocation _chosenLocation;
  TravelLocation get chosenLocation => _chosenLocation;
  void setChosenLocation(TravelLocation place) {
    _chosenLocation = place;
    notifyListeners();
  }

  //Methods that sets the chosenUser for the User Profile Screen
  ChosenUser _chosenUser;
  ChosenUser get chosenUser => _chosenUser;
  void setChosenUser(int position) {
    User user = _topUsers[position];
    _chosenUser = ChosenUser(userData: user, position: position + 1);
    notifyListeners();
  }

  void setChosenUserSelf() {
    int position = 100;
    for (int i = 0; i < topUsersLength; i++) {
      if (_topUsers[i].username == currentUser.username) {
        position = i + 1;
      }
    }
    _chosenUser = ChosenUser(userData: currentUser, position: position);
    notifyListeners();
  }
}

//     // PlacesData().placesForUpload.forEach((element) {
//     //   Firestore.instance
//     //       .collection('places')
//     //       .document(element.id.toString())
//     //       .setData(element.toMap());
//     // });
