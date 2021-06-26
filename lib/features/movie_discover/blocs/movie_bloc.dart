import 'package:fetch_me_movies/features/movie_discover/models/movie_item.dart';
import 'package:fetch_me_movies/features/movie_discover/repositories/repository.dart';
import 'package:rxdart/rxdart.dart';

class MovieBloc {
  final _repository = Repository();
  final _moviesController = BehaviorSubject<MovieList>();

  Stream<MovieList> get fetchMovies => _moviesController.stream;

  Future<void> fetchFirstPageMovies() async {
    MovieList movieList = await _repository.fetchFirstPageMovies();
    _moviesController.sink.add(movieList);
  }

  Future<void> fetchNextPageMovies(int pageNumber) async {
    MovieList movieList = await _repository.fetchNextPageMovies(pageNumber);
    _moviesController.sink.add(movieList);
  }

  void dispose() {
    _moviesController.close();
  }
}
