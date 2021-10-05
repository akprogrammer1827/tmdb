import 'package:flutter/material.dart';
import 'package:tmdb/controllers/featureCollectionController.dart';
import 'package:tmdb/models/featureCollectionModel.dart';

class FeatureCollectionPage extends StatefulWidget {
  const FeatureCollectionPage({Key? key}) : super(key: key);

  @override
  _FeatureCollectionPageState createState() => _FeatureCollectionPageState();
}

class _FeatureCollectionPageState extends State<FeatureCollectionPage> {

  final FeatureCollectionController featureCollectionController = FeatureCollectionController();
  AsyncSnapshot<FeatureCollectionModel>? asyncSnapshot;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    featureCollectionController.fetchFeaturedCollection();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    featureCollectionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        centerTitle: true,
        title: Text("Featured Collection"),
      ),
      body: StreamBuilder<FeatureCollectionModel>(
        stream: featureCollectionController.featureCollectionStream,
        builder: (c,s){
          if (s.connectionState != ConnectionState.active) {
            print("all connection");
            return Container(height: 300,
                alignment: Alignment.center,
                child: Center(
                  heightFactor: 50, child: CircularProgressIndicator(
                  color: Colors.black,
                ),));
          }
          else if (s.hasError) {
            print("as3 error");
            return Container(height: 300,
              alignment: Alignment.center,
              child: Text("Error Loading Data",),);
          }
          else if (s.data
              .toString()
              .isEmpty) {
            print("as3 empty");
            return Container(height: 300,
              alignment: Alignment.center,
              child: Text("No Data Found",),);
          }
          else {
            asyncSnapshot = s;
            return ListView.builder(
              physics: BouncingScrollPhysics(),
                itemCount: asyncSnapshot!.data!.collections!.length,
                itemBuilder: (c,i){
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0,right: 20.0,top: 10.0,bottom: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(asyncSnapshot!.data!.collections![i].title.toString(),style: TextStyle(
                            color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 16
                          ),),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Videos",style: TextStyle(
                                      color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16
                                  ),),
                                  Text(asyncSnapshot!.data!.collections![i].videosCount.toString(),style: TextStyle(
                                      color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16
                                  ),),


                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Photos",style: TextStyle(
                                      color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16
                                  ),),
                                  Text(asyncSnapshot!.data!.collections![i].photosCount.toString(),style: TextStyle(
                                      color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16
                                  ),),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [

                                  Text("All",style: TextStyle(
                                      color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16
                                  ),),
                                  Text(asyncSnapshot!.data!.collections![i].mediaCount.toString(),style: TextStyle(
                                      color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16
                                  ),),

                                ],
                              ),

                            ],
                          )

                        ],
                      ),
                    ),
                  );

            });
          }
        },
      ),
    );
  }
}
