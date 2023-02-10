import 'package:L1_sean/model/menuitem.dart';
import 'package:L1_sean/pages/about.dart';
import 'package:L1_sean/pages/homemenu.dart';
import 'package:L1_sean/pages/profile.dart';
import 'package:L1_sean/pages/statistics.dart';
import 'package:L1_sean/utils/global.dart';
import 'package:flutter/material.dart';
import 'drawer.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:page_transition/page_transition.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  MenuItem currentItem = MenuItems.all.first;

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      borderRadius: 30,
      angle: -15,
      style: DrawerStyle.Style2,
      slideWidth: MediaQuery.of(context).size.width * 0.7,
      // showShadow: true,
      // backgroundColor: Colors.grey[900],
      mainScreen: getScreen(),
      menuScreen: Builder(
        builder: (context) => MyDrawer(
            currentItem: currentItem,
            onSelectedItem: (item) {
              setState(() {
                currentItem = item;
              });
              ZoomDrawer.of(context).close();
            }),
      ),
    );
  }

  Widget getScreen() {
    switch (currentItem.title) {
      case "Home":
        return HomeMenu();
      case "About Us":
        return About();
      case "Profile":
        return Profile();
      case "Statistics":
        return Statistics();
    }
  }
}
