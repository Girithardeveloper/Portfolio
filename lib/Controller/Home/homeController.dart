import 'dart:async';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:emailjs/emailjs.dart' as emailjs;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/Helper/assetConstants.dart';
import 'package:portfolio/Helper/logger.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Helper/appDescriptionConstants.dart';
import '../../Model/projectModel.dart';

class HomeController extends GetxController  with SingleGetTickerProviderMixin {


  int currentIndex = 0;

  int selectedMenuIndex = -1;

  late AnimationController sectionController;
  late Animation<Offset> slideFromBottom;

  bool isVisible = false;
  bool menuSelected = false;


  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey experienceKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey toolsKey = GlobalKey();
  final GlobalKey blogKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  final CarouselSliderController carouselController = CarouselSliderController();






  final List<Map<String, String>> cardData = [
    {'title': "BCA", 'subtitle': "Education"},
    {'title': "6.7", 'subtitle': "CGPA"},
    {'title': "3.3+", 'subtitle': "Experience"},
    {'title': "5+", 'subtitle': "Projects"},
  ];





  final List<Map<String, String>> languagesAndFrameworks = [
    {'name': 'C', 'level': 'Intermediate','image':AssetConstants.cLogo},
    {'name': 'Dart', 'level': 'Experienced','image':AssetConstants.dartLogo},
    {'name': 'Kotlin', 'level': 'Beginner','image':AssetConstants.kotlinLogo},
    {'name': 'SQL', 'level': 'Intermediate','image':AssetConstants.sqlLogo},
    {'name': 'Flutter', 'level': 'Advanced','image':AssetConstants.flutterLogo},
    {'name': 'Flutter Flow', 'level': 'Intermediate','image':AssetConstants.flutterFlowLogo},
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
    Project(imagePath: AssetConstants.nearleDealsProjectImage, title: 'Nearle Deals', description: TextConst.aboutNearleDeals,backgroundColor:Color(0XFF8a589f),blogUrl: '' ),
    Project(imagePath: AssetConstants.nearleXpressProjectImage, title: 'Nearle Xpress', description: TextConst.aboutNearleXpress,backgroundColor:Color(0XFF8a589f) ,blogUrl: '' ),
    Project(imagePath: AssetConstants.LegendaryProjectImage, title: 'Legendary', description: TextConst.aboutLegendary,backgroundColor: Color(0XFF32a2ad),blogUrl: '' ),
    // Project(imagePath: AssetConstants.profileImage, title: 'Groom Gear', description: TextConst.aboutGroomGear),
  ];

  final List<Project> blogs = [
    Project(imagePath: 'Nearle Deals', title: 'Revolutionizing Local Shopping: My Journey with Nearle Deals', description: TextConst.aboutNearleDeals,backgroundColor:Color(0XFF8a589f),blogUrl: 'https://giritharkdev.blogspot.com/2025/03/revolutionizing-local-shopping-my.html'  ),
    Project(imagePath: 'Nearle Xpress', title: 'Nearle Express: Transforming Food Delivery', description: TextConst.aboutNearleXpress,backgroundColor:Color(0XFF8a589f),blogUrl: 'https://giritharkdev.blogspot.com/2025/03/nearle-express-transforming-food.html'  ),
    Project(imagePath: 'Legendary', title: 'Legendary: Simplifying Workforce Management', description: TextConst.aboutLegendary,backgroundColor: Color(0XFF32a2ad),blogUrl: 'https://giritharkdev.blogspot.com/2025/03/legendary-simplifying-workforce.html' ),
    // Project(imagePath: AssetConstants.profileImage, title: 'Groom Gear', description: TextConst.aboutGroomGear),
  ];

  ///TextField FocusNode
  FocusNode nameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode descriptionFocusNode = FocusNode();


  ///TextField Controller
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

// creating smtp server for gmail
//   final gmailSmtp = gmail(dotenv.env["GMAIL_MAIL"]!, dotenv.env["GMAIL_PASSWORD"]!);

  final ScrollController scrollController = ScrollController();
  final ScrollController contactScrollController = ScrollController();

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
  void sendEmail(String name, String email, String description) async {
    try {
      final response = await emailjs.send(
        'service_esfbqo9',
        'template_mxthphs',
        {
          'name':name,
          'email': email,
          'message': description,
        },
        const emailjs.Options(
            publicKey: 'DFq07OOqhs5j3yovI',
            privateKey: 'CJSPOcNPIrWxyMJ_05A-m',
            limitRate: emailjs.LimitRate(
              id: 'app',
              throttle: 10000,
            )),
      );
      if (response.status == 200) {
        logger.i('✅ SUCCESS: Email Sent!');

        // // ✅ Clear text fields after success
        nameController.clear();
        emailController.clear();
        descriptionController.clear();
      }
      else{
        logger.i('Failed: Email Sent!');
      }
    } catch (error) {
      if (error is emailjs.EmailJSResponseStatus) {
        logger.i('ERROR... $error');
      }
      logger.i(error.toString());
    }
  }


  ///
  void triggerAnimation(bool visible) {
    if (visible && !isVisible) {
      isVisible = true;
      sectionController.forward();
      update();
    }
  }





  @override
  void onInit() {
    // TODO: implement onInit
    _startAutoScroll();
    super.onInit();
    sectionController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    slideFromBottom = Tween<Offset>(begin: Offset(0, 0.5), end: Offset(0, 0)).animate(
      CurvedAnimation(parent: sectionController, curve: Curves.easeOut),
    );
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
    // scrollController.dispose();
    sectionController.dispose();
    super.dispose();
  }

}