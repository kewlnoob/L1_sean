import 'dart:convert';

List<ColorModel> colorFromJson(String str) => List<ColorModel>.from(json.decode(str).map((x) => ColorModel.fromJson(x)));

String colorToJson(List<ColorModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ColorModel {
    ColorModel({
        this.id,
        this.color,
    });

    String id;
    String color;

    factory ColorModel.fromJson(Map<String, dynamic> json) => ColorModel(
        id: json["id"],
        color: json["color"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "color": color,
    };
}
