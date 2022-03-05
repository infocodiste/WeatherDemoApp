

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:developer' as logger;

class Const {

  /// Toast for default time
  void toast(
      String? value, {
        ToastGravity? gravity,
        length = Toast.LENGTH_SHORT,
        Color? bgColor,
        Color? textColor,
        bool print = false,
      }) {
    if (value!.isEmpty) {
      logger.log(value);
    } else {
      Fluttertoast.showToast(
        msg: value.toString(),
        gravity: gravity,
        toastLength: length,
        backgroundColor: bgColor,
        textColor: textColor,
      );
      if (print) logger.log(value);
    }
  }

}
