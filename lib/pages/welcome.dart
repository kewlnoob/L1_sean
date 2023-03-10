import 'package:L1_sean/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height:70),
              Container(
                child: Text('Welcome to Notes', style: Theme.of(context).textTheme.headline1),
              ),
              Lottie.asset('assets/images/todo.json',
                  height: 350, animate: true),
              Container(
                width: 250,
                height: 50,
                decoration: buttonDecoration,
                child: FlatButton(
                  child: Text('Login'),
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                ),
              ),
              margin20,
              Container(
                width: 250,
                height: 50,
                decoration: buttonDecoration,
                child: FlatButton(
                  child: Text('Sign Up'),
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
