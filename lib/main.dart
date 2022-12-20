import 'package:L1_sean/pages/addlist.dart';
import 'package:L1_sean/pages/login.dart';
import 'package:L1_sean/pages/signup.dart';
import 'package:L1_sean/pages/userlogin.dart';
import 'package:L1_sean/provider/userProvider.dart';
import 'pages/home.dart';
import 'pages/welcome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:L1_sean/utils/global.dart';

Future<void> main() async {
  return runApp(ChangeNotifierProvider(
      create: (context) => UserProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'SF-Pro-Rounded',
        scaffoldBackgroundColor: backgroundColor,
      ),
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: "/",
      routes: {
        "/": (context) => Welcome(),
        "/login": (context) => Login(),
        "/signup": (context) => Signup(),
        "/home": (context) => Home(),
        "/userlogin": (context) => UserLogin(),
        "/addlist": (context) => AddList(),
      },
    );
  }
}
