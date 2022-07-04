
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flipped_classroom/models/Admin.dart';
import 'package:flipped_classroom/models/Srudent.dart';
import 'package:flipped_classroom/models/Useer.dart';



class DatabaseServiceAdmin {

  final String uid;
  DatabaseServiceAdmin({ this.uid });
  String userType;
  final Firestore _firestore = Firestore.instance;
  String loggedInUserID;

  // collection reference
/*
  Stream<QuerySnapshot> get student{
    return clct.snapshots();
  }*/



  final CollectionReference clct = Firestore.instance.collection('Admins');
  Future<void> updateUserData(FirebaseUser usr, String nm, String lastname,String email, String password, String Address, String code) async {
    var userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = nm;
    usr.updateProfile(userUpdateInfo);





    return await clct.document(uid).setData({

      'name': nm,
      'lastname':lastname,
      'email':email,
      'password': password,
      'Address':Address,
      'code':code

    });
  }
  Future getUserType() async {
    userType = (await _firestore
        .collection('Admins')
        .document(uid)
        .get()) as String;
    print(userType);
  }


  // brew list from snapshot
  List<Teachr> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      print(doc.data);
      return Teachr(
        name: doc.data['name'] ?? '',
        //  age: doc.data['age'] ?? 0,
        lastname: doc.data['lastname'] ?? '',

      );
    }).toList();

  }



  // user data from snapshots
  Admiin _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return Admiin(
        aid: uid,
        name: snapshot.data['name'],
        lastname: snapshot.data['ln'],
        email: snapshot.data['email']
    );
  }
  //////heeeeeeeeeeeeere change user data
  /* void _onPressed() {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    Firestore.instance
        .collection("users")
        .document(firebaseUser.uid).updateData(
       {"age": 60}).then((_) {
      print("success!");
    });
  }*/
  /////with arraaaaaaaaaaay
  /* void _onPressed() {
    var firebaseUser =  FirebaseAuth.instance.currentUser;
    firestoreInstance.collection("users").doc(firebaseUser.uid).update({
      "characteristics" : FieldValue.arrayUnion(["generous","loving","loyal"])
    }).then((_) {
      print("success!");
    });
  }*/
  //deleeeeeeeeeete
  /*void _onPressed() {
  var firebaseUser =  FirebaseAuth.instance.currentUser;
    firestoreInstance.collection("users").doc(firebaseUser.uid).delete().then((_) {
    print("success!");
  });
}*/
  //display data with whereee
  /*void _onPressed() {
firestoreInstance
    .collection("users")
    .where("address.country", isEqualTo: "USA")
    .get()
    .then((value) {
  value.docs.forEach((result) {
    print(result.data());
  });
});
}*/


  // get brews stream
  Stream<List<Teachr>> get brews {
    return clct.snapshots()
        .map(_brewListFromSnapshot);
  }

  // get user doc stream
/*  Stream<UserData> get userData {
    return clct.document(uid).snapshots()
        .map(_userDataFromSnapshot);
  }*/

}