import 'package:L1_sean/model/statisticsModel.dart';
import 'package:L1_sean/model/userStatisticsModel.dart';
import 'package:L1_sean/utils/global.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StatisticService {
  Future<List<StatisticsModel>> fetchListStatistics() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString('user');
    if (value != null) {
      var url =
          "$ipAddress/Statistics.php?userid=" + jsonDecode(value)['userid'];
      final response = await http.get(url);
      return statisticsModelFromJson(response.body);
    }
    return null;
  }

  Future<List<UserStatisticsModel>> fetchUserStatistics() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString('user');
    if (value != null) {
      var url =
          "$ipAddress/userStatistics.php?userid=" + jsonDecode(value)['userid'];
      final response = await http.get(url);
      return userStatisticsModelFromJson(response.body);
    }
    return null;
  }
}
