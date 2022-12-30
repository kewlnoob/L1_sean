import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:L1_sean/utils/global.dart';
class ItemService{

    Future<bool> addItem(String name,int position) async {
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
}