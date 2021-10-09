import 'dart:async';

import 'package:tmdb/models/newsModel.dart';
import 'package:tmdb/services/apiConnection.dart';

class NewsController{

  final _apiConnection = ApiConnection();

  final _newsController = StreamController<NewsModel>.broadcast();

  Stream<NewsModel> get newsStream => _newsController.stream;

  fetchTopHeadlinesNews(String country) async {
    try {
      final results = await _apiConnection.getTopHeadLinesNews(country);
      _newsController.sink.add(results);

    } on Exception catch (e) {
      print(e.toString());
      _newsController.sink.addError("something went wrong ${e.toString()}");
    }
  }

  final _searchedNewsController = StreamController<NewsModel>.broadcast();

  Stream<NewsModel> get searchedNewsStream => _searchedNewsController.stream;

  fetchSearchedNews(String keyword, String date) async {
    try {
      final results = await _apiConnection.getSearchedNews(keyword, date);
      _searchedNewsController.sink.add(results);

    } on Exception catch (e) {
      print(e.toString());
      _searchedNewsController.sink.addError("something went wrong ${e.toString()}");
    }
  }

  dispose(){
    _newsController.close();
    _searchedNewsController.close();
  }

}