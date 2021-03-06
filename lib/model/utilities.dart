import 'dart:math';
import 'package:conquer_bulgaria_app/model/travel_location.dart';

double calculateDistance(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  return 12742 * asin(sqrt(a));
}

List<TravelLocation> sortByRange(List<TravelLocation> currentPlaces) {
  var filteredPlaces = new List<TravelLocation>.from(currentPlaces);
  filteredPlaces.sort((a, b) => a.range.compareTo(b.range));
  return filteredPlaces;
}

List<TravelLocation> sortByRating(List<TravelLocation> currentPlaces) {
  var filteredPlaces = new List<TravelLocation>.from(currentPlaces);
  filteredPlaces.sort((a, b) {
    if (a.overallRating == b.overallRating)
      return b.numberRating.compareTo(a.numberRating);
    else
      return b.overallRating.compareTo(a.overallRating);
  });
  //print(filteredPlaces.map((e) => e.overallRating).join(' '));
  return filteredPlaces;
}

List<TravelLocation> sortByNumberVotes(List<TravelLocation> currentPlaces) {
  var filteredPlaces = new List<TravelLocation>.from(currentPlaces);
  filteredPlaces.sort((a, b) {
    if (a.numberRating == b.numberRating)
      return b.overallRating.compareTo(a.overallRating);
    else
      return b.numberRating.compareTo(a.numberRating);
  });
  return filteredPlaces;
}

List<TravelLocation> mainScreenPlaces(
    List<TravelLocation> currentPlaces, List<int> userPlaces) {
  if (currentPlaces.isEmpty) return [];
  var filteredPlaces = new List<TravelLocation>.from(currentPlaces);
  if (currentPlaces[0].range != null) {
    filteredPlaces.sort((a, b) => a.range.compareTo(b.range));
  }
  List<TravelLocation> newPlaces = [];
  int count = 0;
  for (int i = 0; i < filteredPlaces.length; i++) {
    if (!userPlaces.contains(filteredPlaces[i].id)) {
      newPlaces.add(filteredPlaces[i]);
      count++;
      if (count == 5) break;
    }
  }
  if (newPlaces.isEmpty) {
    int range = filteredPlaces.length < 7 ? filteredPlaces.length : 5;
    for (int i = 0; i < range; i++) {
      newPlaces.add(filteredPlaces[i]);
    }
  }
  return newPlaces;
}

bool itemContainsQuery(TravelLocation item, String query) {
  return item.name.toLowerCase().contains(query.toLowerCase().trim()) ||
      item.town.toLowerCase().contains(query.toLowerCase().trim());
}
