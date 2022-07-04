import 'package:firebase_auth/firebase_auth.dart';
import 'package:flipped_classroom/Controler/wrapperAdmin.dart';
import 'package:flipped_classroom/Screens/AuthTeacher/TeacherProfile.dart';
import 'package:flipped_classroom/models/Admin.dart';

import 'package:flutter/material.dart';

import 'package:flipped_classroom/Screens/Spec2.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import 'package:flipped_classroom/Controler/Manage Agenda.dart';
import 'package:flipped_classroom/Controler/ManageStudents.dart';
import 'package:flipped_classroom/Controler/Manege Teacher.dart';
import 'package:flipped_classroom/Controler/authadmin.dart';
import 'package:flipped_classroom/Controler/manage modules.dart';



class adminsn extends StatelessWidget {




  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return StreamProvider<admn>.value(


      value: AuthServiceAdmin().user,
      child: MaterialApp(
        home: Wrapperadmn(),
      ),
    );
  }
}
class Admin extends StatelessWidget {
  String usertype;

  setUserType(String ut){
    usertype=ut;

  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(



      backgroundColor: Colors.green[100],
      appBar: AppBar(

        backgroundColor: Colors.green[400],
        elevation: 0.0,
        title: Text('Admin'),



      ),
      body: Padding(

          padding: EdgeInsets.fromLTRB(120, 10, 30, 0),


          child: Column(

              children:<Widget>[


                ElevatedButton(
                  onPressed: ()  {

                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) {
                      return ManageModules();}));
                  },




                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green)),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/couuurse.jpg'),
                    radius: 50,

                  ),),
                SizedBox(height:5),
                Text('Manage Modules',
                    style: TextStyle(
                        color: Colors.green[800],
                        fontSize: 17,
                        fontWeight: FontWeight.bold)),
                SizedBox(height:20),

                ElevatedButton(
                  onPressed: ()  {

                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) {
                      return ManageStudents();}));
                  },




                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green)),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/tstt.png'),
                    radius: 50,

                  ),),
                SizedBox(height:5),
                Text('Manage Students',
                    style: TextStyle(
                        color: Colors.green[800],
                        fontSize: 17,
                        fontWeight: FontWeight.bold)),
                SizedBox(height:20),


                ElevatedButton(
                  onPressed: () {

                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) {
                      return ManageTeacher();}));
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green)),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/kkkk.jpg'),
                    radius: 50,

                  ),),
                SizedBox(height:5),




                Text('Manage Teachers',style: TextStyle(
                    color: Colors.green[800],
                    fontSize: 17,
                    fontWeight: FontWeight.bold)),
                SizedBox(height:20),


                ElevatedButton(
                  onPressed: () {

                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) {
                      return aagnd();}));
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green)),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/h.jpg'),
                    radius: 50,

                  ),),
                SizedBox(height:5),




                Text('Manage Agenda',style: TextStyle(
                    color: Colors.green[800],
                    fontSize: 17,
                    fontWeight: FontWeight.bold)),
                SizedBox(height:20),
          ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.green),

          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),),),),

        onPressed: () async {
         await _auth.signOut();
        },
        child: Text("Sign out"),
      ),







              ]


          )

      ),



    );
  }

}

