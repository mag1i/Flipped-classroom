
import 'package:flipped_classroom/Screens/vidio/visio.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'Authentificationfldr/hmmm.dart';

import 'package:flipped_classroom/Controler/auth.dart';

import 'Modules.dart';




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

class FirstScreen extends StatelessWidget {

  String selectfield=null;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green[100],
        appBar: AppBar(

          backgroundColor: Colors.green[400],
          elevation: 0.0,
          title: Text('Field'),


        ),
      body:Padding(

        padding: EdgeInsets.fromLTRB(30, 40, 30, 0),

        child: Column(
          children: <Widget>[
            Row(
                children: <Widget>[
                  SizedBox(width: 50),
                  Text('Choose your field \n   and year to get \n     your lessons ',
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 30,
                          fontWeight: FontWeight.bold)),
                ]),
            SizedBox(height: 50),
        Row(
        children: <Widget>[
          SizedBox(width: 40.0),
          DropdownButton(
            value: selectfield,
            items: Tc(),
            onChanged: (value){
              selectfield=value;
              switch(value){
                case "L1" :
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ManageModulesPage(year: "GL")),
                  );
                  break;

                case "L2" :
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ManageModulesPage(year: "L2")),
                  );
                  break;
              }
            },
            hint: Text('Trancommun'),
          ),
          SizedBox(width: 40.0),
          DropdownButton(
            value: selectfield,
            items: L3(),
            onChanged: (value){
              selectfield=value;
              switch(value){
                case "GL" :
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  ManageModulesPage(year: "GL")),
                  );
                  break;

                case "SI" :
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ManageModulesPage(year: "GL")),
                  );
                  break;
                case "RSD" :
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ManageModulesPage(year: "GL")),
                  );
                  break;
              }
            },
            hint: Text('L3'),
          ),
        ],
      ),
            SizedBox(height: 40.0),
            Row(
              children: <Widget>[
                SizedBox(width: 60.0),
                DropdownButton(
                  value: selectfield,
                  items: M1(),
                  onChanged: (value){
                    selectfield=value;
                    switch(value){
                      case "GL" :
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Authenticate()),
                        );
                        break;

                      case "STIC" :
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeSI()),
                        );
                        break;
                      case "STIW" :
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeSI()),
                        );
                        break;
                    }
                  },
                  hint: Text('M1'),
                ),
                SizedBox(width: 70.0),
                DropdownButton(
                  value: selectfield,
                  items: M2(),
                  onChanged: (value){
                    selectfield=value;
                    switch(value){
                      case "GL" :
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ManageModulesPage(year: "GL")),
                        );
                        break;

                      case "STIW" :
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => mnsin()),
                        );
                        break;
                      case "RSD" :
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => mnsin()),
                        );
                        break;
                    }
                  },
                  hint: Text('M2'),
                ),
              ],
            ),
            SizedBox(height:80),
            InkWell(
              onTap: () {
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) {
                  return vv();
                },),);
              }, // Handle your callback.
              splashColor: Colors.brown.withOpacity(0.5),
              child: Ink(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/facetime.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
      ],),)
    );
  }


  List<DropdownMenuItem<String>> Tc() {
    List<String> ddl = ["L1", "L2"];
    return ddl.map(
            (value) =>
            DropdownMenuItem(
              value: value,
              child: Text(value),
            )
    ).toList();
  }
  List<DropdownMenuItem<String>> L3() {
    List<String> ddl = ["GL", "SI", "RSD", "SI"];
    return ddl.map(
            (value) =>
            DropdownMenuItem(
              value: value,
              child: Text(value),
            )
    ).toList();
  }
  List<DropdownMenuItem<String>> M1() {
    List<String> ddl = ["GL", "STIW", "STIC"];
    return ddl.map(
            (value) =>
            DropdownMenuItem(
              value: value,
              child: Text(value),
            )
    ).toList();
  }
  List<DropdownMenuItem<String>> M2() {
    List<String> ddl = ["GL", "STIW", "STIC"];
    return ddl.map(
            (value) =>
            DropdownMenuItem(
              value: value,
              child: Text(value),
            )
    ).toList();
  }
}


class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Screen"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}

class third extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("tgird Screen"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}