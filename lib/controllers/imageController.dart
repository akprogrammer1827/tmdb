import 'dart:async';
import 'package:tmdb/models/imageModel.dart';
import 'package:tmdb/services/apiConnection.dart';

class ImageController {

  final _apiConnection = ApiConnection();

  final _imageController = StreamController<ImagesModel>.broadcast();

  Stream<ImagesModel> get imageStream => _imageController.stream;

  fetchImages() async {
    try {
      final results = await _apiConnection.getTrendingImages();
      _imageController.sink.add(results);

    } on Exception catch (e) {
      print(e.toString());
      _imageController.sink.addError("something went wrong ${e.toString()}");
    }
  }


  final _searchImageController = StreamController<ImagesModel>.broadcast();
  Stream<ImagesModel> get searchImageStream => _searchImageController.stream;
  fetchSearchImages(String searchText) async {
    try {
      final results = await _apiConnection.getSearchImages(searchText);
      _searchImageController.sink.add(results);

    } on Exception catch (e) {
      print(e.toString());
      _searchImageController.sink.addError("something went wrong ${e.toString()}");
    }
  }

  dispose (){
    _imageController.close();
    _searchImageController.close();
  }
}