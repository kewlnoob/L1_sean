import 'dart:convert';

import 'package:L1_sean/model/itemModel.dart';

List<ListItemModel> listItemModelFromJson(String str) => List<ListItemModel>.from(json.decode(str).map((x) => ListItemModel.fromJson(x)));

String listItemModelToJson(List<ListItemModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListItemModel {
    ListItemModel({
        this.name,
        this.items,
    });

    String name;
    List<ItemModel> items;

    factory ListItemModel.fromJson(Map<String, dynamic> json) => ListItemModel(
        name: json["name"],
        items: List<ItemModel>.from(json["items"].map((x) => ItemModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
    };
}