import 'dart:async';
import 'package:fetch_me_movies/features/movie_discover/models/movie_item.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';

class MovieApiProvider {
  Client client = Client();
  final _apiKey = '25b8fd7f2694a9352dfe81cbc7aec0fe';

  Future<MovieList> fetchFirstPageMoviesList() async {
    final response = await client.get(Uri.parse(
        "https://api.themoviedb.org/3/trending/movie/week?api_key=$_apiKey&page=1"));
    // print(response.body.toString());
    if (response.statusCode == 200) {
      return MovieList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<MovieList> fetchNextPageMoviesList(int pageNumber) async {
    final response = await client.get(Uri.parse(
        "https://api.themoviedb.org/3/trending/movie/week?api_key=$_apiKey&page=$pageNumber"));
    // print(response.body.toString());
    if (response.statusCode == 200) {
      return MovieList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}
