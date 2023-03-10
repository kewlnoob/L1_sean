import 'package:L1_sean/model/userModel.dart';
import 'package:L1_sean/utils/global.dart';
import 'package:L1_sean/utils/popup.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
class AuthService {
  Future<bool> register(String username, String email, String password,
      BuildContext context) async {
    if (username == "" || email == "" || password == "") {
      displayToast("All fields cannot be blank!", context, failColor);
      return false;
    } else {
      var url = "$ipAddress/register.php";
      var data = {
        "username": username,
        "password": password,
        "email": email,
      };
      var response = await http.post(url, body: data);

      if (jsonDecode(response.body) == "duplicate") {
        displayToast("Duplicate Email", context, failColor);
        return false;
      } else if (jsonDecode(response.body) == "success") {
        displayToast("Registration Successful", context, successColor);
        return true;
      } else {
        displayToast("Registration Unsuccessful", context, failColor);
        return false;
      }
    }
  }

  Future<bool> login(
      String email, String password, BuildContext context) async {
    if (email == "" || password == "") {
      displayToast("All fields cannot be blank!", context, failColor);
      return false;
    } else {
      var url = "$ipAddress/login.php";
      var data = {
        "email": email,
        "password": password,
      };

      var response = await http.post(url, body: data);

      if (jsonDecode(response.body) == "error") {
        displayToast("User not Found", context, failColor);
        return false;
      } else {
        var jsonData = jsonDecode(response.body);
        var user = UserModel.fromJson(jsonData).toJson();
        String userData = jsonEncode(user);
        var sharedPref = await SharedPreferences.getInstance();
        sharedPref.setString('user', userData);
        displayToast("Login successful", context, successColor);
        return true;
      }
    }
  }

  Future<UserModel> getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString('user');
    var url = "$ipAddress/profile.php?userid=" + jsonDecode(value)['userid'];
    var response = await http.get(url);
    if (response.body != null) {
      return UserModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  Future<bool> uploadImage(PickedFile imageFile) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString('user');
    if (value != null) {
      var url = Uri.parse("$ipAddress/uploadImage.php");
      var response = http.MultipartRequest("POST", url);
      http.MultipartFile multipartFile =
        await http.MultipartFile.fromPath('image', imageFile.path);
      response.files.add(multipartFile);
      response.fields['id'] = jsonDecode(value)['userid'];
      http.StreamedResponse request = await response.send();
      if (request.statusCode == 200) {
        return true;
      }
    }
    return false;
  }

  Future<bool> editProfile(String username,String email,String password) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString('user');
    if (value != null) {
      var data = {
        "userid": jsonDecode(value)['userid'],
        "password":password,
        "email":email,
        "username":username,
      };
      var url = Uri.parse("$ipAddress/editProfile.php");
      var response = await http.post(url,body: data);
      if(jsonDecode(response.body) == "success") return true;
    }
    return false;
  }
}
