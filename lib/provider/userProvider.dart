import 'package:L1_sean/model/categoryModel.dart';
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
  List<CategoryModel> categoryList;
  ThemeMode themeMode = ThemeMode.light;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  getColorList() async {
    colorList = await ListService().fetchColors();
    notifyListeners();
  }

  getIconList() async {
    iconList = await ListService().fetchIcons();
    notifyListeners();
  }

  getCategory() async {
    categoryList = await ListService().fetchCategory();
    notifyListeners();
  }

  void toggle(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    iconTheme: IconThemeData(color: mainBGLightColor),
    scaffoldBackgroundColor: Colors.grey[900],
    colorScheme: ColorScheme.dark(),
    textTheme: TextTheme(
      headline1: TextStyle(
        fontFamily: 'SansPro-Bold',
        color: mainlightTextColor,
        fontSize: 30,
      ),
      headline2: TextStyle(
        fontFamily: 'SansPro-Bold',
        color: mainlightTextColor,
        fontSize: 18,
      ),
      headline3: TextStyle(
        fontFamily: 'SansPro-Bold',
        color: mainlightTextColor,
        fontSize: 15,
      ),
      headline4: TextStyle(
        fontFamily: 'SansPro-Bold',
        color: mainlightTextColor,
        fontSize: 14,
      ),
    ),
  );
  static final lightTheme = ThemeData(
    iconTheme: IconThemeData(color: mainBGDarkColor),
    scaffoldBackgroundColor: mainBGLightColor,
    colorScheme: ColorScheme.light(),
    textTheme: TextTheme(
      headline1: TextStyle(
        fontFamily: 'SansPro-Bold',
        color: mainDarkTextColor,
        fontSize: 30,
      ),
      headline2: TextStyle(
        fontFamily: 'SansPro-Bold',
        color: mainDarkTextColor,
        fontSize: 18,
      ),
      headline3: TextStyle(
        fontFamily: 'SansPro-Bold',
        color: mainDarkTextColor,
        fontSize: 15,
      ),
      headline4: TextStyle(
        fontFamily: 'SansPro-Bold',
        color: mainDarkTextColor,
        fontSize: 14,
      ),
    ),
  );
}

class MyShadows {
  static var primaryLightShadow = BoxShadow(
    color: Colors.grey.shade500,
    offset: Offset(4, 4),
    blurRadius: 15,
    spreadRadius: 1,
  );

  static var secondaryLightShadow = BoxShadow(
    color: Colors.white,
    offset: Offset(-4, -4),
    blurRadius: 15,
    spreadRadius: 1,
  );

  static var primaryDarkShadow = BoxShadow(
    color: Colors.black,
    offset: Offset(4, 4),
    blurRadius: 15,
    spreadRadius: 1,
  );

  static var secondaryDarkShadow = BoxShadow(
    color: Colors.grey[800],
    offset: Offset(-4, -4),
    blurRadius: 15,
    spreadRadius: 1,
  );
}
