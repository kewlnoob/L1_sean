import 'package:L1_sean/utils/global.dart';
import 'package:L1_sean/widgets/arrows.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddItem extends StatefulWidget {
  const AddItem();

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  bool _back = false;
  bool _check = false;

  var textController = TextEditingController();

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
                    color: _back ? Colors.grey : Colors.black,
                    size: 30,
                  ),
                  onPressed: () => {
                        setState(() => {_back = true}),
                        Navigator.of(context).pop(),
                      }),
            ],
          ),
          actions: [
            Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    String text = textController.text;
                    text = text.replaceAll("\n", "\\n");
                    print(text);
                    setState(() => {_check = true});
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    child:
                        Text('Done', style: _check ? thirdGreyText : thirdText),
                  ),
                )
              ],
            ),
          ],
          centerTitle: true,
          title: Text(
            'Details',
            style: secondaryText,
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      Container(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField()),
                      Container(
                        constraints: BoxConstraints(
                          maxHeight: 100,
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: TextField(
                            minLines: 1,
                            maxLines: 5,
                            controller: textController,
                            keyboardType: TextInputType.multiline,
                          ),
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField()),
                    ],
                  ),
                ),
                margin20,
                // Container(
                //   child: ,
                // )
              ],
            ),
          ),
        ));
  }
}
