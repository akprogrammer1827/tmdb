import 'package:flutter/material.dart';
import 'package:tmdb/view/nowPlayingMoviesView.dart';
import 'package:tmdb/view/trendingImagePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TMDB',
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Colors.black
      ),
      home:Home()
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("Now Playing Movies"),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>NowPlayingMoviesView()));
            },
          ),
          ListTile(
            title: Text("Trending Images"),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>TrendingImagePage()));
            },
          ),
        ],
      ),
    );
  }
}

