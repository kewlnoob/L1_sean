import 'package:L1_sean/utils/global.dart';
import 'package:L1_sean/widgets/arrows.dart';
import 'package:flutter/material.dart';

class AddList extends StatefulWidget {
  @override
  State<AddList> createState() => _AddListState();
}

class _AddListState extends State<AddList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40.0),
          child: AppBar(
            leading: ButtonArrow(context),
            elevation: 0,
            flexibleSpace: Container(),
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: Colors.black),
            actions: [
              Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: Icon(
                    Icons.check,
                    size: 30,
                    color: Colors.black,
                  ))
            ],
          ),
        ),
        body: SafeArea(
          child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width * 0.5,
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 25),
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                              color: Colors.blue, shape: BoxShape.circle),
                          child: Icon(
                            Icons.menu,
                            color: Colors.white,
                            size: 60,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ));
  }
}
