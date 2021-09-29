
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

  dispose (){
    _nowPlayingMoviesController.close();
  }

}