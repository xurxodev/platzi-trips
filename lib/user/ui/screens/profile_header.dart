import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_trips/user/bloc/bloc_user.dart';
import 'package:platzi_trips/user/model/user.dart';
import 'package:platzi_trips/user/ui/widgets/user_info.dart';
import 'package:platzi_trips/user/ui/widgets/button_bar.dart';

class ProfileHeader extends StatelessWidget {
  UserBloc userBloc;
  User user;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);

    return showProfileData();
  }

  Widget showProfileData() {
    user = userBloc.getCurrentUser();

    if (user == null) {
      print("No logeado");
      print(user);
      return Container(
        margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
        child: Column(
          children: <Widget>[
            CircularProgressIndicator(),
            Text("No se pudo cargar la información. Haz login"),
            ButtonsBar()
          ],
        ),
      );
    } else {
      print("Logeado");
      print(user);

      final title = Text(
        'Profile',
        style: TextStyle(
            fontFamily: 'Lato',
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30.0),
      );

      return Container(
        margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[title],
            ),
            UserInfo(
              user: user,
            ),
            ButtonsBar()
          ],
        ),
      );
    }
  }
}
