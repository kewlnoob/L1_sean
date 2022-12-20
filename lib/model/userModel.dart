
class UserModel{
  final String id;
  final String email;
  final String username;

  UserModel({this.id, this.email, this.username});

  toJson(){
    return{
      "id": id,
      "username": username,
      "email": email,
    };
  }
}