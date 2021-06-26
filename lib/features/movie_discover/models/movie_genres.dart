class MovieGenresList {
  List<_MovieGenre> _genres = [];

  MovieGenresList.fromJson(Map<String, dynamic> parsedJson) {
    List<_MovieGenre> temp = [];
    for (var i = 0; i < parsedJson["genres"].length; i++) {
      _MovieGenre genre = _MovieGenre(parsedJson["genres"][i]);
      temp.add(genre);
    }
    _genres = temp;
  }

  List<_MovieGenre> get genres => _genres;
}

class _MovieGenre {
  int id;
  String name;

  _MovieGenre(genre) {
    id = genre["id"];
    name = genre["name"];
  }
}
