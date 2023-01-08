import 'package:L1_sean/services/authService.dart';
import 'package:L1_sean/utils/global.dart';
import 'package:L1_sean/widgets/arrows.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile();

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ButtonArrow(context, 'home')],
        ),
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: AuthService().getUserInfo(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            username.text = snapshot.data.username;
            password.text = snapshot.data.password;
            return Column(children: [
              margin20,
              profileImage(imagelink + snapshot.data.image),
              input(username,'Username'),
              input(email,'Email'),
              input(password,'Password'),
              margin20,
            ]);
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  Widget profileImage(imagelink) {
    return Align(
      alignment: Alignment.topCenter,
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 110,
        child: Stack(
          children: [
            FlatButton(
              shape: CircleBorder(),
              onPressed: () {
                // showModalBottomSheet(
                //     context: context,
                //     builder: (builder) => bottomPanel());
              },
              child: CircleAvatar(
                radius: 90,
                backgroundImage: NetworkImage(imagelink),
              ),
            ),
            Positioned(
              bottom: 20,
              right: 40,
              child: Icon(
                Icons.camera_alt,
                color: Colors.teal,
                size: 35,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget input(controller,hint) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 10, bottom: 13),
          hintText: hint,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
