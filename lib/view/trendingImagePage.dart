import 'package:flutter/material.dart';
import 'package:tmdb/controllers/imageController.dart';
import 'package:tmdb/models/imageModel.dart';

class TrendingImagePage extends StatefulWidget {
  const TrendingImagePage({Key? key}) : super(key: key);

  @override
  _TrendingImagePageState createState() => _TrendingImagePageState();
}

class _TrendingImagePageState extends State<TrendingImagePage> {
  
  final ImageController imageController = ImageController();
  AsyncSnapshot<ImagesModel>? asyncSnapshot;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imageController.fetchImages();
  }
  
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    imageController.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trending Images"),
      ),
      body: StreamBuilder<ImagesModel>(
        stream: imageController.imageStream,
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
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 4/4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10
              ),
              physics: BouncingScrollPhysics(),
              itemCount: asyncSnapshot!.data!.photos!.length,
                itemBuilder: (c,i){
                return Column(
                  children: [
                    Image.network(asyncSnapshot!.data!.photos![i].src!.original!),
                    Text(asyncSnapshot!.data!.photos![i].photographer!),
                  ],
                );
                  
            });
          }
        },
      ),
    );
  }
}
