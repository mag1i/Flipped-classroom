import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flipped_classroom/Controler/AddQuizz.dart';
import 'package:flipped_classroom/Controler/Manage%20Agenda.dart';
import 'package:flipped_classroom/Controler/manage%20modules.dart';

import 'package:flipped_classroom/Controler/ManageStudents.dart';

import 'package:flipped_classroom/Controler/wrapperTeacher.dart';
import 'package:flipped_classroom/Screens/Upload/firstpage.dart';

import 'package:flipped_classroom/models/Useer.dart';
import 'package:flipped_classroom/Screens/vidio/visio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../main.dart';

import '../Display homeworks.dart';
import '../Homework.dart';
import '../Library.dart';

import 'package:flipped_classroom/Controler/AuthServTeach.dart';
import 'package:flipped_classroom/Controler/DataServiceTeacher.dart';




class SideDrawer extends StatelessWidget {


  final String username,lastname, imgurl,  field;
  final bool isup;

  const SideDrawer({Key key, this.username, this.imgurl, this.lastname, this.field, this.isup}) : super(key: key);






  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    uploadImage() async {
      final _storage = FirebaseStorage.instance;
      final _picker = ImagePicker();
      PickedFile image;


      //Check Permissions
      await Permission.photos.request();

      var permissionStatus = await Permission.photos.status;

      if (permissionStatus.isGranted){
        //Select Image
        image = await _picker.getImage(source: ImageSource.gallery);
        var file = File(image.path);

        if (image != null){
          //Upload to Firebase
          var snapshot = await _storage.ref().child('folderName/imageName').putFile(file).onComplete;

          var downloadUrl = await snapshot.ref.getDownloadURL();

          final FirebaseUser user = await _auth.currentUser();
          Firestore.instance.collection("Student")
              .document(user.uid).updateData(
              {"image": downloadUrl}).then((_) {
            print("Image changed successfully!");
          });

          // setState(() {
          // imgurl = downloadUrl;
          // });
        } else {
          print('No Path Received');
        }

      } else {
        print('Grant Permissions and try again');
      }




    }




    Future<void> updateinf() async {

      TextEditingController _fieldController = TextEditingController();
      TextEditingController _pwController = TextEditingController();
      TextEditingController _yearController = TextEditingController();



      CollectionReference teachers =
      Firestore.instance.collection('Teacher');
      FirebaseUser user = await _auth.currentUser();

      /*  if (documentSnapshot != null) {

      _pwController.text = documentSnapshot['password'];
          _fieldController.text = documentSnapshot['field'];
      _yearController.text= documentSnapshot['year'].toString();


    }*/


      await showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (BuildContext ctx) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  TextField(
                    controller: _fieldController,
                    decoration: InputDecoration(labelText: 'Field'),
                  ),
                  TextField(
                    controller: _yearController,
                    decoration: InputDecoration(labelText: 'Year'),
                  ),


                  TextField(
                    //  keyboardType: TextInputType.numberWithOptions(decimal: true),
                    controller: _pwController,
                    decoration: InputDecoration(
                      labelText: 'Change Password',
                    ),
                  ),
                  FlatButton.icon(
                    icon: Icon(Icons.photo_camera),
                    label: Text('Change picture'),
                    onPressed: () =>  uploadImage(),
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      child: Text( 'Update'),
                      onPressed: () async {
                        final String field = _fieldController.text;
                        final String pw =  _pwController.text;
                        final int year =  int.tryParse(_yearController.text);
                        if (field != null && field != null  && year != null && pw != null) {

                          await   Firestore.instance.collection("Teachers")
                              .document(user.uid).updateData({"field": field,"year":year, "password":pw});
                        }

                        // Clear the text fields
                        _fieldController.text =" ";
                        _pwController.text= " ";
                        _yearController.text= " ";


                        // Hide the bottom sheet
                        Navigator.of(context).pop();
                      }

                  )
                ],
              ),
            );
          });
    }


    String username = "First name";
    String ln = "Last name";
    String userimage = "image";
    String field="fields";
    bool isup=false;






    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(



            child:  imgurl == null
                ?ElevatedButton(
              onPressed: () { uploadImage();
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green)),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/tchr.png'),
                radius: 50,

              ),) :
              Container(

              child:Image.network(imgurl),
              height: 100,
              width: 100,

              ),







            decoration: BoxDecoration(
              color: Colors.green,

            ),
          ),
          Column( children:<Widget> [



            Text('Name:', style: TextStyle(fontWeight: FontWeight.bold),),



            Text(username+" "+lastname),
            SizedBox(height:20),
            Text('Field of study:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(field)
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
          //  onTap: () => {Navigator.of(context).pop()},
              onTap: () =>   updateinf()),

          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () async {

              await _auth.signOut();
                },
          ),
        ],
      ),
    );
  }
}

class Idk extends StatelessWidget {




  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return StreamProvider<Tchr>.value(

      value: AuthServiceTchr().user,
      child: MaterialApp(
        home: WrapperTchr(),
      ),
    );
  }
}


class TeacherProfile extends StatefulWidget {


  //const HomeSI(){}

  @override
  _TeacherProfileState createState() => _TeacherProfileState();


}

class _TeacherProfileState extends State<TeacherProfile> {

 final TextEditingController _fieldController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();



  CollectionReference teachers =
  Firestore.instance.collection('Teacher');


  Future<void> updateinf() async {
    final FirebaseUser user = await _auth.currentUser();

  /*  if (documentSnapshot != null) {

      _pwController.text = documentSnapshot['password'];
          _fieldController.text = documentSnapshot['field'];
      _yearController.text= documentSnapshot['year'].toString();


    }*/


    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                TextField(
                  controller: _fieldController,
                  decoration: InputDecoration(labelText: 'Field'),
                ),
                TextField(
                  controller: _yearController,
                  decoration: InputDecoration(labelText: 'Year'),
                ),


                TextField(
                  //  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  controller: _pwController,
                  decoration: InputDecoration(
                    labelText: 'Change Password',
                  ),
                ),
                FlatButton.icon(
                  icon: Icon(Icons.photo_camera),
                  label: Text('Change picture'),
                  onPressed: () => uploadImage(),
                ),

                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text( 'Update'),
                  onPressed: () async {
                    final String field = _fieldController.text;
                    final String pw =  _pwController.text;
                    final int year =  int.tryParse(_yearController.text);
                  if (field != null && field != null  && year != null && pw != null) {

                        await   Firestore.instance.collection("Teachers")
                            .document(user.uid).updateData({"field": field,"year":year, "password":pw});
                      }

                      // Clear the text fields
                      _fieldController.text =" ";
                      _pwController.text= " ";
          _yearController.text= " ";


                      // Hide the bottom sheet
                      Navigator.of(context).pop();
                    }

                )
              ],
            ),
          );
        });
  }


  String username = "First name";
  String ln = "Last name";
  String userimage = "image";
  String field="fields";
  bool isup=false;
  uploadImage() async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile image;


    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted){
      //Select Image
      image = await _picker.getImage(source: ImageSource.gallery);
      var file = File(image.path);

      if (image != null){
        //Upload to Firebase
        var snapshot = await _storage.ref().child('folderName/imageName').putFile(file).onComplete;

        var downloadUrl = await snapshot.ref.getDownloadURL();

        final FirebaseUser user = await _auth.currentUser();
        Firestore.instance.collection("Student")
            .document(user.uid).updateData(
            {"image": downloadUrl}).then((_) {
          print("Image changed successfully!");
        });

        setState(() {
          userimage = downloadUrl;
        });
      } else {
        print('No Path Received');
      }

    } else {
      print('Grant Permissions and try again');
    }




  }


  final FirebaseAuth _auth = FirebaseAuth.instance;


  getCurrentUser() async {
    final FirebaseUser user = await _auth.currentUser();
    await _auth.currentUser();
    username=user.displayName;
    //print("Current User   ${currentUser.photoUrl}");
    Firestore.instance.collection("Teachers").where("name", isEqualTo: user.displayName).getDocuments()
        .then((value) {
      value.documents.forEach((result) {

        field=result.data['field'];
        ln=result.data['lastname'];
        userimage=result.data['image'];
      });});


    username = user.displayName;
    //userimage = user.photoUrl;
  }

  @override
  void initState() {
    setState(() {
      getCurrentUser();
      if(isup){updateinf();}
    });
    super.initState();
  }


  var currentUser = FirebaseAuth.instance.currentUser;


  //final AuthService _auth = AuthService();
  final DatabaseServiceTeacher db = DatabaseServiceTeacher();


  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          //child: SettingsForm(),
        );
      });
    }


    return  StreamProvider<List<Teachr>>.value(

      // StreamProvider<QuerySnapshot>.value(
      //  value: DatabaseServiceTeacher().,
      child: Scaffold(
        drawer: SideDrawer(username: username,lastname: ln,imgurl: userimage,field: field, isup: isup, ),


        backgroundColor: Colors.green[100],

        appBar: AppBar(
          title: Text('Flipped'),
          backgroundColor: Colors.green[400],
          elevation: 0.0,
          actions: <Widget>[

            FlatButton.icon(
              icon: Icon(Icons.search),
              label: Text('Search'),
              onPressed: () => _showSettingsPanel(),
            )
          ],
        ),

        body: Container(child:
    Padding(

    padding: EdgeInsets.fromLTRB(20, 20, 30, 0),
        child:

        Column(
            children: <Widget>[
              SizedBox(height: 20),


              //backgroundImage: AssetImage('assets/workr.png'),
              // Image.network(userimage),
              // radius: 50,

              // ),

     userimage != null
    ? Container(


    child:Image.network(userimage),
    height: 100,
    width: 100,

    )
        : Container(

   /* decoration: BoxDecoration(
    color: Colors.grey[200],
    borderRadius:    BorderRadius.circular(200),
    ),*/

    child:
    InkWell(


      //     onPressed: getImage();

      child: Ink(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/tchr.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),),),


              Text('Name:', style: TextStyle(fontWeight: FontWeight.bold),),
              Text(username+"  "+ln),
              SizedBox(height: 20),
              Text('Field of study:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(field),
              SizedBox(height: 40),

              Row(
                  children: <Widget>[
                    SizedBox(width: 40),

                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context, MaterialPageRoute(builder: (context) {
                          return FirstPage(teacher: username, teacherln: ln , field: field);
                        },),);
                      },

                      splashColor: Colors.brown.withOpacity(0.5),
                      child: Ink(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/course.png'),
                            fit: BoxFit.cover,
                          ),),),),
                    SizedBox(width: 60),

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
                    SizedBox(width: 50),

                    InkWell(
                      onTap: () { Navigator.push(
                        context, MaterialPageRoute(builder: (context) {
                        return ManageStudents();
                      },),);}, // Handle your callback.
                      splashColor: Colors.brown.withOpacity(0.5),
                      child: Ink(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/1.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  ]),

              Row(

                  children: <Widget>[
                    SizedBox(width: 30),

                    Text('Post Course',
                        style: TextStyle(
                            color: Colors.green[800],
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                    SizedBox(width: 30),
                    Text('Add visio ', style: TextStyle(
                        color: Colors.green[800],
                        fontSize: 15,
                        fontWeight: FontWeight.bold),),
                    SizedBox(width: 30),
                    Text('Students ', style: TextStyle(
                        color: Colors.green[800],
                        fontSize: 15,
                        fontWeight: FontWeight.bold))


                  ]),
              SizedBox(height: 30),


              Row(
                  children: <Widget>[
                    SizedBox(width: 50),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context, MaterialPageRoute(builder: (context) {
                          return Homeworkpage();
                        },),);
                      }, // Handle your callback.
                      splashColor: Colors.brown.withOpacity(0.5),
                      child: Ink(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/g.png'),
                            fit: BoxFit.cover,
                          ),),),),
                    SizedBox(width: 50),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context, MaterialPageRoute(builder: (context) {
                          return Library(teacherName: username, ln: ln);
                        },),);
                      }, // Handle your callback.
                      splashColor: Colors.brown.withOpacity(0.5),
                      child: Ink(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/test.png'),
                            fit: BoxFit.cover,
                          ),),),),
                    SizedBox(width: 50),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context, MaterialPageRoute(builder: (context) {
                          return ManageQuizzPage(teachername: username);
                        },),);
                      }, // Handle your callback.
                      splashColor: Colors.brown.withOpacity(0.5),
                      child: Ink(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/d.png'),
                            fit: BoxFit.cover,
                          ),),),),

                  ]),
              Row(
                  children: <Widget>[
                    SizedBox(width: 50),
                    Text('Forum', style: TextStyle(
                        color: Colors.green[800],
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                    SizedBox(width: 60),
                    Text('Library', style: TextStyle(
                        color: Colors.green[800],
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                    SizedBox(width: 50),
                    Text('Quizz', style: TextStyle(
                        color: Colors.green[800],
                        fontSize: 15,
                        fontWeight: FontWeight.bold))

                  ]),
              SizedBox(height: 30),
              Row(
                  children: <Widget>[
                    SizedBox(width: 50),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context, MaterialPageRoute(builder: (context) {
                          return Homeworkdesplay();
                        },),);
                      }, // Handle your callback.
                      splashColor: Colors.brown.withOpacity(0.5),
                      child: Ink(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/hm.png'),
                            fit: BoxFit.cover,
                          ),),),),
                    SizedBox(width: 40),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context, MaterialPageRoute(builder: (context) {
                          return ManageModules();
                        },),);
                      }, // Handle your callback.
                      splashColor: Colors.brown.withOpacity(0.5),
                      child: Ink(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/l.png'),
                            fit: BoxFit.cover,
                          ),),),),
                    SizedBox(width: 50),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context, MaterialPageRoute(builder: (context) {
                          return aagnd();
                        },),);
                      }, // Handle your callback.
                      splashColor: Colors.brown.withOpacity(0.5),
                      child: Ink(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/clndr.png'),
                            fit: BoxFit.cover,
                          ),),),),
                  ]),
              Row(
                  children: <Widget>[
                    SizedBox(width: 30),
                    Text('    Check \n Homeworks', style: TextStyle(
                        color: Colors.green[800],
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                    SizedBox(width: 30),
                    Text('Modules', style: TextStyle(
                        color: Colors.green[800],
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                    SizedBox(width: 40),
                    Text('Agenda', style: TextStyle(
                        color: Colors.green[800],
                        fontSize: 15,
                        fontWeight: FontWeight.bold))


                  ])


            ]


        ))


          // child: BrewList()
        ),
      )
    );
  }
}
