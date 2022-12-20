import 'package:flutter/material.dart';


const backgroundColor = Color(0xFFFAFAFA);
const primaryColor = Color(0xFF8200FF);
const secondaryColor = Color(0xFFae64f5);
const thirdColor = Color(0xFF6C63FF);
const header = TextStyle(fontSize: 25,color: Colors.black);
const secondaryText = TextStyle(fontSize: 20,color:Colors.black);
const whiteText = TextStyle(fontSize:15,color: Colors.white,fontWeight: FontWeight.bold);
const bigWhiteText = TextStyle(fontSize:30,color: Colors.white,fontWeight: FontWeight.bold,);
const successColor = Color(0xFF86d28e);
const failColor = Color(0xFFECBDC2);
//images
const welcomeImage = 'assets/images/welcome.svg';
const welcomeImage1 = 'assets/images/welcome1.svg';
const login = 'assets/images/login.svg';
const signup = 'assets/images/signup.svg';


// buttons for login,signup
var buttonDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(10),
  gradient: LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.bottomRight,
    colors: [
      primaryColor,
      secondaryColor,
    ],
  ),
);

//top spacing
const margin20 = SizedBox(height: 20);

const backButton = Icon(
  Icons.keyboard_backspace_rounded,
  color: Colors.grey,
  size: 30,
);

