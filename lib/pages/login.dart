import 'package:L1_sean/utils/global.dart';
import 'package:L1_sean/widgets/arrows.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:L1_sean/services/authService.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isObscure = true;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email.clear();
    password.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              ButtonArrow(context),
              Container(
                child: Text('Login', style: header),
              ),
              Lottie.asset('assets/images/login.json',
                  height: 300, animate: true),
              emailInputElement(),
              margin20,
              passwordInputElement(),
              margin20,
              Container(
                width: 250,
                height: 50,
                decoration: buttonDecoration,
                child: FlatButton(
                  child: Text('Login'),
                  textColor: Colors.white,
                  onPressed: () async {
                    var login = await AuthService()
                        .login(email.text, password.text, context);
                    if(login) {
                      Navigator.pushNamed(context, '/home');
                    }
                  },
                ),
              ),
              margin20,
              accountUrl(),
            ],
          )),
    ));
  }

  Widget emailInputElement() {
    return Container(
      width: 250,
      height: 50,
      child: TextField(
        controller: email,
        decoration: InputDecoration(
          hintText: 'Email',
          labelStyle: TextStyle(
              color: thirdColor, fontSize: 18, fontWeight: FontWeight.bold),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: thirdColor),
          ),
        ),
      ),
    );
  }

  Widget passwordInputElement() {
    return Container(
      width: 250,
      child: TextField(
        // true = can see
        obscureText: _isObscure,
        controller: password,
        decoration: InputDecoration(
          hintText: 'Password',
          labelStyle: TextStyle(
              color: thirdColor, fontSize: 18, fontWeight: FontWeight.bold),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: thirdColor),
          ),
          suffixIcon: IconButton(
            // get rid of splash effect when ontap
            splashColor: Colors.transparent,
            // if true = on else off
            icon: Icon(
              _isObscure ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            ),
            onPressed: () {
              setState(
                () {
                  _isObscure = !_isObscure;
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget accountUrl() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Don\'t have an account?  ',
          style: TextStyle(color: Colors.grey[600]),
        ),
        InkWell(
          splashColor: Colors.transparent,
          child: Text(
            'Sign Up',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          onTap: () {
            Navigator.pushNamed(context, '/signup');
          },
        ),
      ],
    );
  }
}
