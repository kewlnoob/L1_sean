import 'package:L1_sean/model/categoryModel.dart';
import 'package:L1_sean/model/itemModel.dart';
import 'package:L1_sean/model/listModel.dart';
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
import 'package:lottie/lottie.dart';

class Display extends StatefulWidget {
  final String page;
  const Display({Key key, this.page}) : super(key: key);
  @override
  State<Display> createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  List<String> listIds = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<List<ItemModel>> ItemsBasedOnPageName(String id) async {
    switch (widget.page) {
      case "All":
        return await ListService().fetchItemsByList(id);
        break;
      case "Archived":
        return await ListService().fetchArchiveList(id);
        break;
      case "Completed":
        return await ListService().fetchCompleteList(id);
        break;
      case "Favourite":
        return await ListService().fetchFavourite(id);
        break;
    }
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          centerTitle: true,
          title: Text(
            widget.page,
            style: Theme.of(context).textTheme.headline2,
          ),
          leading: ButtonArrow(context, 'home'),
          elevation: 0,
          flexibleSpace: Container(),
          backgroundColor: Colors.transparent,
          iconTheme: Theme.of(context).brightness == Brightness.light
              ? IconThemeData(color: mainBGDarkColor)
              : IconThemeData(color: mainBGLightColor),
          actions: [
            AppPopupMenu(
              menuItems: [
                PopupMenuItem(
                  value: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Delete All Lists', style: TextStyle(fontSize: 13)),
                      Icon(
                        MaterialCommunityIcons.delete,
                        color: redColor,
                      ),
                    ],
                  ),
                ),
              ],
              onSelected: (int value) async {
                if (value == 1) {
                  var delete = await ItemService().deleteUserLists();
                  if (delete) {
                    setState(() {});
                    displayToast("All Lists Deleted", context, successColor);
                  } else {
                    displayToast("Deletion failed", context, failColor);
                  }
                }
              },
              onCanceled: () {},
              tooltip: "tooltip",
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
                  future: ListService().fetchUserCategories(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data.length == 0) {
                      return Container(
                        alignment: Alignment.center,
                        child: Lottie.asset('assets/images/empty.json',
                            height: 500, animate: true),
                      );
                    } else if (snapshot.hasData && snapshot.data.length > 0) {
                      List<CategoryModel> categories = snapshot.data;
                      return ListView.builder(
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return ExpansionTile(
                            title: Text(
                              categories[index].categoryName,
                              style: Theme.of(context).textTheme.headline1,
                            ),
                            children: [
                              FutureBuilder(
                                future: ListService().fetchListByCategory(
                                    categories[index].categoryId,widget.page),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    List<ListModel> list = snapshot.data;
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      physics: ClampingScrollPhysics(),
                                      itemCount: list.length,
                                      itemBuilder: (context, index) {
                                        return ExpansionTile(
                                          title: Row(
                                            children: [
                                              SizedBox(width: 30),
                                              Text(
                                                list[index].listname,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline2,
                                              ),
                                            ],
                                          ),
                                          children: [
                                            FutureBuilder(
                                              future: ItemsBasedOnPageName(
                                                  list[index].id),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  List<ItemModel> items =
                                                      snapshot.data;
                                                  return ListView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        ClampingScrollPhysics(),
                                                    itemCount: items.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Slidable(
                                                        key: ValueKey(
                                                            items[index].id),
                                                        secondaryActions: [
                                                          IconSlideAction(
                                                              caption: items[
                                                                          index]
                                                                      .isarchive
                                                                  ? 'Unarchived'
                                                                  : 'Archived',
                                                              color: Colors
                                                                  .blueAccent,
                                                              icon: Entypo
                                                                  .archive,
                                                              onTap: () async {
                                                                if (items[index]
                                                                    .isarchive) {
                                                                  var archive =
                                                                      await ItemService()
                                                                          .unarchiveItem(
                                                                              items[index].id);
                                                                  if (archive) {
                                                                    setState(
                                                                        () {});
                                                                    displayToast(
                                                                        'Item unrchived successfully',
                                                                        context,
                                                                        successColor);
                                                                  } else {
                                                                    displayToast(
                                                                        'Unarchived failed',
                                                                        context,
                                                                        failColor);
                                                                  }
                                                                } else {
                                                                  var archive =
                                                                      await ItemService()
                                                                          .archiveItem(
                                                                              items[index].id);
                                                                  if (archive) {
                                                                    setState(
                                                                        () {});
                                                                    displayToast(
                                                                        'Item archived successfully',
                                                                        context,
                                                                        successColor);
                                                                  } else {
                                                                    displayToast(
                                                                        'Archived failed',
                                                                        context,
                                                                        failColor);
                                                                  }
                                                                }
                                                              }),
                                                          IconSlideAction(
                                                              foregroundColor:
                                                                  Colors.white,
                                                              caption: items[
                                                                          index]
                                                                      .isfavourite
                                                                  ? 'Unfavourite'
                                                                  : 'Favourite',
                                                              color: Colors
                                                                  .orange[300],
                                                              icon: AntDesign
                                                                  .star,
                                                              onTap: () async {
                                                                var prev = items[
                                                                        index]
                                                                    .isfavourite;
                                                                var favourite = await ItemService().favouriteItem(
                                                                    items[index]
                                                                        .id,
                                                                    items[index]
                                                                        .isfavourite);
                                                                if (favourite) {
                                                                  setState(
                                                                      () {});
                                                                  displayToast(
                                                                      prev
                                                                          ? 'Item has been Favourite'
                                                                          : 'Item has been Unfavourite',
                                                                      context,
                                                                      successColor);
                                                                } else {
                                                                  displayToast(
                                                                      'Favourite failed',
                                                                      context,
                                                                      failColor);
                                                                }
                                                              }),
                                                          IconSlideAction(
                                                              caption: 'Delete',
                                                              color: redColor,
                                                              icon:
                                                                  MaterialCommunityIcons
                                                                      .delete,
                                                              onTap: () async {
                                                                var delete = await ItemService()
                                                                    .deleteItem(
                                                                        items[index]
                                                                            .id);
                                                                if (delete) {
                                                                  setState(
                                                                      () {});
                                                                  displayToast(
                                                                      "Successfully deleted item",
                                                                      context,
                                                                      successColor);
                                                                } else {
                                                                  displayToast(
                                                                      "Deletion failed",
                                                                      context,
                                                                      failColor);
                                                                }
                                                              }),
                                                        ],
                                                        actionPane:
                                                            SlidableDrawerActionPane(),
                                                        child: ListTile(
                                                          leading: Checkbox(
                                                            checkColor:
                                                                Colors.white,
                                                            value: items[index]
                                                                .iscompleted,
                                                            onChanged: (bool
                                                                value) async {
                                                              var update = await ItemService()
                                                                  .checkItem(
                                                                      value,
                                                                      int.parse(
                                                                          items[index]
                                                                              .id));
                                                              if (update) {
                                                                setState(() {
                                                                  items[index]
                                                                          .iscompleted =
                                                                      value;
                                                                });
                                                              }
                                                            },
                                                          ),
                                                          title: Row(
                                                            children: [
                                                              Text(
                                                                items[index]
                                                                    .name,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .headline3,
                                                              ),
                                                            ],
                                                          ),
                                                          trailing: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              items[index].priorityid ==
                                                                      "1"
                                                                  ? Container(
                                                                      width: 1)
                                                                  : displayText(
                                                                      items[index]
                                                                          .priorityid),
                                                              items[index]
                                                                      .isfavourite
                                                                  ? Container(
                                                                      width: 50,
                                                                      child:
                                                                          Icon(
                                                                        AntDesign
                                                                            .star,
                                                                        color: Colors
                                                                            .orange[300],
                                                                      ),
                                                                    )
                                                                  : Container(
                                                                      width:
                                                                          50),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                }
                                                return Container();
                                              },
                                            )
                                          ],
                                        );
                                      },
                                    );
                                  }
                                  return CircularProgressIndicator();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                    return Container();
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
