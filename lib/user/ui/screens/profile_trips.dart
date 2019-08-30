import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_trips/user/bloc/bloc_user.dart';
import 'package:platzi_trips/user/model/user.dart';
import 'package:platzi_trips/user/ui/widgets/profile_background.dart';
import 'package:platzi_trips/user/ui/widgets/profile_places_list.dart';
import 'profile_header.dart';

class ProfileTrips extends StatelessWidget {
  UserBloc userBloc;
  User user;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);

    user = userBloc.getCurrentUser();

    return showProfileData(user);





    /*Stack(
      children: <Widget>[
        ProfileBackground(),
        ListView(
          children: <Widget>[
            ProfileHeader(),//User datos
            ProfilePlacesList()//User uid
          ],
        ),
      ],
    );*/
  }

  Widget showProfileData(User user){
    if(user==null){
      print("No logeado");
      return Stack(
        children: <Widget>[
          ProfileBackground(),
          ListView(
            children: <Widget>[
              Text("Usuario no logeado. Haz Login"),
              ProfileHeader(user: user)
            ],
          ),
        ],
      );
    }else {
      print("Logeado");

      return Stack(
        children: <Widget>[
          ProfileBackground(),
          ListView(
            children: <Widget>[
              ProfileHeader(user: user),//User datos
              ProfilePlacesList(user: user)//User uid
            ],
          ),
        ],
      );
    }

  }
}
