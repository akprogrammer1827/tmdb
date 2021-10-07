import 'package:flutter/material.dart';
import 'package:tmdb/controllers/videosController.dart';
import 'package:tmdb/models/videosModel.dart';
import 'package:video_player/video_player.dart';

class PopularVideosPage extends StatefulWidget {
  const PopularVideosPage({Key? key}) : super(key: key);

  @override
  _PopularVideosPageState createState() => _PopularVideosPageState();
}

class _PopularVideosPageState extends State<PopularVideosPage> {
  
  final VideosController videosController = VideosController();

  VideoPlayerController? _controller;
  
  AsyncSnapshot<VideosModel>? asyncSnapshot;
  String? videoUrl;

  int page = 1;
  int perPage = 80;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    videosController.fetchPopularVideos("https://api.pexels.com/videos/popular?per_page=$perPage&page=$page");
    _controller = playVideo(videoUrl!);


  }


  playVideo(String videoUrl)
  {
    VideoPlayerController.network(
        videoUrl)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    videosController.dispose();
    _controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller!.value.isPlaying
                ? _controller!.pause()
                : _controller!.play();
          });
        },
        child: Icon(
          _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

Widget body(){
    return StreamBuilder<VideosModel>(
      stream: videosController.popularVideosStream,
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
              itemCount: asyncSnapshot!.data!.videos!.length,
              itemBuilder: (c,i){
                return  Padding(
                  padding: const EdgeInsets.only(top: 10.0,bottom: 10),
                  child: _controller!.value.isInitialized
                      ? AspectRatio(
                    aspectRatio: _controller!.value.aspectRatio,
                    child: VideoPlayer(
                        _controller =  playVideo(asyncSnapshot!.data!.videos![i].videoFiles![0].link.toString())
                    ),
                  )
                      : Container(),
                );

              });
        }
      },
    );
}
}
