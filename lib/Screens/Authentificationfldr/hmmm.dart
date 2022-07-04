
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flipped_classroom/Screens/BooksDisplay.dart';
import 'package:flipped_classroom/Screens/Upload/firstpage.dart';

import 'package:flipped_classroom/models/Srudent.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../main.dart';
import '../../wrapper.dart';
import '../Agenda.dart';
import '../Homework.dart';
import 'package:flipped_classroom/Controler/Setting.dart';
import '../Spec2.dart';

import '../quizz2.dart';
import '../teacherlist.dart';
import 'package:flipped_classroom/Controler/DatabaseService.dart';
import 'package:flipped_classroom/Controler/authservices.dart';
import 'snin.dart';









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
              onPressed: () {

                   uploadImage();
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


class mnsin extends StatelessWidget {
  final String usertype;

  const mnsin({Key key, this.usertype}) : super(key: key);



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return StreamProvider<Useer>.value(


      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}

class HomeSI extends StatefulWidget {


  //const HomeSI(){}

  @override
  _HomeSIState createState() => _HomeSIState();


}

class _HomeSIState extends State<HomeSI> {


  final FirebaseAuth _auth = FirebaseAuth.instance;




   String u="First name";
   String f= 'Field';
   String ln="Last name";
   String uu="image";
   String stdntId="uid";
  getuserid() async {

    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user = await _auth.currentUser();
    await user.reload();

    u=user.displayName;
    uu=user.photoUrl;
    stdntId= user.uid;
    }



    getUser() async {
    final FirebaseUser user = await _auth.currentUser();
    await user.reload();
  //  user.reload();
    /*setState((){
      u=user.displayName;

    });*/

    Firestore.instance.collection("Student").where("name", isEqualTo: user.displayName).getDocuments()
        .then((value) {
      value.documents.forEach((result) {
             f=result.data['field'];
             ln=result.data['lastname'];
      });



    Firestore.instance.collection("Student").where("name", isEqualTo: user.displayName).getDocuments()
        .then((value) {
      value.documents.forEach((result) {
        u=user.displayName;
        stdntId=user.uid;

          uu=result.data['image'];
         });
        });
  });}


  @override
  void initState() {
    getUser();
    getuserid();
    super.initState();

  }




  /* Future <dynamic> getImage(bool gallery) async {
    ImagePicker picker = ImagePicker();
    PickedFile pickedFile;
    // Let user select photo from gallery
    if (gallery) {
      pickedFile = await picker.getImage(
        source: ImageSource.gallery,
      );
    }
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path); // Use if you only need a single picture
      } else {
        print('No image selected.');
      }
    });
  }
*/
  Future<dynamic> uploadFile(File image) async {
    final FirebaseUser user = await _auth.currentUser();
    user.reload();
    String downloadURL;


    var ref = FirebaseStorage.instance
        .ref()
        .child("images/${user.uid}");
    await ref.putFile(image);
    downloadURL = await ref.getDownloadURL();
     return  downloadURL ;

  }

  /* Future<dynamic>uploadToFirebase() async {
     final FirebaseUser user = await _auth.currentUser();
    final CollectionReference users =
    Firestore.instance.collection("Student");
    final String uid = user.uid;
    u=user.displayName;
     String url=user.photoUrl;
   // await uploadFile(_image); // this will upload the file and store url in the variable 'url'
    await users.document(uid).updateData({
      //use update to update the doc fields.
      'image': url
    });
    final result = await users.document(uid).get();

   return result.data["image"] ;

   }*/



  /// The current user's profile document in firebase
  /// gotten through Firestore.instance.collection('users).document(userId);




  @override
  Widget build(BuildContext context) {
    getUser();


    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingsForm(),
        );
      });


    }
/*
    displayFile(imageFile) async {

      String fileName = 'images/profile_pics/' + this.getCurrentUser().uid + ".jpg";
      var data = await FirebaseStorage.instance.ref().child(fileName).getData(10000000);
      var text = new String.fromCharCodes(data);
      return new NetworkImage(text);

    }*/

     return  StreamProvider<List<UserData>>.value(
   // StreamProvider<QuerySnapshot>.value(
     // value: DatabaseService().brews,
      child:  Scaffold(
          drawer: SideDrawer(username: u,lastname: ln,imgurl: uu,field: f ),
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

           Column(
        children: <Widget>[


          Container(
            child: Stack(
              children: <Widget>[

                Align(
                  alignment: Alignment.center,
                  child: Column(
                      children:<Widget>[
                      SizedBox(height:20),
                Container(
                  child: uu != null
                      ? Container(
                    child:Image.network(uu),
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(50),

                     /* image: DecorationImage(
                        image: FileImage( _image), // Here needs to be the image from Firestore referring to the current user
                      ),*/

                    ),
                  )
                      : Container(

                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius:
                      BorderRadius.circular(50),
                    ),
                    width: 100,
                    height: 100,

                    child:
                    ElevatedButton(
                 //     onPressed: getImage();

                    child:  CircleAvatar(
                      backgroundImage: AssetImage('assets/stdnt2.png'),
                      radius: 50,

                    ),/* Icon(
                      Icons.camera_alt,
                      color: Colors.grey[800],


                    ),*/
                  ),),
                ),]),)
              ],
            ),
          ),
       Text(u+"  "+ln),
         Text(f),
          Padding(

              padding: EdgeInsets.fromLTRB(55, 20, 30, 0),

              child: Column(
                  children:<Widget>[
                    SizedBox(height: 10),

                    Row(
                        children: <Widget>[
                          SizedBox(width: 30),

                          InkWell(
                            onTap: () {Navigator.push(
                              context, MaterialPageRoute(builder: (context) {
                              return Homeworkpage( StudentId: stdntId, StudentName: u, ln:ln);}, ),);},

                            splashColor: Colors.brown.withOpacity(0.5),
                            child: Ink(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/t.png'),
                                  fit: BoxFit.cover,
                                ),),),),
                          SizedBox(width: 30),

                          InkWell(
                            onTap: () {Navigator.push(
                              context, MaterialPageRoute(builder: (context) {
                              return FirstScreen();}, ),);}, // Handle your callback.
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
                          //SizedBox(width: 20),
                          SizedBox(width: 40),

                          Text('Homework',
                              style: TextStyle(
                                  color: Colors.green[800],
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(width: 50),
                          Text('Courses ', style: TextStyle(
                              color: Colors.green[800],
                              fontSize: 17,
                              fontWeight: FontWeight.bold))

                        ]),
                    SizedBox(height: 30),


                    Row(
                        children: <Widget>[
                          SizedBox(width: 30),
                          InkWell(
                            onTap: () {
                            Navigator.push(
                              context, MaterialPageRoute(builder: (context) {
                              return Agenda();}, ),);},// Handle your callback.
                            splashColor: Colors.green.withOpacity(0.5),
                            child: Ink(
                              height: 90,
                              width: 90,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/h.png'),
                                  fit: BoxFit.cover,
                                ),),),),
                          SizedBox(width: 30),
                          InkWell(
                            onTap: () {Navigator.push(
                              context, MaterialPageRoute(builder: (context) {
                              return AnimalQuiz();}, ),);},// Handle your callback.
                            splashColor: Colors.brown.withOpacity(0.5),
                            child: Ink(
                              height: 90,
                              width: 90,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/qz.png'),
                                  fit: BoxFit.cover,
                                ),),),)
                        ]),
                    Row(
                        children: <Widget>[
                          SizedBox(width: 10),
                          Text('Check Agenda', style: TextStyle(
                              color: Colors.green[800],
                              fontSize: 17,
                              fontWeight: FontWeight.bold)),
                          SizedBox(width: 30),
                          Text('Quizz & test', style: TextStyle(
                              color: Colors.green[800],
                              fontSize: 17,
                              fontWeight: FontWeight.bold)),]),
                          SizedBox(height: 30),


                          Row(
                              children: <Widget>[
                                SizedBox(width: 30),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context, MaterialPageRoute(builder: (context) {
                                      return BooksLibrary();}, ),);},// Handle your callback.
                                  splashColor: Colors.green.withOpacity(0.5),
                                  child: Ink(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage('assets/vvv.png'),
                                        fit: BoxFit.cover,
                                      ),),),),
                                SizedBox(width: 30),
                                InkWell(
                                  onTap: () {Navigator.push(
                                    context, MaterialPageRoute(builder: (context) {
                                    return hp();}, ),);},// Handle your callback.
                                  splashColor: Colors.brown.withOpacity(0.5),
                                  child: Ink(
                                    height: 110,
                                    width: 110,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage('assets/w.png'),
                                        fit: BoxFit.cover,
                                      ),),),),]),

                          Row(
                              children: <Widget>[
                                SizedBox(width: 50),
                                Text('Library', style: TextStyle(
                                    color: Colors.green[800],
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold)),
                                SizedBox(width: 80),
                                Text('Forum', style: TextStyle(
                                    color: Colors.green[800],
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold))

                        ])









          ]),






          // child: BrewList()


     )]),)));
  }



}

