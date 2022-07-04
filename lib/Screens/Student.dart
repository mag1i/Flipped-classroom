import 'package:flutter/material.dart';

import 'package:flipped_classroom/Screens/Spec2.dart';

import 'Homework.dart';
//import 'package:flutter_pdfview/flutter_pdfview.dart';




class SideDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/workr.png'),
              radius: 50,

            ),






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
            onTap: () => {},
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
class Stdnt extends StatelessWidget {
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

          padding: EdgeInsets.fromLTRB(30, 40, 30, 0),

          child: Column(
              children:<Widget>[

                      CircleAvatar(
                        backgroundImage: AssetImage('assets/workr.png'),
                        radius: 50,

                      ),


                      Text('Name:', style: TextStyle(fontWeight: FontWeight.bold),),
                      Text('here get the name'),
                      SizedBox(height:20),
                      Text('Field of study:', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('here get the field'),
                SizedBox(height: 30),
                Row(
                    children: <Widget>[
                      SizedBox(width: 50),

                      InkWell(
                        onTap: () {},

                        splashColor: Colors.brown.withOpacity(0.5),
                        child: Ink(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/t.png'),
                              fit: BoxFit.cover,
                            ),),),),
                      SizedBox(width: 50),

                      InkWell(
                        onTap: () {}, // Handle your callback.
                        splashColor: Colors.brown.withOpacity(0.5),
                        child: Ink(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/tt.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                    ]),

                Row(

                    children: <Widget>[
                      SizedBox(width: 20),

                      Text('Share homework',
                          style: TextStyle(
                              color: Colors.green[800],
                              fontSize: 17,
                              fontWeight: FontWeight.bold)),
                      SizedBox(width: 50),
                      Text('Courses followed', style: TextStyle(
                          color: Colors.green[800],
                          fontSize: 17,
                          fontWeight: FontWeight.bold))

                    ]),
                SizedBox(height: 50),


                Row(
                    children: <Widget>[
                      SizedBox(width: 50),
                      InkWell(
                        onTap: () {Navigator.push(
                          context, MaterialPageRoute(builder: (context) {
                          return Homeworkpage();}, ),);},// Handle your callback.
                        splashColor: Colors.brown.withOpacity(0.5),
                        child: Ink(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/ttt.jpg'),
                              fit: BoxFit.cover,
                            ),),),),
                      SizedBox(width: 50),
                      InkWell(
                        onTap: () {Navigator.push(
                          context, MaterialPageRoute(builder: (context) {
                          return Homeworkpage();}, ),);},// Handle your callback.
                        splashColor: Colors.brown.withOpacity(0.5),
                        child: Ink(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/tttt.jpg'),
                              fit: BoxFit.cover,
                            ),),),)
                    ]),
                Row(
                    children: <Widget>[
                      SizedBox(width: 30),
                      Text('My homeworks', style: TextStyle(
                          color: Colors.green[800],
                          fontSize: 17,
                          fontWeight: FontWeight.bold)),
                      SizedBox(width: 50),
                      Text('My testsests', style: TextStyle(
                          color: Colors.green[800],
                          fontSize: 17,
                          fontWeight: FontWeight.bold))

                    ])







              ]


          )

      ),



    );
  }

}

