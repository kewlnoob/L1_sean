import 'package:L1_sean/model/colorModel.dart';
import 'package:L1_sean/model/iconModel.dart';
import 'package:L1_sean/model/listItemModel.dart';
import 'package:L1_sean/model/listModel.dart';
import 'package:L1_sean/utils/global.dart';
import 'package:L1_sean/utils/popup.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ListService {
  Future<List<ListModel>> fetchList() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString('user');
    if (value != null) {
      var url = "$ipAddress/getList.php?userid=" + jsonDecode(value)['userid'];
      final response = await http.get(url);
      return listFromJson(response.body);
    }
  }

  Future<bool> editList(String id, listname, int colorid, int iconid) async {
    var url = "$ipAddress/editList.php";
    var data = {
      "listname": listname,
      "iconid": iconid.toString(),
      "colorid": colorid.toString(),
      'id': id.toString(),
    };
    var response = await http.post(url, body: data);
    if (jsonDecode(response.body) == "success") {
      return true;
    }
    return false;
  }

  Future<bool> addList(String listName, int iconid, int colorid) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString('user');
    var url = "$ipAddress/addList.php";
    var data = {
      "listname": listName,
      "iconid": iconid.toString(),
      "colorid": colorid.toString(),
      "userid": jsonDecode(value)['userid'],
    };
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

  Future<List<ListItemModel>> fetchAllList() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString('user');

    if (value != null) {
      var url =
          "$ipAddress/fetchAll.php?userid=" + jsonDecode(value)['userid'];
      final response = await http.get(url);
      if (jsonDecode(response.body) != null) {
        return listItemModelFromJson(response.body);
      }
    }
    return null;
  }
}
