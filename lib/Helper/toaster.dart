
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Colorconstants.dart';

class Toast{
  static void showToast(String message){
    Fluttertoast.showToast(
        msg: message,
        textColor:  Platform.isAndroid?Colors.black:ColorConstants.whiteColor,
        timeInSecForIosWeb: 1,
        webShowClose: true,
        // webBgColor: Color(0xFF003479),
        backgroundColor: Platform.isAndroid?Colors.grey[100]:ColorConstants.primaryColor,
        gravity: ToastGravity.TOP_RIGHT,
        fontSize: 15.0,
    );
  }
}