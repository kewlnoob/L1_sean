import 'package:L1_sean/model/categoryModel.dart';
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
  final String categoryid;

  const AddList({Key key, this.id, this.iconid, this.colorid, this.listname,this.categoryid})
      : super(key: key);
  @override
  State<AddList> createState() => _AddListState();
}

class _AddListState extends State<AddList> with SingleTickerProviderStateMixin {
  final myController = TextEditingController();
  AnimationController controller;
  bool _isPanDown = false;
  int selectedColorIndex;
  int selectedIconIndex;
  List<ColorModel> colorlist;
  List<IconModel> iconlist;
  List<CategoryModel> categorylist;
  String selectedCategory;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    colorlist = Provider.of<UserProvider>(context, listen: false).colorList;
    iconlist = Provider.of<UserProvider>(context, listen: false).iconList;
    // categorylist = Provider.of<UserProvider>(context, listen: false).categoryList;
    if (widget.id != null) {
      selectedIconIndex = widget.iconid - 1;
      selectedColorIndex = widget.colorid - 1;
      myController.text = widget.listname;
      selectedCategory = widget.categoryid;
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
            leading: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ButtonArrow(context, 'home')],
            ),
            elevation: 0,
            flexibleSpace: Container(),
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: Colors.black),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      if (myController.text != null &&
                          selectedColorIndex != null &&
                          selectedIconIndex != null && selectedCategory != null) {
                        if (widget.id != null) {
                          var editList = await ListService().editList(
                              widget.id,
                              myController.text,
                              selectedColorIndex + 1,
                              selectedIconIndex + 1,
                              selectedCategory);
                          if (editList) {
                            displayDialog('Success!', context, controller, true,
                                'addlist');
                          } else {
                            displayDialog('Failed!', context, controller, false,
                                'addlist');
                          }
                        } else {
                          var addList = await ListService().addList(
                              myController.text,
                              selectedIconIndex + 1,
                              selectedColorIndex + 1,
                              selectedCategory);

                          if (addList) {
                            displayDialog('Success!', context, controller, true,
                                'addlist');
                          } else {
                            displayDialog('Failed!', context, controller, false,
                                'addlist');
                          }
                        }
                      } else {
                        displayToast("There must be a name,icon,color & category",
                            context, failColor);
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 10, top: 5),
                      child: Icon(
                        Icons.check,
                        size: 30,
                        color: myController.text != null &&
                                selectedColorIndex != null &&
                                selectedIconIndex != null
                            ? Theme.of(context).iconTheme.color
                            : Colors.white,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
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
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? mainBGLightColor
                                    : mainBGDarkColor,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow:
                                Theme.of(context).brightness == Brightness.light
                                    ? [
                                        MyShadows.primaryLightShadow,
                                        MyShadows.secondaryLightShadow
                                      ]
                                    : [
                                        MyShadows.primaryDarkShadow,
                                        MyShadows.secondaryDarkShadow
                                      ],
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
                                            colorlist[selectedColorIndex]
                                                .color))
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
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
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
                        FutureBuilder(
                          future: ListService().fetchCategory(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? mainBGLightColor
                                      : mainBGDarkColor,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? [
                                          MyShadows.primaryLightShadow,
                                          MyShadows.secondaryLightShadow
                                        ]
                                      : [
                                          MyShadows.primaryDarkShadow,
                                          MyShadows.secondaryDarkShadow
                                        ],
                                ),
                                width: MediaQuery.of(context).size.width,
                                child: DropdownButtonHideUnderline(
                                  child: ButtonTheme(
                                    alignedDropdown: true,
                                    child: DropdownButton(
                                      hint: Text('Select a category'),
                                      isExpanded: true,
                                      value: selectedCategory,
                                      items: snapshot.data
                                          .map<DropdownMenuItem<String>>(
                                              (category) {
                                        return DropdownMenuItem<String>(
                                          child: Text(category.categoryName),
                                          value: category.categoryId,
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectedCategory = newValue;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              );
                            }
                            return Container();
                          },
                        ),
                        margin20,
                        Container(
                          constraints: BoxConstraints(
                            minHeight:
                                MediaQuery.of(context).size.height * 0.10,
                          ),
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? mainBGLightColor
                                    : mainBGDarkColor,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow:
                                Theme.of(context).brightness == Brightness.light
                                    ? [
                                        MyShadows.primaryLightShadow,
                                        MyShadows.secondaryLightShadow
                                      ]
                                    : [
                                        MyShadows.primaryDarkShadow,
                                        MyShadows.secondaryDarkShadow
                                      ],
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
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    ColorModel colorModel =
                                        snapshot.data[index];
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color:
                                                    index == selectedColorIndex
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
                        margin20,
                        Container(
                            constraints: BoxConstraints(
                              minHeight:
                                  MediaQuery.of(context).size.height * 0.3,
                            ),
                            decoration: BoxDecoration(
                              boxShadow: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? [
                                      MyShadows.primaryLightShadow,
                                      MyShadows.secondaryLightShadow
                                    ]
                                  : [
                                      MyShadows.primaryDarkShadow,
                                      MyShadows.secondaryDarkShadow
                                    ],
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? mainBGLightColor
                                  : mainBGDarkColor,
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
                                                    color: index ==
                                                            selectedIconIndex
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
          ),
        ));
  }
}
