import 'package:flutter/material.dart';

import 'Spec.dart';
void main() {
  runApp( MaterialApp(
    debugShowCheckedModeBanner: false,
    theme:  ThemeData(
      primaryColor: const Color(0xFF02BB9F),
      primaryColorDark: const Color(0xFF167F67),
      accentColor: const Color(0xFF167F67),
    ),
    home:  DropdownScreen(),
  ));
}
class Item {
  const Item(this.name,this.icon);
  final String name;
  final Icon icon;
}
class DropdownScreen extends StatefulWidget {
  State createState() =>  DropdownScreenState();
}
class DropdownScreenState extends State<DropdownScreen> {
  Item selectedUser;
  List<Item> Tc = <Item>[
    Item('L1',Icon(Icons.android,color:  const Color(0xFF167F67),)),
    Item('L2',Icon(Icons.flag,color:  const Color(0xFF167F67),)),

  ];
  Item Master;
  List<Item> M1 = <Item>[
    Item('STIW',Icon(Icons.android,color:  const Color(0xFF167F67),)),
    Item('STIC',Icon(Icons.flag,color:  const Color(0xFF167F67),)),
    Item('GL',Icon(Icons.format_indent_decrease,color:  const Color(0xFF167F67),)),
    Item('d',Icon(Icons.mobile_screen_share,color:  const Color(0xFF167F67),)),
  ];
  Item L3;
  List<Item> users = <Item>[
    Item('TI',Icon(Icons.android,color:  const Color(0xFF167F67),)),
    Item('GL',Icon(Icons.flag,color:  const Color(0xFF167F67),)),
    Item('RSD',Icon(Icons.format_indent_decrease,color:  const Color(0xFF167F67),)),
    Item('SI',Icon(Icons.mobile_screen_share,color:  const Color(0xFF167F67),)),
  ];
  Item M2;
  List<Item> mm2 = <Item>[
    Item('TI',Icon(Icons.android,color:  const Color(0xFF167F67),)),
    Item('GL',Icon(Icons.flag,color:  const Color(0xFF167F67),)),
    Item('RSD',Icon(Icons.format_indent_decrease,color:  const Color(0xFF167F67),)),
    Item('SI',Icon(Icons.mobile_screen_share,color:  const Color(0xFF167F67),)),
  ];
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home:  Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF167F67),
          title: Text(
            'Flields',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body:  Padding(

          padding: EdgeInsets.fromLTRB(30, 40, 30, 0),

          child: Column(
            children:<Widget>[
              Row(
                  children: <Widget>[
                    Text('Choose your field \n and year to get your courses',
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 25,
                            fontWeight: FontWeight.bold)),
                  ]),
              SizedBox(height: 50),
              Row(
                children:<Widget>[
                  SizedBox(width: 40),
                  DropdownButton<Item>(
                    hint:  Text("Trancommun"),
                    value: selectedUser,
                    onChanged: (Item Value) {
                      /*switch(value){
                        case "L1" :

                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) {
                            return Speci();
                          }));};
*/
                      setState(() {
                        selectedUser = Value;
                      });
                    },
                    items: Tc.map((Item t) {
                      return  DropdownMenuItem<Item>(
                        value: t,
                        child: Row(
                          children: <Widget>[
                            t.icon,
                            SizedBox(width: 10,),
                            Text(
                              t.name,
                              style:  TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(width: 40),
                  DropdownButton<Item>(
                    hint:  Text("L3"),
                    value: L3,
                    onChanged: (Item Value) {
                      setState(() {
                        L3 = Value;
                      });
                    },
                    items: users.map((Item l) {
                      return  DropdownMenuItem<Item>(
                        value: l,
                        child: Row(
                          children: <Widget>[
                            l.icon,
                            SizedBox(width: 10,),
                            Text(
                              l.name,
                              style:  TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  )],),
              SizedBox(height: 50),
              Row(
                children:<Widget>[
                  SizedBox(width: 40),
                  DropdownButton<Item>(
                    hint:  Text("M1"),
                    value: M2,
                    onChanged: (Item Value) {
                      setState(() {
                        M2 = Value;
                      });
                    },
                    items: mm2.map((Item c) {
                      return  DropdownMenuItem<Item>(
                        value: c,
                        child: Row(
                          children: <Widget>[
                            c.icon,
                            SizedBox(width: 10,),
                            Text(
                              c.name,
                              style:  TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(width: 60),
                  DropdownButton<Item>(
                    hint:  Text("M2"),
                    value: Master,
                    onChanged: (Item Value) {
                      setState(() {
                        Master = Value;
                      });
                    },
                    items: M1.map((Item m) {
                      return  DropdownMenuItem<Item>(

                        value: m,
                        child: Row(
                          children: <Widget>[
                            m.icon,

                            SizedBox(width: 10,),
                            Text(
                              m.name,
                              style:  TextStyle(color: Colors.black),

                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  )
                ],)
            ],),
        ),
      ),
    );
  }
}