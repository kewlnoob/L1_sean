import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

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

Future<dynamic> displayDialog(context) {
  return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      });
}
