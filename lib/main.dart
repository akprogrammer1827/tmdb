import 'package:flutter/material.dart';
import 'package:tmdb/view/featuredCollectionPage.dart';
import 'package:tmdb/view/nowPlayingMoviesView.dart';
import 'package:tmdb/view/popularVideosPage.dart';
import 'package:tmdb/view/topHeadlinesNewsPage.dart';
import 'package:tmdb/view/trendingImagePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TMDB',
      theme: ThemeData.dark(),
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


  String? dropDownValue = "in";
  List<String> countryList = ["ae" ,"ar" ,"at", "au", "be", "bg", 'br' ,'ca' ,'ch' ,'cn' ,'co','cu' ,"cz", "de", "eg", "fr","gb", "gr" ,
    "hk", "hu", "id", "ie", "il", "in" ,'it', 'jp', 'kr', "lt", "lv", "ma" ,'mx', 'my', 'ng' ,'nl' ,'no', 'nz', 'ph', 'pl',
    "pt", "ro" ,"rs", "ru", "sa" ,"se", "sg", "si", "sk", "th", "tr", "tw", "ua" , "us" ,"ve", "za"];

  List<String> countryNamesList = ["UAE" ,"Argentina" ,"Austria", "Australia", "Belgium", "Bulgaria", 'Brazil' ,'Canada' ,'China' ,'China' ,'Columbia','Cuba',
    "Czech Republic", "Denmark", "Egypt", "France", "Gabon", "Greece" , "Hong Kong", "Hungary", "Indonesia", "Ireland", "Israel", "India" ,'Italy', 'Japan', 'Korea',
    "Lithuania", "Latvia", "Morocco" ,'Mexico', 'Malaysia', 'Nigeria' ,'Netherlands' ,'Norway', 'New Zealand', 'Philippines', 'Poland',
    "Portugal", "Romania" ,"rs", "Russia", "Saudi Arabia" ,"Sweden", "Singapore", "Slovenia", "Slovakia", "Thailand", "Turkey", "Taiwan", "Ukraine" , "America" ,"Venezuela", "Zimbabwe"];

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
          ListTile(
            title: Text("Feature Collection"),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>FeatureCollectionPage()));
            },
          ),ListTile(
            title: Text("Top Headlines News"),
            onTap: (){
              showDialog(context: context, builder: (context){
                return  AlertDialog(

                     title: Column(
                       children: [
                         Text("Select Country"),
                         Container(
                           child:DropdownButton(
                             value: dropDownValue,
                             icon: Icon(Icons.keyboard_arrow_down),
                             items: countryList.map((String items) {
                               return DropdownMenuItem(
                                   value: items,
                                   child: Text(items));
                             }).toList(),
                             onChanged: (String? newValue) {
                               setState(() {
                                 dropDownValue = newValue!;
                                 print(dropDownValue);

                                 Navigator.push(context, MaterialPageRoute(builder: (context)=>TopHeadlinesNewsPage(dropDownValue: dropDownValue,)));

                               });

                             },

                           ),
                         ),
                       ],
                     )
                  ,
                );
              });


              //
            },
          ),
        ],
      ),
    );
  }
}

