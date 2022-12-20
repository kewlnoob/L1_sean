import 'package:L1_sean/utils/global.dart';
import 'package:flutter/material.dart';


Widget ButtonArrow(BuildContext context) {
      return Container(
        margin: EdgeInsets.only(left: 15),
        child: Align(
          alignment: Alignment.topLeft,
          child: IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: backButton,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      );
    }