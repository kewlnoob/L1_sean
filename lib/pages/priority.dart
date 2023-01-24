import 'package:L1_sean/pages/additem.dart';
import 'package:L1_sean/provider/userProvider.dart';
import 'package:L1_sean/services/itemService.dart';
import 'package:L1_sean/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class Priority extends StatefulWidget {
  final String priorityid;
  final String pname;
  final String different;
  final Function callback;
  const Priority({this.priorityid, this.pname, this.different, this.callback});

  @override
  State<Priority> createState() => _PriorityState();
}

class _PriorityState extends State<Priority> {
  bool _back = false;
  String priorityid;
  String pname;
  String selectedIndex;
  @override
  void initState() {
    if (widget.different == "add") {
      setState(() {
        selectedIndex = "0";
      });
    }
    if (widget.different == "edit") {
      setState(() {
        selectedIndex = widget.priorityid;
      });
    }
    setState(() {
      priorityid = widget.priorityid;
      pname = widget.pname;
    });

    // TODO: implement initState
    super.initState();
  }

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
        centerTitle: true,
        title: Text(
          'Priority',
          style: Theme.of(context).textTheme.headline2,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              height: 240,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
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
              ),
              child: FutureBuilder(
                future: ItemService().fetchPriority(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            widget.callback(snapshot.data[index].name, (index+1).toString());
                            setState(() {
                              selectedIndex = index.toString();
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    width: 1,
                                    color: Theme.of(context).iconTheme.color),
                              ),
                            ),
                            child: ListTile(
                                title: Text(
                                  snapshot.data[index].name,
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                                trailing: selectedIndex != null &&
                                        index.toString() == selectedIndex
                                    ? Icon(AntDesign.check, color: Colors.black)
                                    : null),
                          ),
                        );
                      },
                    );
                  }
                  return CircularProgressIndicator();
                },
              )),
        ),
      ),
    );
  }
}
