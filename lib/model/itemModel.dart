import 'dart:convert';

List<ItemModel> itemFromJson(String str) =>
    List<ItemModel>.from(json.decode(str).map((x) => ItemModel.fromJson(x)));

String itemToJson(List<ItemModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ItemModel {
  ItemModel({
    this.id,
    this.name,
    this.iscompleted,
    this.listid,
    this.position,
    this.url,
    this.description,
    this.isflagged,
    this.isarchive,
    this.priorityid,
    this.pname,
  });

  String id;
  String name;
  bool iscompleted;
  bool isarchive;
  String listid;
  String position;
  String url;
  String description;
  bool isflagged;
  String priorityid;
  String pname;

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
      id: json["id"],
      name: json["name"],
      iscompleted: json["iscompleted"],
      listid: json["listid"],
      position: json["position"],
      url: json["url"],
      description: json["description"],
      isflagged: json["isflagged"],
      isarchive: json["isarchive"],
      priorityid: json["priorityid"],
      pname: json["pname"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "iscompleted": iscompleted,
        "listid": listid,
        "position": position,
        "url": url,
        "description": description,
        "isflagged": isflagged,
        "isarchive": isarchive,
        "priorityid": priorityid,
        "pname": pname
      };
}
