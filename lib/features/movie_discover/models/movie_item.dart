class MovieList {
  int _page;
  int _totalResults;
  int _totalPages;
  List<MovieItem> _moviesList = [];

  MovieList.fromJson(Map<String, dynamic> parsedJson) {
    _page = parsedJson['page'];
    _totalResults = parsedJson['total_results'];
    _totalPages = parsedJson['total_pages'];
    List<MovieItem> temp = [];
    for (int i = 0; i < parsedJson['results'].length; i++) {
      MovieItem result = MovieItem(parsedJson['results'][i]);
      temp.add(result);
    }
    _moviesList = temp;
  }

  List<MovieItem> get moviesList => _moviesList;

  int get page => _page;

  int get totalResults => _totalResults;

  int get totalPages => _totalPages;
}

class MovieItem {
  int _voteCount;
  int _id;
  bool _video;
  var _voteAverage;
  String _title;
  double _popularity;
  String _posterPath;
  String _originalLanguage;
  String _originalTitle;
  List<int> _genreIds = [];
  String _backdropPath;
  bool _adult;
  String _overview;
  String _releaseDate;

  MovieItem(movieItem) {
    _voteCount = movieItem['vote_count'];
    _id = movieItem['id'];
    _video = movieItem['video'];
    _voteAverage = movieItem['vote_average'];
    _title = movieItem['title'];
    _popularity = movieItem['popularity'];
    _posterPath = movieItem['poster_path'];
    _originalLanguage = movieItem['original_language'];
    _originalTitle = movieItem['original_title'];
    for (int i = 0; i < movieItem['genre_ids'].length; i++) {
      _genreIds.add(movieItem['genre_ids'][i]);
    }
    _backdropPath = movieItem['backdrop_path'];
    _adult = movieItem['adult'];
    _overview = movieItem['overview'];
    _releaseDate = movieItem['release_date'];
  }

  int get voteCount => _voteCount;

  int get id => _id;

  bool get video => _video;

  double get voteAverage => _voteAverage;

  String get title => _title;

  double get popularity => _popularity;

  String get posterPath => _posterPath;

  String get originalLanguage => _originalLanguage;

  String get originalTitle => _originalTitle;

  List<int> get genreIds => _genreIds;

  String get backdropPath => _backdropPath;

  bool get adult => _adult;

  String get overview => _overview;

  String get releaseDate => _releaseDate;
}
