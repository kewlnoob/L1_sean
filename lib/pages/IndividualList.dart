import 'package:L1_sean/mapper/itemMapper.dart';
import 'package:L1_sean/model/itemModel.dart';
import 'package:L1_sean/pages/additem.dart';
import 'package:L1_sean/provider/userProvider.dart';
import 'package:L1_sean/services/itemService.dart';
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

class IndividualList extends StatefulWidget {
  final int listid;
  final String listname;

  const IndividualList({Key key, this.listid, this.listname}) : super(key: key);

  @override
  State<IndividualList> createState() => _IndividualListState();
}

class _IndividualListState extends State<IndividualList> {
  int _focusedIndex;
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
          title: Container(
            height: 30,
            width: 60,
            child: TextField(
              focusNode: _searchFocus,
              controller: _searchController,
              decoration: InputDecoration(
                labelText: "Search",
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                ),
              ),
            ),
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
                          child: Text('Done'),
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
                                  Text('Show Completed',
                                      style: TextStyle(fontSize: 13)),
                                  Icon(Feather.eye),
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
                          onSelected: (int value) async {},
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
            // margin20,
            Container(
              margin: EdgeInsets.only(left: 20),
              alignment: Alignment.topLeft,
              child: Text(
                '${widget.listname}',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            margin20,
            Expanded(
                child: FutureBuilder(
              future: ItemService().fetchItems(widget.listid),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
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
                          secondaryActions: [
                            IconSlideAction(
                                caption:
                                    item.isflagged ? 'Unflagged' : 'Flagged',
                                color: Colors.orange[300],
                                icon: Foundation.flag,
                                foregroundColor: Colors.white,
                                onTap: () async {
                                  var prev = item.isflagged;
                                  var flag = await ItemService()
                                      .flagItem(item.id, item.isflagged);
                                  if (flag) {
                                    setState(() {});
                                    displayToast(
                                        prev
                                            ? 'Item has been Unflagged'
                                            : 'Item has been Flagged',
                                        context,
                                        successColor);
                                  } else {
                                    displayToast(
                                        'Flagged failed', context, failColor);
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
                                  color: Colors.black,
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
                              leading: Container(
                                margin: EdgeInsets.only(left: 20, right: 10),
                                child: RoundCheckBox(
                                    isChecked: item.iscompleted,
                                    onTap: (bool value) async {
                                      var update = await ItemService()
                                          .checkItem(value, int.parse(item.id));
                                      if (update) {
                                        setState(() {
                                          item.iscompleted = value;
                                        });
                                      }
                                    },
                                    size: 25,
                                    checkedColor: backgroundColor,
                                    checkedWidget: Icon(
                                      Icons.circle,
                                      size: 20,
                                      color: Colors.black,
                                    )),
                              ),
                              title: Row(
                                children: [
                                  AbsorbPointer(
                                    child: Container(
                                      width: 200,
                                      child: TextField(
                                        key: ValueKey(item),
                                        autofocus: _focusedIndex != null &&
                                                index == _focusedIndex
                                            ? true
                                            : false,
                                        style: TextStyle(
                                            decoration: item.iscompleted
                                                ? TextDecoration.lineThrough
                                                : TextDecoration.none),
                                        controller:
                                            _text[index].textEditingController,
                                        decoration: InputDecoration(
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  item.isflagged
                                      ? Icon(Foundation.flag,
                                          color: Colors.orange[300])
                                      : Container(),
                                ],
                              ),
                              subtitle: Text(
                                item.description != null
                                    ? item.description.toString()
                                    : "",
                                style: TextStyle(color: Colors.grey[500]),
                              ),
                              trailing: _focusedIndex != null &&
                                      _focusedIndex == index
                                  ? GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(context, '/additem',
                                            arguments: {
                                              "item": item,
                                              "listname": widget.listname,
                                              "isflagged": item.isflagged,
                                            });
                                      },
                                      child: Container(
                                          margin: EdgeInsets.only(right: 20),
                                          child: Icon(Feather.info)),
                                    )
                                  : null,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }
                return CircularProgressIndicator();
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
          boxShadow: Theme.of(context).brightness == Brightness.light
              ? [
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-4, -4),
                    blurRadius: 15,
                    spreadRadius: 0.1,
                  ),
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(4, 4),
                    blurRadius: 15,
                    spreadRadius: 0.1,
                  )
                ]
              : [
                  BoxShadow(
                    color: Colors.grey[800],
                    offset: Offset(-4, -4),
                    blurRadius: 15,
                    spreadRadius: 0.1,
                  ),
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(4, 4),
                    blurRadius: 15,
                    spreadRadius: 0.1,
                  ),
                ],
        ),
        child: OpenContainer(
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
                child: Icon(Icons.add, color: Colors.white),
              );
            }),
      ),
    );
  }
}
