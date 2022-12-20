import 'package:L1_sean/utils/global.dart';
import 'package:L1_sean/utils/popup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User> signIn(
      {String email, String password, BuildContext context}) async {
    displayDialog(context);
    try {
      UserCredential ucred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = ucred.user;
      displayToast('You have successfully login!', context, successColor);
      return user;
    } on FirebaseAuthException catch (e) {
      displayToast('Please try again', context, failColor);
    } catch (e) {
      print(e.message);
      return null;
    }
  }

  Future<User> signUp(
      {String email,
      String password,
      BuildContext context,
      String username}) async {
    displayDialog(context);

    try {
      // create user
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = credential.user;
      FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'email': user.email,
        'username': username,
      });

      Navigator.of(context).pop();
      displayToast('Signed up successful!', context, successColor);
      return user;
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      return null;
    } catch (e) {
      Navigator.of(context).pop();
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
