

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:flipped_classroom/Controler/AuthServTeach.dart';



class TeacherRegister extends StatefulWidget {

  final Function toggleView;
  TeacherRegister({ this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<TeacherRegister> {

  final AuthServiceTchr _auth = AuthServiceTchr();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String name='';
  String ln='';
  String field='';
  DateTime bd=DateTime.now();
  String _selectedGender = 'male';
   String imageUrl='';
  TextEditingController dateCtl = TextEditingController();
  var finaldate;
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

        setState(() {
          imageUrl = downloadUrl;
        });
      } else {
        print('No Path Received');
      }

    } else {
      print('Grant Permissions and try again');
    }




  }







  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        elevation: 0.0,
        title: Text('Sign up a teacher'),
        actions: <Widget>[

        ],
      ),
      body:SingleChildScrollView(child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(


                /*decoration: InputDecoration(
                  hintStyle: TextStyle(fontSize: 17),
                  hintText: 'Search your trips',
                  suffixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(20),
                ),*/
                decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 17),
                    hintText: 'Name'),
                // decoration: textInputDecoration=" ".copyWith(hintText: 'email'),
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
              TextFormField(
                //decoration: textInputDecoration.copyWith(hintText: 'password'),
                decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 17),
                    hintText: 'Repeat Password'),
                obscureText: true,
                validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                onChanged: (val) {
                //  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),

                    TextFormField(
                //    decoration: textInputDecoration.copyWith(hintText: 'email'),
                decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 17),
                    hintText: 'Field of Study'),
                validator: (val) => val.isEmpty ? 'Enter your field please' : null,
                onChanged: (val) {
                  setState(() => field = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: dateCtl,
                decoration: InputDecoration(
                  labelText: "Date of birth",
                  hintText: "Ex. Insert your dob",),
                onTap: () async{
                  DateTime date = DateTime(1900);
                  FocusScope.of(context).requestFocus(new FocusNode());

                  date = await showDatePicker(
                      context: context,
                      initialDate:DateTime.now(),
                      firstDate:DateTime(1900),
                      lastDate: DateTime(2100));

                  dateCtl.text = date.toIso8601String();
                  var dateTime = DateTime.parse( dateCtl.text);

                  var formate1 = "${date.day}-${date.month}-${date.year}";
                  dateCtl.text=formate1;
                  bd=formate1 as DateTime;


                },),
              SizedBox(height: 20.0),
              Text('Please select gender:'),
              ListTile(
                leading: Radio(
                  value: 'male',
                  groupValue: _selectedGender,
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                ),
                title: Text('Male'),
              ),
              ListTile(
                leading: Radio(
                  value: 'female',
                  groupValue: _selectedGender,
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                ),
                title: Text('Female'),
              ),

              //  Text(_selectedGender == 'male' ? 'Hello gentlement!' : 'Hi lady!'),
              SizedBox(height: 20),
              (imageUrl != null)
                  ? Image.network(imageUrl)
                  : Placeholder(fallbackHeight: 200.0,fallbackWidth: double.infinity),
              SizedBox(height: 20.0,),
              RaisedButton(
                child: Text('Upload Image'),
                color: Colors.lightBlue,
                onPressed: () => uploadImage(),
              ),




              SizedBox(height: 20.0),

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
                      dynamic result = await _auth.registerWithEmailAndPassword(name, ln, email, password,  field, bd, _selectedGender, imageUrl);

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
      ),)
    );
  }
}