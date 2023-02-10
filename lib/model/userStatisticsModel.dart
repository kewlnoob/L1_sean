import 'dart:convert';

List<UserStatisticsModel> userStatisticsModelFromJson(String str) => List<UserStatisticsModel>.from(json.decode(str).map((x) => UserStatisticsModel.fromJson(x)));

String userStatisticsModelToJson(List<UserStatisticsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserStatisticsModel {
    UserStatisticsModel({
        this.total,
        this.completed,
    });

    String total;
    String completed;

    factory UserStatisticsModel.fromJson(Map<String, dynamic> json) => UserStatisticsModel(
        total: json["total"],
        completed: json["completed"],
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "completed": completed,
    };
}
