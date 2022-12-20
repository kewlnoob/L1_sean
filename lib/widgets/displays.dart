import 'package:L1_sean/utils/global.dart';
import 'package:flutter/material.dart';

Widget displays(IconData icon, String text, Color color, int count) {
  return Container(
    height: 70,
    width: 150,
    decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(1.5, 3),
          )
        ],
        image: DecorationImage(
            image: AssetImage('assets/images/dashboard.png'),
            fit: BoxFit.fill)),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [
            primaryColor.withOpacity(0.8),
            secondaryColor.withOpacity(0.7),
          ],
        ),
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
            top: 6,
            right: 15,
            child: Text(
              count.toString(),
              style: bigWhiteText,
            ),
          ),
          Positioned(
            bottom: 8,
            left: 15,
            child: Text(
              text,
              style: whiteText,
            ),
          ),
        ],
      ),
    ),
  );
}
