import 'package:flutter/material.dart';
import 'package:tmdb/controllers/moviesBloc.dart';
import 'package:tmdb/models/moviesModel.dart';
import 'package:tmdb/services/apiConnection.dart';
import 'package:tmdb/view/movieDetailPage.dart';

class SearchedMoviePage extends StatefulWidget {
  final String? keyword;
  const SearchedMoviePage({Key? key, this.keyword}) : super(key: key);

  @override
  _SearchedMoviePageState createState() => _SearchedMoviePageState();
}

class _SearchedMoviePageState extends State<SearchedMoviePage> {

  final MoviesController moviesController = MoviesController();

  int page = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    moviesController.fetchSearchedMovies(widget.keyword.toString(), page);
  }




  AsyncSnapshot<MoviesListModel>? asyncSnapshot;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    moviesController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.keyword!),
      ),
      body: RefreshIndicator(
        color: Colors.black,
        onRefresh: (){
          return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
            return SearchedMoviePage(keyword: widget.keyword,);
          }));
        },
        child: StreamBuilder<MoviesListModel>(
          stream: moviesController.searchedMoviesStream,
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
            else {
              asyncSnapshot = s;
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    ...List.generate(s.data!.results!.length, (index) {
                      return MoviesTile(results: asyncSnapshot!.data!.results![index],imageUrl: ApiConnection.imageBaseUrl,);
                    })
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
class MoviesTile extends StatelessWidget {

  final Results? results;
  final imageUrl;
  const MoviesTile({Key? key,this.results,this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0,right: 5,top: 2.5,bottom: 2.5),
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return MovieDetailPage(movieId: results!.id.toString(),);
          }));
        },
        child: Card(
          shadowColor: Colors.blueGrey,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
          ),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                    flex: 1,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: results!.posterPath == null ? Image.asset("images/image_not_available.png"): Image.network(
                          imageUrl+results!.posterPath,

                        ))),
                SizedBox(width: 10,),
                Flexible(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      results!.title == "" ? Text("No Title Available"):Text(results!.title.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black),),
                      SizedBox(height: 10,),
                      results!.popularity.toString() == "" ? Text("No Popularity Available"):Text("Popularity : "+results!.popularity.toString(),style: TextStyle(color: Colors.blue,fontSize: 16,fontWeight: FontWeight.bold),),
                      SizedBox(height: 10,),
                      results!.voteAverage.toString() == "" ? Text("No Rating Available"):    Text("TMDB Rating : "+results!.voteAverage.toString()+"/10",style: TextStyle(color: Colors.green,fontSize: 16,fontWeight: FontWeight.bold),),
                      SizedBox(height: 10,),
                      results!.voteCount.toString() == "" ? Text("No Votes Available"):    Text("Vote Count : "+results!.voteCount.toString(),style: TextStyle(color: Colors.orange,fontSize: 16,fontWeight: FontWeight.bold),)
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