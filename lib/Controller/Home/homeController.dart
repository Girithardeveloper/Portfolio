import 'package:get/get.dart';
import 'package:portfolio/Helper/assetConstants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Helper/appDescriptionConstants.dart';
import '../../Model/projectModel.dart';

class HomeController extends GetxController{

  final List<Map<String, String>> languagesAndFrameworks = [
    {'name': 'C', 'level': 'Intermediate'},
    {'name': 'Dart', 'level': 'Experienced'},
    {'name': 'Kotlin', 'level': 'Beginner'},
    {'name': 'SQL', 'level': 'Intermediate'},
    {'name': 'Flutter', 'level': 'Advanced'},
    {'name': 'Flutter Flow', 'level': 'Advanced'},
    {'name': 'Golang', 'level': 'Beginner'},
  ];

  final List<Map<String, String>> toolsAndIDEs = [
    {'name': 'Android Studio', 'level': 'Experienced'},
    {'name': 'Git', 'level': 'Advanced'},
    {'name': 'Postman', 'level': 'Intermediate'},
    {'name': 'Firebase', 'level': 'Intermediate'},
    {'name': 'Cloudinary', 'level': 'Intermediate'},
    {'name': 'Figma', 'level': 'Intermediate'},
    {'name': 'Jira', 'level': 'Intermediate'},

  ];


  final List<Project> projects = [
    Project(imagePath: AssetConstants.nearleDealsProjectImage, title: 'Nearle Deals', description: TextConst.aboutNearleDeals),
    Project(imagePath: AssetConstants.nearleXpressProjectImage, title: 'Nearle Xpress', description: TextConst.aboutNearleXpress),
    Project(imagePath: AssetConstants.LegendaryProjectImage, title: 'Legendary', description: TextConst.aboutLegendary),
    // Project(imagePath: AssetConstants.profileImage, title: 'Groom Gear', description: TextConst.aboutGroomGear),
  ];


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



}