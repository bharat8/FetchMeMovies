import 'package:fetch_me_movies/features/movie_discover/models/movie_genres.dart';
import 'package:fetch_me_movies/features/movie_discover/repositories/repository.dart';
import 'package:rxdart/rxdart.dart';

class MovieGenreBloc {
  final _repository = Repository();
  final _moviesGenresController = BehaviorSubject<MovieGenresList>();

  Stream<MovieGenresList> get fetchGenres => _moviesGenresController.stream;

  Future<void> fetchAllGenres() async {
    MovieGenresList movieList = await _repository.fetchAllGenres();
    _moviesGenresController.sink.add(movieList);
  }

  void dispose() {
    _moviesGenresController.close();
  }
}
