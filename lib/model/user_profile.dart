import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String username;
  String picture;
  int totalPlaces;
  List<int> places;
  List<int> votedPlaces;

  User(
      {this.username,
      this.places,
      this.picture,
      this.totalPlaces,
      this.votedPlaces});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        username: json['username'],
        picture: json['picture'],
        totalPlaces: json['totalPlaces'],
        places: List.from(json['places']),
        votedPlaces: List.from(json['votedPlaces']));
  }

  Map<String, dynamic> toMap() {
    return {
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
