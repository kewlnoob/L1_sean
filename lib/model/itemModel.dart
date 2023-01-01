
import 'dart:convert';

List<ItemModel> itemFromJson(String str) => List<ItemModel>.from(json.decode(str).map((x) => ItemModel.fromJson(x)));

String itemToJson(List<ItemModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ItemModel {
    ItemModel({
        this.id,
        this.name,
        this.iscompleted,
        this.listid,
        this.position,
    });

    String id;
    String name;
    bool iscompleted;
    String listid;
    String position;

    factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
        id: json["id"],
        name: json["name"],
        iscompleted: json["iscompleted"],
        listid: json["listid"],
        position: json["position"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "iscompleted": iscompleted,
        "listid": listid,
        "position": position,
    };
}
