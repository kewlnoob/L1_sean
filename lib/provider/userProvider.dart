import 'package:L1_sean/model/colorModel.dart';
import 'package:L1_sean/model/iconModel.dart';
import 'package:L1_sean/model/itemModel.dart';
import 'package:L1_sean/services/itemService.dart';
import 'package:L1_sean/services/listService.dart';
import 'package:L1_sean/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class UserProvider extends ChangeNotifier{

  List<ColorModel> colorList;
  List<IconModel> iconList;

  Future<List<ColorModel>> getColorList() async {
    colorList = await ListService().fetchColors();
    notifyListeners();
    return colorList;
  }

  getIconList() async {
    iconList =  await ListService().fetchIcons();
    notifyListeners();
  }


  
} 