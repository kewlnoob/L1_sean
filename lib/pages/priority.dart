import 'package:L1_sean/pages/additem.dart';
import 'package:L1_sean/utils/global.dart';
import 'package:flutter/material.dart';

class Priority extends StatefulWidget {
  const Priority();

  @override
  State<Priority> createState() => _PriorityState();
}

class _PriorityState extends State<Priority> {
  bool _back = false;
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
                Navigator.of(context).pop()
              },
            ),
          ],
        ),
        centerTitle: true,
        title: Text(
          'Priority',
          style: secondaryText,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
      ),
    );
  }
}
