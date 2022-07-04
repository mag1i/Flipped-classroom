
import 'package:flipped_classroom/Screens/AuthTeacher/SignUpTeacher.dart';
import 'package:flipped_classroom/Screens/AuthTeacher/SigninTeacher.dart';
import 'package:flutter/material.dart';

class AuthenticateTeacher extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<AuthenticateTeacher> {

  bool showSignIn = true;



  void toggleView() {
    //print(showSignIn.toString());
    setState(() => showSignIn = !showSignIn);
  }



  @override
  Widget build(BuildContext context) {

    if (showSignIn) {
      return SignInTeacher(toggleView: toggleView);
    } else {
      return TeacherRegister(toggleView: toggleView);
    }
  }
}