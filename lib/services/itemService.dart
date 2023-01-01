import 'package:L1_sean/model/itemModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:L1_sean/utils/global.dart';

class ItemService {
  Future<bool> addItem(String name, int position) async {
    var url = "$ipAddress/addItem.php";
    var data = {
      "name": name,
      "position": position.toString(),
    };
    var response = await http.post(url, body: data);
    if (jsonDecode(response.body) == "success") {
      return true;
    }
    return false;
  }

  Future<List<ItemModel>> fetchItems(int listid) async {
    if (listid == null) return null;

    var url = "$ipAddress/getitems.php?listid=" + listid.toString();
    final response = await http.get(url);
    List<ItemModel> json = itemFromJson(response.body);
    for (var i = 0; i < json.length; i++) {
      if (json[i].position == null) {
        json[i].position = i.toString();
      }
    }
    if (json.length > 1) {
      List<ItemModel> sorted = List.from(json)
        ..sort((a, b) => a.position.compareTo(b.position));
      return sorted;
    } else {
      return json;
    }
  }

  Future<bool> reorderItem(items) async {
    var url = "$ipAddress/reorder.php";
    String json = jsonEncode(items);
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json,
    );
    try {
      if (jsonDecode(response.body) == "success") {
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> checkItem(bool iscompleted, int itemid) async {
    if (iscompleted != null && itemid != null) {
      var url = "$ipAddress/updateItemStatus.php";
      var data = {
        "itemid": itemid.toString(),
        "iscompleted": iscompleted ? "1" : "0",
      };
      var response = await http.post(url, body: data);
      if (jsonDecode(response.body) == "success") {
        return true;
      }
    }
    return false;
  }
}
