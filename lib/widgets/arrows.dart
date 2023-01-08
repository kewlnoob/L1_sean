import 'package:L1_sean/utils/global.dart';
import 'package:flutter/material.dart';

Widget ButtonArrow(BuildContext context, String pageName) {
  return Container(
    child: Align(
      alignment: Alignment.topLeft,
      child: IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        icon: Icon(
          Icons.keyboard_backspace_rounded,
          color: Colors.grey,
          size: 30,
        ),
        onPressed: () {
          switch (pageName) {
            case "home":
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case "welcome":
              Navigator.pushReplacementNamed(context, '/');
              break;

            default:
              Navigator.of(context).pop();
          }
        },
      ),
    ),
  );
}
