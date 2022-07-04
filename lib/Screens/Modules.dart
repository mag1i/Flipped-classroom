
import 'package:flipped_classroom/Controler/Modules.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import 'Desplay Course.dart';


/*

class DesplayModules extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Modules',
      home: ManageModulesPage(),
    );
  }
}
*/
class ManageModulesPage extends StatefulWidget {
  final String year;

  const ManageModulesPage({Key key, this.year}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<ManageModulesPage> {
  // List<Modules> itemList=List();
  //final Modules  mm=Modules("jh", "jh", "kjj", "jj", " ", 0, 0, 0) ;




  CollectionReference Modules =
  Firestore.instance.collection('Modules');



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        title: Text('Modules'),
      ),
      // Using StreamBuilder to display all products from Firestore in real-time
      body: StreamBuilder(
        stream: Modules.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data.documents.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                streamSnapshot.data.documents[index];
                print(documentSnapshot.data);
                return   Column(
                    children:<Widget>[
                     // documentSnapshot['year']== widget.year ?
                    ElevatedButton(
                  onPressed: () {Navigator.push(
                    context, MaterialPageRoute(builder: (context) {
                    return CoursesDesplay(module: documentSnapshot['name'] ,year:documentSnapshot['year'] );}, ),);},              //    margin: EdgeInsets.all(10),
                  child: ListTile(

                    title:
                    Text(documentSnapshot['name']),
                    // subtitle: Text(documentSnapshot['email'].toString()),
                    subtitle: Column( children: [ Text('Credit: '+documentSnapshot['credit'].toString()),Text('Field: '+documentSnapshot['field']),
                      Text("Year: "+documentSnapshot['year']),Text('  '),Text("Couurse Teeacher:"+documentSnapshot['courseteacher']),
                      Text("TD teacher: "+documentSnapshot['TDteacher']),Text('  '),Text("TP teacher: "+documentSnapshot['TPteacher']),Text("Coefission: "+documentSnapshot['coef'].toString())]),

                    trailing: SizedBox( width: 100, ),
                  )),
                        //: SizedBox( height: 0.00, ),
                  SizedBox( height: 10, ),]
                );
              },
            );
          }

          return Center(
            child: CircularProgressIndicator(),

          );
        },
      ),

    );
  }

/* @override
  void initState() {
    mainReference.once().then((DataSnapshot snap){
      print(snap);
      var data=snap.value;
      print(data);
      itemList.clear();
      data.forEach((key, value){
        mm= new Modules(value['name'], value['field'], value['courseteacher'], value['TDTeacher']) ;
        itemList.add(mm);

      }

      );

    });
  }*/
}