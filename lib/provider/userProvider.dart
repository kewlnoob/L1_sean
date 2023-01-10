import 'package:L1_sean/model/colorModel.dart';
import 'package:L1_sean/model/iconModel.dart';
import 'package:L1_sean/model/itemModel.dart';
import 'package:L1_sean/services/itemService.dart';
import 'package:L1_sean/services/listService.dart';
import 'package:L1_sean/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserProvider extends ChangeNotifier {
  List<ColorModel> colorList;
  List<IconModel> iconList;
  ThemeMode themeMode = ThemeMode.light;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  Future<List<ColorModel>> getColorList() async {
    colorList = await ListService().fetchColors();
    notifyListeners();
    return colorList;
  }

  getIconList() async {
    iconList = await ListService().fetchIcons();
    notifyListeners();
  }

  void toggle(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    colorScheme: ColorScheme.dark(),
    textTheme: TextTheme(
      headline1: TextStyle(
        fontFamily: 'SansPro-Bold',
        color: Colors.white,
        fontSize: 30,
      ),
      headline2: TextStyle(
        fontFamily: 'SansPro-Bold',
        color: Colors.white,
        fontSize: 18,
      ),
      headline3: TextStyle(
        fontFamily: 'SansPro-Bold',
        color: Colors.white,
        fontSize: 15,
      ),
    ),
  );
  static final lightTheme = ThemeData(
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: ColorScheme.light());
}
