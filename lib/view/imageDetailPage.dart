import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:tmdb/controllers/imageDetailsController.dart';
import 'package:tmdb/models/imageDetailModel.dart';
import 'package:tmdb/services/apiConnection.dart';
import 'package:http/http.dart' as http;

class ImageDetailsPage extends StatefulWidget {
  final imageId;
  const ImageDetailsPage({Key? key,this.imageId}) : super(key: key);

  @override
  _ImageDetailsPageState createState() => _ImageDetailsPageState();
}

class _ImageDetailsPageState extends State<ImageDetailsPage> {

  final ImageDetailsController imageDetailsController = ImageDetailsController();
  AsyncSnapshot<ImageDetailsModel>? asyncSnapshot;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imageDetailsController.fetchImageDetail(widget.imageId);

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    imageDetailsController.dispose();

  }

   saveNetworkImage(String imageUrl) async {
    GallerySaver.saveImage(imageUrl,).then((bool? success) {
      setState(() {
        print('Image is saved');
        final snackBar = SnackBar(content: Text('Image Saved Successfully'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);


      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Photo"),
        centerTitle: true,
      ),
      body: StreamBuilder<ImageDetailsModel>(
        stream: imageDetailsController.imageDetailStream,
        builder: (c,s){
          if (s.connectionState != ConnectionState.active) {
            print("all connection");
            return Center(
              heightFactor: 50, child: CircularProgressIndicator(
            ),);
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
          else{
            asyncSnapshot =s;
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    child: PhotoView(imageProvider: NetworkImage(asyncSnapshot!.data!.src!.original.toString()),

            loadingBuilder:(BuildContext context,ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null)
                return Container();
              return Container(
                color: HexColor(asyncSnapshot!.data!.avgColor.toString()),
                height: 500,
                child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: Colors.black,
                          value: loadingProgress.expectedTotalBytes != null ?
                          loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                        SizedBox(height: 10,),
                        Text("Loading...")
                      ],
                    ),
                ),
              );
            },),
                  ),

                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Photographer : "+asyncSnapshot!.data!.photographer.toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: HexColor(asyncSnapshot!.data!.avgColor.toString()),
                        ),),

                        IconButton(onPressed: (){
                          saveNetworkImage(asyncSnapshot!.data!.src!.portrait.toString().split("?").first);

                        }, icon: Icon(Icons.download,size: 30, color: HexColor(asyncSnapshot!.data!.avgColor.toString()),))
                      ],
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
