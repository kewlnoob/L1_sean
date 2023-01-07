import 'package:L1_sean/mapper/itemMapper.dart';
import 'package:L1_sean/model/itemModel.dart';
import 'package:L1_sean/pages/additem.dart';
import 'package:L1_sean/services/itemService.dart';
import 'package:L1_sean/utils/global.dart';
import 'package:L1_sean/utils/popup.dart';
import 'package:L1_sean/widgets/arrows.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/widgets.dart';

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
            style: TextStyle(color: Colors.black),
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
                  child: IconButton(
                    onPressed: () {},
                    color: Colors.black,
                    icon: _focusedIndex != null
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
                        : Icon(AntDesign.ellipsis1, size: 30),
                  ),
                )
              ],
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                    child: FutureBuilder(
                  future: ItemService().fetchItems(widget.listid),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var data = snapshot.data;
                      List<ItemMapper> _text = [];
                      data.forEach((item) {
                        _text.add(ItemMapper(
                            TextEditingController(text: item.name), item.id));
                      });
                      outerItems = _text;

                      return ReorderableListView(
                        onReorder: (int oldIndex, int newIndex) async {
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
                        },
                        children: data.map<Widget>((item) {
                          int index = data.indexOf(item);
                          return Slidable(
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
                                    var archive = await ItemService()
                                        .archiveItem(item.id);
                                    if (archive) {
                                      displayToast('Item archived successfully',
                                          context, successColor);
                                    } else {
                                      displayToast('Archived failed', context,
                                          failColor);
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
                                      displayToast('Item deleted successfully',
                                          context, successColor);
                                    } else {
                                      displayToast('Deletion failed', context,
                                          failColor);
                                    }
                                  }),
                            ],
                            key: ValueKey(item),
                            actionPane: SlidableDrawerActionPane(),
                            child: Container(
                              constraints: BoxConstraints(
                                minHeight: 100,
                              ),
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
                                            .checkItem(
                                                value, int.parse(item.id));
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
                                          controller: _text[index]
                                              .textEditingController,
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
                                          Navigator.pushNamed(
                                              context, '/additem', arguments: {
                                            "item": item,
                                            'listname': widget.listname
                                          });
                                        },
                                        child: Container(
                                            margin: EdgeInsets.only(right: 20),
                                            child: Icon(Feather.info)),
                                      )
                                    : null,
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
          ],
        ),
      ),
      floatingActionButton: OpenContainer(
          onClosed: (data) {
            //refresh page
            setState(() {});
          },
          transitionDuration: Duration(seconds: 1),
          closedShape: CircleBorder(),
          closedColor: primaryColor,
          openBuilder: (context, _) => AddItem(listid: widget.listid),
          closedBuilder: (context, action) {
            return Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColor,
              ),
              height: 50,
              width: 50,
              child: Icon(Icons.add, color: Colors.white),
            );
          }),
    );
  }
}
