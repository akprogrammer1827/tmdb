import 'package:flutter/material.dart';
import 'package:tmdb/controllers/moviesBloc.dart';
import 'package:tmdb/controllers/people_Controllers.dart';
import 'package:tmdb/models/moviesModel.dart';
import 'package:tmdb/models/people_model.dart';
import 'package:tmdb/services/apiConnection.dart';
import 'package:tmdb/view/searchedMoviePage.dart';
import 'package:tmdb/view/widget/people_tile.dart';
import 'package:tmdb/view/widget/movie_tile.dart';

class MoviesView extends StatefulWidget {
  const MoviesView({Key? key}) : super(key: key);

  @override
  _MoviesViewState createState() => _MoviesViewState();
}

class _MoviesViewState extends State<MoviesView> {


  final MoviesController moviesController = MoviesController();
  final PeopleController peopleController = PeopleController();

  TextEditingController searchMoviesTextEditingController = TextEditingController();
  int page = 1;
  int? next;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    moviesController.fetchNowPlayingMovies(page);
    moviesController.fetchPopularMovies(page);
    moviesController.fetchTopRatedMovies(page);
    moviesController.fetchUpcomingMovies(page);
    peopleController.fetchPopularPeople(page);
  }




  AsyncSnapshot<MoviesListModel>? asyncSnapshot;
  AsyncSnapshot<PeopleModel>? asyncSnapshot1;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    moviesController.dispose();
    peopleController.dispose();
  }

  navigateMovieSearchPage(){

    Navigator.push(context, MaterialPageRoute(builder: (context){
      return SearchedMoviePage(keyword: searchMoviesTextEditingController.text,);
    }));

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Movies"),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Container(
            height: 50,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                cursorColor: Colors.white,
                controller: searchMoviesTextEditingController,
                onEditingComplete: (){
                  if(searchMoviesTextEditingController.text.isEmpty){
                    print("Search any movie");
                    final snackBar = SnackBar(content: Text('Type any movie name first',
                      style: TextStyle(color: Colors.white),),
                    backgroundColor: Colors.black,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  else {
                    navigateMovieSearchPage();
                  }

                },
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: "Search movies...",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        color: Colors.white,
        onRefresh: (){
          return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
            return MoviesView();
          }));
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0,top: 10,bottom: 10),
                child: Text("Popular People",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
              ),
              StreamBuilder<PeopleModel>(
                stream: peopleController.popularPeopleStream,
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
                    asyncSnapshot1 = s;
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...List.generate(s.data!.results!.length, (index) {
                            return PeopleTile(results: asyncSnapshot1!.data!.results![index],imageUrl: ApiConnection.imageBaseUrl,);
                          })
                        ],

                      ),
                    );
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0,top: 10,bottom: 10),
                child: Text("Now Playing Movies",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
              ),
              StreamBuilder<MoviesListModel>(
                stream: moviesController.nowPlayingMoviesStream,
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
                      scrollDirection: Axis.horizontal,
                      child: Row(
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
              Padding(
                padding: const EdgeInsets.only(left: 10.0,top: 10,bottom: 10),
                child: Text("Popular Movies",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
              ),
              StreamBuilder<MoviesListModel>(
                stream: moviesController.popularMoviesStream,
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
                      scrollDirection: Axis.horizontal,
                      child: Row(
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
              Padding(
                padding: const EdgeInsets.only(left: 10.0,top: 10,bottom: 10),
                child: Text("Top Rated Movies",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
              ),
              StreamBuilder<MoviesListModel>(
                stream: moviesController.topRatedMoviesStream,
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
                      scrollDirection: Axis.horizontal,
                      child: Row(
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
              Padding(
                padding: const EdgeInsets.only(left: 10.0,top: 10,bottom: 10),
                child: Text("UpComing Movies",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
              ),
              StreamBuilder<MoviesListModel>(
                stream: moviesController.upcomingMoviesStream,
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
                      scrollDirection: Axis.horizontal,
                      child: Row(
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
              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }


}




