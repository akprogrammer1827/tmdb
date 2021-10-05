

import 'dart:async';

import 'package:tmdb/models/featureCollectionModel.dart';
import 'package:tmdb/services/apiConnection.dart';

class FeatureCollectionController {
  final _apiConnection = ApiConnection();

  final _featureCollectionController = StreamController<FeatureCollectionModel>.broadcast();

  Stream<FeatureCollectionModel> get featureCollectionStream => _featureCollectionController.stream;

  fetchFeaturedCollection() async {
    try {
      final results = await _apiConnection.getFeatureCollection();
      _featureCollectionController.sink.add(results);

    } on Exception catch (e) {
      print(e.toString());
      _featureCollectionController.sink.addError("something went wrong ${e.toString()}");
    }
  }

  dispose (){
    _featureCollectionController.close();
  }
}