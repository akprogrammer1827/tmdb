import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tmdb/models/featureCollectionModel.dart';
import 'package:tmdb/models/imageDetailModel.dart';
import 'package:tmdb/models/imageModel.dart';
import 'package:tmdb/models/movieDetailsModel.dart';
import 'package:tmdb/models/moviesModel.dart';
import 'package:http/http.dart' as http;
import 'package:tmdb/models/newsModel.dart';
import 'package:tmdb/models/videosModel.dart';



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

  Future<ImagesModel> getSearchImages(String searchText) async {
    var response = await http.get(Uri.parse("https://api.pexels.com/v1/search?query=$searchText&per_page=80"),headers: {
      "Authorization" : "563492ad6f917000010000016ad5fa274c9a495daa94377b240b2a5b"
    });
    var result = json.decode(response.body);
    ImagesModel imagesModel;
    imagesModel = ImagesModel.fromJson(result);
    print("imagesModel Performance $imagesModel");
    return imagesModel;
  }


  Future<ImageDetailsModel> getImageDetails(String imageId) async {
    var response = await http.get(Uri.parse("https://api.pexels.com/v1/photos/$imageId"),headers: {
      "Authorization" : "563492ad6f917000010000016ad5fa274c9a495daa94377b240b2a5b"
    });
    var result = json.decode(response.body);
    ImageDetailsModel imageDetailsModel;
    imageDetailsModel = ImageDetailsModel.fromJson(result);
    print("imagesDetails Model Performance $imageDetailsModel");
    return imageDetailsModel;
  }

  Future<FeatureCollectionModel> getFeatureCollection() async {
    var response = await http.get(Uri.parse("https://api.pexels.com/v1/collections/featured?per_page=80"),headers: {
      "Authorization" : "563492ad6f917000010000016ad5fa274c9a495daa94377b240b2a5b"
    });
    var result = json.decode(response.body);
    FeatureCollectionModel featureCollectionModel;
    featureCollectionModel = FeatureCollectionModel.fromJson(result);
    print("feature collection Performance $featureCollectionModel");
    return featureCollectionModel;
  }


 Future<VideosModel> getPopularVideos(String popularVideosUrl) async {
    var response = await http.get(Uri.parse(popularVideosUrl),headers: {
      "Authorization" : "563492ad6f917000010000016ad5fa274c9a495daa94377b240b2a5b"
    });
    var result = json.decode(response.body);
    VideosModel videosModel;
    videosModel = VideosModel.fromJson(result);
    print("videos Performance $videosModel");
    return videosModel;
  }

  Future<NewsModel> getTopHeadLinesNews() async {
    var response = await http.get(Uri.parse("https://newsapi.org/v2/top-headlines?country=in&apiKey=cbc6e3ab2dca4063a1c7548d812ba985&pageSize=100&page=1"));
    var result = json.decode(response.body);
    NewsModel newsModel;
    newsModel = NewsModel.fromJson(result);
    print("news Performance $newsModel");
    return newsModel;
  }

}


class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
