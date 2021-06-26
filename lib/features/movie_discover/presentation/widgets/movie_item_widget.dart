import 'package:fetch_me_movies/features/movie_discover/models/movie_item.dart';
import 'package:fetch_me_movies/features/movie_discover/presentation/providers/movie_provider.dart';
import 'package:fetch_me_movies/features/movie_discover/presentation/screens/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'rating_widget.dart';

import 'movie_genres_widgets.dart';

class MovieItemWidget extends StatefulWidget {
  final String source;
  final int currentIndex;
  final List<MovieItem> movieList;
  MovieItemWidget({this.currentIndex, @required this.movieList, this.source});
  @override
  _MovieItemWidgetState createState() => _MovieItemWidgetState();
}

class _MovieItemWidgetState extends State<MovieItemWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final movieProv = Provider.of<MovieProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.currentIndex == null && widget.source != "search"
          ? widget.movieList.length + 1
          : widget.movieList.length,
      itemBuilder: (context, index) {
        if (index == widget.movieList.length &&
            widget.currentIndex == null &&
            widget.source != "search") {
          return Center(
            child: SpinKitThreeBounce(
              color: Colors.green,
              size: size.height * 0.04,
            ),
          );
        } else if (widget.currentIndex == null || index != widget.currentIndex)
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DetailsScreen(
                        index: index,
                        currentMovieList: widget.movieList,
                        source: widget.source,
                      )));
            },
            child: Padding(
              padding: EdgeInsets.only(bottom: size.height * 0.03),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: size.height * 0.28,
                  child: Row(
                    children: [
                      Container(
                        width: size.width * 0.33,
                        color: Colors.black12,
                        child: widget.movieList[index].posterPath == null ||
                                widget.movieList[index].posterPath.length == 0
                            ? Image.asset("assets/images/splash_icon.png")
                            : Image.network(
                                'https://image.tmdb.org/t/p/w185${widget.movieList[index].posterPath}',
                                fit: BoxFit.fitWidth,
                              ),
                      ),
                      Expanded(
                        child: Container(
                          color: index == 0 && widget.source == null
                              ? Color(0xff007CFF)
                              : Color(0xff272830),
                          child: Padding(
                            padding: EdgeInsets.all(size.height * 0.02),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                LayoutBuilder(
                                  builder: (context, constraints) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (index == 0 && widget.source == null)
                                          Row(
                                            children: [
                                              Container(
                                                width: size.width * 0.04,
                                                height: size.width * 0.04,
                                                child: Image.asset(
                                                    "assets/images/gold-medal.png"),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: size.width * 0.01),
                                                child: Text(
                                                  "Top Movie this week",
                                                  style: TextStyle(
                                                      color: Colors.white
                                                          .withOpacity(0.8),
                                                      fontSize:
                                                          size.height * 0.02),
                                                ),
                                              ),
                                            ],
                                          ),
                                        Text(
                                          widget.movieList[index].title ==
                                                      null ||
                                                  widget.movieList[index].title
                                                          .length ==
                                                      0
                                              ? "Movie"
                                              : widget.movieList[index].title,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: size.height * 0.027),
                                        ),
                                        if (widget.movieList[index].genreIds
                                                .length !=
                                            0)
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: size.height * 0.005),
                                            child: MovieGenresWigets(index),
                                          ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: size.height * 0.005),
                                          child: Text(
                                              widget.movieList[index]
                                                              .releaseDate ==
                                                          null ||
                                                      widget
                                                              .movieList[index]
                                                              .releaseDate
                                                              .length ==
                                                          0
                                                  ? "TBD or Unknown"
                                                  : widget.movieList[index]
                                                      .releaseDate
                                                      .substring(0, 4),
                                              style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.8))),
                                        )
                                      ],
                                    );
                                  },
                                ),
                                RatingWidget(
                                  size: size,
                                  movieProv: movieProv,
                                  index: index,
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        else
          return Container();
      },
    );
  }
}
