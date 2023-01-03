import 'package:L1_sean/model/menuitem.dart';
import 'package:L1_sean/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
class MenuItems {
  static List<MenuItem> all = <MenuItem>[
    MenuItem('Home', Icon(AntDesign.home)),
    MenuItem('About Us', Icon(Feather.info)),
  ];
}

class MyDrawer extends StatelessWidget {
  final MenuItem currentItem;
  final ValueChanged<MenuItem> onSelectedItem;

  const MyDrawer({Key key, this.currentItem, this.onSelectedItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        backgroundColor: thirdColor,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DrawerHeader(
                  child: CircleAvatar(
                radius: 52,
              )),
              // Spacer(),
              margin20,
              ...MenuItems.all.map(buildItem).toList(),
              Spacer(flex: 2),
              margin20,
              ListTile(
                leading: Icon(Icons.logout),
                title: Text("logout"),
                onTap: () async{
                  final prefs = await SharedPreferences.getInstance();
                  prefs.remove('user');
                  Navigator.pushNamed(context,'/');
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
          selected: currentItem == item,
          selectedTileColor: Colors.black26,
          leading: item.icon,
          title: Text(item.title),
          onTap: () {
            onSelectedItem(item);
          },
        ),
      );
}
