import 'package:L1_sean/model/itemModel.dart';
import 'package:L1_sean/services/itemService.dart';
import 'package:L1_sean/utils/global.dart';
import 'package:L1_sean/widgets/arrows.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/widgets.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

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
                                  margin: EdgeInsets.only(left:20,right:10),
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
                                    checkedColor: Colors.white,
                                    checkedWidget: Icon(Icons.circle,size:20,color: Colors.black,)
                                  ),
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
                                    decoration: InputDecoration(
                                        border: InputBorder.none),
                                  ),
                                ),
                                subtitle: Text('40char\neuhfeufh\neuhfeufh\neuhfeufh\neuhfeufh',style: TextStyle(color: Colors.grey[500]),),
                                trailing: _focusedIndex != null &&
                                        _focusedIndex == index
                                    ? Icon(Icons.info)
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
    );
  }
}
