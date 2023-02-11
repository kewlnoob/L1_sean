import 'package:L1_sean/model/categoryModel.dart';
import 'package:L1_sean/model/colorModel.dart';
import 'package:L1_sean/model/iconModel.dart';
import 'package:L1_sean/model/itemModel.dart';
import 'package:L1_sean/model/listModel.dart';
import 'package:L1_sean/utils/global.dart';
import 'package:L1_sean/utils/popup.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ListService {
  Future<bool> addCategory(String categoryName) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString('user');
    if (value != null) {
      var url = "$ipAddress/addCategory.php";
      var data = {
        "userid": jsonDecode(value)['userid'],
        "name": categoryName,
      };
      var response = await http.post(url, body: data);
      if (jsonDecode(response.body) == "success") {
        return true;
      }
    }
    return false;
  }

  Future<List<CategoryModel>> fetchCategory() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString('user');
    if (value != null) {
      var url =
          "$ipAddress/fetchCategory.php?userid=" + jsonDecode(value)['userid'];
      final response = await http.get(url);
      return categoryFromJson(response.body);
    }
  }

  Future<List<ListModel>> fetchList() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString('user');
    if (value != null) {
      var url = "$ipAddress/getList.php?userid=" + jsonDecode(value)['userid'];
      final response = await http.get(url);
      return listFromJson(response.body);
    }
  }

  Future<bool> editList(String id, listname, int colorid, int iconid,
      String selectedCategory) async {
    var url = "$ipAddress/editList.php";
    var data = {
      "listname": listname,
      "iconid": iconid.toString(),
      "colorid": colorid.toString(),
      "id": id.toString(),
      "categoryid": selectedCategory,
    };
    var response = await http.post(url, body: data);
    if (jsonDecode(response.body) == "success") {
      return true;
    }
    return false;
  }

  Future<bool> addList(
      String listName, int iconid, int colorid, String selectedCategory) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString('user');
    var url = "$ipAddress/addList.php";
    var data = {
      "listname": listName,
      "iconid": iconid.toString(),
      "colorid": colorid.toString(),
      "userid": jsonDecode(value)['userid'],
      "categoryid": selectedCategory,
    };
    print(data);
    var response = await http.post(url, body: data);
    if (jsonDecode(response.body) == "success") {
      return true;
    }
    return false;
  }

  Future<bool> deleteList(String id) async {
    var url = "$ipAddress/deleteList.php";
    var data = {"id": id};
    final response = await http.post(url, body: data);
    if (jsonDecode(response.body) == "success") {
      return true;
    }
    return false;
  }

  Future<List<ColorModel>> fetchColors() async {
    var url = "$ipAddress/getColors.php";
    final response = await http.get(url);
    return colorFromJson(response.body);
  }

  Future<List<IconModel>> fetchIcons() async {
    var url = "$ipAddress/getIcons.php";
    final response = await http.get(url);
    return iconFromJson(response.body);
  }

  // ------------------ ALL
  Future<List<CategoryModel>> fetchUserCategories() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString('user');

    if (value != null) {
      var url = "$ipAddress/fetchUserCategories.php?userid=" +
          jsonDecode(value)['userid'];
      final response = await http.get(url);
      if (jsonDecode(response.body) != null) {
        return categoryFromJson(response.body);
      }
    }
    return null;
  }

  Future<List<ListModel>> fetchListByCategory(String categoryid) async {
    var url = "$ipAddress/fetchListByCategory.php?categoryid=" + categoryid;
    final response = await http.get(url);
    if (jsonDecode(response.body) != null) {
      return listFromJson(response.body);
    }

    return null;
  }

  Future<List<ItemModel>> fetchItemsByList(String listid) async {
    var url = "$ipAddress/fetchItemsByList.php?listid=" + listid;
    final response = await http.get(url);
    if (jsonDecode(response.body) != null) {
      return itemFromJson(response.body);
    }

    return null;
  }

  Future<String> fetchAllCount() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString('user');

    if (value != null) {
      var url =
          "$ipAddress/fetchAllCount.php?userid=" + jsonDecode(value)['userid'];
      final response = await http.get(url);
      if (jsonDecode(response.body)['count'] != null) {
        return jsonDecode(response.body)['count'];
      }
    }
    return "0";
  }

  Future<String> fetchCompleteCount() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString('user');

    if (value != null) {
      var url = "$ipAddress/fetchCompleteCount.php?userid=" +
          jsonDecode(value)['userid'];
      final response = await http.get(url);
      if (jsonDecode(response.body)['count'] != null) {
        return jsonDecode(response.body)['count'];
      }
    }
    return "0";
  }

  Future<String> fetchFavouriteCount() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString('user');

    if (value != null) {
      var url = "$ipAddress/fetchFavouriteCount.php?userid=" +
          jsonDecode(value)['userid'];
      final response = await http.get(url);
      if (jsonDecode(response.body)['count'] != null) {
        return jsonDecode(response.body)['count'];
      }
    }
    return "0";
  }

  Future<String> fetchArchiveCount() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString('user');

    if (value != null) {
      var url = "$ipAddress/fetchArchiveCount.php?userid=" +
          jsonDecode(value)['userid'];
      final response = await http.get(url);
      if (jsonDecode(response.body)['count'] != null) {
        return jsonDecode(response.body)['count'];
      }
    }
    return "0";
  }

  Future<List<ItemModel>> fetchArchiveList(String id) async {
    var url = "$ipAddress/fetchArchive.php?listid=" + id;
    final response = await http.get(url);
    if (jsonDecode(response.body) != null) {
      return itemFromJson(response.body);
    }
    return null;
  }

  Future<List<ItemModel>> fetchCompleteList(String id) async {
    var url = "$ipAddress/fetchComplete.php?listid=" + id;
    final response = await http.get(url);
    if (jsonDecode(response.body) != null) {
      return itemFromJson(response.body);
    }
    return null;
  }

  Future<List<ItemModel>> fetchFavourite(String id) async {
    var url = "$ipAddress/fetchFavourite.php?listid=" + id;
    final response = await http.get(url);
    if (jsonDecode(response.body) != null) {
      return itemFromJson(response.body);
    }
    return null;
  }

}
