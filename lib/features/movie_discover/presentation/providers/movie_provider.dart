import 'package:fetch_me_movies/features/movie_discover/blocs/movie_bloc.dart';
import 'package:fetch_me_movies/features/movie_discover/blocs/movie_genre_bloc.dart';
import 'package:fetch_me_movies/features/movie_discover/blocs/search_movie_bloc.dart';
import 'package:fetch_me_movies/features/movie_discover/models/movie_genres.dart';
import 'package:fetch_me_movies/features/movie_discover/models/movie_item.dart';
import 'package:flutter/material.dart';

class MovieProvider extends ChangeNotifier {
  MovieBloc movieBloc = MovieBloc();
  MovieGenreBloc movieGenreBloc = MovieGenreBloc();
  SearchMovieBloc searchMovieBloc = SearchMovieBloc();

  int _totalPages;
  int get totalPages => _totalPages;

  List<MovieItem> _moviesList = [];
  List<MovieItem> get getMoviesList => _moviesList;

  void addMoviesToList(MovieList val) {
    _totalPages = val.totalPages;
    _moviesList.addAll(val.moviesList);
  }

  MovieGenresList _movieGenres;
  MovieGenresList get getMovieGenresList => _movieGenres;
  set setMovieGenresList(MovieGenresList val) {
    _movieGenres = val;
  }
}
