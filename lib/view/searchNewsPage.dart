import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:tmdb/controllers/newsController.dart';
import 'package:tmdb/models/newsModel.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class SearchNewsPage extends StatefulWidget {

  final String keyword;
  const SearchNewsPage({Key? key,required this.keyword}) : super(key: key);

  @override
  _SearchNewsPageState createState() => _SearchNewsPageState();
}

class _SearchNewsPageState extends State<SearchNewsPage> {

  final NewsController newsController = NewsController();
  AsyncSnapshot<NewsModel>? asyncSnapshot;

  final DateTime date = DateTime.now();

  _webViewPage(String url, String title) async {
    if (await url_launcher.canLaunch(url)) {
      Navigator.push(context,
          MaterialPageRoute(
              builder: (context) => WebviewScaffold(
                initialChild: Center(
                  child: CircularProgressIndicator(),
                ),
                url: url,
                appBar: AppBar(
                  title: Text(title),
                  centerTitle: true,
                ),
              )));
    } else {
      print("Can't launch Url");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(date.toString().split(" ").first);
    newsController.fetchSearchedNews(widget.keyword, date.toString().split(" ").first);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.keyword),
        centerTitle: true,
      ),
      body: StreamBuilder<NewsModel>(
        stream: newsController.searchedNewsStream,
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
          else{
            asyncSnapshot = s;
            return  asyncSnapshot!.data!.articles!.length == 0 ?  Center(
              child: Text("No Data"),
            ) :  ListView.builder(
                itemCount: asyncSnapshot!.data!.articles!.length,
                itemBuilder: (c,i){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: (){
                        _webViewPage(asyncSnapshot!.data!.articles![i].url.toString(),asyncSnapshot!.data!.articles![i].source!.name.toString());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white
                        ),
                        child: Stack(
                          children: [

                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                asyncSnapshot!.data!.articles![i].urlToImage  == null ?
                                Image.asset("images/image_not_available.png",height:250,width: MediaQuery.of(context).size.width,fit: BoxFit.cover,):
                                Image.network(asyncSnapshot!.data!.articles![i].urlToImage.toString()),
                                SizedBox(height: 10,),
                                asyncSnapshot!.data!.articles![i].title == null ? Padding(
                                  padding: const EdgeInsets.only(left: 10.0,right: 10),
                                  child: Text("Not Available"),
                                ):
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0,right: 10),
                                  child: Text(asyncSnapshot!.data!.articles![i].title.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                                ),
                                SizedBox(height: 10,),
                                asyncSnapshot!.data!.articles![i].description == null ? Padding(
                                  padding: const EdgeInsets.only(left: 10.0,right: 10),
                                  child: Text("Description Not Available",style: TextStyle(color: Colors.blueGrey,fontSize: 12),),
                                ):
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0,right: 10),
                                  child: Text(asyncSnapshot!.data!.articles![i].description.toString(),style: TextStyle(color: Colors.blueGrey,fontSize: 12),),
                                ),
                                SizedBox(height: 10),
                                asyncSnapshot!.data!.articles![i].publishedAt == null ? Padding(
                                  padding: const EdgeInsets.only(left: 10.0,right: 10),
                                  child: Text("Not Available"),
                                ):
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0,right: 10),
                                  child: Text("Published On : "+asyncSnapshot!.data!.articles![i].publishedAt.toString().split("T").first,style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold),),
                                ),
                                SizedBox(height: 20),

                              ],
                            ),

                            asyncSnapshot!.data!.articles![i].source!.name == null ? Padding(
                              padding: const EdgeInsets.only(left: 10.0,right: 10),
                              child: Text(""),
                            ):
                            Positioned(
                              left: 0,
                              right: 200,
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(10))
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Center(child: Text(asyncSnapshot!.data!.articles![i].source!.name.toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                                  )),
                            ),
                          ],
                        ),
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
