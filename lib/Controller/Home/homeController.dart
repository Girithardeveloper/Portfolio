import 'dart:async';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:portfolio/Helper/assetConstants.dart';
import 'package:portfolio/Helper/logger.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Helper/appDescriptionConstants.dart';
import '../../Model/projectModel.dart';

class HomeController extends GetxController{


  int currentIndex = 0;

  final CarouselSliderController carouselController = CarouselSliderController();


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
    {'name': 'Slack', 'level': 'Experienced','image':AssetConstants.slackLogo},
    {'name': 'Firebase', 'level': 'Intermediate','image':AssetConstants.firebaseLogo},
    {'name': 'Cloudinary', 'level': 'Intermediate','image':AssetConstants.cloudinaryLogo},
    {'name': 'Figma', 'level': 'Intermediate','image':AssetConstants.figmaLogo},
    {'name': 'Jira', 'level': 'Intermediate','image':AssetConstants.jiraLogo},
    {'name': 'Bitbucket', 'level': 'Intermediate','image':AssetConstants.bitbucketLogo},
    {'name': 'Canva', 'level': 'Intermediate','image':AssetConstants.canvaLogo},
    {'name': 'Github', 'level': 'Intermediate','image':AssetConstants.githubLogo},
    {'name': 'SourceTree', 'level': 'Intermediate','image':AssetConstants.sourceTreeLogo},

  ];


  final List<Project> projects = [
    Project(imagePath: AssetConstants.nearleDealsProjectImage, title: 'Nearle Deals', description: TextConst.aboutNearleDeals,backgroundColor:Color(0XFF8a589f) ),
    Project(imagePath: AssetConstants.nearleXpressProjectImage, title: 'Nearle Xpress', description: TextConst.aboutNearleXpress,backgroundColor:Color(0XFF8a589f) ),
    Project(imagePath: AssetConstants.LegendaryProjectImage, title: 'Legendary', description: TextConst.aboutLegendary,backgroundColor: Color(0XFF32a2ad)),
    // Project(imagePath: AssetConstants.profileImage, title: 'Groom Gear', description: TextConst.aboutGroomGear),
  ];

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();



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

  /// Email Contact Info
  Future<void> sendEmail(String name, String email, String description) async {
    // final smtpServer = SmtpServer('smtp.mailtrap.io',
    //     username: 'girithardev@gmail.com',
    //     password: 'Girithardev@5456');
    final smtpServer = gmail('girithardev@gmail.com', 'Girithardev@5456'); // Use your email and password

    final message = Message()
      ..from = Address('girithardev@gmail.com', 'Girithar')
      ..recipients.add(email) // Recipient email
      ..subject = 'Portfolio Contact Form Submission – $name'
      ..text = '''
    Name: $name
    Email: $email
    Description: $description
    ''';

    try {
      final sendReport = await send(message, smtpServer);
        logger.i('Message sent: $sendReport');
    } catch (e) {
      logger.i('Message not sent. Error: $e');
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
      if (!Get.isRegistered<HomeController>()) {
        timer.cancel();
        return;
      }

      if (scrollController.hasClients) {
        double maxScroll = scrollController.position.maxScrollExtent;
        if (maxScroll > 0) {
          double currentScroll = scrollController.offset;
          double nextScroll = currentScroll + 200.0;

          if (nextScroll >= maxScroll) {
            if (scrollController.hasClients && scrollController.positions.isNotEmpty) {
              scrollController.animateTo(
                  0, duration: Duration(seconds: 1), curve: Curves.easeInOut);
            }
          } else {
            if (scrollController.hasClients && scrollController.positions.isNotEmpty) {
              scrollController.animateTo(
                  nextScroll, duration: Duration(seconds: 1), curve: Curves.easeInOut);
            }

          }
        }
      }
    });
  }


  @override
  void dispose() {
    if (_timer.isActive) {
      _timer.cancel();
    }
    scrollController.dispose();
    super.dispose();
  }






}