import 'package:L1_sean/model/itemModel.dart';
import 'package:L1_sean/services/itemService.dart';
import 'package:flutter/material.dart';

class ItemProvider extends ChangeNotifier {
  bool loading = false;
  List<ItemModel> itemList;


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
}
