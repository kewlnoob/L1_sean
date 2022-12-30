import 'dart:convert';

List<IconModel> iconFromJson(String str) => List<IconModel>.from(json.decode(str).map((x) => IconModel.fromJson(x)));

String iconToJson(List<IconModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class IconModel {
    IconModel({
        this.id,
        this.icon,
    });

    String id;
    String icon;

    factory IconModel.fromJson(Map<String, dynamic> json) => IconModel(
        id: json["id"],
        icon: json["icon"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "icon": icon,
    };
}
