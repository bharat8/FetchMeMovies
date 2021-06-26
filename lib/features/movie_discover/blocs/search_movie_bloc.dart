import 'package:fetch_me_movies/features/movie_discover/models/movie_item.dart';
import 'package:fetch_me_movies/features/movie_discover/repositories/repository.dart';
import 'package:rxdart/rxdart.dart';

class SearchMovieBloc {
  final _repository = Repository();
  final _moviesController = BehaviorSubject<MovieList>();

  Stream<MovieList> get searchMovies => _moviesController.stream;

  Future<void> searchFirstPageMovies(String query) async {
    MovieList movieList = await _repository.searchFirstPageMovies(query);
    _moviesController.sink.add(movieList);
  }

  Future<void> searchNextPageMovies(String query, int pageNumber) async {
    MovieList movieList =
        await _repository.searchNextPagesMovies(query, pageNumber);
    _moviesController.sink.add(movieList);
  }

  void dispose() {
    _moviesController.close();
  }
}
