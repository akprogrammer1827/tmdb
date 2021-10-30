import 'package:flutter/material.dart';
import 'package:tmdb/models/moviesModel.dart';
import 'package:tmdb/view/movieDetailPage.dart';

class SearchMoviesTile extends StatelessWidget {

  final Results? results;
  final imageUrl;

  const SearchMoviesTile({Key? key, this.results, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 5.0, right: 5, top: 2.5, bottom: 2.5),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return MovieDetailPage(movieId: results!.id.toString(),movieName: results!.title,);
          }));
        },
        child: Card(
          shadowColor: Colors.blueGrey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),

          ),
          color: Colors.white,
          child: Container(
            width: 130,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: results!.posterPath == null
                        ? Image.asset(
                      "images/image_not_available.png", fit: BoxFit.contain,)
                        : Image.network(
                      imageUrl + results!.posterPath,
                      fit: BoxFit.contain,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,


                    )),
                 SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0,right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      results!.title == "" ? Text("No Title Available"):Text(results!.title.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10,color: Colors.black),),
                      SizedBox(height: 10,),
                      results!.popularity.toString() == "" ? Text("No Popularity Available"):Text("Popularity : "+results!.popularity.toString(),style: TextStyle(color: Colors.blue,fontSize: 10,fontWeight: FontWeight.bold),),
                      SizedBox(height: 10,),
                      results!.voteAverage.toString() == "" ? Text("No Rating Available"):    Text("TMDB Rating : "+results!.voteAverage.toString()+"/10",style: TextStyle(color: Colors.green,fontSize: 10,fontWeight: FontWeight.bold),),
                      SizedBox(height: 10,),
                      results!.voteCount.toString() == "" ? Text("No Votes Available"):    Text("Vote Count : "+results!.voteCount.toString(),style: TextStyle(color: Colors.orange,fontSize: 10,fontWeight: FontWeight.bold),),
                      SizedBox(height: 10,),
                    ],
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}