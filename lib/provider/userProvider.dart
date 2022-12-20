import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class UserProvider extends ChangeNotifier{

  final _auth = FirebaseAuth.instance;
  
  // String getCurrentUsername() async {
  //   var ds = FirebaseFirestore.instance.collection('users').doc(_auth.currentUser.uid).get();
  //   if(ds != null){
      
  //   }
  //   return null;
  // }
}