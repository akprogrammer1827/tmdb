import 'package:flutter/material.dart';
import 'package:tmdb/controllers/movieDetailController.dart';
import 'package:tmdb/models/movieDetailsModel.dart';
import 'package:tmdb/services/apiConnection.dart';

class MovieDetailPage extends StatefulWidget {
  final movieId;
  const MovieDetailPage({Key? key,this.movieId}) : super(key: key);

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {

  final MovieDetailController movieDetailController = MovieDetailController();
  AsyncSnapshot<MovieDetailModel>? asyncSnapshot;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    movieDetailController.fetchMovieDetail(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<MovieDetailModel>(
        stream: movieDetailController.movieDetailStream,
        builder: (c,s){
          if (s.connectionState != ConnectionState.active) {
            print("all connection");
            return Container(height: 300,
                alignment: Alignment.center,
                child: Center(
                  heightFactor: 50, child: CircularProgressIndicator(
                  color: Colors.black,
                ),));
          }
          else if (s.hasError) {
            print("as3 error");
            return Container(height: 300,
              alignment: Alignment.center,
              child: Text("Error Loading Data",),);
          }
          else if (s.data
              .toString()
              .isEmpty) {
            print("as3 empty");
            return Container(height: 300,
              alignment: Alignment.center,
              child: Text("No Data Found",),);
          }
          else
            asyncSnapshot =s;
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                s.data!.posterPath == "" ? Image.asset("images/image_not_available.png"):ClipRRect(
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20)),
                    child: Image.network(ApiConnection.imageBaseUrl+ s.data!.posterPath.toString())),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0,right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      s.data!.title == "" ? Text("Movie Title Not Available"):Text(s.data!.title.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      SizedBox(height: 10,),
                      s.data!.tagline == "" ? Text("Movie Tagline Not Available"):Text("Tagline: "+s.data!.tagline.toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                      SizedBox(height: 10,),
                      s.data!.overview == "" ? Text("Movie Overview Not Available"):Text("Overview: "+s.data!.overview.toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.grey),),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Genres: ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                          ...List.generate(s.data!.genres!.length, (index) => GenresCard(genres: s.data!.genres![index])),
                        ],
                      ),
                      SizedBox(height: 10,),
                      s.data!.releaseDate == "" ? Text("Movie Release Date Not Available"):Text("Release Date : "+s.data!.releaseDate.toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.grey),),
                      SizedBox(height: 10,),
                      s.data!.runtime.toString() == "" ? Text("Movie Runtime Not Available"):Text("Runtime: "+s.data!.runtime.toString()+" minutes",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.grey),),
                      SizedBox(height: 10,),
                      s.data!.budget.toString() == "" ? Text("Movie Budget Not Available"):Text("Budget: "+r"$."+s.data!.budget.toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.grey),),
                       SizedBox(height: 10,),
                      s.data!.revenue.toString() == "" ? Text("Movie Revenue Not Available"):Text("Revenue: "+r"$."+s.data!.revenue.toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.grey),),
                      SizedBox(height: 10,),
                      s.data!.status.toString() == "" ? Text("Movie Status Not Available"):Text("Movie Status: "+s.data!.status.toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.grey),),
                      SizedBox(height: 10,),
                      s.data!.belongsToCollection == null ? Container(): Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            s.data!.belongsToCollection!.posterPath == null ? Image.asset("images/image_not_available.png",height: 200,width: 200,):     Flexible(
                              flex: 1,
                                child: Image.network(ApiConnection.imageBaseUrl+ s.data!.belongsToCollection!.posterPath.toString())),
                            SizedBox(width: 10,),
                            Flexible(
                              flex: 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  s.data!.belongsToCollection!.name == "" ? Text("Movie Collection Not Available"):      Text(s.data!.belongsToCollection!.name.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                  SizedBox(height: 10,),
                                  s.data!.belongsToCollection!.backdropPath == null ? Image.asset("images/image_not_available.png",height: 200,width: 200,):       Image.network(ApiConnection.imageBaseUrl+ s.data!.belongsToCollection!.backdropPath.toString(),),
                                ],
                              ),
                            )

                          ],
                        ),
                      ),

                    ],
                  ),
                )
              ],
            ),
          );

        },
      ),

    );
  }
}

class GenresCard extends StatelessWidget {
  final Genres genres;

  const GenresCard({Key? key,required this.genres}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(child: Text(genres.name.toString()+ ", ",maxLines: 1,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),));
  }

}


class MovieCollectionCard extends StatelessWidget {

  final BelongsToCollection? belongsToCollection;
  const MovieCollectionCard({Key? key,required this.belongsToCollection}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 100,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Image.network(ApiConnection.imageBaseUrl+ belongsToCollection!.posterPath.toString()),
            SizedBox(height: 10,),
            Text(belongsToCollection!.name.toString())

          ],
        ),
      ),
    );
  }
}

