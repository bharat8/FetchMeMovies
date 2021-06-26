import 'dart:convert';

import 'package:fetch_me_movies/features/movie_discover/models/movie_item.dart';
import 'package:http/http.dart';

class SearchMovieApiProvider {
  Client client = Client();
  final _apiKey = '25b8fd7f2694a9352dfe81cbc7aec0fe';

  Future<MovieList> searchFirstPageMoviesList(String query) async {
    final response = await client.get(Uri.parse(
        "https://api.themoviedb.org/3/search/movie?api_key=$_apiKey&language=en-US&query=$query&page=1&include_adult=false"));
    // print(response.body.toString());
    if (response.statusCode == 200) {
      return MovieList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<MovieList> searchNextPagesMoviesList(
      String query, int pageNumber) async {
    final response = await client.get(Uri.parse(
        "https://api.themoviedb.org/3/search/movie?api_key=$_apiKey&language=en-US&query=$query&page=$pageNumber&include_adult=false"));
    // print(response.body.toString());
    if (response.statusCode == 200) {
      return MovieList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}
