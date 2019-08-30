import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:platzi_trips/place/model/place.dart';
import 'profile_place_info.dart';

class ProfilePlace extends StatelessWidget {

  Place place;
  bool internet = true;

  ProfilePlace(this.place,this.internet);

  @override
  Widget build(BuildContext context) {

    final photoCard = Container(
      margin: EdgeInsets.only(
          top: 10.0,
          bottom: 70.0
      ),
      height: 220.0,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: internet
                  ? CachedNetworkImageProvider(place.urlImage)
                  : AssetImage(place.urlImage)
          ),
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          color: Colors.red,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black38,
                blurRadius: 10.0,
                offset: Offset(0.0, 5.0)
            )
          ]
      ),
    );

    return Stack(
      alignment: Alignment(0.0, 0.8),
      children: <Widget>[
        photoCard,
        ProfilePlaceInfo(place)
      ],
    );
  }

}