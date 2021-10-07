import 'dart:async';

import 'package:tmdb/models/newsModel.dart';
import 'package:tmdb/services/apiConnection.dart';

class NewsController{

  final _apiConnection = ApiConnection();

  final _newsController = StreamController<NewsModel>.broadcast();

  Stream<NewsModel> get newsStream => _newsController.stream;

  fetchTopHeadlinesNews() async {
    try {
      final results = await _apiConnection.getTopHeadLinesNews();
      _newsController.sink.add(results);

    } on Exception catch (e) {
      print(e.toString());
      _newsController.sink.addError("something went wrong ${e.toString()}");
    }
  }

  dispose(){
    _newsController.close();
  }

}