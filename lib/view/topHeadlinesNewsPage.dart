import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:tmdb/controllers/newsController.dart';
import 'package:tmdb/models/newsModel.dart';
import 'package:tmdb/view/searchNewsPage.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class TopHeadlinesNewsPage extends StatefulWidget {
  final dropDownValue;
  const TopHeadlinesNewsPage({Key? key,this.dropDownValue}) : super(key: key);

  @override
  _TopHeadlinesNewsPageState createState() => _TopHeadlinesNewsPageState();
}

class _TopHeadlinesNewsPageState extends State<TopHeadlinesNewsPage> {

  final NewsController newsController = NewsController();
  AsyncSnapshot<NewsModel>? asyncSnapshot;
  
  TextEditingController searchTextEditingController = TextEditingController();




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
    newsController.fetchTopHeadlinesNews(widget.dropDownValue!);
  }



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    newsController.dispose();
  }
  
  navigateSearchPage(){
    Navigator.push(context, MaterialPageRoute(builder: (context){
          return SearchNewsPage(keyword: searchTextEditingController.text);
    }));
  }


  refreshPage(){
    return  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TopHeadlinesNewsPage(dropDownValue: widget.dropDownValue,)));
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: (){
       return refreshPage();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Top Headlines"),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Container(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: searchTextEditingController ,
                  textInputAction: TextInputAction.search,
                  onEditingComplete: (){
                    navigateSearchPage();
                  },
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search your topic.."
                  ),
                ),
              ),
            ),
          ),
        ),
        body: StreamBuilder<NewsModel>(
          stream: newsController.newsStream,
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
              return ListView.builder(
                  itemCount: asyncSnapshot!.data!.articles!.length,
                  itemBuilder: (c,i){
                    return  Padding(
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
      ),
    );
  }
}



class ArticlesTile extends StatelessWidget {

  final Articles? articles;

  const ArticlesTile({Key? key,this.articles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          articles!.urlToImage == null ? Text("No Image"): Image.network(articles!.urlToImage.toString()),
          articles!.title == null ? Text("No Image"): Text(articles!.title.toString())
        ],
      ),
    );
  }
}

