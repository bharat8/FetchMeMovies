import 'package:fetch_me_movies/features/movie_discover/models/movie_genres.dart';
import 'package:fetch_me_movies/features/movie_discover/presentation/providers/movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieGenresWigets extends StatefulWidget {
  final int index;
  MovieGenresWigets(this.index);
  @override
  _MovieGenresWigetsState createState() => _MovieGenresWigetsState();
}

class _MovieGenresWigetsState extends State<MovieGenresWigets> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final movieProv = Provider.of<MovieProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return StreamBuilder(
        stream: movieProv.movieGenreBloc.fetchGenres,
        builder: (context, AsyncSnapshot<MovieGenresList> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData) {
            return Center(child: Text("Error Occured"));
          }
          movieProv.setMovieGenresList = snapshot.data;
          var list = movieProv.getMoviesList[widget.index].genreIds.length > 2
              ? movieProv.getMoviesList[widget.index].genreIds.sublist(0, 2)
              : movieProv.getMoviesList[widget.index].genreIds;
          return Wrap(
            direction: Axis.horizontal,
            children: [
              ...list
                  .map<Widget>((genre) => Text(
                        "${movieProv.getMovieGenresList.genres[movieProv.getMovieGenresList.genres.indexWhere((element) => element.id == genre)].name}${list.indexOf(genre) != list.length - 1 ? " / " : ""}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white.withOpacity(0.8)),
                      ))
                  .toList()
            ],
          );
        });
  }
}
