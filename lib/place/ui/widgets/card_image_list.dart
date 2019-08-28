import 'package:flutter/material.dart';
import 'card_image.dart';

class CardImageList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = 300.0;
    double height = 250.0;
    double left = 20.0;

    return Container(
      height: 350.0,
      child: ListView(
        padding: EdgeInsets.all(25.0),
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          CardImageWithFabIcon(
            pathImage: "assets/images/beach.jpeg",
            iconData: Icons.favorite_border,
            width: width,
            height: height,
            left: left,
          ),
          CardImageWithFabIcon(
            pathImage: "assets/images/beach_palm.jpeg",
            iconData: Icons.favorite_border,
            width: width,
            height: height,
            left: left,
          ),
          CardImageWithFabIcon(
            pathImage: "assets/images/mountain.jpeg",
            iconData: Icons.favorite_border,
            width: width,
            height: height,
            left: left,
          ),
          CardImageWithFabIcon(
            pathImage: "assets/images/mountain_stars.jpeg",
            iconData: Icons.favorite_border,
            width: width,
            height: height,
            left: left,
          ),
          CardImageWithFabIcon(
            pathImage: "assets/images/river.jpeg",
            iconData: Icons.favorite_border,
            width: width,
            height: height,
            left: left,
          ),
          CardImageWithFabIcon(
            pathImage: "assets/images/sunset.jpeg",
            iconData: Icons.favorite_border,
            width: width,
            height: height,
            left: left,
          ),
        ],
      ),
    );
  }
}
