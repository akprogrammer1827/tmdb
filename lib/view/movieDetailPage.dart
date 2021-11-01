import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:readmore/readmore.dart';
import 'package:tmdb/controllers/movieDetailController.dart';
import 'package:tmdb/controllers/moviesBloc.dart';
import 'package:tmdb/models/movieDetailsModel.dart';
import 'package:tmdb/models/moviesModel.dart';
import 'package:tmdb/services/apiConnection.dart';
import 'package:tmdb/view/widget/movie_tile.dart';

class MovieDetailPage extends StatefulWidget {
  final movieId;
  final movieName;
  const MovieDetailPage({Key? key, this.movieId, this.movieName})
      : super(key: key);

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  final MovieDetailController movieDetailController = MovieDetailController();

  final MoviesController moviesController = MoviesController();

  int page = 1;

  AsyncSnapshot<MovieDetailModel>? asyncSnapshot;
  AsyncSnapshot<MoviesListModel>? asyncSnapshot1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    movieDetailController.fetchMovieDetail(widget.movieId);
    moviesController.fetchNowSimilarMovies(page, widget.movieId);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    moviesController.dispose();
    movieDetailController.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movieName),
        titleTextStyle: TextStyle(fontSize: 18),
        centerTitle: true,
      ),
      body: _body(),
    );
  }

  Widget movieDetailView() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          StreamBuilder<MovieDetailModel>(
            stream: movieDetailController.movieDetailStream,
            builder: (c, s) {
              if (s.connectionState != ConnectionState.active) {
                print("all connection");
                return Container(
                    height: 300,
                    alignment: Alignment.center,
                    child: Center(
                      heightFactor: 50,
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    ));
              } else if (s.hasError) {
                print("as3 error");
                return Container(
                  height: 300,
                  alignment: Alignment.center,
                  child: Text(
                    "Error Loading Data",
                  ),
                );
              } else if (s.data.toString().isEmpty) {
                print("as3 empty");
                return Container(
                  height: 300,
                  alignment: Alignment.center,
                  child: Text(
                    "No Data Found",
                  ),
                );
              } else
                asyncSnapshot = s;
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    s.data!.posterPath == ""
                        ? Image.asset("images/image_not_available.png")
                        : ClipRRect(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20)),
                            child: Image.network(ApiConnection.imageBaseUrl +
                                s.data!.posterPath.toString())),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          s.data!.title == ""
                              ? Text("Movie Title Not Available")
                              : Text(
                                  s.data!.title.toString(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          s.data!.tagline == ""
                              ? Text("Movie Tagline Not Available")
                              : Text(
                                  "Tagline: " + s.data!.tagline.toString(),
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          s.data!.overview == ""
                              ? Text("Movie Overview Not Available")
                              : Text(
                                  "Overview: " + s.data!.overview.toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Genres: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              ...List.generate(
                                  s.data!.genres!.length,
                                  (index) => GenresCard(
                                      genres: s.data!.genres![index])),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          s.data!.releaseDate == ""
                              ? Text("Movie Release Date Not Available")
                              : Text(
                                  "Release Date : " +
                                      s.data!.releaseDate.toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          s.data!.runtime.toString() == ""
                              ? Text("Movie Runtime Not Available")
                              : Text(
                                  "Runtime: " +
                                      s.data!.runtime.toString() +
                                      " minutes",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          s.data!.budget.toString() == ""
                              ? Text("Movie Budget Not Available")
                              : Text(
                                  "Budget: " +
                                      r"$." +
                                      s.data!.budget.toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          s.data!.revenue.toString() == ""
                              ? Text("Movie Revenue Not Available")
                              : Text(
                                  "Revenue: " +
                                      r"$." +
                                      s.data!.revenue.toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          s.data!.status.toString() == ""
                              ? Text("Movie Status Not Available")
                              : Text(
                                  "Movie Status: " + s.data!.status.toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          s.data!.belongsToCollection == null
                              ? Container()
                              : Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      s.data!.belongsToCollection!.posterPath ==
                                              null
                                          ? Image.asset(
                                              "images/image_not_available.png",
                                              height: 200,
                                              width: 200,
                                            )
                                          : Flexible(
                                              flex: 1,
                                              child: Image.network(
                                                  ApiConnection.imageBaseUrl +
                                                      s
                                                          .data!
                                                          .belongsToCollection!
                                                          .posterPath
                                                          .toString())),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Flexible(
                                        flex: 2,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            s.data!.belongsToCollection!.name ==
                                                    ""
                                                ? Text(
                                                    "Movie Collection Not Available")
                                                : Text(
                                                    s.data!.belongsToCollection!
                                                        .name
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            s.data!.belongsToCollection!
                                                        .backdropPath ==
                                                    null
                                                ? Image.asset(
                                                    "images/image_not_available.png",
                                                    height: 200,
                                                    width: 200,
                                                  )
                                                : Image.network(
                                                    ApiConnection.imageBaseUrl +
                                                        s
                                                            .data!
                                                            .belongsToCollection!
                                                            .backdropPath
                                                            .toString(),
                                                  ),
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
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 10),
            child: Row(
              children: [
                Text(
                  "Similar Movies",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          StreamBuilder<MoviesListModel>(
              stream: moviesController.similarMoviesStream,
              builder: (c, s) {
                if (s.connectionState != ConnectionState.active) {
                  print("all connection");
                  return Container(
                      height: 300,
                      alignment: Alignment.center,
                      child: Center(
                        heightFactor: 50,
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      ));
                } else if (s.hasError) {
                  print("as3 error");
                  return Container(
                    height: 300,
                    alignment: Alignment.center,
                    child: Text(
                      "Error Loading Data",
                    ),
                  );
                } else if (s.data.toString().isEmpty) {
                  print("as3 empty");
                  return Container(
                    height: 300,
                    alignment: Alignment.center,
                    child: Text(
                      "No Data Found",
                    ),
                  );
                } else
                  asyncSnapshot1 = s;
                return asyncSnapshot1!.data!.results!.length == 0
                    ? Container()
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...List.generate(
                                asyncSnapshot1!.data!.results!.length,
                                (index) => MoviesTile(
                                      imageUrl: ApiConnection.imageBaseUrl,
                                      results:
                                          asyncSnapshot1!.data!.results![index],
                                    ))
                          ],
                        ),
                      );
              }),
          SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StreamBuilder<MovieDetailModel>(
            stream: movieDetailController.movieDetailStream,
            builder: (c, s) {
              if (s.connectionState != ConnectionState.active) {
                print("all connection");
                return Container(
                    height: 300,
                    alignment: Alignment.center,
                    child: Center(
                      heightFactor: 50,
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    ));
              } else if (s.hasError) {
                print("as3 error");
                return Container(
                  height: 300,
                  alignment: Alignment.center,
                  child: Text(
                    "Error Loading Data",
                  ),
                );
              } else if (s.data.toString().isEmpty) {
                print("as3 empty");
                return Container(
                  height: 300,
                  alignment: Alignment.center,
                  child: Text(
                    "No Data Found",
                  ),
                );
              } else {
                asyncSnapshot = s;
                return SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Stack(
                      children: [
                        asyncSnapshot!.data!.backdropPath == null
                            ? Container(
                          color: Colors.grey.shade200,
                          height: 200,
                        )
                            : Image.network(
                          ApiConnection.imageBaseUrl +
                              asyncSnapshot!.data!.backdropPath.toString(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0,right: 10),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: CircularPercentIndicator(
                                  radius: 60.0,
                                  lineWidth: 5.0,
                                  percent: double.parse(asyncSnapshot!.data!.voteAverage.toString()) / 10,
                                  center: new Text(asyncSnapshot!.data!.voteAverage.toString()+"%",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                                  progressColor: Colors.green,
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(60)
                              ),
                            )
                          ),
                        )
                      ],
                    ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: ClipRRect(
                                child: asyncSnapshot!.data!.posterPath == null
                                    ? Container(
                                        color: Colors.grey.shade200,
                                        width: 150,
                                      )
                                    : Image.network(
                                        ApiConnection.imageBaseUrl +
                                            asyncSnapshot!.data!.posterPath
                                                .toString(),
                                        width: 150,
                                      ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                flex: 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(asyncSnapshot!.data!.title == null
                                        ? "Title"
                                        : asyncSnapshot!.data!.title
                                            .toString(), style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),),
                                    SizedBox(height: 10),
                                    Container(
                                      height:100,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SingleChildScrollView(
                                          child: ReadMoreText(
                                            asyncSnapshot!.data!.overview == null
                                                ? "Overview"
                                                : asyncSnapshot!.data!.overview
                                                    .toString(),
                                            trimLines: 5,
                                           style: TextStyle(
                                               fontSize: 12,
                                               color: Colors.white,
                                               letterSpacing: 0.8,
                                               fontWeight: FontWeight.w300),
                                            trimMode: TrimMode.Line,
                                            trimCollapsedText: 'read more',
                                            trimExpandedText: 'read less',
                                            lessStyle: TextStyle(
                                                fontSize: 12,
                                                color: Colors.orange,
                                                fontWeight: FontWeight.bold),
                                            moreStyle: TextStyle(
                                                fontSize: 12,
                                                color: Colors.orange,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.zero,
                                        border: Border.all(color: Colors.white)
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                     SingleChildScrollView(
                                       scrollDirection: Axis.horizontal,
                                       child: Row(

                                         children: [
                                           ...List.generate(
                                               s.data!.genres!.length,
                                                   (index) => GenresCard(
                                                   genres: s.data!.genres![index])),
                                         ],
                                       ),
                                     )

                                  ],
                                ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0,right: 10),
                        child: GridView(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Status", style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,),),
                                Text(asyncSnapshot!.data!.status == null
                                    ? "_"
                                    : asyncSnapshot!.data!.status
                                    .toString(), style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.orangeAccent,
                                    fontWeight: FontWeight.bold),),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Release Date", style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,),),
                                Text(asyncSnapshot!.data!.releaseDate == null
                                    ? "_"
                                    : asyncSnapshot!.data!.releaseDate
                                    .toString(), style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.orangeAccent,
                                    fontWeight: FontWeight.bold),),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Runtime", style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,),),
                                Text(asyncSnapshot!.data!.runtime == null
                                    ? "_"
                                    : asyncSnapshot!.data!.runtime.toString() + "m", style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.orangeAccent,
                                    fontWeight: FontWeight.bold),),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Popularity", style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,),),
                                Text(asyncSnapshot!.data!.popularity == null
                                    ? "_"
                                    : asyncSnapshot!.data!.popularity.toString(), style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.orangeAccent,
                                    fontWeight: FontWeight.bold),),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Budget", style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,),),
                                Text(asyncSnapshot!.data!.budget == null
                                    ? "_"
                                    : asyncSnapshot!.data!.budget
                                    .toString()  + ".00", style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.orangeAccent,
                                    fontWeight: FontWeight.bold),),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Revenue", style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,),),
                                Text(asyncSnapshot!.data!.revenue == null
                                    ? "_"
                                    : asyncSnapshot!.data!.revenue
                                    .toString()  + ".00", style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.orangeAccent,
                                    fontWeight: FontWeight.bold),),
                              ],
                            ),



                          ],
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            mainAxisExtent: 40

                          ),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      asyncSnapshot!.data!.belongsToCollection == null ?    SizedBox():
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0,right: 10,top: 10,bottom: 10),
                          child:Row(
                            children: [
                              Expanded(flex:2,
                                child: asyncSnapshot!.data!.belongsToCollection!.backdropPath == null ? Container():
                              ClipRRect(
                                child: Image.network(ApiConnection.imageBaseUrl+ asyncSnapshot!.data!.belongsToCollection!.backdropPath.toString(),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),),
                             Expanded(
                               flex: 1,
                               child: Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 crossAxisAlignment: CrossAxisAlignment.center,
                                 children: [
                                   ClipRRect(
                                     borderRadius: BorderRadius.circular(10),
                                     child:  asyncSnapshot!.data!.belongsToCollection!.posterPath == null ? Container():Image.network(ApiConnection.imageBaseUrl+ asyncSnapshot!.data!.belongsToCollection!.posterPath.toString(),width: 70,),
                                   ),
                                   SizedBox(height: 10,),
                                   Text(asyncSnapshot!.data!.belongsToCollection!.name == null ? "-" :asyncSnapshot!.data!.belongsToCollection!.name.toString(),textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold),),
                                 ],
                               ),
                             )
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        ),
                        color: Colors.black38,
                      ),





                    ],
                  ),
                );
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 10,bottom: 10),
            child: Row(
              children: [
                Text(
                  "Similar Movies",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          StreamBuilder<MoviesListModel>(
              stream: moviesController.similarMoviesStream,
              builder: (c, s) {
                if (s.connectionState != ConnectionState.active) {
                  print("all connection");
                  return Container(
                      height: 300,
                      alignment: Alignment.center,
                      child: Center(
                        heightFactor: 50,
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      ));
                } else if (s.hasError) {
                  print("as3 error");
                  return Container(
                    height: 300,
                    alignment: Alignment.center,
                    child: Text(
                      "Error Loading Data",
                    ),
                  );
                } else if (s.data.toString().isEmpty) {
                  print("as3 empty");
                  return Container(
                    height: 300,
                    alignment: Alignment.center,
                    child: Text(
                      "No Data Found",
                    ),
                  );
                } else
                  asyncSnapshot1 = s;
                return asyncSnapshot1!.data!.results!.length == 0
                    ? Container()
                    : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: ClampingScrollPhysics(),
                  child: Row(
                    children: [
                      ...List.generate(
                          asyncSnapshot1!.data!.results!.length,
                              (index) => MoviesTile(
                            imageUrl: ApiConnection.imageBaseUrl,
                            results:
                            asyncSnapshot1!.data!.results![index],
                          ))
                    ],
                  ),
                );
              }),
          SizedBox(height: 30,)
        ],
      ),
    );
  }

}

class GenresCard extends StatelessWidget {
  final Genres genres;

  const GenresCard({Key? key, required this.genres}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white,width: 0.5)
        ),
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Text(
        genres.name.toString(),
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8),
      ),
          )),
    );
  }
}

class MovieCollectionCard extends StatelessWidget {
  final BelongsToCollection? belongsToCollection;
  const MovieCollectionCard({Key? key, required this.belongsToCollection})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 100,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Image.network(ApiConnection.imageBaseUrl +
                belongsToCollection!.posterPath.toString()),
            SizedBox(
              height: 10,
            ),
            Text(belongsToCollection!.name.toString())
          ],
        ),
      ),
    );
  }
}
