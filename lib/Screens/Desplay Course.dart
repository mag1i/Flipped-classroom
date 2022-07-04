import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flipped_classroom/Screens/Upload/secondpage.dart';
import 'package:flutter/material.dart';

import 'package:flipped_classroom/models/Course.dart';

class CoursesDesplay extends StatefulWidget {
  final String module, year;

  const CoursesDesplay({Key key, this.module, this.year}) : super(key: key);
  @override
  _CoursesDesplayState createState() => _CoursesDesplayState();
}

class _CoursesDesplayState extends State<CoursesDesplay> {
  String Name="";
  String field ="";


  bool dlt=false;
  List<Courses> itemList=List();
  final mainReference = FirebaseDatabase(databaseURL: "https://flippedclassroom-b5283-default-rtdb.firebaseio.com/").reference().child('Courses');

  Courses  mm=Courses("jh", "jh", " ", " ", "") ;


  // final mainReference = FirebaseDatabase.instance.reference().child('Courses');
  TextEditingController _textFieldController = TextEditingController();

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Book name'),
          content: TextField(
            controller: _textFieldController,
            decoration: InputDecoration(hintText: "Name your Course"),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Name=_textFieldController.text;

                print(_textFieldController.text);
                _textFieldController.clear();
                Navigator.pop(context);
                _fieldDialog(context);
                //  _textFieldController.text=" ";
              },
            ),
          ],
        );
      },
    );
  }
  Future<void> _fieldDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Field'),
          content: TextField(
            controller: _textFieldController,
            decoration: InputDecoration(hintText: "Field of the Course"),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                field=_textFieldController.text;
                getPdfAndUpload();
                print(_textFieldController.text);
                Navigator.pop(context);
                //  _textFieldController.text=" ";
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Courses list"),
      ),
      body: itemList.length==0?Text("Loading"):ListView.builder(
        itemCount:itemList.length,

        itemBuilder: (context,index){


          //   final DocumentSnapshot documentSnapshot =          streamSnapshot.data.documents[index];
          return Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child:

              GestureDetector(


                onTap: (){
                  String passData=itemList[index].link;


                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context)=>ViewPdf(),
                          settings: RouteSettings(
                            arguments: passData,
                          )
                      )
                  );
                },
                child:
                itemList[index].year== widget.year && itemList[index].teacher==widget.module ?
                   Stack(
                  children: <Widget>[
                    Container(
                      height: 100,

                      decoration: BoxDecoration(

                        image: DecorationImage(
                          image: AssetImage('assets/818.jpg'),

                          fit: BoxFit.cover,
                        ),

                      ),

                    ),
                    Center(
                      child: Container(
                        height: 100,
                        child:

                        Card(
                          margin: EdgeInsets.all(18),
                          elevation: 7.0,

                          child:Row( children: <Widget>[

                            Text("Name: "+itemList[index].name+" "+(index+1).toString()+"\n Posted By: "+itemList[index].field
                                +"\n Field: "+itemList[index].teacher  +"\n Year: "+itemList[index].year),]
                          ),
                        )
                            //
                      ),
                    ),
                  ],
                )
               :SizedBox(height:0)
              ),
          );
        },
      ),
     /* floatingActionButton: FloatingActionButton(
        onPressed: () {
          //  getPdfAndUpload();
          _displayTextInputDialog( context);
        },
        child: Icon(Icons.add,color: Colors.white,),
        backgroundColor: Colors.green,
      ),*/
    );
  }
  Future getPdfAndUpload()async{
    var rng = new Random();
    String randomName="";
    for (var i = 0; i < 20; i++) {
      print(rng.nextInt(100));
      randomName+= rng.nextInt(100).toString();

      //generate
    }
    File file = await FilePicker.getFile(type: FileType.custom);
    String fileName = '${randomName}.pdf';

    //function call
  }


  @override
  void initState() {
    mainReference.once().then((DataSnapshot snap){
      print(snap);
      var data=snap.value;
      print(data);

      itemList.clear();
      data.forEach((key, value){
        mm= new Courses(value['PDF'], value['FileName'], value['PostedBy'], value['field'], value['year']) ;




        itemList.add(mm);


      }

      );
      setState((){
        if(dlt==true){

          itemList.remove(mm);
        }
        print ("value is");
        print (itemList.length);
      });

      //get data from firebase
    });
  }
/* Future<void> _deleteCourse(String coursId) async {
    // await Teachers.document(coursId).delete();

    mainReference.equalTo(Id).once().then((DataSnapshot snapshot){
      if(snapshot.value.isNotEmpty){
        var dbRef = FirebaseDatabase.instance.reference();
        dbRef.child(numberController.text).once().then((DataSnapshot snapshot){
          snapshot.value.forEach((key,values) {
            print(values["Password"]);
          });
        });
      }
      else{
        print("pleasesignup first");
      }
    });


    // Show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You have successfully deleted a product')));
  }
*/

}