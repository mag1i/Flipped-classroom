
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flipped_classroom/models/Srudent.dart';

import 'package:flipped_classroom/Controler/DatabaseService.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  Useer _userFromFirebaseUser(FirebaseUser user) {

    return user != null ? Useer(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<Useer> get user {
    return _auth.onAuthStateChanged
       .map((FirebaseUser user) => _userFromFirebaseUser(user));
      //  .map(_userFromFirebaseUser);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String nm, String lastname,String email, String password,  String fld, int yr, DateTime bd, String gender, String image) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword( email: email, password: password);
      FirebaseUser user = result.user;
      // create a new document for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData( user, nm,  lastname, email,  password,   fld,  yr, bd, gender, image );

      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }


  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

}