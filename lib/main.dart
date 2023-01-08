import 'package:L1_sean/pages/additem.dart';
import 'package:L1_sean/pages/addlist.dart';
import 'package:L1_sean/pages/IndividualList.dart';
import 'package:L1_sean/pages/all.dart';
import 'package:L1_sean/pages/archived.dart';
import 'package:L1_sean/pages/login.dart';
import 'package:L1_sean/pages/priority.dart';
import 'package:L1_sean/pages/signup.dart';
import 'package:L1_sean/provider/itemProvider.dart';
import 'package:L1_sean/provider/userProvider.dart';
import 'pages/home.dart';
import 'pages/welcome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:L1_sean/utils/global.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:page_transition/page_transition.dart';

var user;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  user = prefs.getString('user');
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
            create: (context) => UserProvider()),
        ChangeNotifierProvider<ItemProvider>(
            create: (context) => ItemProvider())
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'SansPro-Bold',
          scaffoldBackgroundColor: backgroundColor,
        ),
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: user != null ? "/home" : "/",
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/addlist':
              if (settings.arguments != null) {
                Map<String, dynamic> args = settings.arguments;
                return MaterialPageRoute(
                    builder: (context) => AddList(
                        id: args['id'],
                        iconid: args['iconid'],
                        colorid: args['colorid'],
                        listname: args['listname']));
              } else {
                return MaterialPageRoute(builder: (context) => AddList());
              }
              break;
            case '/list':
              if (settings.arguments != null) {
                Map<String, dynamic> args = settings.arguments;
                return MaterialPageRoute(
                  builder: (context) => IndividualList(
                    listid: args['listid'],
                    listname: args['listname'],
                  ),
                );
              }
              break;
            case '/additem':
              if (settings.arguments != null) {
                Map<String, dynamic> args = settings.arguments;
                if (args['item'] != null) {
                  return PageTransition(
                      duration: Duration(milliseconds: 300),
                      child: AddItem(
                        item: args['item'],
                        listname: args['listname'],
                        isflagged: args['isflagged'],
                      ),
                      type: PageTransitionType.bottomToTop);
                }
              }
              break;
            case '/all':
              return PageTransition(
                  duration: Duration(milliseconds: 300),
                  child: All(),
                  type: PageTransitionType.rightToLeft);
              break;
            case '/archived':
              return PageTransition(
                  duration: Duration(milliseconds: 300),
                  child: Archived(),
                  type: PageTransitionType.rightToLeft);
              break;
            case '/priority':
              return PageTransition(
                  duration: Duration(milliseconds: 300),
                  child: Priority(),
                  type: PageTransitionType.rightToLeft);
              break;
          }
        },
        routes: {
          "/": (context) => Welcome(),
          "/login": (context) => Login(),
          "/signup": (context) => Signup(),
          "/home": (context) => Home(),
          // "/addlist": (context) => AddList(),
          // '/list': (context) => IndividualList(),
          // '/all': (context) => All(),
        },
      ),
    );
  }
}
