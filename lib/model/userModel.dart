
class UserModel{
  String userid;
  String email;
  String username;

  UserModel({this.userid, this.email, this.username});


  UserModel.fromJson(Map<String,dynamic> json){
    userid = json['userid'];
    email = json['email'];
    username = json['username'];
  }

  Map<String,dynamic> toJson(){
    return{
      "userid": userid,
      "email": email,
      "username": username,
    };
  }
}