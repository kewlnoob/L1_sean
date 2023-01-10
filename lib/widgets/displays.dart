import 'package:L1_sean/provider/userProvider.dart';
import 'package:L1_sean/utils/global.dart';
import 'package:flutter/material.dart';

Widget displays(IconData icon, String text, Color color, String count,
    BuildContext context) {
  return GestureDetector(
    onTap: () {
      switch (text) {
        case 'All':
          Navigator.pushNamed(context, "/all");
          break;
        case 'Archived':
          Navigator.pushNamed(context, "/archived");
          break;
      }
    },
    child: Container(
      height: 70,
      width: 150,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? mainBGLightColor
            : mainBGDarkColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: Theme.of(context).brightness == Brightness.light
            ? [MyShadows.primaryLightShadow, MyShadows.secondaryLightShadow]
            : [MyShadows.primaryDarkShadow, MyShadows.secondaryDarkShadow],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 10,
            left: 15,
            child: Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              child: Icon(
                icon,
                color: Colors.white,
                size: 15,
              ),
            ),
          ),
          Positioned(
            top: 2,
            right: 15,
            child: Text(
              count,
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          Positioned(
            bottom: 8,
            left: 15,
            child: Text(
              text,
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
        ],
      ),
    ),
  );
}
