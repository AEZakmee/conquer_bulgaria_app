import 'dart:math';

import 'package:conquer_bulgaria_app/model/filters.dart';
import 'package:conquer_bulgaria_app/model/travel_location.dart';
import 'package:conquer_bulgaria_app/model/user_location.dart';
import 'package:conquer_bulgaria_app/model/user_profile.dart';
import 'package:flutter/cupertino.dart';

class Data extends ChangeNotifier {
  PlaceFilters placeFilters = PlaceFilters();

  User currentUser = User();
  void changeCurrentUser(User user) {
    print(user.places.toString() + ' ' + user.totalPlaces.toString());
    currentUser = user;
    notifyListeners();
  }

  //Map<int, TravelLocation> placesData;
  List<TravelLocation> _places = [];
  List<TravelLocation> get places => _places;
  List<TravelLocation> get sortedPlaces {
    switch (placeFilters.sortType) {
      case sortBy.range:
        if (_places[0].range == null) return _places;
        _places.sort((a, b) => a.range.compareTo(b.range));
        return _places;
      case sortBy.rating:
        _places
            .sort((a, b) => (a.overallRating == null || b.overallRating == null)
                ? 0
                : a.overallRating > b.overallRating
                    ? 0
                    : 1);
        return _places;
      case sortBy.number:
        _places.sort((a, b) => a.id > b.id ? 1 : 0);
        return _places;
      default:
        return _places;
    }
  }

  void toggleFilterSortBy(sortBy value) {
    placeFilters.sortType = value;
    notifyListeners();
  }

  void loadPlaces(List<TravelLocation> places) {
    if (_places.isEmpty || _places == null || _places.length < places.length)
      _places = places;
    else
      _places.sort((a, b) => a.id > b.id ? 1 : 0);
    for (int i = 0; i < places.length; i++) {
      _places[i].overallRating = places[i].overallRating;
      _places[i].totalRating = places[i].totalRating;
      _places[i].numberRating = places[i].numberRating;
    }
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

  TravelLocation _chosenLocation;
  TravelLocation get chosenLocation => _chosenLocation;
  void setChosenLocation(TravelLocation place) {
    _chosenLocation = place;
    notifyListeners();
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
