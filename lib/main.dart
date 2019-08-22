import 'package:flutter/material.dart';
import 'package:platzi_trips/place/bloc/bloc_place.dart';
import 'platzi_trips_cupertino.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        child: MaterialApp(
          title: 'Flutter Demo',
          home: PlatziTripsCupertino(),
        ),
        bloc: UserBloc());
  }
}

