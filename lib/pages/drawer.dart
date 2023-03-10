import 'package:L1_sean/model/menuitem.dart';
import 'package:L1_sean/services/authService.dart';
import 'package:L1_sean/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';
import 'dart:convert';

class MenuItems {
  static List<MenuItem> all = <MenuItem>[
    MenuItem('Home', Icon(AntDesign.home)),
    MenuItem('Profile', Icon(MaterialCommunityIcons.account)),
    MenuItem('About Us', Icon(Feather.info)),
    MenuItem('Statistics', Icon(Foundation.graph_bar)),
  ];
}

class MyDrawer extends StatefulWidget {
  final MenuItem currentItem;
  final ValueChanged<MenuItem> onSelectedItem;
  const MyDrawer({Key key, this.currentItem, this.onSelectedItem})
      : super(key: key);
  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  String image;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findImage();
  }

  findImage() async {
    var user = await AuthService().getUserInfo();
    if (user != null) {
      this.setState(() {
        image = imagelink + user.image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        backgroundColor: Colors.black26,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: WidgetCircularAnimator(
                  size: 150,
                  innerIconsSize: 3,
                  outerIconsSize: 3,
                  innerAnimation: Curves.easeInOutBack,
                  outerAnimation: Curves.easeInOutBack,
                  innerColor: backgroundColor,
                  outerColor: redColor,
                  innerAnimationSeconds: 10,
                  outerAnimationSeconds: 10,
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey[200]),
                    child: CircleAvatar(
                      backgroundColor: Colors.black26,
                      radius: 520,
                      backgroundImage:
                          image != null ? NetworkImage(image) : null,
                    ),
                  ),
                ),
              ),
              margin20,
              ...MenuItems.all.map(buildItem).toList(),
              Spacer(flex: 2),
              margin20,
              ListTile(
                leading: Icon(Icons.logout),
                title: Text("logout"),
                onTap: () async {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.remove('user');
                  Navigator.pushReplacementNamed(context, '/');
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildItem(MenuItem item) => ListTileTheme(
        selectedColor: Colors.white,
        child: ListTile(
          selected: widget.currentItem == item,
          selectedTileColor: Colors.black26,
          leading: item.icon,
          title: Text(item.title),
          onTap: () {
            widget.onSelectedItem(item);
          },
        ),
      );
}
