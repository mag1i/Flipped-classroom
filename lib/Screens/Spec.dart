import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flipped_classroom/Screens/teacherlist.dart';

import 'package:flutter/material.dart';

import 'package:flipped_classroom/Screens/Spec2.dart';
import '../main.dart';

import 'Authentificationfldr/snin.dart';
import 'Student.dart';
import 'StudentAgenda.dart';

import 'Upload/firstpage.dart';



class SideDrawer extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child:ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) {
                  return Stdnt();}));
              },
             style: ButtonStyle(
             backgroundColor: MaterialStateProperty.all(Colors.green)),
                 child: CircleAvatar(
              backgroundImage: AssetImage('assets/workr.png'),
              radius: 50,

            ),),






            decoration: BoxDecoration(
              color: Colors.green,

            ),
          ),
          Column( children:<Widget> [
            Text('Name:', style: TextStyle(fontWeight: FontWeight.bold),),
            Text('here get the name'),
            SizedBox(height:20),
            Text('Field of study:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('here get the field')
          ],

          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () => { Navigator.push(
                context, MaterialPageRoute(builder: (context) {
              return Home();}))},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Change'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}
class Speci extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      drawer: SideDrawer(),

      backgroundColor: Colors.green[100],
      appBar: AppBar(

        backgroundColor: Colors.green[400],
        elevation: 0.0,
        title: Text('Fields'),



      ),
      body: Padding(

          padding: EdgeInsets.fromLTRB(5, 40, 30, 0),

          child: Column(
              children:<Widget>[
                Row(
                    children:<Widget>[
                      Text('   Choose your field',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 30,
                              fontWeight: FontWeight.bold)),
                    ]),
                SizedBox(height:50),
                Row(
                    children:<Widget>[
                      FlatButton(
                          onPressed: () {

                          Navigator.push(
                          context, MaterialPageRoute(builder: (context) {
                          return SignInType();}));
                          },
                          padding: EdgeInsets.all(20.20),

                          child: Image.asset('assets/cs.jpg', height: 120, width: 120,)),

                      FlatButton(
                          onPressed: () async {Firestore.instance.collection('sessions').getDocuments().then((snapshot) {
                            for (DocumentSnapshot ds in snapshot.documents){
                          ds.reference.delete();
                          } });
                                                },
                          padding: EdgeInsets.all(20.20),

                          child: Image.asset('assets/im.jpg', height: 120, width: 120,))]),
                Row(
                    children:<Widget>[
                      SizedBox(width:20),
                      Text('Computer scienc',
                          style: TextStyle(
                              color: Colors.green[800],
                              fontSize: 17,
                              fontWeight: FontWeight.bold)),
                      SizedBox(width:50),
                      Text('علم المكتبات',style: TextStyle(
                          color: Colors.green[800],
                          fontSize: 17,
                          fontWeight: FontWeight.bold))

                    ]),







              ]


          )

      ),



    );
  }
  void moveTo(){

  }
}

