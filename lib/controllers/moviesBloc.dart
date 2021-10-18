
import 'dart:async';

import 'package:tmdb/models/moviesModel.dart';
import 'package:tmdb/services/apiConnection.dart';

class MoviesController {

  final _apiConnection = ApiConnection();

  final _nowPlayingMoviesController = StreamController<MoviesListModel>.broadcast();
  Stream<MoviesListModel> get nowPlayingMoviesStream => _nowPlayingMoviesController.stream;

  fetchNowPlayingMovies(int page) async {
    try {
      final results = await _apiConnection.getNowPlayingMovies(page);
      _nowPlayingMoviesController.sink.add(results);
      print("now playing movies ${results.results}");

    } on Exception catch (e) {
      print(e.toString());
      _nowPlayingMoviesController.sink.addError("something went wrong ${e.toString()}");
    }
  }

  final _upcomingMoviesController = StreamController<MoviesListModel>.broadcast();
  Stream<MoviesListModel> get upcomingMoviesStream => _upcomingMoviesController.stream;

  fetchUpcomingMovies(int page) async {
    try {
      final results = await _apiConnection.getUpcomingMovies(page);
      _upcomingMoviesController.sink.add(results);
      print("now playing movies ${results.results}");

    } on Exception catch (e) {
      print(e.toString());
      _upcomingMoviesController.sink.addError("something went wrong ${e.toString()}");
    }
  }

  final _topRatedMoviesController = StreamController<MoviesListModel>.broadcast();
  Stream<MoviesListModel> get topRatedMoviesStream => _topRatedMoviesController.stream;
  fetchTopRatedMovies(int page) async {
    try {
      final results = await _apiConnection.getTopRatedMovies(page);
      _topRatedMoviesController.sink.add(results);
      print("_topRatedMoviesController ${results.results}");

    } on Exception catch (e) {
      print(e.toString());
      _topRatedMoviesController.sink.addError("something went wrong ${e.toString()}");
    }
  }


  final _popularMoviesController = StreamController<MoviesListModel>.broadcast();
  Stream<MoviesListModel> get popularMoviesStream => _popularMoviesController.stream;
  fetchPopularMovies(int page) async {
    try {
      final results = await _apiConnection.getPopularMovies(page);
      _popularMoviesController.sink.add(results);
      print("now playing movies ${results.results}");

    } on Exception catch (e) {
      print(e.toString());
      _popularMoviesController.sink.addError("something went wrong ${e.toString()}");
    }
  }

  final _similarMoviesController = StreamController<MoviesListModel>.broadcast();
  Stream<MoviesListModel> get similarMoviesStream => _similarMoviesController.stream;
  fetchNowSimilarMovies(int page,String movieId) async {
    try {
      final results = await _apiConnection.getSimilarMovies(page,movieId);
      _similarMoviesController.sink.add(results);
      print("similar movies ${results.results}");

    } on Exception catch (e) {
      print(e.toString());
      _similarMoviesController.sink.addError("something went wrong ${e.toString()}");
    }
  }

  final _searchedMoviesController = StreamController<MoviesListModel>.broadcast();
  Stream<MoviesListModel> get searchedMoviesStream => _searchedMoviesController.stream;
  fetchSearchedMovies(String keyword,int page) async {
    try {
      final results = await _apiConnection.getSearchedMovies(keyword, page);
      _searchedMoviesController.sink.add(results);
      print("similar movies ${results.results}");

    } on Exception catch (e) {
      print(e.toString());
      _searchedMoviesController.sink.addError("something went wrong ${e.toString()}");
    }
  }

  dispose (){
    _nowPlayingMoviesController.close();
    _similarMoviesController.close();
    _searchedMoviesController.close();
    _popularMoviesController.close();
    _topRatedMoviesController.close();
    _upcomingMoviesController.close();
  }

}