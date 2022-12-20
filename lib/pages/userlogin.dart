import 'package:L1_sean/pages/home.dart';
import 'package:L1_sean/pages/welcome.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class UserLogin extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return Home();
          }else{
            return Welcome();
          }
        },
      )
    );
  }
}