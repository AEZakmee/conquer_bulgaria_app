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
  filteredPlaces
      .sort((a, b) => (a.overallRating == null || b.overallRating == null)
          ? 0
          : (a.overallRating != b.overallRating)
              ? a.overallRating > b.overallRating
                  ? 0
                  : 1
              : a.numberRating > b.numberRating
                  ? 0
                  : 1);
  return filteredPlaces;
}

bool itemContainsQuery(TravelLocation item, String query) {
  return item.name.toLowerCase().contains(query.toLowerCase()) ||
      item.town.toLowerCase().contains(query.toLowerCase());
}
