import 'dart:convert';
import 'dart:io';
import 'package:tmdb/models/imageModel.dart';
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
  Future<MoviesListModel> getSimilarMovies(int page,String movieId) async {
    var response = await http.get(Uri.parse("https://api.themoviedb.org/3/movie/$movieId/similar?api_key=b9a825a82ebe362e74f0a59439b3b6de&language=en-US&page=$page"));
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


  Future<ImagesModel> getTrendingImages() async {
    var response = await http.get(Uri.parse("https://api.pexels.com/v1/curated?per_page=80"),headers: {
      "Authorization" : "563492ad6f917000010000016ad5fa274c9a495daa94377b240b2a5b"
    });
    var result = json.decode(response.body);
    ImagesModel imagesModel;
    imagesModel = ImagesModel.fromJson(result);
    print("imagesModel Performance $imagesModel");
    return imagesModel;
  }






}