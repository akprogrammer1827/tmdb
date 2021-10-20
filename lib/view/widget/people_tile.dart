import 'package:flutter/material.dart';
import 'package:tmdb/models/people_model.dart';

class PeopleTile extends StatelessWidget {
  final Results? results;
  final imageUrl;

  const PeopleTile({Key? key, this.results, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 5.0, right: 5, top: 2.5, bottom: 2.5),
      child: GestureDetector(
        onTap: () {

        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 70,
                backgroundImage: results!.profilePath == null
                    ? Image.asset("images/image_not_available.png", fit: BoxFit.contain).image
                    : Image.network(
                  imageUrl + results!.profilePath,
                  fit: BoxFit.contain,



                ).image),
            SizedBox(height: 10,),
            Text(results!.name.toString())
          ],
        ),
      ),
    );
  }
}