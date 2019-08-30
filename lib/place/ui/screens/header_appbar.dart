import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_trips/place/ui/widgets/card_image_list.dart';
import 'package:platzi_trips/user/bloc/bloc_user.dart';
import 'package:platzi_trips/widgets/gradient_back.dart';

class HeaderAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    UserBloc userBloc;
    userBloc = BlocProvider.of(context);

    // TODO: implement build
    return Stack(
      children: <Widget>[
        GradientBack(height: 350.0,),
        CardImageList(userBloc.getCurrentUser())
      ],
    );
  }

}