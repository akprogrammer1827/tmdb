import 'package:flutter/material.dart';
import 'package:tmdb/controllers/imageController.dart';
import 'package:tmdb/models/imageModel.dart';
import 'package:tmdb/view/imageDetailPage.dart';

class SearchImagePage extends StatefulWidget {
  final searchText;

  const SearchImagePage({Key? key,this.searchText}) : super(key: key);

  @override
  _SearchImagePageState createState() => _SearchImagePageState();
}

class _SearchImagePageState extends State<SearchImagePage> {

  final ImageController searchImageController = ImageController();
  AsyncSnapshot<ImagesModel>? asyncSnapshot;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchImageController.fetchSearchImages(widget.searchText);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchImageController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.searchText}".toUpperCase()),
        centerTitle: true,

      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: StreamBuilder<ImagesModel>(
          stream: searchImageController.searchImageStream,
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
              return asyncSnapshot!.data!.totalResults == 0 ? Center(child: Text("No Images of "+ "${widget.searchText}".toUpperCase()),)
                  :GridView.builder(
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
