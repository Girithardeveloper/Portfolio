import 'dart:async';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:emailjs/emailjs.dart' as emailjs;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/Helper/assetConstants.dart';
import 'package:portfolio/Helper/colorConstants.dart';
import 'package:portfolio/Helper/logger.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Helper/appDescriptionConstants.dart';
import '../../Model/projectModel.dart';

class HomeController extends GetxController with SingleGetTickerProviderMixin {
  int currentIndex = 0;
  int selectedMenuIndex = -1;

  late AnimationController sectionController;
  late Animation<Offset> slideFromBottom;

  bool isVisible = false;

  final GlobalKey aboutKey      = GlobalKey();
  final GlobalKey experienceKey = GlobalKey();
  final GlobalKey projectsKey   = GlobalKey();
  final GlobalKey toolsKey      = GlobalKey();
  final GlobalKey blogKey       = GlobalKey();
  final GlobalKey contactKey    = GlobalKey();

  final CarouselSliderController carouselController = CarouselSliderController();

  // ── Stats cards (resume-verified, numeric for count-up animation) ──
  final List<Map<String, dynamic>> cardData = [
    {'title': 'BCA',  'subtitle': 'Education',       'isNumeric': false, 'numVal': 0.0,  'suffix': ''},
    {'title': '4+',   'subtitle': 'Years Experience', 'isNumeric': true,  'numVal': 4.0,  'suffix': '+'},
    {'title': '5+',   'subtitle': 'Apps Shipped',    'isNumeric': true,  'numVal': 5.0,  'suffix': '+'},
    {'title': '6.7',  'subtitle': 'CGPA',             'isNumeric': true,  'numVal': 6.7,  'suffix': ''},
  ];

  // ── Work Experience Timeline (from resume) ──────────────
  final List<Map<String, dynamic>> workExperience = [
    {
      'company': 'NectarIT Technologies Pvt Ltd',
      'role': 'Senior Flutter Developer',
      'period': 'Jul 2025 — Present',
      'location': 'Coimbatore, India',
      'color': const Color(0xFF7C3AED),
      'current': true,
      'achievements': [
        'Developed & maintained Awesometicks V2 — enterprise app for asset, attendance & job management',
        'Built Asset Management, Attendance Tracking, and Job Management modules for enterprise teams',
        'Integrated GraphQL APIs to reduce unnecessary network calls and improve data efficiency',
        'Implemented secure authentication with role-based access control (RBAC)',
      ],
    },
    {
      'company': 'Nearle Technology Pvt Ltd',
      'role': 'Software Engineer (Flutter)',
      'period': 'Jan 2022 — Jul 2025',
      'location': 'Coimbatore, India',
      'color': const Color(0xFF00D4FF),
      'current': false,
      'achievements': [
        'Designed & developed user-centric mobile apps using Flutter, enhancing user engagement',
        'Integrated Firebase for real-time data sync, improving application responsiveness',
        'Collaborated on payment gateway integrations, streamlining transaction processes',
        'Developed Nearle Super App, Nearle Xpress App, and Legendary Client App',
      ],
    },
  ];

  // ── Languages & Frameworks (resume-synced) ─────────────
  final List<Map<String, String>> languagesAndFrameworks = [
    {'name': 'Flutter',      'level': 'Expert',       'image': AssetConstants.flutterLogo},
    {'name': 'Dart',         'level': 'Advanced',     'image': AssetConstants.dartLogo},
    {'name': 'GraphQL',      'level': 'Experienced',  'image': AssetConstants.golangLogo},
    {'name': 'SQL',          'level': 'Intermediate', 'image': AssetConstants.sqlLogo},
    {'name': 'Kotlin',       'level': 'Beginner',     'image': AssetConstants.kotlinLogo},
    {'name': 'Flutter Flow', 'level': 'Intermediate', 'image': AssetConstants.flutterFlowLogo},
    {'name': 'Golang',       'level': 'Beginner',     'image': AssetConstants.golangLogo},
    {'name': 'C',            'level': 'Intermediate', 'image': AssetConstants.cLogo},
  ];

  // ── Tools, IDEs & Others (resume-synced — VS Code primary IDE) ──
  final List<Map<String, String>> toolsAndIDEs = [
    {'name': 'Android Studio', 'level': 'Expert',       'image': AssetConstants.androidStudioLogo},
    {'name': 'Git',            'level': 'Advanced',     'image': AssetConstants.gitLogo},
    {'name': 'Firebase',       'level': 'Experienced',  'image': AssetConstants.firebaseLogo},
    {'name': 'Bitbucket',      'level': 'Advanced',     'image': AssetConstants.bitbucketLogo},
    {'name': 'Postman',        'level': 'Intermediate', 'image': AssetConstants.postmanLogo},
    {'name': 'Figma',          'level': 'Intermediate', 'image': AssetConstants.figmaLogo},
    {'name': 'Jira',           'level': 'Intermediate', 'image': AssetConstants.jiraLogo},
    {'name': 'Github',         'level': 'Intermediate', 'image': AssetConstants.githubLogo},
    {'name': 'Cloudinary',     'level': 'Intermediate', 'image': AssetConstants.cloudinaryLogo},
    {'name': 'Slack',          'level': 'Experienced',  'image': AssetConstants.slackLogo},
    {'name': 'Canva',          'level': 'Intermediate', 'image': AssetConstants.canvaLogo},
    {'name': 'SourceTree',     'level': 'Intermediate', 'image': AssetConstants.sourceTreeLogo},
  ];

  // ── Projects Carousel ───────────────────────────────────
  final List<Project> projects = [
    Project(
      imagePath: AssetConstants.nearleDealsProjectImage,
      title: 'Nearle Deals',
      description: TextConst.aboutNearleDeals,
      backgroundColor: Color(0XFF8a589f),
      blogUrl: '',
    ),
    Project(
      imagePath: AssetConstants.nearleXpressProjectImage,
      title: 'Nearle Xpress',
      description: TextConst.aboutNearleXpress,
      backgroundColor: Color(0XFF8a589f),
      blogUrl: '',
    ),
    Project(
      imagePath: AssetConstants.LegendaryProjectImage,
      title: 'Legendary',
      description: TextConst.aboutLegendary,
      backgroundColor: Color(0XFF32a2ad),
      blogUrl: '',
    ),
  ];

  // ── Case Studies / Blogs ────────────────────────────────
  final List<Project> blogs = [
    Project(
      imagePath: 'Awesometicks V2',
      title: 'Awesometicks V2: Enterprise IoT Asset Management',
      description: TextConst.aboutAwesometicks,
      backgroundColor: Color(0xFF7C3AED),
      blogUrl: '',
    ),
    Project(
      imagePath: 'Nearle Deals',
      title: 'Revolutionizing Local Shopping: My Journey with Nearle Deals',
      description: TextConst.aboutNearleDeals,
      backgroundColor: Color(0XFF8a589f),
      blogUrl: 'https://giritharkdev.blogspot.com/2025/03/revolutionizing-local-shopping-my.html',
    ),
    Project(
      imagePath: 'Nearle Xpress',
      title: 'Nearle Express: Transforming Food Delivery',
      description: TextConst.aboutNearleXpress,
      backgroundColor: Color(0XFF8a589f),
      blogUrl: 'https://giritharkdev.blogspot.com/2025/03/nearle-express-transforming-food.html',
    ),
    Project(
      imagePath: 'Legendary',
      title: 'Legendary: Simplifying Workforce Management',
      description: TextConst.aboutLegendary,
      backgroundColor: Color(0XFF32a2ad),
      blogUrl: 'https://giritharkdev.blogspot.com/2025/03/legendary-simplifying-workforce.html',
    ),
  ];

  // ── TextField Controllers ───────────────────────────────
  FocusNode nameFocusNode        = FocusNode();
  FocusNode emailFocusNode       = FocusNode();
  FocusNode descriptionFocusNode = FocusNode();

  TextEditingController nameController        = TextEditingController();
  TextEditingController emailController       = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final ScrollController scrollController        = ScrollController();
  final ScrollController contactScrollController = ScrollController();

  late Timer _timer;

  // ── Links ───────────────────────────────────────────────
  void resumeDriveLink() async {
    const url =
        'https://drive.google.com/file/d/18PqYaAzhfQSGIIzv4wT3cWD9n4k1wVwQ/view?usp=drivesdk';
    if (await canLaunch(url)) await launch(url);
  }

  void linkedInLink() async {
    const url = 'https://www.linkedin.com/in/girithar-kaarthiraajan-329206225';
    if (await canLaunch(url)) await launch(url);
  }

  void gitHubLink() async {
    const url = 'https://github.com/Girithardeveloper?tab=repositories';
    if (await canLaunch(url)) await launch(url);
  }

  static void openEmailApp({String? subject, String? toMail}) {
    launch(Uri(
      scheme: 'mailto',
      path: toMail ?? '',
      queryParameters: {'subject': subject ?? ''},
    ).toString());
  }

  // ── Navigation ──────────────────────────────────────────
  void scrollToSection(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(ctx,
          duration: const Duration(milliseconds: 600), curve: Curves.easeInOut);
    }
  }

  // ── Email ───────────────────────────────────────────────
  void sendEmail(String name, String email, String description) async {
    try {
      final response = await emailjs.send(
        'service_esfbqo9',
        'template_mxthphs',
        {'name': name, 'email': email, 'message': description},
        const emailjs.Options(
          publicKey: 'DFq07OOqhs5j3yovI',
          privateKey: 'CJSPOcNPIrWxyMJ_05A-m',
          limitRate: emailjs.LimitRate(id: 'app', throttle: 10000),
        ),
      );
      if (response.status == 200) {
        logger.i('✅ Email sent');
        nameController.clear();
        emailController.clear();
        descriptionController.clear();
      }
    } catch (error) {
      logger.i('Email error: $error');
    }
  }

  // ── Animation (kept for backward compat) ────────────────
  void triggerAnimation(bool visible) {
    if (visible && !isVisible) {
      isVisible = true;
      sectionController.forward();
      update();
    }
  }

  @override
  void onInit() {
    _startAutoScroll();
    super.onInit();
    sectionController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    slideFromBottom = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: sectionController, curve: Curves.easeOut));
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(milliseconds: 2000), (timer) {
      if (!Get.isRegistered<HomeController>() || !scrollController.hasClients) {
        timer.cancel();
        return;
      }
      if (scrollController.hasClients) {
        final max = scrollController.position.maxScrollExtent;
        if (max > 0) {
          final next = scrollController.offset + 200;
          if (next >= max) {
            scrollController.animateTo(0,
                duration: const Duration(seconds: 1), curve: Curves.easeInOut);
          } else {
            scrollController.animateTo(next,
                duration: const Duration(seconds: 1), curve: Curves.easeInOut);
          }
        }
      }
    });
  }

  @override
  void dispose() {
    if (_timer.isActive) _timer.cancel();
    sectionController.dispose();
    super.dispose();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
