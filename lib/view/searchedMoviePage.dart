import 'package:flutter/material.dart';
import 'package:tmdb/controllers/moviesBloc.dart';
import 'package:tmdb/models/moviesModel.dart';
import 'package:tmdb/services/apiConnection.dart';
import 'package:tmdb/view/movieDetailPage.dart';
import 'package:tmdb/view/widget/movie_tile.dart';
import 'package:tmdb/view/widget/search_movie_tile.dart';

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
              return GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisExtent: 400
                ),
                children: [
                  ...List.generate(s.data!.results!.length, (index) {
                    return SearchMoviesTile(results: asyncSnapshot!.data!.results![index],imageUrl: ApiConnection.imageBaseUrl,);
                  })
                ],
              );
            }
          },
        ),
      ),
    );
  }
}