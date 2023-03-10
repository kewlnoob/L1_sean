import 'package:L1_sean/model/itemModel.dart';
import 'package:L1_sean/model/priorityModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:L1_sean/utils/global.dart';

class ItemService {
  Future<bool> addItem(String name, String description, String inputUrl,
      bool isfavourite, String listid, String priorityid) async {
    var url = "$ipAddress/addItem.php";
    var data = {
      "name": name,
      "description": description,
      "url": inputUrl,
      "favourite": isfavourite ? "1" : "0",
      "listid": listid,
      "priorityid": priorityid != null ? priorityid : "1"
    };
    var response = await http.post(url, body: data);
    if (jsonDecode(response.body) == "success") {
      return true;
    }
    return false;
  }

  Future<bool> updateItem(String name, String description, String inputUrl,
      bool isfavourite, String id, String priorityid) async {
    var url = "$ipAddress/updateItem.php";
    var data = {
      "name": name,
      "description": description,
      "url": inputUrl,
      "favorite": isfavourite ? "1" : "0",
      'id': id,
      'priorityid': priorityid != null ? priorityid : "1"
    };
    var response = await http.post(url, body: data);
    if (jsonDecode(response.body) == "success") {
      return true;
    }
    return false;
  }

  Future<List<ItemModel>> fetchItems(int listid,String hideCompleted) async {
    if (listid == null) return null;

    var url = "$ipAddress/getItems.php?listid=" + listid.toString() + "&hideCompleted=" + hideCompleted;
    final response = await http.get(url);
    List<ItemModel> json = itemFromJson(response.body);
    print(json);
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

  Future<bool> archiveItem(String id) async {
    if (id != null) {
      var url = "$ipAddress/archiveItem.php";
      var data = {
        "id": id,
      };
      var response = await http.post(url, body: data);
      if (jsonDecode(response.body) == "success") {
        return true;
      }
    }
    return false;
  }

  Future<bool> unarchiveItem(String id) async {
    if (id != null) {
      var url = "$ipAddress/unarchiveItem.php";
      var data = {
        "id": id,
      };
      var response = await http.post(url, body: data);
      if (jsonDecode(response.body) == "success") {
        return true;
      }
    }
    return false;
  }

  Future<bool> favouriteItem(String id, bool isFavorite) async {
    if (id != null) {
      var url = "$ipAddress/favouriteItem.php";
      var data = {
        "id": id,
        "favourite": isFavorite ? "0" : "1",
      };
      var response = await http.post(url, body: data);
      if (jsonDecode(response.body) == "success") {
        return true;
      }
    }
    return false;
  }

  Future<bool> deleteItem(String id) async {
    if (id != null) {
      var url = "$ipAddress/deleteItem.php";
      var data = {
        "id": id,
      };
      var response = await http.post(url, body: data);
      if (jsonDecode(response.body) == "success") {
        return true;
      }
    }
    return false;
  }

  Future<bool> deleteUserLists() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString('user');

    if (jsonDecode(value)['userid'] != null) {
      var url = "$ipAddress/deleteUserLists.php";
      var data = {
        "userid": jsonDecode(value)['userid'],
      };
      var response = await http.post(url, body: data);
      if (jsonDecode(response.body) == "success") {
        return true;
      }
    }
    return false;
  }

  Future<bool> deleteArchiveItems() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString('user');

    if (jsonDecode(value)['userid'] != null) {
      var url = "$ipAddress/deleteArchiveItems.php";
      var data = {
        "userid": jsonDecode(value)['userid'],
      };
      var response = await http.post(url, body: data);
      if (jsonDecode(response.body) == "success") {
        return true;
      }
    }
    return false;
  }

  Future<List<PriorityModel>> fetchPriority() async {
    var url = "$ipAddress/getPriority.php";
    final response = await http.get(url);
    return priorityModelFromJson(response.body);
  }

  Future<bool> deleteItemsBasedOnList(int listid) async {
    var url = "$ipAddress/deleteItemsBasedOnList.php";
    var data = {
      "listid": listid.toString(),
    };
    var response = await http.post(url, body: data);
    if (jsonDecode(response.body) == "success") {
      return true;
    }
    return false;
  }
}
