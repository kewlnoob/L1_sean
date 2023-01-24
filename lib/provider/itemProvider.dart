import 'package:L1_sean/model/itemModel.dart';
import 'package:L1_sean/services/itemService.dart';
import 'package:flutter/material.dart';

enum priority { None, Low, Medium, High }

class ItemProvider extends ChangeNotifier {
  bool loading = false;
  List<ItemModel> itemList;
  String priorityStatus = priority.None.toString().split('.')[0];
  String priorityid;
  var selectedIndex;
  Future<List<ItemModel>> fetchItem(int listid) async {
    itemList = [];
    notifyListeners();
    loading = true;
    itemList = await ItemService().fetchItems(listid);
    loading = false;
    notifyListeners();
    return itemList;
  }

  void setPriority(pname,id) {
    priorityStatus = pname;
    priorityid = id;
    notifyListeners();
  }
}
