import 'dart:async';

import 'package:tmdb/models/distributor_dashboard_model.dart';
import 'package:tmdb/models/featureCollectionModel.dart';
import 'package:tmdb/services/apiConnection.dart';

class DistributorDashboardController {
  final _apiConnection = ApiConnection();

  final _distributorDashboardController = StreamController<DistributorDashboardModel>.broadcast();

  Stream<DistributorDashboardModel> get distributorDashboardStream => _distributorDashboardController.stream;

  fetchDistributorDashboardData() async {
    try {
      final results = await _apiConnection.getDistributorDashboardData();
      _distributorDashboardController.sink.add(results);

    } on Exception catch (e) {
      print(e.toString());
      _distributorDashboardController.sink.addError("something went wrong ${e.toString()}");
    }
  }

  dispose (){
    _distributorDashboardController.close();
  }
}