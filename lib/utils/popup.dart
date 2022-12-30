import 'package:L1_sean/utils/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:lottie/lottie.dart';

ToastFuture displayToast(msg, context, color) {
  return showToast(
    msg,
    context: context,
    backgroundColor: color,
    duration: const Duration(seconds: 3),
    axis: Axis.horizontal,
    position: StyledToastPosition.bottom,
    curve: Curves.bounceInOut,
  );
}

// Future<dynamic> displayDialog(context) {
//   return showDialog(
//       context: context,
//       builder: (context) {
//         return Center(
//           child: CircularProgressIndicator(),
//         );
//       });
// }

Future displayDialog(msg, context, controller, boolean, page) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => Dialog(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Lottie.asset(
            boolean ? 'assets/images/success.json' : 'assets/images/fail.json',
            controller: controller,
            height: 100,
            width: 100,
            repeat: false, onLoaded: (composition) {
          if (boolean) {
            switch (page) {
              case "addlist":
                controller.forward().whenComplete(() {
                  Navigator.pushNamed(context, "/home");
                });
              break;
              case "homemenu":
              controller.forward();
            }
          } else {
            controller.forward();
          }
        }),
        Text(
          msg,
          style: secondaryText,
        ),
        margin20
      ],
    )),
  );
}
