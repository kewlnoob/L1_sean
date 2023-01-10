import 'package:L1_sean/model/itemModel.dart';
import 'package:L1_sean/provider/userProvider.dart';
import 'package:L1_sean/services/itemService.dart';
import 'package:L1_sean/utils/global.dart';
import 'package:L1_sean/utils/popup.dart';
import 'package:L1_sean/widgets/arrows.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class AddItem extends StatefulWidget {
  final int listid;
  final ItemModel item;
  final String listname;
  final bool isflagged;
  const AddItem({this.listid, this.item, this.listname, this.isflagged});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  bool _back = false;
  bool _check = false;
  bool isFlagged = false;
  var nameController = TextEditingController();
  var descController = TextEditingController();
  var urlController = TextEditingController();
  @override
  void initState() {
    // edit item
    if (widget.item != null &&
        widget.listid == null &&
        widget.listname != null &&
        widget.isflagged != null) {
      nameController.text = widget.item.name;
      descController.text = widget.item.description;
      urlController.text = widget.item.url;
      isFlagged = widget.isflagged;
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    descController.dispose();
    urlController.dispose();
  }

  void callbackFunction(int data) {
    // Do something with the data passed from the child
    print(data);
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Flex(
          mainAxisAlignment: MainAxisAlignment.center,
          direction: Axis.horizontal,
          children: [
            IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: Icon(
                Icons.keyboard_backspace_rounded,
                color: _back
                    ? Theme.of(context).scaffoldBackgroundColor
                    : Theme.of(context).iconTheme.color,
                size: 30,
              ),
              onPressed: () => {
                setState(() => {_back = true}),
                Navigator.of(context).pop()
              },
            ),
          ],
        ),
        actions: [
          Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  if (urlController.text.isNotEmpty) {
                    bool validURL = Uri.parse(urlController.text).isAbsolute;

                    if (!validURL) {
                      displayToast('URL is not valid', context, failColor);
                      return null;
                    }
                  }

                  if (widget.item != null && widget.listid == null) {
                    // update item
                    String desc = descController.text;
                    desc = desc.replaceAll("\n", "\\n");
                    var item = await ItemService().updateItem(
                        nameController.text,
                        desc,
                        urlController.text,
                        isFlagged,
                        widget.item.id.toString());
                    setState(() => {_check = true});
                    if (item) {
                      displayToast(
                          'Update Item Successfully', context, successColor);
                      Navigator.pushNamed(context, '/list', arguments: {
                        'listname': widget.listname,
                        'listid': int.parse(widget.item.listid)
                      });
                    } else {
                      displayToast('Add Item Failed', context, failColor);
                    }
                  } else {
                    // add item
                    if (nameController.text.length != 0) {
                      String desc = descController.text;
                      desc = desc.replaceAll("\n", "\\n");
                      var item = await ItemService().addItem(
                          nameController.text,
                          desc,
                          urlController.text,
                          isFlagged,
                          widget.listid.toString());
                      setState(() => {_check = true});
                      if (item) {
                        displayToast(
                            'Item Added Successfully', context, successColor);
                        Navigator.of(context).pop();
                      } else {
                        displayToast('Add Item Failed', context, failColor);
                      }
                    } else {
                      displayToast('Input a name', context, failColor);
                    }
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Text('Done',
                      style: _check
                          ? thirdGreyText
                          : Theme.of(context).textTheme.headline3),
                ),
              )
            ],
          ),
        ],
        centerTitle: true,
        title: Text(
          'Details',
          style: Theme.of(context).textTheme.headline2,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.light
                        ? mainBGLightColor
                        : mainBGDarkColor,
                    boxShadow: Theme.of(context).brightness == Brightness.light
                        ? [
                            MyShadows.primaryLightShadow,
                            MyShadows.secondaryLightShadow
                          ]
                        : [
                            MyShadows.primaryDarkShadow,
                            MyShadows.secondaryDarkShadow
                          ],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
                        child: TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            hintText: 'Name',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2,
                                  color: Theme.of(context).iconTheme.color),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:  BorderSide(
                                  width: 2, color: Theme.of(context).iconTheme.color),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      margin20,
                      Container(
                        child: SingleChildScrollView(
                          child: TextField(
                            minLines: 5,
                            maxLines: 5,
                            decoration: InputDecoration(
                              hintText: 'Description',
                              enabledBorder: OutlineInputBorder(
                                borderSide:  BorderSide(
                                    width: 2, color: Theme.of(context).iconTheme.color),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:  BorderSide(
                                    width: 2, color: Theme.of(context).iconTheme.color),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            controller: descController,
                            keyboardType: TextInputType.multiline,
                          ),
                        ),
                      ),
                      margin20,
                      Container(
                        child: TextField(
                          controller: urlController,
                          decoration: InputDecoration(
                            hintText: 'URL',
                            enabledBorder: OutlineInputBorder(
                              borderSide:  BorderSide(
                                  width: 2, color: Theme.of(context).iconTheme.color),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:  BorderSide(
                                  width: 2, color: Theme.of(context).iconTheme.color),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                margin20,
                margin20,
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.light
                          ? mainBGLightColor
                          : mainBGDarkColor,
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
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 6),
                            decoration: BoxDecoration(
                              color: Colors.orangeAccent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.all(6),
                            child: Icon(
                              Foundation.flag,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Flagged',
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        ],
                      ),
                      CupertinoSwitch(
                        trackColor: Colors.grey,
                        activeColor: Colors.greenAccent,
                        value: isFlagged,
                        onChanged: (value) => {
                          print(value),
                          setState(() => {isFlagged = value})
                        },
                      ),
                    ],
                  ),
                ),
                margin20,
                margin20,
                GestureDetector(
                  onTap: () => {Navigator.pushNamed(context, "/priority")},
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.light
                            ? mainBGLightColor
                            : mainBGDarkColor,
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
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 6),
                              decoration: BoxDecoration(
                                  color: Colors.orangeAccent,
                                  borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.all(6),
                              child: Icon(
                                FontAwesome.exclamation,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Priority',
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          ],
                        ),
                        Icon(
                          MaterialIcons.keyboard_arrow_right,
                          size: 30,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        // CupertinoSwitch(
                        //   trackColor: Colors.grey,
                        //   activeColor: Colors.greenAccent,
                        //   value: isFlagged,
                        //   onChanged: (value) => {
                        //     print(value),
                        //     setState(() => {isFlagged = value})
                        //   },
                        // ),
                      ],
                    ),
                  ),
                ),
                margin20,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
