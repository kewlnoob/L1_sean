import 'package:L1_sean/services/itemService.dart';
import 'package:L1_sean/services/listService.dart';
import 'package:L1_sean/utils/global.dart';
import 'package:L1_sean/utils/popup.dart';
import 'package:L1_sean/widgets/arrows.dart';
import 'package:flutter/material.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:app_popup_menu/app_popup_menu.dart';

class Archived extends StatefulWidget {
  @override
  State<Archived> createState() => _ArchivedState();
}

class _ArchivedState extends State<Archived> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          leading: ButtonArrow(context, 'home'),
          elevation: 0,
          flexibleSpace: Container(),
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black),
          actions: [
            AppPopupMenu(
              menuItems: [
                PopupMenuItem(
                  value: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Delete Archive Items', style: TextStyle(fontSize: 13)),
                      Icon(
                        MaterialCommunityIcons.delete,
                        color: redColor,
                      ),
                    ],
                  ),
                ),
              ],
              // initialValue: 2,
              onSelected: (int value) async {
                if (value == 1) {
                  var delete = await ItemService().deleteArchiveItems();
                  if (delete) {
                    setState(() {});
                    displayToast("All Archive Items Deleted", context, successColor);
                  } else {
                    displayToast("Deletion failed", context, failColor);
                  }
                }
              },
              onCanceled: () {},
              tooltip: "Here's a tip for you.",
              elevation: 12,
              icon: const Icon(Ionicons.ellipsis_vertical_sharp),
              offset: const Offset(0, 200),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder(
                  future: ListService().fetchArchiveList(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var list = snapshot.data;
                      return GroupListView(
                        sectionsCount: list.length,
                        groupHeaderBuilder:
                            (BuildContext context, int section) {
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: Text(
                                    list[section].name,
                                    textAlign: TextAlign.start,
                                    style: secondaryText,
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                        countOfItemInSection: (int section) {
                          return list[section].items.length;
                        },
                        itemBuilder: (BuildContext context, IndexPath index) {
                          var description = list[index.section]
                              .items[index.index]
                              .description;
                          List<String> lines = description.split("\n");
                          var newLineCount = description.split("\n").length - 1;
                          return Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Slidable(
                                secondaryActions: [
                                  IconSlideAction(
                                      caption: 'Unarchived',
                                      color: Colors.blueAccent,
                                      icon: Entypo.archive,
                                      onTap: () async {
                                        var unarchive = await ItemService()
                                            .unarchiveItem(list[index.section]
                                                .items[index.index]
                                                .id);
                                        if (unarchive) {
                                          setState(() {});
                                          displayToast(
                                              "Item has been unarchived",
                                              context,
                                              failColor);
                                        } else {
                                          displayToast("Unarchive failed",
                                              context, failColor);
                                        }
                                      }),
                                  IconSlideAction(
                                      caption: 'Delete',
                                      color: redColor,
                                      icon: MaterialCommunityIcons.delete,
                                      onTap: () async {
                                        var delete = await ItemService()
                                            .deleteItem(list[index.section]
                                                .items[index.index]
                                                .id
                                                .toString());
                                        if (delete) {
                                          setState(() {});
                                          displayToast(
                                              "Successfully deleted item",
                                              context,
                                              successColor);
                                        } else {
                                          displayToast("Deletion failed",
                                              context, failColor);
                                        }
                                      }),
                                ],
                                key: ValueKey(index.index),
                                actionPane: SlidableDrawerActionPane(),
                                child: Material(
                                  elevation: 10,
                                  child: Container(
                                    padding: EdgeInsets.all(15),
                                    constraints: BoxConstraints(
                                      minHeight: 110,
                                      maxHeight: 110,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: RoundCheckBox(
                                            size: 20,
                                            isChecked: list[index.section]
                                                .items[index.index]
                                                .iscompleted,
                                            onTap: (bool value) async {
                                              var update = await ItemService()
                                                  .checkItem(
                                                      value,
                                                      int.parse(list[
                                                              index.section]
                                                          .items[index.index]
                                                          .id));
                                              if (update) {
                                                setState(() {
                                                  list[index.section]
                                                      .items[index.index]
                                                      .iscompleted = value;
                                                });
                                              }
                                            },
                                            uncheckedColor: backgroundColor,
                                            checkedColor: backgroundColor,
                                            checkedWidget: Icon(
                                              Icons.circle,
                                              size: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                list[index.section]
                                                    .items[index.index]
                                                    .name,
                                                style: secondaryText,
                                              ),
                                              Text(
                                                newLineCount > 1
                                                    ? lines[0] +
                                                        "\n" +
                                                        lines[1] +
                                                        "\n..."
                                                    : description,
                                                style: thirdGreyText,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 20),
                        // sectionSeparatorBuilder: (context, section) =>
                        //     SizedBox(height: 10),
                      );
                    }
                    return CircularProgressIndicator();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
