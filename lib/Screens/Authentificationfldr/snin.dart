import 'package:firebase_auth/firebase_auth.dart';
import 'package:flipped_classroom/Screens/Admin/Admin.dart';
import 'package:flipped_classroom/Screens/Admin/signinadmin.dart';
import 'package:flipped_classroom/Screens/AuthTeacher/TeacherProfile.dart';

import 'package:flutter/material.dart';

import 'package:flipped_classroom/Screens/Spec2.dart';

import '../../main.dart';
import '../Student.dart';
import 'package:flipped_classroom/Controler/DatabaseService.dart';
import 'package:flipped_classroom/Controler/authservices.dart';
import 'hmmm.dart';


class SignInType extends StatelessWidget {
String usertype=" ";
  AuthService db;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(



      backgroundColor: Colors.green[100],
      appBar: AppBar(

        backgroundColor: Colors.green[400],
          elevation: 0.0,
          actions: <Widget>[

      FlatButton.icon(
      icon: Icon(Icons.person),
      label: Text('Admin'),
      onPressed: (){Navigator.push(
        context, MaterialPageRoute(builder: (context) {
      return adminsn();}));},
    ),],
        title: Text('Sign in'),



      ),
      body: Padding(

          padding: EdgeInsets.fromLTRB(30, 40, 30, 0),

          child: Column(
              children:<Widget>[
                Row(
                    children:<Widget>[
                      Text('Sign in as?',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 30,
                              fontWeight: FontWeight.bold)),
                    ]),
                SizedBox(height:50),

                      ElevatedButton(
                        onPressed: () {


                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) {
                            return mnsin();}));
                        },

                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.green)),
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/stdnt2.png'),
                          radius: 50,

                        ),),
                SizedBox(height:10),
                Text('A Student',
                    style: TextStyle(
                        color: Colors.green[800],
                        fontSize: 17,
                        fontWeight: FontWeight.bold)),
                SizedBox(height:30),


                      ElevatedButton(
                        onPressed: () {

                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) {
                            return Idk();}));
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.green)),
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/tchr.png'),
                          radius: 50,

                        ),),
                SizedBox(height:20),




                      Text('A Teacher',style: TextStyle(
                          color: Colors.green[800],
                          fontSize: 17,
                          fontWeight: FontWeight.bold))


              /*  Row(
                    children:<Widget>[
                      Text('Sign in as?',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 30,
                              fontWeight: FontWeight.bold)),
                    ]),
                SizedBox(height:50),
                Row(
                    children:<Widget>[
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) {
                            return mnsin();}));
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.green)),
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/stdnt2.png'),
                          radius: 50,

                        ),),


                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) {
                            return Idk();}));
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.green)),
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/tchr.png'),
                          radius: 50,

                        ),)]),
                Row(
                    children:<Widget>[
                      SizedBox(width:30),
                      Text('A Student',
                          style: TextStyle(
                              color: Colors.green[800],
                              fontSize: 17,
                              fontWeight: FontWeight.bold)),
                      SizedBox(width:60),
                      Text('A Teacher',style: TextStyle(
                          color: Colors.green[800],
                          fontSize: 17,
                          fontWeight: FontWeight.bold))

                    ]),*/







              ]


          )

      ),



    );
  }

}

