
import 'package:flipped_classroom/Screens/AuthTeacher/TeacherProfile.dart';
import 'package:flipped_classroom/models/Useer.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';



import 'package:flipped_classroom/Controler/authTeacher.dart';





class WrapperTchr extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final usr = Provider.of<Tchr>(context);
    print(usr);


    //to return either home or auth widget
    if (usr == null) {
      return AuthenticateTeacher();
    }
    else {
      return TeacherProfile();
    }



  }
}
