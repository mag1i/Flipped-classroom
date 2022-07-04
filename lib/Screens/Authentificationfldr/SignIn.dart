
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flipped_classroom/Screens/AuthTeacher/SigninTeacher.dart';
import 'package:flipped_classroom/Screens/AuthTeacher/TeacherProfile.dart';
import 'package:flipped_classroom/Controler/wrapperTeacher.dart';
import 'package:flipped_classroom/Screens/Authentificationfldr/snin.dart';
import 'package:flutter/material.dart';

import '../facerecognition.dart';
import 'package:flipped_classroom/Controler/DatabaseService.dart';
import 'package:flipped_classroom/Controler/TeacherAuth.dart';
import 'package:flipped_classroom/Controler/authservices.dart';
import 'hmmm.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({ this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  SignInType g;
  bool existInCollection=false;
  DatabaseService ds;
  final CollectionReference clct = Firestore.instance.collection('Student');






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        elevation: 0.0,
        title: Text('Sign in '),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register'),
            onPressed: () => widget.toggleView(),
          ),
        ],
      ),
      body:  SingleChildScrollView(child: Container(
    padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
    child: Form(
          key: _formKey,
          child: Column(


            children: <Widget>[
              SizedBox(height: 30.0),
              CircleAvatar(
                backgroundImage: AssetImage('assets/stdnt2.png'),
                radius: 50,

              ),
              Text('SignIn as a Student',


                style: TextStyle(color: Colors.green, fontSize: 20.0, fontWeight: FontWeight.bold),

              ),
              SizedBox(height: 20.0),
              SizedBox(height: 30.0),
              TextFormField(
               // decoration: textInputDecoration.copyWith(hintText: 'email'),
                decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 17),
                    hintText: 'Email'),
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {

                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                obscureText: true,
                //decoration: textInputDecoration.copyWith(hintText: 'password'),
                decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 17),
                    hintText: 'Password'),
                validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),

              RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    final QuerySnapshot rs = await Firestore.instance.collection('Student').where( 'email', isEqualTo: email).getDocuments();

                    final List <DocumentSnapshot> documents = rs.documents;


                    if (documents.length > 0) {
                      existInCollection = true;
                    } else {
                      existInCollection = false;
                    }
                    if (existInCollection == true) {
                    if(_formKey.currentState.validate()) {
                      // setState(() => loading = true);
                      dynamic result = await _auth.signInWithEmailAndPassword(
                          email, password);

                    //  hs.getCurrentUser();
                      //  print(Firestore.instance.collection('Student').where('email', arrayContainsAny: [email]).getDocuments());


                        if (result == null) {
                          setState(() {
                            //loading = false;
                            error = 'Could not sign in with those credentials';
                          });
                        }
                      } else {
                        error = 'This Student does not exist';
                      }
                    }
                  }


              ),
              SizedBox(height: 12.0),

              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
              TextButton(
                onPressed: (){ Navigator.push(
                    context, MaterialPageRoute(builder: (context) {
                  return Idk();}));},
                child:Text('SignIn as a Teacher',


                  style: TextStyle(color: Colors.green, fontSize: 15.0),

                ),),
              SizedBox(height: 12.0),
              TextButton(
                onPressed: (){ Navigator.push(
                    context, MaterialPageRoute(builder: (context) {
                  return FaceRec();}));},
                child:Text('SignIn in with \nface recognition',


                  style: TextStyle(color: Colors.green, fontSize: 15.0),

                ),)
            ],
          ),
        ),)
      ),
    );
  }
}