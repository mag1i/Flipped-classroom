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

import 'Authentificationfldr/hmmm.dart';
import 'package:flipped_classroom/models/Homeworks.dart';

class Homeworkdesplay extends StatefulWidget {



  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<Homeworkdesplay> {
  String Name="kjhkj";
  String StudentId="llkoi";






  bool dlt=false;
  List<Homeworks> itemList=List();
  final mainReference = FirebaseDatabase(databaseURL: "https://flippedclassroom-b5283-default-rtdb.firebaseio.com/").reference().child('Homeworks');

  Homeworks  mm=Homeworks("jh", "jh", "kjh", "jhkjh") ;





  // final mainReference = FirebaseDatabase.instance.reference().child('Courses');
  TextEditingController _textFieldController = TextEditingController();

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('File Name'),
          content: TextField(
            controller: _textFieldController,
            decoration: InputDecoration(hintText: "Name your course"),
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
        title: Text("Upload Homework"),
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
                child:Stack(
                  children: <Widget>[
                    Container(
                      height: 100,

                      decoration: BoxDecoration(

                        image: DecorationImage(
                          image: AssetImage('hrk.jpg'),

                          fit: BoxFit.cover,
                        ),

                      ),

                    ),
                    Center(
                      child: Container(
                        height: 100,
                        child: Card(
                          margin: EdgeInsets.all(18),
                          elevation: 7.0,

                          child:Row( children: <Widget>[
                            IconButton(

                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  String nm= itemList[index].name.toString();

                                  itemList.removeAt(index);
                                  mainReference.orderByChild("FileName").equalTo(
                                      nm).onChildAdded.listen((Event event) {
                                    FirebaseDatabase.instance.reference()
                                        .child('Homeworks')
                                        .child(event.snapshot.key)
                                        .remove();
                                  }, onError: (Object o) {
                                    final DatabaseError error = o;
                                    print('Error: ${error.code} ${error.message}');
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Refresh to see the new list')));
                                    /* .reference()
                                  .remove().then((value) => itemList.removeAt(index));*/
                                  });}




                              //_deleteCourse(documentSnapshot.documentID)),
                            ),
                            Text(itemList[index].name+"Student name: "+itemList[index].studentName)]
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
          );
        },
      ),

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
    savePdf(file.readAsBytesSync(), fileName);
    //function call
  }
  savePdf(List<int> asset, String name) async {
    StorageReference reference = FirebaseStorage.instance.ref().child(name);
    StorageUploadTask uploadTask = reference.putData(asset);
    String url = await (await uploadTask.onComplete).ref.getDownloadURL();
    documentFileUpload(url);

    //function call
  }
  String CreateCryptoRandomString([int length = 32]) {
    final Random rndm =Random.secure();
    var values= List <int>.generate(length, (i)=>rndm.nextInt(256));

    return base64Url.encode(values);
    //generate key
  }
  void documentFileUpload(String str) {
    var data = {
      "PDF": str,
      "FileName": Name,
      // "StudentId": widget.StudentId,
      //"StudentName": widget.StudentName,
      //store data
    };
    mainReference.child(CreateCryptoRandomString()).set(data).then((v) {

    });
  }

  @override
  void initState() {
    mainReference.once().then((DataSnapshot snap){
      print(snap);
      var data=snap.value;
     // StudentId=widget.StudentId;
      print(data);
      itemList.clear();
      data.forEach((key, value){
        mm= new Homeworks(value['PDF'], value['FileName'],  value['StudentId'],value['StudentName'], ) ;



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