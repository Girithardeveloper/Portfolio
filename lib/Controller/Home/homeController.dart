import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:portfolio/Helper/assetConstants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Helper/appDescriptionConstants.dart';
import '../../Model/projectModel.dart';

class HomeController extends GetxController{

  final List<Map<String, String>> languagesAndFrameworks = [
    {'name': 'C', 'level': 'Intermediate','image':AssetConstants.cLogo},
    {'name': 'Dart', 'level': 'Experienced','image':AssetConstants.dartLogo},
    {'name': 'Kotlin', 'level': 'Beginner','image':AssetConstants.kotlinLogo},
    {'name': 'SQL', 'level': 'Intermediate','image':AssetConstants.sqlLogo},
    {'name': 'Flutter', 'level': 'Advanced','image':AssetConstants.flutterLogo},
    {'name': 'Flutter Flow', 'level': 'Advanced','image':AssetConstants.flutterFlowLogo},
    {'name': 'Golang', 'level': 'Beginner','image':AssetConstants.golangLogo},
  ];

  final List<Map<String, String>> toolsAndIDEs = [
    {'name': 'Android Studio', 'level': 'Experienced','image':AssetConstants.androidStudioLogo},
    {'name': 'Git', 'level': 'Advanced','image':AssetConstants.gitLogo},
    {'name': 'Postman', 'level': 'Intermediate','image':AssetConstants.postmanLogo},
    {'name': 'Firebase', 'level': 'Intermediate','image':AssetConstants.firebaseLogo},
    {'name': 'Cloudinary', 'level': 'Intermediate','image':AssetConstants.cloudinaryLogo},
    {'name': 'Figma', 'level': 'Intermediate','image':AssetConstants.figmaLogo},
    {'name': 'Jira', 'level': 'Intermediate','image':AssetConstants.jiraLogo},

  ];


  final List<Project> projects = [
    Project(imagePath: AssetConstants.nearleDealsProjectImage, title: 'Nearle Deals', description: TextConst.aboutNearleDeals),
    Project(imagePath: AssetConstants.nearleXpressProjectImage, title: 'Nearle Xpress', description: TextConst.aboutNearleXpress),
    Project(imagePath: AssetConstants.LegendaryProjectImage, title: 'Legendary', description: TextConst.aboutLegendary),
    // Project(imagePath: AssetConstants.profileImage, title: 'Groom Gear', description: TextConst.aboutGroomGear),
  ];

  final ScrollController scrollController = ScrollController();

  late Timer _timer;


  void resumeDriveLink() async {
    var resumeDriveLinkUrl;
      // appInfo = await Utility.getApplicationInfo();

    resumeDriveLinkUrl = 'https://drive.google.com/file/d/1Vc4XGP3znz8yfxknu0dPZk4mPr1YR8NZ/view?usp=drivesdk';

    if (await canLaunch(resumeDriveLinkUrl)) {
      await launch(resumeDriveLinkUrl);
    } else {
      throw 'Could not launch App';
    }
  }

  void linkedInLink() async {
    var linkedInLinkUrl;
      // appInfo = await Utility.getApplicationInfo();

    linkedInLinkUrl = 'https://www.linkedin.com/in/girithar-kaarthiraajan-329206225';

    if (await canLaunch(linkedInLinkUrl)) {
      await launch(linkedInLinkUrl);
    } else {
      throw 'Could not launch App';
    }
  }

  void gitHubLink() async {
    var gitHubLinkUrl;
      // appInfo = await Utility.getApplicationInfo();

    gitHubLinkUrl = 'https://github.com/Girithardeveloper?tab=repositories';

    if (await canLaunch(gitHubLinkUrl)) {
      await launch(gitHubLinkUrl);
    } else {
      throw 'Could not launch App';
    }
  }


  static void openEmailApp({String? subject,String? toMail}) {
    launch(Uri(
        scheme: 'mailto',
        path: toMail??"",
        queryParameters: {
          'subject': subject??""
        }
    ).toString());
  }

/// Scroll Appbar Menu
  void scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }


  @override
  void onInit() {
    // TODO: implement onInit
    _startAutoScroll();
    super.onInit();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(milliseconds: 2000), (timer) {
      if (scrollController.hasClients) {
        double maxScroll = scrollController.position.maxScrollExtent;

        if (maxScroll > 0) { // Ensure there is content to scroll
          double currentScroll = scrollController.offset;
          double nextScroll = currentScroll + 200.0;

          if (nextScroll >= maxScroll) {
            scrollController.animateTo(0,
                duration: Duration(seconds: 1), curve: Curves.easeInOut);
          } else {
            scrollController.animateTo(nextScroll,
                duration: Duration(seconds: 1), curve: Curves.easeInOut);
          }
        }
      }
    });
  }


  @override
  void dispose() {
    _timer.cancel();
    scrollController.dispose();
    super.dispose();
  }



}