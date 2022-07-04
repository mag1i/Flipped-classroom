import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:flipped_classroom/Controler/auth.dart';
import 'Screens/Authentificationfldr/hmmm.dart';
import 'package:flipped_classroom/models/Srudent.dart';




class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final usr = Provider.of<Useer>(context);
    print(usr);


    //to return either home or auth widget
    if (usr == null) {
      return Authenticate();
    }
    else {

      return HomeSI();
    }



  }
}
