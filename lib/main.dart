import 'package:flutter/material.dart';
import 'package:platzi_trips/user/bloc/bloc_user.dart';
import 'package:platzi_trips/user/ui/screens/sign_in_screen.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        child: MaterialApp(
          title: 'Flutter Demo',
          //home: PlatziTripsCupertino(),
          home: SignInScreen(),
        ),
        bloc: UserBloc());
  }
}
