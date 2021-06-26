import 'package:fetch_me_movies/features/movie_discover/models/movie_genres.dart';
import 'package:fetch_me_movies/features/movie_discover/models/movie_item.dart';
import 'package:fetch_me_movies/features/movie_discover/repositories/movie_api_provider.dart';
import 'package:fetch_me_movies/features/movie_discover/repositories/movie_genre_api_provider.dart';
import 'package:fetch_me_movies/features/movie_discover/repositories/search_movie_api_provider.dart';

class Repository {
  final movieApiProvider = MovieApiProvider();
  final movieGenresApiProvider = MovieGenreApiProvider();
  final searchMovieApiProvider = SearchMovieApiProvider();

  Future<MovieList> fetchFirstPageMovies() =>
      movieApiProvider.fetchFirstPageMoviesList();

  Future<MovieList> fetchNextPageMovies(int pageNumber) =>
      movieApiProvider.fetchNextPageMoviesList(pageNumber);

  Future<MovieGenresList> fetchAllGenres() =>
      movieGenresApiProvider.fetchMoviesGenresList();

  Future<MovieList> searchFirstPageMovies(String query) =>
      searchMovieApiProvider.searchFirstPageMoviesList(query);

  Future<MovieList> searchNextPagesMovies(String query, int pageNumber) =>
      searchMovieApiProvider.searchNextPagesMoviesList(query, pageNumber);
}
