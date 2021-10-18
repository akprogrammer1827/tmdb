import 'package:flutter/material.dart';
import 'package:tmdb/controllers/moviesBloc.dart';
import 'package:tmdb/models/moviesModel.dart';
import 'package:tmdb/services/apiConnection.dart';
import 'package:tmdb/view/movieDetailPage.dart';
import 'package:tmdb/view/searchedMoviePage.dart';

class NowPlayingMoviesView extends StatefulWidget {
  const NowPlayingMoviesView({Key? key}) : super(key: key);

  @override
  _NowPlayingMoviesViewState createState() => _NowPlayingMoviesViewState();
}

class _NowPlayingMoviesViewState extends State<NowPlayingMoviesView> {


  final MoviesController moviesController = MoviesController();

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
  }




  AsyncSnapshot<MoviesListModel>? asyncSnapshot;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    moviesController.dispose();
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
            return NowPlayingMoviesView();
          }));
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                    child: results!.posterPath == null ? Image.asset("images/image_not_available.png",fit: BoxFit.contain,): Image.network(
                      imageUrl+results!.posterPath,
                      fit: BoxFit.contain,
                      width: MediaQuery.of(context).size.width,


                    )),
               /* SizedBox(height: 10,),
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
                )*/

              ],
            ),
          ),
        ),
      ),
    );
  }
}
