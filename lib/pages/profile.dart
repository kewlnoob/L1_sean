import 'package:L1_sean/main.dart';
import 'package:L1_sean/services/authService.dart';
import 'package:L1_sean/utils/global.dart';
import 'package:L1_sean/utils/popup.dart';
import 'package:L1_sean/widgets/arrows.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile();

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with TickerProviderStateMixin {
  PickedFile imageFile;
  ImagePicker picker = ImagePicker();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  AnimationController popup;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    popup = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    popup.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pop(context);
        popup.reset();
      }
    });
  }

  void takePhoto(ImageSource source) async {
    final pickerFile = await picker.getImage(source: source);
    if (pickerFile == null) return;
    setState(() {
      imageFile = pickerFile;
    });
    if (imageFile != null) {
      var upload = await AuthService().uploadImage(imageFile);
      if (upload) {
        displayDialog("Success!", context, popup, true, "profile");
      } else {
        displayDialog("Failed!", context, popup, false, "profile");
      }
      setState(() {});
    }
  }

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
          style: Theme.of(context).textTheme.headline2,
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: AuthService().getUserInfo(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            username.text = snapshot.data.username;
            password.text = snapshot.data.password;
            email.text = snapshot.data.email;
            return Column(children: [
              margin20,
              profileImage(imagelink + snapshot.data.image),
              input(username, 'Username'),
              margin20,
              input(email, 'Email'),
              margin20,
              input(password, 'Password'),
              margin20,
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: ElevatedButton(
                  onPressed: () async {
                    if (username.text.isNotEmpty &&
                        password.text.isNotEmpty &&
                        email.text.isNotEmpty) {
                      var edit = await AuthService().editProfile(
                          username.text, email.text, password.text);
                      if (!edit)
                        displayDialog(
                            "Edit Failed!", context, popup, false, "profile");

                      displayDialog("Sucess!", context, popup, true, "profile");
                    } else {
                      displayDialog(
                          "username, email & password cannot be empty",
                          context,
                          popup,
                          false,
                          "profile");
                    }
                    setState(() {});
                  },
                  child: Text(
                    "Save",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    elevation: 0,
                  ),
                ),
              )
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
                showMaterialModalBottomSheet(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        topLeft: Radius.circular(50)),
                  ),
                  context: context,
                  builder: (context) => Container(
                    height: 200,
                    child: Column(
                      children: [
                        SizedBox(height: 50),
                        Text(
                          "Choose Profile Picture",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FlatButton.icon(
                              onPressed: () {
                                takePhoto(ImageSource.camera);
                              },
                              icon: Icon(Icons.camera),
                              label: Text('Camera'),
                            ),
                            FlatButton.icon(
                              onPressed: () {
                                takePhoto(ImageSource.gallery);
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.image),
                              label: Text('Gallery'),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: CircleAvatar(
                radius: 90,
                backgroundColor: Colors.grey,
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

  Widget input(controller, hint) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 10, bottom: 13),
          hintText: hint,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Theme.of(context).iconTheme.color,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).iconTheme.color, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
