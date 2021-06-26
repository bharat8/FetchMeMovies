import 'package:fetch_me_movies/features/movie_discover/models/movie_item.dart';
import 'package:fetch_me_movies/features/movie_discover/presentation/providers/movie_provider.dart';
import 'package:fetch_me_movies/features/movie_discover/presentation/widgets/movie_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class SearchData extends SearchDelegate {
  @override
  String get searchFieldLabel => "Search for movies";
  @override
  TextStyle get searchFieldStyle => TextStyle(fontFamily: "AirbnbCereal");

  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, query);
          Provider.of<MovieProvider>(context, listen: false)
              .searchMovieBloc
              .dispose();
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    final movieProv = Provider.of<MovieProvider>(context, listen: false);
    movieProv.searchMovieBloc.searchFirstPageMovies(query);
    print("here");
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final movieProv = Provider.of<MovieProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    movieProv.searchMovieBloc.searchFirstPageMovies(query);
    return StreamBuilder(
        stream: movieProv.searchMovieBloc.searchMovies,
        builder: (context, AsyncSnapshot<MovieList> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinKitThreeBounce(
                color: Colors.green,
                size: size.height * 0.04,
              ),
            );
          }
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
                padding: EdgeInsets.only(
                    top: size.height * 0.04,
                    left: size.width * 0.05,
                    right: size.width * 0.05),
                child: MovieItemWidget(
                  movieList: snapshot.data.moviesList,
                  source: "search",
                )),
          );
        });
  }
}
