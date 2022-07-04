import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flipped_classroom/Screens/Upload/secondpage.dart';
import 'package:flipped_classroom/models/Books.dart';
import 'package:flutter/material.dart';


class BooksLibrary extends StatefulWidget {

  @override
  _BooksLibraryState createState() => _BooksLibraryState();
}

class _BooksLibraryState extends State<BooksLibrary> {

  bool dlt=false;
  List<Book> itemList=List();
  final mainReference = FirebaseDatabase(databaseURL: "https://flippedclassroom-b5283-default-rtdb.firebaseio.com/").reference().child('Books');

  Book  mm=Book("jh", "jh", "kjj", "jj") ;


  // final mainReference = FirebaseDatabase.instance.reference().child('Courses');
  TextEditingController _textFieldController = TextEditingController();



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Library"),
      ),
      body: itemList.length==0?Text("Loading"):ListView.builder(
        itemCount:itemList.length,

        itemBuilder: (context,index){


          //   final DocumentSnapshot documentSnapshot =          streamSnapshot.data.documents[index];
          return Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: GestureDetector(

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
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: 100,

                      decoration: BoxDecoration(

                        image: DecorationImage(
                          image: AssetImage('assets/library.jpg'),

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

                                icon: Icon(Icons.assignment_returned),
                                onPressed: () async {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Book downloaded')));
                                 // String nm= itemList[index].link;
                                  StorageReference ref =
                                  FirebaseStorage.instance.ref().child(itemList[index].link.toString());
                                  String url = (await ref.getDownloadURL()).toString();
                                  print(url);

                                //  PDF().cachedFromUrl('your download link');


                                    /* .reference()
                                  .remove().then((value) => itemList.removeAt(index));*/
                                  }




                              //_deleteCourse(documentSnapshot.documentID)),
                            ),
                            Text("Book name:  "+itemList[index].name+" \n"+"Book field:  "+itemList[index].field+"\n" +"Posted by:  "+itemList[index].postedBy),]
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
  /*
  void documentFileUpload(String str) {
    var data = {
      "PDF": str,
      "FileName": Name,
      "posted by": widget.teacherName,
      "Field": field
      //store data
    };
    mainReference.child(CreateCryptoRandomString()).set(data).then((v) {

    });
  }*/

  @override
  void initState() {
    mainReference.once().then((DataSnapshot snap){
      print(snap);
      var data=snap.value;
      print(data);
      itemList.clear();
      data.forEach((key, value){
        mm= new Book(value['PDF'], value['FileName'], value['Field'], value['posted by']) ;



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
/*

    // Show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You have successfully deleted a product')));
  }
*/

}