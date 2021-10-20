import 'dart:async';

import 'package:tmdb/models/people_model.dart';
import 'package:tmdb/services/apiConnection.dart';

class PeopleController {
  final _apiConnection = ApiConnection();

  final _popularPeopleController = StreamController<PeopleModel>.broadcast();

  Stream<PeopleModel> get popularPeopleStream => _popularPeopleController.stream;

  fetchPopularPeople(int page) async {
    try {
      final results = await _apiConnection.getPopularPeople(page);
      _popularPeopleController.sink.add(results);

    } on Exception catch (e) {
      print(e.toString());
      _popularPeopleController.sink.addError("something went wrong ${e.toString()}");
    }
  }

  dispose(){
    _popularPeopleController.close();
  }

}