import 'package:fetch_me_movies/features/movie_discover/models/movie_item.dart';
import 'package:fetch_me_movies/features/movie_discover/presentation/providers/movie_provider.dart';
import 'package:fetch_me_movies/features/movie_discover/presentation/widgets/movie_item_widget.dart';
import 'package:fetch_me_movies/features/movie_discover/presentation/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _scrollController;
  ScrollController _searchScrollController;
  int currentPage = 1;

  @override
  void initState() {
    final movieProv = Provider.of<MovieProvider>(context, listen: false);
    movieProv.movieBloc.fetchFirstPageMovies();
    movieProv.movieGenreBloc.fetchAllGenres();
    _scrollController = ScrollController();
    _scrollController.addListener(listener);
    super.initState();
  }

  void listener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      final movieProv = Provider.of<MovieProvider>(context, listen: false);
      if (currentPage <= movieProv.totalPages) currentPage += 1;
      movieProv.movieBloc.fetchNextPageMovies(currentPage);
    }
  }

  @override
  void dispose() {
    final movieProv = Provider.of<MovieProvider>(context, listen: false);
    movieProv.movieBloc.dispose();
    movieProv.movieGenreBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final movieProv = Provider.of<MovieProvider>(context, listen: false);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + size.height * 0.03,
            left: size.width * 0.05,
            right: size.width * 0.05),
        child: SingleChildScrollView(
          controller: _scrollController,
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Top Movies",
                      style: TextStyle(
                          fontSize: size.height * 0.038,
                          fontWeight: FontWeight.w600)),
                  GestureDetector(
                      onTap: () =>
                          showSearch(context: context, delegate: SearchData()),
                      child: Container(
                          width: size.width * 0.1,
                          height: size.width * 0.1,
                          padding: EdgeInsets.all(size.height * 0.01),
                          // color: Colors.white,
                          child: Image.asset(
                            "assets/images/search.png",
                          ))),
                ],
              ),
              StreamBuilder(
                  stream: movieProv.movieBloc.fetchMovies,
                  builder: (context, AsyncSnapshot<MovieList> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: SpinKitThreeBounce(
                          color: Colors.green,
                          size: size.height * 0.04,
                        ),
                      );
                    }
                    movieProv.addMoviesToList(snapshot.data);
                    return MovieItemWidget(movieList: movieProv.getMoviesList);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
