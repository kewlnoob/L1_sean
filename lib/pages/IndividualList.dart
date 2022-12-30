import 'package:L1_sean/utils/global.dart';
import 'package:L1_sean/widgets/arrows.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class IndividualList extends StatefulWidget {
  @override
  State<IndividualList> createState() => _IndividualListState();
}

class MyObject {
  final String title;
  final String description;
  bool isChecked;
  MyObject({this.title, this.description, this.isChecked});
}

class _IndividualListState extends State<IndividualList> {
  FocusNode _focusNode;
  int _focusedIndex;
  final List<MyObject> myObjects = [
    MyObject(
        title: 'Object 1', description: 'This is object 1', isChecked: false),
    MyObject(
        title: 'Object 2', description: 'This is object 2', isChecked: false),
    MyObject(
        title: 'Object 3', description: 'This is object 3', isChecked: false),
  ];
  final List<FocusNode> focusNodes = [];
  final List<TextEditingController> _textEditingControllers = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusNode = FocusNode();
    myObjects.forEach((item) {
      _textEditingControllers.add(TextEditingController(text: item.title));
      focusNodes.add(FocusNode());
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    for (int i = 0; i < focusNodes.length; i++) {
      focusNodes[i].dispose();
    }
  }

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
            'LOL',
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
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    color: Colors.black,
                    icon: _focusedIndex != null
                        ? TextButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
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
                  child: ReorderableListView(
                    children: myObjects.asMap().entries.map((object) {
                      int index = object.key;
                      return Slidable(
                        key: ValueKey(object.value),
                        actionPane: SlidableDrawerActionPane(),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _focusedIndex = index;
                            });
                            focusNodes[index].requestFocus((FocusNode()));
                          },
                          child: ListTile(
                            leading: Checkbox(
                              value: object.value.isChecked,
                              onChanged: (bool value) {
                                setState(() {
                                  object.value.isChecked = value;
                                });
                              },
                            ),
                            title: AbsorbPointer(
                              child: TextField(
                                focusNode: focusNodes[index],
                                style: TextStyle(
                                    decoration: object.value.isChecked
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none),
                                controller: _textEditingControllers[index],
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                              ),
                            ),
                            subtitle: Text(
                              'Description',
                              style: TextStyle(
                                  decoration: object.value.isChecked
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none),
                            ),
                            trailing: _focusedIndex == index
                                ? Icon(Icons.info)
                                : null,
                          ),
                        ),
                        // Add the desired Slidable actions here
                      );
                    }).toList(),
                    onReorder: (oldIndex, newIndex) {
                      setState(() {
                        if (newIndex > oldIndex) {
                          newIndex -= 1;
                        }
                        final MyObject item = myObjects.removeAt(oldIndex);
                        myObjects.insert(newIndex, item);
                        var text1 = _textEditingControllers[newIndex].text;
                        var text2 = _textEditingControllers[oldIndex].text;
                        _textEditingControllers[newIndex].text = text2;
                        _textEditingControllers[oldIndex].text = text1;
                        text1 = null;
                        text2 = null;
                      });
                    },
                  ),
                ),
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
