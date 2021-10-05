import 'package:flutter/material.dart';
import 'package:tmdb/controllers/imageController.dart';
import 'package:tmdb/models/imageModel.dart';
import 'package:tmdb/view/imageDetailPage.dart';
import 'package:tmdb/view/searchImagesPage.dart';

class TrendingImagePage extends StatefulWidget {
  const TrendingImagePage({Key? key}) : super(key: key);

  @override
  _TrendingImagePageState createState() => _TrendingImagePageState();
}

class _TrendingImagePageState extends State<TrendingImagePage> {
  
  final ImageController imageController = ImageController();
  AsyncSnapshot<ImagesModel>? asyncSnapshot;
  TextEditingController searchTextEditingController = TextEditingController();
  
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
  navigate(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchImagePage(searchText: searchTextEditingController.text,)));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        backgroundColor: Colors.white,
        title: Text("Trending Images",style: TextStyle(color: Colors.black),),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Container(
            height: 50,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: searchTextEditingController,
                textInputAction: TextInputAction.search,
                onEditingComplete: (){
                  return navigate();
                },
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hintText: "Search Images",
                  border: InputBorder.none
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: StreamBuilder<ImagesModel>(
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
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 200 ,
                  childAspectRatio: 9/16
                ),
                physics: BouncingScrollPhysics(),
                itemCount: asyncSnapshot!.data!.photos!.length,
                  itemBuilder: (c,i){
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return ImageDetailsPage(
                              imageId: asyncSnapshot!.data!.photos![i].id.toString(),
                            );
                          }));
                        },
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(asyncSnapshot!.data!.photos![i].src!.portrait!)),
                      ),
                    ],
                  );

              });
            }
          },
        ),
      ),
    );
  }
}
