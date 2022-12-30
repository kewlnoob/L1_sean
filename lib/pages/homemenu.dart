import 'package:L1_sean/provider/userProvider.dart';
import 'package:L1_sean/services/listService.dart';
import 'package:L1_sean/utils/global.dart';
import 'package:L1_sean/utils/popup.dart';
import 'package:L1_sean/widgets/displays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';

class HomeMenu extends StatefulWidget {
  @override
  State<HomeMenu> createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> with TickerProviderStateMixin {
  AnimationController popup;
  AnimationController controller;
  bool isActive = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    asyncMethod();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

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

  void asyncMethod() async {
    await Provider.of<UserProvider>(context, listen: false).getColorList();
    await Provider.of<UserProvider>(context, listen: false).getIconList();
  }

  void animate() {
    setState(() {
      isActive = !isActive;
    });

    isActive ? controller.forward() : controller.reverse();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              icon: AnimatedIcon(
                color: Colors.black,
                icon: AnimatedIcons.menu_close,
                progress: controller,
              ),
              onPressed: () => {animate(), ZoomDrawer.of(context).toggle()});
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
        child: Stack(children: [
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
                      displays(Icons.all_inbox, 'All', Colors.grey, 3, context),
                      margin20,
                      displays(Icons.archive, 'Archived', Colors.blueAccent, 3,
                          context)
                    ],
                  ),
                  margin20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      displays(Icons.check, 'Completed', Colors.green[400], 3,
                          context),
                      margin20,
                      displays(
                          Icons.flag, 'Flagged', Colors.orange[300], 3, context)
                    ],
                  ),
                  margin20,
                  Text(
                    'My Lists',
                    style: header,
                  ),
                  SizedBox(height: 10),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 300,
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: FutureBuilder(
                            future: ListService().fetchList(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var item = snapshot.data[index];
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(context, "/list");
                                      },
                                      child: Container(
                                        child: Slidable(
                                          key: Key(item.listname),
                                          dismissal: SlidableDismissal(
                                            child: SlidableDrawerDismissal(),
                                            onDismissed: (type) {
                                              print(type);
                                            },
                                          ),
                                          actionPane:
                                              SlidableDrawerActionPane(),
                                          secondaryActions: [
                                            IconSlideAction(
                                              caption: 'Info',
                                              color: backgroundColor,
                                              icon: Icons.info,
                                              onTap: () {
                                                Navigator.pushNamed(
                                                    context, '/addlist',
                                                    arguments: {
                                                      'iconid': int.parse(
                                                          item.iconid),
                                                      'colorid': int.parse(
                                                          item.colorid),
                                                      'id': item.id,
                                                      'listname': item.listname,
                                                    });
                                              },
                                            ),
                                            IconSlideAction(
                                              caption: 'Delete',
                                              color: backgroundColor,
                                              icon: Icons.delete,
                                              onTap: () async {
                                                var deletelist =
                                                    await ListService()
                                                        .deleteList(item.id);

                                                if (deletelist) {
                                                  displayDialog(
                                                      'Success',
                                                      context,
                                                      popup,
                                                      true,
                                                      'homemenu');
                                                  Navigator.push(
                                                      context,
                                                      new MaterialPageRoute(
                                                          builder: (context) =>
                                                              this.build(
                                                                  context)));
                                                } else {
                                                  displayDialog('Fail', context,
                                                      popup, false, 'homemenu');
                                                }
                                              },
                                            ),
                                          ],
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: secondaryColor,
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/images/dashboard.png'),
                                                    fit: BoxFit.fill)),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        width: 1,
                                                        color: Colors.white)),
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Color(int.parse(item.color))
                                                        .withOpacity(0.9),
                                                    Color(int.parse(item.color))
                                                        .withOpacity(0.5)
                                                  ],
                                                ),
                                              ),
                                              child: ListTile(
                                                leading: Icon(
                                                    IconData(
                                                        int.parse(item.icon),
                                                        fontFamily:
                                                            'MaterialIcons'),
                                                    color: Colors.white),
                                                title: Text(
                                                  item.listname,
                                                  style: whiteText,
                                                ),
                                                trailing: Icon(
                                                    Icons
                                                        .arrow_forward_ios_rounded,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                              return CircularProgressIndicator();
                            })),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: Row(
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
            ),
          )
        ]),
      )),
    );
  }
}
