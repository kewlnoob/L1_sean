import 'package:L1_sean/model/itemModel.dart';
import 'package:L1_sean/provider/itemProvider.dart';
import 'package:L1_sean/provider/userProvider.dart';
import 'package:L1_sean/services/itemService.dart';
import 'package:L1_sean/utils/global.dart';
import 'package:L1_sean/widgets/arrows.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';

class IndividualList extends StatefulWidget {
  final int listid;
  final String listname;

  const IndividualList({Key key, this.listid, this.listname}) : super(key: key);

  @override
  State<IndividualList> createState() => _IndividualListState();
}

class _IndividualListState extends State<IndividualList> {
  int _focusedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          leading: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [ButtonArrow(context)],
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
                            onPressed: () {
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
                      List<TextEditingController> _text = [];
                      data.forEach((item) {
                        _text.add(TextEditingController(text: item.name));
                      });
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
                            key: ValueKey(item),
                            actionPane: SlidableDrawerActionPane(),
                            child: ListTile(
                              onTap: () {
                                if (index != null) {
                                  setState(() {
                                    _focusedIndex = index;
                                  });
                                }
                              },
                              leading: Checkbox(
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
                              title: AbsorbPointer(
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
                                  controller: _text[index],
                                  decoration:
                                      InputDecoration(border: InputBorder.none),
                                ),
                              ),
                              trailing: _focusedIndex != null &&
                                      _focusedIndex == index
                                  ? Icon(Icons.info)
                                  : null,
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
            Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin:
                            EdgeInsets.only(bottom: 20, right: 20, left: 20),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0, 0),
                                  blurRadius: 8,
                                  spreadRadius: 0)
                            ],
                            borderRadius: BorderRadius.circular(10)),
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: 'Add New Item',
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(15)),
                      height: 60,
                      width: 60,
                      margin: EdgeInsets.only(bottom: 20, right: 20),
                      child: BouncingWidget(
                          duration: Duration(milliseconds: 100),
                          scaleFactor: 1.5,
                          onPressed: () {
                            print("onPressed");
                          },
                          child: Icon(Ionicons.add_outline,
                              size: 40, color: Colors.white)),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.grey[400];
    }
    return Colors.black;
  }
}
