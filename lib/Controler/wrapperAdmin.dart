import 'package:flipped_classroom/Screens/Admin/Admin.dart';
import 'package:flipped_classroom/Screens/Admin/signinadmin.dart';
import 'package:flipped_classroom/Controler/authTeacher.dart';
import 'package:flipped_classroom/models/Admin.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';





class Wrapperadmn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final usr = Provider.of<admn>(context);
    print(usr);


    //to return either home or auth widget
    if (usr == null) {
      return SignInAdmin();
    }
    else {
      return Admin();
    }



  }
}
