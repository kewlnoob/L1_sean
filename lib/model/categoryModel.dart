import 'dart:convert';

List<CategoryModel> categoryFromJson(String str) => List<CategoryModel>.from(json.decode(str).map((x) => CategoryModel.fromJson(x)));

String categoryToJson(List<CategoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryModel {
    CategoryModel({
        this.categoryId,
        this.categoryName,
        this.userId,
    });

    String categoryId;
    String categoryName;
    String userId;

    factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        categoryId: json["categoryId"],
        categoryName: json["categoryName"],
        userId: json["userId"],
    );

    Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "categoryName": categoryName,
        "userId": userId,
    };
}