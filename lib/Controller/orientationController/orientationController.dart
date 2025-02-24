
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrientationController extends GetxController {
  final isLandscape = false.obs;

  void updateOrientation(BuildContext context) {
    isLandscape.value = MediaQuery.of(context).orientation == Orientation.landscape;
    // logger.i('IsLandscape listener: $isLandscape');
    update();
  }
}