import 'dart:async';

import 'package:tmdb/models/imageDetailModel.dart';
import 'package:tmdb/services/apiConnection.dart';

class ImageDetailsController {

  final _apiConnection = ApiConnection();

  final _imageDetailController = StreamController<ImageDetailsModel>.broadcast();

  Stream<ImageDetailsModel> get imageDetailStream => _imageDetailController.stream;

  fetchImageDetail(String imageId) async {
    try {
      final results = await _apiConnection.getImageDetails(imageId);
      _imageDetailController.sink.add(results);

    } on Exception catch (e) {
      print(e.toString());
      _imageDetailController.sink.addError("something went wrong ${e.toString()}");
    }
  }

  dispose (){
    _imageDetailController.close();
  }

}