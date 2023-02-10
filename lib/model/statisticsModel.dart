import 'dart:convert';

List<StatisticsModel> statisticsModelFromJson(String str) => List<StatisticsModel>.from(json.decode(str).map((x) => StatisticsModel.fromJson(x)));

String statisticsModelToJson(List<StatisticsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StatisticsModel {
    StatisticsModel({
        this.listname,
        this.totalItems,
        this.completed,
    });

    String listname;
    String totalItems;
    String completed;

    factory StatisticsModel.fromJson(Map<String, dynamic> json) => StatisticsModel(
        listname: json["listname"],
        totalItems: json["totalItems"],
        completed: json["completed"],
    );

    Map<String, dynamic> toJson() => {
        "listname": listname,
        "totalItems": totalItems,
        "completed": completed,
    };
}