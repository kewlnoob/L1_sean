import 'package:L1_sean/model/itemModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:L1_sean/utils/global.dart';

class ItemService {
  Future<bool> addItem(String name,String description,String inputUrl,bool flagged,String listid) async {
    var url = "$ipAddress/addItem.php";
    var data = {
      "name": name,
      "description": description,
      "url": inputUrl,
      "flagged": flagged ? "1" : "0",
      "listid":listid
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

  Future<bool> reorderItem(data) async {
    var url = "$ipAddress/reorder.php";
    String json = jsonEncode(data);
    // print(json);
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

  Future<bool> updateName(String name, String id) async {
    if (name != null && id != null) {
      var url = "$ipAddress/updateItemName.php";
      var data = {
        "name": name,
        "id": id,
      };
      var response = await http.post(url, body: data);
      if (jsonDecode(response.body) == "success") {
        return true;
      }
    }
    return false;
  }


}
