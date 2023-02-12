import 'package:L1_sean/mapper/itemMapper.dart';
import 'package:L1_sean/model/itemModel.dart';
import 'package:L1_sean/pages/additem.dart';
import 'package:L1_sean/provider/userProvider.dart';
import 'package:L1_sean/services/itemService.dart';
import 'package:L1_sean/services/listService.dart';
import 'package:L1_sean/utils/global.dart';
import 'package:L1_sean/utils/popup.dart';
import 'package:L1_sean/widgets/arrows.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/widgets.dart';
import 'package:app_popup_menu/app_popup_menu.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:animations/animations.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

class IndividualList extends StatefulWidget {
  final int listid;
  final String listname;

  const IndividualList({Key key, this.listid, this.listname}) : super(key: key);

  @override
  State<IndividualList> createState() => _IndividualListState();
}

class _IndividualListState extends State<IndividualList> {
  int _focusedIndex;
  bool hideCompleted = false;
  List<ItemMapper> outerItems = [];
  final TextEditingController _searchController = TextEditingController();
  String _searchText = "";
  final FocusNode _searchFocus = FocusNode();
  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text;
      });
    });
  }

  Widget displayText(String id) {
    switch (id) {
      case "2":
        return Container(
          width: 60,
          child: Text(
            'Low',
            style: Theme.of(context).textTheme.headline3,
          ),
        );
        break;
      case "3":
        return Container(
          width: 60,
          child: Text(
            'Medium',
            style: Theme.of(context).textTheme.headline3,
          ),
        );
        break;
      case "4":
        return Container(
          width: 60,
          child: Text(
            'High',
            style: Theme.of(context).textTheme.headline3,
          ),
        );
        break;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          leading: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [ButtonArrow(context, 'home')],
          ),
          elevation: 0,
          title: Text(
            '${widget.listname}',
            style: Theme.of(context).textTheme.headline2,
          ),
          centerTitle: true,
          flexibleSpace: Container(),
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 70,
                  child: _focusedIndex != null
                      ? TextButton(
                          onPressed: () async {
                            var update = await ItemService().updateName(
                                outerItems[_focusedIndex]
                                    .textEditingController
                                    .text,
                                outerItems[_focusedIndex].id);
                            if (!update) {
                              displayToast(
                                  "Update Name Failed", context, failColor);
                            }
                            setState(() {
                              _focusedIndex = null;
                            });
                          },
                          child: Text(
                            'Done',
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        )
                      : AppPopupMenu(
                          offset: const Offset(0, 200),
                          onCanceled: () {},
                          tooltip: "Here's a tip for you.",
                          elevation: 12,
                          icon: Icon(Ionicons.ellipsis_vertical_sharp,
                              color: Theme.of(context).iconTheme.color),
                          menuItems: [
                            PopupMenuItem(
                              value: 1,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      hideCompleted
                                          ? 'Hide Completed'
                                          : 'Show Completed',
                                      style: TextStyle(fontSize: 13)),
                                  hideCompleted
                                      ? Icon(Feather.eye_off)
                                      : Icon(Feather.eye),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: 2,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Delete Items',
                                      style: TextStyle(fontSize: 13)),
                                  Icon(
                                    MaterialCommunityIcons.delete,
                                    color: redColor,
                                  ),
                                ],
                              ),
                            ),
                          ],
                          onSelected: (int value) async {
                            switch (value) {
                              case 1:
                                setState(() {
                                  hideCompleted = !hideCompleted;
                                });
                                break;
                              case 2:
                                var delete = await ItemService()
                                    .deleteItemsBasedOnList(widget.listid);
                                if (delete) {
                                  displayToast("All items deleted", context,
                                      successColor);
                                } else {
                                  displayToast("Unable to delete items",
                                      context, failColor);
                                }
                                break;
                            }
                          },
                        ),
                )
              ],
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 30,
              width: 200,
              child: Align(
                alignment: Alignment.center,
                child: TextField(
                  focusNode: _searchFocus,
                  controller: _searchController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(25.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            margin20,
            Expanded(
                child: FutureBuilder(
              future: hideCompleted
                  ? ItemService().fetchItems(widget.listid, 'show')
                  : ItemService().fetchItems(widget.listid, 'hide'),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data.length > 0) {
                  List<ItemModel> data = snapshot.data;
                  List<ItemMapper> _text = [];
                  data.forEach((item) {
                    _text.add(ItemMapper(
                        TextEditingController(text: item.name), item.id));
                  });
                  outerItems = _text;
                  return ReorderableListView(
                    onReorder: (int oldIndex, int newIndex) async {
                      if (_searchText.isEmpty) {
                        setState(() {
                          if (newIndex > oldIndex) {
                            newIndex -= 1;
                          }
                          final ItemModel item = data.removeAt(oldIndex);
                          data.insert(newIndex, item);
                          for (var i = 0; i < data.length; i++) {
                            data[i].position = i.toString();
                          }
                        });
                        ItemService().reorderItem(data);
                      }
                    },
                    children: data
                        .where((item) => item.name
                            .toLowerCase()
                            .contains(_searchText.toLowerCase()))
                        .map<Widget>((item) {
                      int index = data.indexOf(item);
                      return Container(
                        height: 70,
                        key: ValueKey(item),
                        child: Slidable(
                          key: ValueKey(item),
                          secondaryActions: [
                            IconSlideAction(
                                caption: item.isfavourite
                                    ? 'Unfavourite'
                                    : 'Favourite',
                                color: Colors.orange[300],
                                icon: AntDesign.star,
                                foregroundColor: Colors.white,
                                onTap: () async {
                                  var prev = item.isfavourite;
                                  var favourite = await ItemService()
                                      .favouriteItem(item.id, item.isfavourite);
                                  if (favourite) {
                                    setState(() {});
                                    displayToast(
                                        prev
                                            ? 'Item has been Unfavourite'
                                            : 'Item has been Favourite',
                                        context,
                                        successColor);
                                  } else {
                                    displayToast(
                                        'Favourite failed', context, failColor);
                                  }
                                }),
                            IconSlideAction(
                                caption: 'Archived',
                                color: Colors.blueAccent,
                                icon: Entypo.archive,
                                onTap: () async {
                                  var archive =
                                      await ItemService().archiveItem(item.id);
                                  if (archive) {
                                    setState(() {});
                                    displayToast('Item archived successfully',
                                        context, successColor);
                                  } else {
                                    displayToast(
                                        'Archived failed', context, failColor);
                                  }
                                }),
                            IconSlideAction(
                                caption: 'Delete',
                                color: redColor,
                                icon: MaterialCommunityIcons.delete,
                                onTap: () async {
                                  var delete =
                                      await ItemService().deleteItem(item.id);
                                  if (delete) {
                                    setState(() {});
                                    displayToast('Item deleted successfully',
                                        context, successColor);
                                  } else {
                                    displayToast(
                                        'Deletion failed', context, failColor);
                                  }
                                }),
                          ],
                          actionPane: SlidableDrawerActionPane(),
                          child: Container(
                            // constraints: BoxConstraints(
                            //   minHeight: 70,
                            // ),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Theme.of(context).iconTheme.color,
                                  width: 1,
                                ),
                              ),
                            ),
                            child: ListTile(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 0),
                              onTap: () {
                                _searchFocus.unfocus();
                                if (index != null) {
                                  setState(() {
                                    _focusedIndex = index;
                                  });
                                }
                              },
                              leading: Checkbox(
                                checkColor: Colors.white,
                                value: item.iscompleted,
                                onChanged: (bool value) async {
                                  var update = await ItemService()
                                      .checkItem(value, int.parse(item.id));
                                  if (update) {
                                    setState(() {
                                      item.iscompleted = value;
                                    });
                                  }
                                },
                              ),
                              title: Row(
                                children: [
                                  AbsorbPointer(
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 200,
                                      child: TextField(
                                        key: ValueKey(item),
                                        autofocus: _focusedIndex != null &&
                                                index == _focusedIndex
                                            ? true
                                            : false,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2,
                                        controller:
                                            _text[index].textEditingController,
                                        decoration: InputDecoration(
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ),
                                  item.priorityid == "1"
                                      ? Container(width: 1)
                                      : displayText(item.priorityid),
                                  item.isfavourite
                                      ? Icon(AntDesign.star,
                                          color: Colors.orange[300])
                                      : Container(),
                                ],
                              ),
                              trailing: _focusedIndex != null &&
                                      _focusedIndex == index
                                  ? GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(context, '/additem',
                                            arguments: {
                                              "item": item,
                                              "listname": widget.listname,
                                              "isfavourite": item.isfavourite,
                                              "priorityid": item.priorityid,
                                              "pname": item.pname
                                            });
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(right: 20),
                                        child: Icon(Feather.info),
                                      ),
                                    )
                                  : null,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                } else if (snapshot.hasData) {
                  return Container(
                    alignment: Alignment.center,
                    child: Lottie.asset('assets/images/empty.json',
                        height: 500, animate: true),
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
                    highlightColor: Colors.grey[400]);
              },
            )),
          ],
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).brightness == Brightness.light
                ? mainBGLightColor
                : mainBGDarkColor,
            border:
                Border.all(color: Theme.of(context).iconTheme.color, width: 2)),
        child: OpenContainer(
            openElevation: 0,
            closedElevation: 0,
            onClosed: (data) {
              //refresh page
              setState(() {});
            },
            transitionDuration: Duration(seconds: 1),
            closedShape: CircleBorder(),
            closedColor: Theme.of(context).brightness == Brightness.light
                ? mainBGLightColor
                : mainBGDarkColor,
            openBuilder: (context, _) => AddItem(listid: widget.listid),
            closedBuilder: (context, action) {
              return Container(
                height: 50,
                width: 50,
                child:
                    Icon(Icons.add, color: Theme.of(context).iconTheme.color),
              );
            }),
      ),
    );
  }
}
