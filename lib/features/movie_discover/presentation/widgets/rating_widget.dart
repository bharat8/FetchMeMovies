import 'package:fetch_me_movies/features/movie_discover/presentation/providers/movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingWidget extends StatelessWidget {
  const RatingWidget({
    Key key,
    @required this.size,
    @required this.index,
    @required this.movieProv,
  }) : super(key: key);

  final Size size;
  final MovieProvider movieProv;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Color(0xff393b47), borderRadius: BorderRadius.circular(5)),
        padding: EdgeInsets.symmetric(
            vertical: size.height * 0.005, horizontal: size.height * 0.0025),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            RatingBar.builder(
              initialRating: (movieProv.getMoviesList[index].voteAverage / 2)
                  .floor()
                  .toDouble(),
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: size.height * 0.03,
              ignoreGestures: true,
              itemPadding: EdgeInsets.symmetric(horizontal: 2),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: null,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
              child: Row(
                children: [
                  Text((movieProv.getMoviesList[index].voteAverage / 2)
                      .floor()
                      .toString()),
                  Text("/5")
                ],
              ),
            ),
          ],
        ));
  }
}
