import 'dart:convert';

List<UserModel> userFromJson(String str) => json.decode(str) == null ? [] : List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userToJson(List<UserModel> data) => json.encode(data == null ? [] : List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
    UserModel({
        this.userid,
        this.email,
        this.password,
        this.username,
        this.image,
    });

    String userid;
    String email;
    String password;
    String username;
    String image;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userid: json["userid"],
        email: json["email"],
        password: json["password"],
        username: json["username"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "userid": userid,
        "email": email,
        "password": password,
        "username": username,
        "image": image,
    };
}
