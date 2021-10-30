import 'package:flutter/material.dart';
import 'package:tmdb/models/moviesModel.dart';
import 'package:tmdb/view/movieDetailPage.dart';

class MoviesTile extends StatelessWidget {

  final Results? results;
  final imageUrl;

  const MoviesTile({Key? key, this.results, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 5.0, right: 5, top: 2.5, bottom: 2.5),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return MovieDetailPage(movieId: results!.id.toString(),movieName: results!.title);
          }));
        },
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: results!.posterPath == null
                ? Image.asset(
              "images/image_not_available.png", fit: BoxFit.contain,)
                : Image.network(
              imageUrl + results!.posterPath,
              fit: BoxFit.contain,
              width:150,


            )),
      ),
    );
  }
}