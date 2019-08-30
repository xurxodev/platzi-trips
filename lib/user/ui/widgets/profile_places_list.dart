import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_trips/place/model/place.dart';
import 'package:platzi_trips/user/bloc/bloc_user.dart';
import 'package:platzi_trips/user/model/user.dart';
import 'profile_place.dart';

class ProfilePlacesList extends StatelessWidget {
  UserBloc userBloc;

  User user;
  ProfilePlacesList({@required this.user});

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);

    return Container(
      margin: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
      child: StreamBuilder(
          stream: userBloc.myPlacesListSream(user.uid),
          builder: (context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              case ConnectionState.done:
                return Column(
                    children: userBloc.buildPlaces(snapshot.data.documents));

              case ConnectionState.active:
                return Column(
                    children: userBloc.buildPlaces(snapshot.data.documents));

              case ConnectionState.none:
                return CircularProgressIndicator();
              default:
                return Column(
                    children: userBloc.buildPlaces(snapshot.data.documents));
            }
          }),
    );
  }

/*
  * Column(
        children: <Widget>[
          ProfilePlace(place),
          ProfilePlace(place2),
        ],
      ),
  * */

}
