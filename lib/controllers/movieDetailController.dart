import 'dart:async';

import 'package:tmdb/models/movieDetailsModel.dart';
import 'package:tmdb/models/moviesModel.dart';
import 'package:tmdb/services/apiConnection.dart';

class MovieDetailController {

  final _apiConnection = ApiConnection();

  final _movieDetailController = StreamController<MovieDetailModel>.broadcast();

  Stream<MovieDetailModel> get movieDetailStream => _movieDetailController.stream;

  fetchMovieDetail(String movieId) async {
    try {
      final results = await _apiConnection.getMovieDetail(movieId);
      _movieDetailController.sink.add(results);

    } on Exception catch (e) {
      print(e.toString());
      _movieDetailController.sink.addError("something went wrong ${e.toString()}");
    }
  }

  dispose (){
    _movieDetailController.close();
  }

}