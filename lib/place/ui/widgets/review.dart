import 'package:flutter/material.dart';

class Review extends StatelessWidget {
  final String pathImage;
  final String name;
  final String details;
  final String comment;

  Review(this.pathImage, this.name, this.details, this.comment);

  @override
  Widget build(BuildContext context) {
    final userPhotoWidget = createUserPhotoWidget();

    final infoWidget = createInfoWidget();

    return Container(
        margin: EdgeInsets.only(
          top: 20.0,
          left: 20.0,
          right: 20.0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            userPhotoWidget,
            infoWidget,
          ],
        ));
  }

  Widget createUserPhotoWidget() {
    final photoWidget = Container(
      width: 80.0,
      height: 80.0,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(pathImage),
          )),
    );
    return photoWidget;
  }

  Widget createInfoWidget() {
    final userNameWidget = createNameWidget();

    final userDetailsWidget = createUserDetailsWidget();

    final userCommentsWidget = createUserCommentsWidget();

    final infoWidget = Container(
      margin: EdgeInsets.only(
        left: 20.0,
        right: 20.0,
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            userNameWidget,
            userDetailsWidget,
            userCommentsWidget,
          ]),
    );
    return infoWidget;
  }

  Widget createNameWidget() {
    final userName = Text(
      name,
      textAlign: TextAlign.left,
      style: TextStyle(
        fontFamily: "Lato",
        fontSize: 17.0,
      ),
    );

    return userName;
  }

  Widget createUserDetailsWidget() {
    final userInfoText = Text(
      details,
      textAlign: TextAlign.left,
      style: TextStyle(
          fontFamily: "Lato", fontSize: 13.0, color: Color(0xFFa3a5a7)),
    );

    final userInfoStars = createStars();

    final userInfo = Row(
      children: <Widget>[
        userInfoText,
        userInfoStars,
      ],
    );

    return userInfo;
  }

  Widget createUserCommentsWidget() {
    final userComment = Text(
      comment,
      textAlign: TextAlign.left,
      style: TextStyle(
        fontFamily: "Lato",
        fontSize: 13.0,
        fontWeight: FontWeight.bold,
      ),
    );

    return userComment;
  }

  createStars() {
    final starHalf = Container(
      margin: EdgeInsets.only(
        right: 3.0,
      ),
      child: Icon(
        Icons.star_half,
        color: Color(0xFFf2C611),
      ),
    );

    final starBorder = Container(
      margin: EdgeInsets.only(
        right: 3.0,
      ),
      child: Icon(
        Icons.star_border,
        color: Color(0xFFf2C611),
      ),
    );

    final star = Container(
      margin: EdgeInsets.only(
        right: 3.0,
      ),
      child: Icon(
        Icons.star,
        color: Color(0xFFf2C611),
      ),
    );

    return Row(
      children: <Widget>[
        star,
        star,
        star,
        star,
        starHalf,
      ],
    );
  }
}
