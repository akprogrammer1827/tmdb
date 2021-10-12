
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
  }

}