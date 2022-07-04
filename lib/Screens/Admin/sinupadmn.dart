
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:flipped_classroom/Controler/authadmin.dart';



class RegisterAdmin extends StatefulWidget {



  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<RegisterAdmin> {

  final AuthServiceAdmin _auth = AuthServiceAdmin();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String name='';
  String ln='';
  String Address;
  String code='';








  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.green[100],
        appBar: AppBar(
          backgroundColor: Colors.green[400],
          elevation: 0.0,
          title: Text('Sign up'),
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Sign In'),
           //   onPressed: () => widget.toggleView(),
            ),
          ],
        ),
        body: SingleChildScrollView(child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 17),
                      hintText: 'Name'),

                  validator: (val) => val.isEmpty ? 'Enter your full name please' : null,
                  onChanged: (val) {
                    setState(() => name = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  //    decoration: textInputDecoration.copyWith(hintText: 'email'),
                  decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 17),
                      hintText: 'Last Name'),
                  validator: (val) => val.isEmpty ? 'Enter your last name please' : null,
                  onChanged: (val) {
                    setState(() => ln = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  //    decoration: textInputDecoration.copyWith(hintText: 'email'),
                  decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 17),
                      hintText: 'Code'),
                  validator: (val) => val.isEmpty ? 'Enterthe admin code please' : null,
                  onChanged: (val) {
                    setState(() => code = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  //    decoration: textInputDecoration.copyWith(hintText: 'email'),
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
                  //decoration: textInputDecoration.copyWith(hintText: 'password'),
                  decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 17),
                      hintText: 'Password'),
                  obscureText: true,
                  validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
                SizedBox(height: 20.0),

                TextFormField(
                  //    decoration: textInputDecoration.copyWith(hintText: 'email'),
                  decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 17),
                      hintText: 'Address'),
                  validator: (val) => val.isEmpty ? 'Enter your adrs please' : null,
                  onChanged: (val) {
                    setState(() => Address = val);
                  },
                ),
                SizedBox(height: 20.0),






                RaisedButton(
                    color: Colors.pink[400],
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if(_formKey.currentState.validate()){
                        setState(() => loading = true);
                        dynamic result = await _auth.registerWithEmailAndPassword(name, ln, email, password, Address , code  );

                        if(result == null) {
                          setState(() {
                            loading = false;
                            error = 'Please supply a valid email';
                          });
                        }
                      }
                    }
                ),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                )
              ],
            ),
          ),
        ), )
    );
  }
}