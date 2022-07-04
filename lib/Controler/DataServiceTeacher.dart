
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseServiceTeacher {

  final String tid;
  DatabaseServiceTeacher({ this.tid });

  // collection reference
/*
  Stream<QuerySnapshot> get student{
    return clct.snapshots();
  }*/



  final CollectionReference clct = Firestore.instance.collection('Teachers');
  Future<void> updateUserData(FirebaseUser usr, String nm, String lastname,String email, String password,  String fld, DateTime bd, String gender, String image) async {
    var userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = nm;
    usr.updateProfile(userUpdateInfo);


    return await clct.document(tid).setData({

      'name': nm,
      'lastname':lastname,
      'email':email,
      'password': password,
      'field':fld,
      'birthdate':bd,
      'gender':gender,
      'image':image,

    });
  }

  // brew list from snapshot


}