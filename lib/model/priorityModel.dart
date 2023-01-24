import 'dart:convert';

List<PriorityModel> priorityModelFromJson(String str) => List<PriorityModel>.from(json.decode(str).map((x) => PriorityModel.fromJson(x)));

String priorityModelToJson(List<PriorityModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PriorityModel {
    PriorityModel({
        this.id,
        this.name,
    });

    String id;
    String name;

    factory PriorityModel.fromJson(Map<String, dynamic> json) => PriorityModel(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}