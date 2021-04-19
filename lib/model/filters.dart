class PlaceFilters {
  sortBy sortType;
  double rangeFrom;
  double rangeTo;
  bool showVisited;

  PlaceFilters(
      {this.sortType = sortBy.number,
      this.rangeFrom = 0,
      this.showVisited,
      this.rangeTo = double.infinity});
}

enum sortBy {
  number,
  rating,
  range,
  numberVotes,
}

Map<sortBy, String> sortByStrings = {
  sortBy.number: 'Номер на обекта',
  sortBy.rating: 'Рейтинг',
  sortBy.range: 'Растояние',
  sortBy.numberVotes: 'Брой гласове',
};
