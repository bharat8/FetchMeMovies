import 'package:fetch_me_movies/features/movie_discover/models/movie_item.dart';
import 'package:fetch_me_movies/features/movie_discover/presentation/providers/movie_provider.dart';
import 'package:fetch_me_movies/features/movie_discover/presentation/widgets/movie_genres_widgets.dart';
import 'package:fetch_me_movies/features/movie_discover/presentation/widgets/movie_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../widgets/rating_widget.dart';

class DetailsScreen extends StatefulWidget {
  final int index;
  final String source;
  final List<MovieItem> currentMovieList;
  DetailsScreen(
      {@required this.index, @required this.currentMovieList, this.source});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final movieProv = Provider.of<MovieProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    var spacer = Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
      child: CircleAvatar(
        radius: size.height * 0.003,
        backgroundColor: Colors.white70,
      ),
    );
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: size.height * 0.7,
                      width: size.width,
                      child: ShaderMask(
                        shaderCallback: (rect) {
                          return LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.black, Colors.transparent],
                          ).createShader(
                              Rect.fromLTRB(0, 0, rect.width, rect.height));
                        },
                        blendMode: BlendMode.dstIn,
                        child:
                            widget.currentMovieList[widget.index].posterPath ==
                                        null ||
                                    widget.currentMovieList[widget.index]
                                            .posterPath.length ==
                                        0
                                ? Image.asset("assets/images/splash_icon.png")
                                : Image.network(
                                    'https://image.tmdb.org/t/p/w500${widget.currentMovieList[widget.index].posterPath}',
                                    width: size.width,
                                    fit: BoxFit.cover,
                                  ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                    top:
                        MediaQuery.of(context).padding.top + size.height * 0.02,
                    left: size.width * 0.03,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                          width: size.width * 0.12,
                          height: size.width * 0.12,
                          padding: EdgeInsets.all(size.height * 0.01),
                          // color: Colors.black26,
                          child:
                              FittedBox(child: Icon(Icons.arrow_back_rounded))),
                    )),
                Container(
                  width: size.width,
                  margin: EdgeInsets.only(top: size.height * 0.3),
                  padding: EdgeInsets.only(
                      left: size.height * 0.03, right: size.width * 0.03),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.index == 0 && widget.source == null)
                        Text(
                          "Top Movie of the week",
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: size.height * 0.025),
                        ),
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.01),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (widget.index == 0 && widget.source == null)
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: size.height * 0.01,
                                          right: size.height * 0.01),
                                      child: Container(
                                        width: size.width * 0.1,
                                        height: size.width * 0.1,
                                        child: Image.asset(
                                            "assets/images/gold-medal.png"),
                                      ),
                                    ),
                                  ),
                                Expanded(
                                  flex: 9,
                                  child: Text(
                                    widget.currentMovieList[widget.index]
                                                    .title ==
                                                null ||
                                            widget
                                                    .currentMovieList[
                                                        widget.index]
                                                    .title
                                                    .length ==
                                                0
                                        ? "Movie"
                                        : widget.currentMovieList[widget.index]
                                            .title,
                                    style: TextStyle(
                                        fontSize: size.height * 0.04,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                widget.index == 0 && widget.source == null
                                    ? Expanded(flex: 2, child: Container())
                                    : Container(),
                                Expanded(
                                  flex: 9,
                                  child: Row(
                                    children: [
                                      Text(
                                        widget.currentMovieList[widget.index]
                                                        .releaseDate ==
                                                    null ||
                                                widget
                                                    .currentMovieList[
                                                        widget.index]
                                                    .releaseDate
                                                    .isEmpty
                                            ? "TBD or Unknown"
                                            : widget
                                                .currentMovieList[widget.index]
                                                .releaseDate
                                                .substring(0, 4),
                                        style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.8)),
                                      ),
                                      spacer,
                                      if (widget.currentMovieList[widget.index]
                                              .genreIds.length !=
                                          0)
                                        Row(
                                          children: [
                                            MovieGenresWigets(widget.index),
                                          ],
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (widget.currentMovieList[widget.index].overview !=
                              null ||
                          widget.currentMovieList[widget.index].overview
                                  .length !=
                              0)
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: size.height * 0.03),
                              child: Text(
                                widget.currentMovieList[widget.index].overview,
                                style: TextStyle(
                                  fontSize: size.height * 0.022,
                                ),
                              ),
                            ),
                          ],
                        ),
                      Padding(
                          padding: EdgeInsets.only(top: size.height * 0.03),
                          child: RatingWidget(
                            size: size,
                            movieProv: movieProv,
                            index: widget.index,
                          ))
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: size.height * 0.04,
                  left: size.width * 0.05,
                  right: size.width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Also trending",
                    style: TextStyle(
                        fontSize: size.height * 0.04,
                        fontWeight: FontWeight.w600),
                  ),
                  FutureBuilder(
                    future: Future.delayed(Duration(seconds: 2)),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: SpinKitThreeBounce(
                            color: Colors.green,
                            size: size.height * 0.04,
                          ),
                        );
                      }
                      return MovieItemWidget(
                        currentIndex: widget.index,
                        movieList: movieProv.getMoviesList,
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
