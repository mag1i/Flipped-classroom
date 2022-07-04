import 'package:flutter/material.dart';
import 'package:flipped_classroom/Screens/Spec.dart';
import 'package:flipped_classroom/Screens/Authentificationfldr/signup.dart';

import 'Screens/Admin/Admin.dart';




void main() => runApp(MaterialApp(
  home: Home()));


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
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    drawer: SideDrawer(),

    backgroundColor: Colors.green[100],
    appBar: AppBar(

    backgroundColor: Colors.green[400],
    elevation: 0.0,
    title: Text('Home'),



    ),
    body: Padding(

      padding: EdgeInsets.fromLTRB(5, 40, 30, 0),

      child: Column(
        children:<Widget>[
          Row(
      children:<Widget>[
              Text('  Choose your department',
          style: TextStyle(
          color: Colors.green,
          fontSize: 25,
            fontWeight: FontWeight.bold)),
                ]),
          SizedBox(height:50),
          Row(
              children:<Widget>[
                FlatButton(
                    onPressed: (){debugPrint('well done');
                    Navigator.push(context,MaterialPageRoute(builder:(context){
                      return Speci();
                    }));},
                    padding: EdgeInsets.all(20.20),


                    child: Image.asset('assets/n.jpg', height: 120, width: 120,)),

                FlatButton(
                onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder:(context){
                return Register();
                }));},
                padding: EdgeInsets.all(20.20),

                child: Image.asset('assets/e.jpg', height: 120, width: 120,))]),
          Row(
              children:<Widget>[
                SizedBox(width:60),
                Text('NTIC',
                    style: TextStyle(
                    color: Colors.green[800],
                    fontSize: 17,
                        fontWeight: FontWeight.bold)),
                SizedBox(width:100),
                Text('Econimics',style: TextStyle(
                    color: Colors.green[800],
                    fontSize: 17,
                    fontWeight: FontWeight.bold))

                ]),



          Row(
      children:<Widget>[
            FlatButton(
            onPressed: null,
                padding: EdgeInsets.all(20.20),

                child: Image.asset('assets/sc.jpeg', height: 120, width: 120,)),
            FlatButton(
            onPressed: null,
            padding: EdgeInsets.all(20.20),

            child: Image.asset('assets/s.jpg', height: 120, width: 120,))]),
          Row(
              children:<Widget>[
                SizedBox(width:40),
                Text('Sociology',style: TextStyle(
                    color: Colors.green[800],
                    fontSize: 17,
                    fontWeight: FontWeight.bold) ),
                SizedBox(width:90),
                Text('psycology', style: TextStyle(
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

