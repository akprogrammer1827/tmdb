import 'package:flutter/material.dart';
import 'package:tmdb/view/nowPlayingMoviesView.dart';

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
      home:NowPlayingMoviesView()
    );
  }
}
