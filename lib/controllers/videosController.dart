import 'dart:async';

import 'package:tmdb/models/videosModel.dart';
import 'package:tmdb/services/apiConnection.dart';

class VideosController {
  final _apiConnection = ApiConnection();

  final _popularVideosController = StreamController<VideosModel>.broadcast();

  Stream<VideosModel> get popularVideosStream => _popularVideosController.stream;

  fetchPopularVideos(String popularVideosUrl) async {
    try {
      final results = await _apiConnection.getPopularVideos(popularVideosUrl);
      _popularVideosController.sink.add(results);

    } on Exception catch (e) {
      print(e.toString());
      _popularVideosController.sink.addError("something went wrong ${e.toString()}");
    }
  }

dispose(){
    _popularVideosController.close();
}
}