import 'package:flutter/cupertino.dart';
import 'dart:math' as math;

class ResponsiveSize {
  ///Screen Breakpoints
  static const double largeDesktopWidth = 1920.0;
  static const double desktopWidth = 1024.0;
  static const double tabletWidth = 768.0;
  static const double mobileWidth = 768.0;

  ///Screen factors for each device type
  static const double largeDesktopScale = 1.1;
  static const double desktopScale = 1.15;
  static const double tabletScale = 1.05;
  static const double mobileScale = 0.95;

  static double getSize(BuildContext context, double baseSize) {
    double screenWidth = MediaQuery.of(context).size.width;
    double pixelRadio = MediaQuery.of(context).devicePixelRatio;

    ///Calculate Scale factor based on screen width
    double scaleFactor;
    if (screenWidth > largeDesktopWidth) {
      scaleFactor = (screenWidth / largeDesktopWidth) * largeDesktopScale;
    } else if (screenWidth > desktopWidth) {
      scaleFactor = (screenWidth / desktopWidth) * desktopScale;
    } else if (screenWidth > tabletWidth) {
      scaleFactor = (screenWidth / tabletWidth) * tabletScale;
    } else {
      scaleFactor = (screenWidth / mobileWidth) * mobileScale;
    }

    ///Apply constraints
    scaleFactor = scaleFactor.clamp(0.75, 1.5);
    // scaleFactor = scaleFactor.clamp(0.85, 1.8);


    ///Calculate final size with pixel ratio compensation
    return math.max((baseSize * scaleFactor) / (pixelRadio > 2 ? pixelRadio * 0.7 : 1), 8.0);
  }
}
