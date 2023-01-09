import 'package:L1_sean/provider/userProvider.dart';
import 'package:L1_sean/services/listService.dart';
import 'package:L1_sean/utils/global.dart';
import 'package:L1_sean/utils/popup.dart';
import 'package:L1_sean/widgets/ChangeThemeButton.dart';
import 'package:L1_sean/widgets/displays.dart';
import 'package:L1_sean/widgets/fade.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:day_night_switcher/day_night_switcher.dart';

class HomeMenu extends StatefulWidget {
  @override
  State<HomeMenu> createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> with TickerProviderStateMixin {
  AnimationController popup;
  AnimationController controller;
  AnimationController slideController;
  bool isActive = false;
  bool animated = true;
  String allCount;
  String archiveCount;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    asyncMethod();
    fetchCounts();
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
    slideController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
  }

  void fetchCounts() async {
    var all = await ListService().fetchAllCount();
    var archive = await ListService().fetchArchiveCount();
    setState(() {
      allCount = all;
      archiveCount = archive;
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
    slideController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
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
        actions: [Container(height:100,width:70,margin:EdgeInsets.only(right:30),child: ChangeThemeButton())],
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
                        animated
                            ? FadeAnimation(
                                1,
                                'up',
                                displays(FontAwesome.inbox, 'All', Colors.grey,
                                    allCount != null ? allCount : '0', context))
                            : displays(FontAwesome.inbox, 'All', Colors.grey,
                                allCount != null ? allCount : '0', context),
                        margin20,
                        animated
                            ? FadeAnimation(
                                1,
                                'up',
                                displays(
                                    Entypo.archive,
                                    'Archived',
                                    Colors.blueAccent,
                                    archiveCount != null ? archiveCount : '0',
                                    context))
                            : displays(
                                Entypo.archive,
                                'Archived',
                                Colors.blueAccent,
                                archiveCount != null ? archiveCount : '0',
                                context)
                      ],
                    ),
                    margin20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        animated
                            ? FadeAnimation(
                                1.5,
                                'up',
                                displays(FontAwesome.check, 'Completed',
                                    Colors.green[400], '3', context))
                            : displays(FontAwesome.check, 'Completed',
                                Colors.green[400], '3', context),
                        margin20,
                        animated
                            ? FadeAnimation(
                                1.5,
                                'up',
                                displays(Foundation.flag, 'Flagged',
                                    Colors.orange[300], '3', context))
                            : displays(Foundation.flag, 'Flagged',
                                Colors.orange[300], '3', context)
                      ],
                    ),
                    margin20,
                    animated
                        ? FadeAnimation(
                            2,
                            'up',
                            Text(
                              'My Lists',
                              style: header,
                            ),
                          )
                        : Text(
                            'My Lists',
                            style: header,
                          ),
                    SizedBox(height: 10),
                    animated
                        ? FadeAnimation(2.5, 'up', futureList())
                        : futureList()
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
        ),
      ),
    );
  }

  Widget futureList() {
    return FutureBuilder(
        future: ListService().fetchList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var item = snapshot.data;
            return ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 300,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        if (item[index].id == null &&
                            item[index].listname == null) {
                          displayToast("ListName and ListId is null", context,
                              failColor);
                        }
                        Navigator.pushNamed(context, '/list', arguments: {
                          'listid': int.parse(item[index].id),
                          'listname': item[index].listname,
                        });
                      },
                      child: Container(
                        child: Slidable(
                          key: Key(item[index].listname),
                          actionPane: SlidableDrawerActionPane(),
                          secondaryActions: [
                            IconSlideAction(
                              caption: 'Info',
                              color: thirdColor,
                              icon: Feather.info,
                              onTap: () {
                                Navigator.pushNamed(context, '/addlist',
                                    arguments: {
                                      'iconid': int.parse(item[index].iconid),
                                      'colorid': int.parse(item[index].colorid),
                                      'id': item[index].id,
                                      'listname': item[index].listname,
                                    });
                              },
                            ),
                            IconSlideAction(
                              caption: 'Delete',
                              color: redColor,
                              icon: MaterialCommunityIcons.delete,
                              onTap: () async {
                                var deletelist = await ListService()
                                    .deleteList(item[index].id);
                                if (deletelist) {
                                  setState(() {
                                    animated = false;
                                  });
                                  displayDialog('Success', context, popup, true,
                                      'homemenu');
                                } else {
                                  displayDialog('Fail', context, popup, false,
                                      'homemenu');
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
                            width: MediaQuery.of(context).size.width,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Colors.white)),
                                gradient: LinearGradient(
                                  colors: [
                                    Color(int.parse(item[index].color))
                                        .withOpacity(0.9),
                                    Color(int.parse(item[index].color))
                                        .withOpacity(0.5)
                                  ],
                                ),
                              ),
                              child: ListTile(
                                leading: Icon(
                                    IconData(int.parse(item[index].icon),
                                        fontFamily: 'MaterialIcons'),
                                    color: Colors.white),
                                title: Text(
                                  item[index].listname,
                                  style: whiteText,
                                ),
                                trailing: Icon(Icons.arrow_forward_ios_rounded,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          }
          return CircularProgressIndicator();
        });
  }
}
