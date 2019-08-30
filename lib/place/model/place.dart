import 'package:flutter/material.dart';

class Place {

  String uid;
  String name;
  String description;
  String urlImage;
  int likes;
  //User userOwner;

  Place({
    Key key,
    @required this.uid,
    @required this.name,
    @required this.description,
    @required this.urlImage,
    this.likes,
    //@required this.userOwner
  });
}