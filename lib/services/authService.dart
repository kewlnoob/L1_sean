import 'package:L1_sean/model/userModel.dart';
import 'package:L1_sean/utils/global.dart';
import 'package:L1_sean/utils/popup.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService{

  Future<bool> register(String username,String email,String password, BuildContext context) async{
    if(username == "" || email == "" || password == ""){
      displayToast("All fields cannot be blank!", context, failColor);
      return false;
    }else{
      var url = "$ipAddress/register.php";
      var data = {
        "username": username,
        "password": password,
        "email": email,
      };
      var response = await http.post(url,body:data);

      if(jsonDecode(response.body) == "duplicate"){
        displayToast("Duplicate Email", context, failColor);
        return false;
      }
      else if(jsonDecode(response.body) == "success"){
        displayToast("Registration Successful", context, successColor);
        return true;
      }
      else{
        displayToast("Registration Unsuccessful", context, failColor);
        return false;
      }
    }
  }

  Future<bool> login(String email,String password,BuildContext context) async {
    if (email == "" || password == "") {
      displayToast("All fields cannot be blank!", context, failColor);
      return false;
    }else{
      var url = "$ipAddress/login.php";
      var data = {
        "email": email,
        "password": password,
      };

      var response = await http.post(url,body:data);

      if(jsonDecode(response.body) == "error"){
        displayToast("User not Found", context, failColor);
        return false;
      }else{
        var jsonData = jsonDecode(response.body);
        var user = UserModel.fromJson(jsonData).toJson();
        print(user);
        String userData = jsonEncode(user);
        print(userData);
        var sharedPref = await SharedPreferences.getInstance();
        sharedPref.setString('user', userData);
        displayToast("Login successful", context, successColor);
        return true;
      }
    }

  }

}