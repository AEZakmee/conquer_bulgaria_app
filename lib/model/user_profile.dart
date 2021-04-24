import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String uniqueID;
  String username;
  String picture;
  int totalPlaces;
  List<int> places;
  List<int> votedPlaces;

  User(
      {this.uniqueID,
      this.username,
      this.places,
      this.picture,
      this.totalPlaces,
      this.votedPlaces});

  factory User.fromJson(Map<String, dynamic> json) {
    List<int> placesFilter = List.from(json['places']);
    placesFilter.removeWhere((element) => element < 1001);
    List<int> votedFilter = List.from(json['votedPlaces']);
    votedFilter.removeWhere((element) => element < 1001);
    return User(
        uniqueID: json['uniqueID'],
        username: json['username'],
        picture: json['picture'],
        totalPlaces: json['totalPlaces'],
        places: placesFilter,
        votedPlaces: votedFilter);
  }

  Map<String, dynamic> toMap() {
    return {
      'uniqueID': uniqueID,
      'username': username,
      'picture': picture,
      'totalPlaces': totalPlaces,
      'places': places,
      'votedPlaces': votedPlaces
    };
  }

  String data() {
    return this.username + ' ' + this.picture + ' ' + places.toString();
  }
}
