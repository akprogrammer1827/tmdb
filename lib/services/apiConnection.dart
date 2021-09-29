import 'dart:convert';
import 'package:tmdb/models/movieDetailsModel.dart';
import 'package:tmdb/models/moviesModel.dart';
import 'package:http/http.dart' as http;



class ApiConnection {

  static final String imageBaseUrl = "http://image.tmdb.org/t/p/w500/";

  Future<MoviesListModel> getNowPlayingMovies(int page) async {
    var response = await http.get(Uri.parse("https://api.themoviedb.org/3/movie/now_playing?api_key=b9a825a82ebe362e74f0a59439b3b6de&language=en-US&page=$page"));
    var result = json.decode(response.body);
    MoviesListModel moviesListModel;
    moviesListModel = MoviesListModel.fromJson(result);
    print("moviesListModel Performance $moviesListModel");
    return moviesListModel;
  }


  Future<MovieDetailModel> getMovieDetail(String movieId) async {
    var response = await http.get(Uri.parse("https://api.themoviedb.org/3/movie/$movieId?api_key=b9a825a82ebe362e74f0a59439b3b6de&language=en-US"));
    var result = json.decode(response.body);
    MovieDetailModel movieDetailModel;
    movieDetailModel = MovieDetailModel.fromJson(result);
    print("moviesDetailModel Performance $movieDetailModel");
    return movieDetailModel;
  }






}