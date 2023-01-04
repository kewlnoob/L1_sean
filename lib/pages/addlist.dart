import 'package:L1_sean/model/colorModel.dart';
import 'package:L1_sean/model/iconModel.dart';
import 'package:L1_sean/provider/userProvider.dart';
import 'package:L1_sean/utils/global.dart';
import 'package:L1_sean/widgets/arrows.dart';
import 'package:flutter/material.dart';
import 'package:L1_sean/services/listService.dart';
import 'package:L1_sean/utils/popup.dart';
import 'package:provider/provider.dart';

class AddList extends StatefulWidget {
  final String id;
  final int iconid;
  final int colorid;
  final String listname;

  const AddList({Key key, this.id, this.iconid, this.colorid, this.listname})
      : super(key: key);
  @override
  State<AddList> createState() => _AddListState();
}

class _AddListState extends State<AddList> with SingleTickerProviderStateMixin {
  final myController = TextEditingController();
  AnimationController controller;

  int selectedColorIndex;
  int selectedIconIndex;
  List<ColorModel> colorlist;
  var iconlist;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    colorlist = Provider.of<UserProvider>(context, listen: false).colorList;
    iconlist = Provider.of<UserProvider>(context, listen: false).iconList;
    if (widget.id != null) {
      selectedIconIndex = widget.iconid - 1;
      selectedColorIndex = widget.colorid - 1;
      myController.text = widget.listname;
    }
    controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pop(context);
        controller.reset();
      }
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(30.0),
          child: AppBar(
            leading: ButtonArrow(context,'home'),
            elevation: 0,
            flexibleSpace: Container(),
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: Colors.black),
            actions: [
              GestureDetector(
                onTap: () async {
                  if (myController.text != null &&
                      selectedColorIndex != null &&
                      selectedIconIndex != null) {
                    if (widget.id != null) {
                      print("Color: " + selectedColorIndex.toString());
                      print("Icon: " + selectedIconIndex.toString());
                      var editList = await ListService().editList(
                          widget.id,
                          myController.text,
                          selectedColorIndex + 1,
                          selectedIconIndex + 1);
                      if (editList) {
                        displayDialog('Success!', context, controller, true,'addlist');
                      } else {
                        displayDialog('Failed!', context, controller, false,'addlist');
                      }
                    } else {
                      var addList = await ListService().addList(
                          myController.text,
                          selectedIconIndex + 1,
                          selectedColorIndex + 1);

                      if (addList) {
                        displayDialog('Success!', context, controller, true, 'addlist');
                      } else {
                        displayDialog('Failed!', context, controller, false,'addlist');
                      }
                    }
                  } else {
                    displayToast("There must be a name,icon and color", context,
                        failColor);
                  }
                },
                child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.check,
                      size: 30,
                      color: myController.text != null &&
                              selectedColorIndex != null &&
                              selectedIconIndex != null
                          ? Colors.black
                          : Colors.grey,
                    )),
              )
            ],
          ),
        ),
        body: SafeArea(
          child: Padding(
              padding: EdgeInsets.all(20),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
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
                            margin20,
                            Container(
                              width: 85,
                              height: 85,
                              decoration: BoxDecoration(
                                  color: selectedColorIndex != null
                                      ? Color(int.parse(
                                          colorlist[selectedColorIndex].color))
                                      : Colors.blue,
                                  shape: BoxShape.circle),
                              child: Icon(
                                selectedIconIndex != null
                                    ? IconData(
                                        int.parse(
                                            iconlist[selectedIconIndex].icon),
                                        fontFamily: 'MaterialIcons')
                                    : Icons.menu,
                                color: Colors.white,
                                size: 60,
                              ),
                            ),
                            margin20,
                            Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              height: MediaQuery.of(context).size.height * 0.08,
                              child: TextField(
                                textAlign: TextAlign.center,
                                controller: myController,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 2),
                                  ),
                                  hintStyle: TextStyle(
                                      fontSize: 20.0,
                                      color: selectedColorIndex != null
                                          ? Color(int.parse(
                                              colorlist[selectedColorIndex]
                                                  .color))
                                          : Colors.white,
                                      fontWeight: FontWeight.bold),
                                  hintText: "List Name",
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                style: TextStyle(
                                    color: selectedColorIndex != null
                                        ? Color(int.parse(
                                            colorlist[selectedColorIndex]
                                                .color))
                                        : Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      margin20,
                      Container(
                        constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height * 0.10,
                        ),
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: FutureBuilder(
                          future: ListService().fetchColors(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return GridView.builder(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemCount: snapshot.data.length,
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 5,
                                        childAspectRatio: 1.1),
                                itemBuilder: (BuildContext context, int index) {
                                  ColorModel colorModel = snapshot.data[index];
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: index == selectedColorIndex
                                                  ? Colors.white
                                                  : Color(int.parse(
                                                      colorModel.color)),
                                              width: 2.0),
                                          color: Color(
                                              int.parse(colorModel.color)),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Material(
                                          color: Color(
                                              int.parse(colorModel.color)),
                                          shape: const CircleBorder(),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            onTap: () {
                                              setState(() {
                                                selectedColorIndex = index;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                            return CircularProgressIndicator();
                          },
                        ),
                      ),
                      margin20,
                      Container(
                          constraints: BoxConstraints(
                            minHeight: MediaQuery.of(context).size.height * 0.5,
                          ),
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: FutureBuilder(
                              future: ListService().fetchIcons(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return GridView.builder(
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    itemCount: snapshot.data.length,
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 5,
                                            childAspectRatio: 1.1),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      IconModel iconModel =
                                          snapshot.data[index];
                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color:
                                                      index == selectedIconIndex
                                                          ? Colors.white
                                                          : Colors.transparent,
                                                  width: 2.0),
                                            ),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              onTap: () {
                                                setState(() {
                                                  selectedIconIndex = index;
                                                });
                                              },
                                              child: Icon(
                                                IconData(
                                                    int.parse(iconModel.icon),
                                                    fontFamily:
                                                        'MaterialIcons'),
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                                return CircularProgressIndicator();
                              })),
                    ],
                  ),
                ),
              )),
        ));
  }
}
