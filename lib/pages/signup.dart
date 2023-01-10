import 'package:L1_sean/utils/global.dart';
import 'package:L1_sean/widgets/arrows.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:L1_sean/services/authService.dart';

class Signup extends StatefulWidget {
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool _isObscure = true;
  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email.clear();
    username.clear();
    password.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ButtonArrow(context, 'welcome'),
            margin20,
            Container(
              child: Text('Sign Up', style: header),
            ),
            Lottie.asset('assets/images/register.json',
                height: 250, animate: true),
            inputElement('Email', email),
            margin20,
            inputElement('Username', username),
            margin20,
            passwordInputElement('Password', password),
            margin20,
            Container(
              width: 250,
              height: 50,
              decoration: buttonDecoration,
              child: FlatButton(
                child: Text('Sign Up'),
                textColor: Colors.white,
                onPressed: () async {
                  var register = await AuthService().register(
                      username.text, email.text, password.text, context);
                  if (register) {
                    Navigator.pushNamed(context, "/login");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    )));
  }

  Widget inputElement(String name, TextEditingController controller) {
    return Container(
      width: 250,
      height: 50,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: name,
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

  Widget passwordInputElement(String name, TextEditingController controller) {
    return Container(
      width: 250,
      child: TextField(
        // true = can see
        obscureText: _isObscure,
        controller: controller,
        decoration: InputDecoration(
          hintText: name,
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
}
