import 'package:L1_sean/utils/global.dart';
import 'package:L1_sean/widgets/arrows.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class All extends StatefulWidget {
  @override
  State<All> createState() => _AllState();
}

class _AllState extends State<All> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          leading: ButtonArrow(context,'home'),
          elevation: 0,
          flexibleSpace: Container(),
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black),
          actions: [
            Container(
                margin: const EdgeInsets.only(right: 20),
                child: Icon(
                  Icons.account_circle_sharp,
                  size: 50,
                  color: primaryColor,
                ))
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }
}
