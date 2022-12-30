import 'dart:convert';

List<ListModel> listFromJson(String str) => List<ListModel>.from(json.decode(str).map((x) => ListModel.fromJson(x)));

String listToJson(List<ListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListModel {
    ListModel({
        this.id,
        this.listname,
        this.color,
        this.icon,
        this.colorid,
        this.iconid,
    });

    String id;
    String listname;
    String color;
    String icon;
    String colorid;
    String iconid;

    factory ListModel.fromJson(Map<String, dynamic> json) => ListModel(
        id: json["id"],
        listname: json["listname"],
        color: json["color"],
        icon: json["icon"],
        colorid: json["colorid"],
        iconid: json["iconid"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "listname": listname,
        "color": color,
        "icon": icon,
        "colorid": colorid,
        "iconid": iconid,
    };
}