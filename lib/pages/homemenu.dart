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
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

class HomeMenu extends StatefulWidget {
  @override
  State<HomeMenu> createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> with TickerProviderStateMixin {
  AnimationController popup;
  AnimationController controller;
  AnimationController slideController;
  final categoryText = TextEditingController();
  bool isActive = false;
  bool animated = true;
  String allCount;
  String archiveCount;
  String completeCount;
  String flagCount;
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
    var complete = await ListService().fetchCompleteCount();
    var flag = await ListService().fetchFavouriteCount();
    setState(() {
      allCount = all;
      archiveCount = archive;
      completeCount = complete;
      flagCount = flag;
    });
  }

  void asyncMethod() async {
    await Provider.of<UserProvider>(context, listen: false).getColorList();
    await Provider.of<UserProvider>(context, listen: false).getIconList();
    await Provider.of<UserProvider>(context, listen: false).getCategory();
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
    categoryText.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              icon: AnimatedIcon(
                color: Theme.of(context).iconTheme.color,
                icon: AnimatedIcons.menu_close,
                progress: controller,
              ),
              onPressed: () => {animate(), ZoomDrawer.of(context).toggle()},
            );
          },
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Container(
              height: 100,
              width: 70,
              margin: EdgeInsets.only(right: 30),
              child: ChangeThemeButton())
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
                                displays(
                                    FontAwesome.check,
                                    'Completed',
                                    Colors.green[400],
                                    completeCount != null ? completeCount : "0",
                                    context))
                            : displays(
                                FontAwesome.check,
                                'Completed',
                                Colors.green[400],
                                completeCount != null ? completeCount : "0",
                                context),
                        margin20,
                        animated
                            ? FadeAnimation(
                                1.5,
                                'up',
                                displays(
                                    AntDesign.star,
                                    'Favourite',
                                    Colors.orange[300],
                                    flagCount != null ? flagCount : "0",
                                    context))
                            : displays(
                                AntDesign.star,
                                'Favourite',
                                Colors.orange[300],
                                flagCount != null ? flagCount : "0",
                                context)
                      ],
                    ),
                    margin20,
                    animated
                        ? FadeAnimation(
                            2,
                            'up',
                            Text(
                              'My Lists',
                              style: Theme.of(context).textTheme.headline1,
                            ),
                          )
                        : Text(
                            'My Lists',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                    SizedBox(height: 10),
                    animated
                        ? FadeAnimation(2.5, 'fadeIn', futureList())
                        : futureList()
                  ],
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
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
                          onPressed: () {
                            showMaterialModalBottomSheet(
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(50),
                                  topLeft: Radius.circular(50),
                                ),
                              ),
                              context: context,
                              builder: (context) => Container(
                                height: 200,
                                child: Column(
                                  children: [
                                    SizedBox(height: 50),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      child: TextField(
                                        controller: categoryText,
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .iconTheme
                                                  .color,
                                              width: 2,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .iconTheme
                                                    .color,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          border: OutlineInputBorder(),
                                          hintText: 'New Category',
                                        ),
                                      ),
                                    ),
                                    margin20,
                                    ElevatedButton(
                                      child: Text(
                                        "Add Category",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.red,
                                        elevation: 0,
                                      ),
                                      onPressed: () async {
                                        if (categoryText.text.isNotEmpty) {
                                          var category = await ListService()
                                              .addCategory(categoryText.text);
                                          if (category) {
                                            Navigator.pop(context);
                                            categoryText.clear();
                                            displayDialog('Success!', context,
                                                popup, true, 'homemenu');
                                          }
                                          return;
                                        }
                                        displayDialog('Please Enter A Category',
                                            context, popup, false, 'homemenu');
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          child: Text(
                            'New Category',
                            style: Theme.of(context).textTheme.headline2,
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
                        child: Text(
                          'Add List',
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ),
                    )
                  ],
                ),
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
        if (snapshot.hasData && snapshot.data.length > 0) {
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
                        displayToast(
                            "ListName and ListId is null", context, failColor);
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
                              Navigator.pushNamed(
                                context,
                                '/addlist',
                                arguments: {
                                  'iconid': int.parse(item[index].iconid),
                                  'colorid': int.parse(item[index].colorid),
                                  'id': item[index].id,
                                  'listname': item[index].listname,
                                  'categoryid': item[index].categoryid
                                },
                              );
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
                                fetchCounts();
                                displayDialog('Success', context, popup, true,
                                    'homemenu');
                              } else {
                                displayDialog(
                                    'Fail', context, popup, false, 'homemenu');
                              }
                            },
                          ),
                        ],
                        child: Container(
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/images/dashboard.png'),
                                fit: BoxFit.fill),
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1, color: Colors.white)),
                              gradient: LinearGradient(
                                colors: [
                                  Color(
                                    int.parse(item[index].color),
                                  ).withOpacity(0.9),
                                  Color(
                                    int.parse(item[index].color),
                                  ).withOpacity(0.5)
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
        } else if (snapshot.hasData) {
          return Container(
            alignment: Alignment.center,
            child: Lottie.asset('assets/images/empty.json',
                height: 300, animate: true),
          );
        }
        return Shimmer.fromColors(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black,
            ),
            height: 200,
            width: MediaQuery.of(context).size.width,
          ),
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[400],
        );
      },
    );
  }
}
