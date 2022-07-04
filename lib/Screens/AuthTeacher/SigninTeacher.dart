
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flipped_classroom/Controler/wrapperTeacher.dart';
import 'package:flipped_classroom/Screens/Authentificationfldr/hmmm.dart';
import 'package:flipped_classroom/Screens/Authentificationfldr/snin.dart';
import 'package:flutter/material.dart';


import '../facerecognition.dart';
import 'package:flipped_classroom/Controler/AuthServTeach.dart';
import 'TeacherProfile.dart';



class SignInTeacher extends StatefulWidget {

  final Function toggleView;
  SignInTeacher({ this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignInTeacher> {

  final AuthServiceTchr _auth = AuthServiceTchr();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;
  bool isTeacher=false;

  // text field state
  String email = '';
  String password = '';
  int pls=0;

  SignInType g;



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
    body: SingleChildScrollView(child: Container(
    padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
    child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 30.0),


            CircleAvatar(
              backgroundImage: AssetImage('assets/tchr.png'),
              radius: 50,

            ),
            SizedBox(height: 30.0),
              Text('SignIn as a Teacher',


                style: TextStyle(color: Colors.green, fontSize: 20.0, fontWeight: FontWeight.bold),

              ),
              SizedBox(height: 20.0),
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
                    final QuerySnapshot rs = await Firestore.instance.collection('Teachers').where('email', isEqualTo: email).getDocuments();
                    final List < DocumentSnapshot > documents = rs.documents;
                    SignInType sss;
                   // sss.setUserType("Teacher");
                    if (documents.length > 0) {

                      isTeacher=true;

                      pls=1;

                    } else {
                      isTeacher=false;

                      pls=0;}

                    if(isTeacher==true) {
                      if (_formKey.currentState.validate()) {
                        setState(() => loading = true);
                        dynamic result = await _auth.signInWithEmailAndPassword(
                            email, password);

                        if ( result == null) {
                          setState(() {
                            // loading = false;
                            error = 'Could not sign in with those credentials ';
                          });
                        }
                      }
                    }else{
                      error = 'This teacher doesnt exist ';
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
                  return mnsin();}));},
                child:Text('SignIn as a Student',


                  style: TextStyle(color: Colors.green, fontSize: 15.0),

                ),),
              SizedBox(height: 12.0),
              TextButton(
                onPressed: (){ Navigator.push(
                    context, MaterialPageRoute(builder: (context) {
                  return FaceRec();}));},
                child:Text('SignIn in with \n  face recognition',


                  style: TextStyle(color: Colors.green, fontSize: 15.0),

                ),)
            ],
          ),
        ),
      ),)
    );
  }
}