import 'dart:ui';
import 'package:flutter/material.dart';
const ipAddress = "http://172.26.158.122/flutterphp";
const imagelink = '${ipAddress}/images/';

// const backgroundColor = Color(0xFFFAFAFA);
const backgroundColor = Color(0xFFFFE1E8);

Color mainBGLightColor = Colors.grey[300];
Color mainlightTextColor = Colors.grey[300];

Color mainBGDarkColor = Colors.grey[900];
Color mainDarkTextColor = Colors.grey[900];

// const primaryColor = Color(0xFF8
// 200FF);
const primaryColor = Color(0xFF8843e4);
const secondaryColor = Color(0xFFae64f5);
const thirdColor = Color(0xFF6C63FF);
const blackColor = Color(0xFF32184B);
const redColor = Color(0xFFFF4779);
const header = TextStyle(
  fontSize: 30,
  color: blackColor,
  fontFeatures: [FontFeature.proportionalFigures()],
  fontFamily: 'SansPro-Bold',
);
const secondaryText = TextStyle(
  fontSize: 18,
  color: blackColor,
  fontFeatures: [FontFeature.proportionalFigures()],
  fontFamily: 'SansPro-Bold',
);
const thirdText = TextStyle(
  fontSize: 15,
  color: blackColor,
  fontFeatures: [FontFeature.proportionalFigures()],
  fontFamily: 'SansPro-Bold',
);
const thirdGreyText = TextStyle(
  fontSize: 15,
  color: Colors.grey,
  fontFeatures: [FontFeature.proportionalFigures()],
  fontFamily: 'SansPro-Bold',
);

const secondaryTextOnPressed = TextStyle(
  fontSize: 20,
  color: Colors.grey,
  fontFeatures: [FontFeature.proportionalFigures()],
  fontFamily: 'SansPro-Bold',
);
const whiteText = TextStyle(
  fontSize: 18,
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFeatures: [FontFeature.proportionalFigures()],
  fontFamily: 'SansPro-Bold',
);
const bigWhiteText = TextStyle(
  fontSize: 30,
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFeatures: [FontFeature.proportionalFigures()],
  fontFamily: 'SansPro-Bold',
);
const successColor = Color(0xFF86d28e);
const failColor = redColor;
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
