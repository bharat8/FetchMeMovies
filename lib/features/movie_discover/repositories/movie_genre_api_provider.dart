import 'dart:convert';

import 'package:fetch_me_movies/features/movie_discover/models/movie_genres.dart';
import 'package:http/http.dart';

class MovieGenreApiProvider {
  Client client = Client();
  final _apiKey = '25b8fd7f2694a9352dfe81cbc7aec0fe';

  Future<MovieGenresList> fetchMoviesGenresList() async {
    final response = await client.get(Uri.parse(
        "https://api.themoviedb.org/3/genre/movie/list?api_key=$_apiKey&language=en-US"));
    // print(response.body.toString());
    if (response.statusCode == 200) {
      return MovieGenresList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}
