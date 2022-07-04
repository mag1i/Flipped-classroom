import 'package:flipped_classroom/Screens/AuthTeacher/TeacherProfile.dart';
import 'package:flipped_classroom/Screens/Authentificationfldr/SignIn.dart';

import 'package:flutter/material.dart';


class TeacherSignIn extends StatefulWidget {


  @override
  _TeacherSignInState createState() => _TeacherSignInState();
}

class _TeacherSignInState extends State<TeacherSignIn> {


  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:_formKey,
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        elevation: 0.0,
        title: Text('Sign in'),
        actions: <Widget>[

        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          child: Column(

            children: <Widget>[
              SizedBox(height: 20.0),
              Text('Sign in to get your \n         courses',
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 30,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 60.0),
              TextFormField(
                decoration:  InputDecoration(
                 // hintText: 'Email',
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(12.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange, width: 2.0),
                  ),
                ),
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration:  InputDecoration(
                  hintText: 'Password',
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(12.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange, width: 2.0),
                  ),
                ),
                validator: (val) => val.length<6 ? 'Enter a password longer than 6 characters' : null,
                obscureText: true,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                  color: Colors.green[400],
                  child: Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                     Navigator.push(
                        context, MaterialPageRoute(builder: (context) {
                      return TeacherProfile();}));
                    if(_formKey.currentState.validate()){
                      setState(() => loading = true);
                      // dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                      /*if(result == null) {
                        setState(() {
                          loading = false;
                          error = 'Could not sign in with those credentials';
                        });
                      }*/
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
              return SignIn();}));},
                child:Text('SignIn as a Student',


                  style: TextStyle(color: Colors.green, fontSize: 17.0, fontWeight: FontWeight.bold),

                ),),

            ],
          ),
        ),
      ),
    );
  }
}
/*
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown[100],
      child: Center(
        child: SpinKitChasingDots(
          color: Colors.brown,
          size: 50.0,
        ),
      ),
    );
  }
}*/