import 'package:flutter/material.dart';
import 'package:tmdb/controllers/newsController.dart';
import 'package:tmdb/models/newsModel.dart';

class TopHeadlinesNewsPage extends StatefulWidget {
  const TopHeadlinesNewsPage({Key? key}) : super(key: key);

  @override
  _TopHeadlinesNewsPageState createState() => _TopHeadlinesNewsPageState();
}

class _TopHeadlinesNewsPageState extends State<TopHeadlinesNewsPage> {

  final NewsController newsController = NewsController();
  AsyncSnapshot<NewsModel>? asyncSnapshot;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    newsController.fetchTopHeadlinesNews();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    newsController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        asyncSnapshot!.data!.articles![i].urlToImage  == null ? Text("No Image"):  Image.network(asyncSnapshot!.data!.articles![i].urlToImage.toString()),
                      ],
                    ),
                  );

            });
          }
        },
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

