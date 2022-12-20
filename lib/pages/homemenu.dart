import 'package:L1_sean/utils/global.dart';
import 'package:L1_sean/widgets/displays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class HomeMenu extends StatefulWidget {

  @override
  State<HomeMenu> createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {

  var dummylist = [
    {"name": "list1"},
    {"name": "list2"},
    {"name": "list3"},
    {"name": "list4"},
    {"name": "list5"},
    {"name": "list6"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
              icon: Icon(Icons.menu, size: 40),
              onPressed: () => ZoomDrawer.of(context).toggle());
        }),
        elevation: 0,
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
      body: SafeArea(
          child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 40,
              right: 40,
            ),
            child: Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  margin20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      displays(Icons.all_inbox, 'All', Colors.grey, 3),
                      margin20,
                      displays(Icons.archive, 'Archived', Colors.blueAccent, 3)
                    ],
                  ),
                  margin20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      displays(Icons.check, 'Completed', Colors.green[400], 3),
                      margin20,
                      displays(Icons.flag, 'Flagged', Colors.orange[300], 3)
                    ],
                  ),
                  margin20,
                  Text(
                    'My Lists',
                    style: header,
                  ),
                  SizedBox(height: 10),
                  LimitedBox(
                    maxHeight: 290,
                    child: ListView.builder(
                      itemCount: dummylist.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.only(top: 8),
                          child: Slidable(
                            key: Key(dummylist[index]["name"]),
                            dismissal: SlidableDismissal(
                              child: SlidableDrawerDismissal(),
                              onDismissed: (type) {
                                print(type);
                                // delete
                              },
                            ),
                            actionPane: SlidableDrawerActionPane(),
                            secondaryActions: [
                              IconSlideAction(
                                caption: 'Info',
                                color: backgroundColor,
                                icon: Icons.info,
                                onTap: () {},
                              ),
                              IconSlideAction(
                                caption: 'Delete',
                                color: backgroundColor,
                                icon: Icons.delete,
                                onTap: () {},
                              ),
                            ],
                            child: Container(
                                decoration: BoxDecoration(
                                    color: secondaryColor,
                                    borderRadius: BorderRadius.circular(25),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/dashboard.png'),
                                        fit: BoxFit.fill)),
                                // height: 50,
                                width: MediaQuery.of(context).size.width,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    gradient: LinearGradient(
                                      colors: [
                                        primaryColor.withOpacity(0.8),
                                        secondaryColor.withOpacity(0.7),
                                      ],
                                    ),
                                  ),
                                  child: ListTile(
                                    leading:
                                        Icon(Icons.email, color: Colors.white),
                                    title: Text(
                                      dummylist[index]['name'],
                                      style: whiteText,
                                    ),
                                    trailing: Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: Colors.white),
                                  ),
                                )),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          margin20,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: 20),
                child: TextButton(
                    style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'New Item',
                      style: secondaryText,
                    )),
              ),
              Container(
                margin: EdgeInsets.only(right: 20),
                child: TextButton(
                    style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, "/addlist");
                    },
                    child: const Text(
                      'Add List',
                      style: secondaryText,
                    )),
              )
            ],
          )
        ]),
      )),
    );
  }
}