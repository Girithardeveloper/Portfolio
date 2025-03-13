import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:portfolio/Controller/Home/homeController.dart';
import 'package:portfolio/Helper/assetConstants.dart';
import 'package:portfolio/Helper/colorConstants.dart';
import 'package:portfolio/Helper/fontConstants.dart';
import 'package:portfolio/Helper/logger.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../Model/projectModel.dart';
import '../globalWidgets/responsiveSizeWidget.dart';
import '../globalWidgets/textWidget.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  HomeController homeController = Get.put(HomeController());



  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ///Scroll
    ValueNotifier<bool> showSecondSegment = ValueNotifier<bool>(false);
    ValueNotifier<bool> showThirdSegment = ValueNotifier<bool>(false);

    ///Responsive
    Size screenSize = MediaQuery.of(context).size;
    bool isTabletOrMobile = screenSize.width <= ResponsiveSize.tabletWidth;

    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [Color(0XFFF2F9FF),Color(0XFFB1F0F7),], // Gradient colors

        ),
      ),
      child: GetBuilder<HomeController>(
        builder: (controller) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              forceMaterialTransparency: true,

              elevation: 0,
              toolbarHeight:isTabletOrMobile?60:100,
              // ResponsiveSize.getSize(context, screenSize.height * 0.08),
              backgroundColor: ColorConstants.primaryColor.withAlpha(0),
              leading: isTabletOrMobile ? Padding(
                padding: const EdgeInsets.only(top: 8,left: 16,bottom: 8),
                child: Image.asset(AssetConstants.GiritharDarkLogoImage,height: ResponsiveSize.getSize(context, screenSize.height * 0.08),width: ResponsiveSize.getSize(context, screenSize.width * 0.04),fit: BoxFit.fill,),
              ): null,
              title: isTabletOrMobile
                  ?Container():Image.asset(AssetConstants.GiritharDarkLogoImage,height: ResponsiveSize.getSize(context, screenSize.height * 0.06),width: ResponsiveSize.getSize(context, screenSize.width * 0.06),fit: isTabletOrMobile?BoxFit.contain:BoxFit.contain,),
              // flexibleSpace: Padding(
              //   padding: EdgeInsets.only(
              //       left: ResponsiveSize.getSize(context, screenSize.width * 0.04),
              //       right: ResponsiveSize.getSize(context, screenSize.width * 0.02),
              //       top: ResponsiveSize.getSize(context, screenSize.height * 0.02)),
              //   child: Row(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       Image.asset(AssetConstants.GiritharDarkLogoImage,height: ResponsiveSize.getSize(context, screenSize.height * 0.06),width: ResponsiveSize.getSize(context, screenSize.width * 0.06),),
              //     ],
              //   )
              //   // Text(
              //   //   "Portfolio",
              //   //   style: TextStyle(
              //   //     fontSize: ResponsiveSize.getSize(context, 30),
              //   //     fontFamily: FontConstants.fontFamily,
              //   //     color: ColorConstants.whiteColor,
              //   //   ),
              //   // ),
              // ),
              actions: isTabletOrMobile
                  ? [
                Builder(builder: (context) {
                  return IconButton(
                    highlightColor: Colors.transparent,  // Remove the highlight shadow
                    splashColor: Colors.transparent,
                    hoverColor:  Colors.transparent,
                    icon: const Icon(
                      Icons.menu,
                      color: ColorConstants.primaryColor,
                      size: 40,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                }),
                SizedBox(
                  width:
                  ResponsiveSize.getSize(context, screenSize.width * 0.02),
                ),
              ] // Hide actions in AppBar, show them in Drawer
                  : [
                InkWell(
                    highlightColor: Colors.transparent,  // Remove the highlight shadow
                    splashColor: Colors.transparent,
                hoverColor:  Colors.transparent,  // Remove the highlight shadow
                onTap: () {
                  homeController.selectedMenuIndex = 0;
                  homeController.scrollToSection(controller.aboutKey);
                  homeController.update();
                },
              child: _menuItem("About", screenSize, context,0,isTabletOrMobile)),

                InkWell(
                    highlightColor: Colors.transparent,  // Remove the highlight shadow
                    splashColor: Colors.transparent,
                    hoverColor:  Colors.transparent,
                    onTap: () {
                      homeController.selectedMenuIndex = 1;
                      homeController.scrollToSection(controller.experienceKey);
                      homeController.update();
                    },
                    child: _menuItem("Experience", screenSize, context,1,isTabletOrMobile)),
                InkWell(
                    highlightColor: Colors.transparent,  // Remove the highlight shadow
                    splashColor: Colors.transparent,
                    hoverColor:  Colors.transparent,
                    onTap: () {
                      homeController.selectedMenuIndex = 2;
                      homeController.scrollToSection(controller.toolsKey);
                      homeController.update();
                    },
                    child: _menuItem("Tools", screenSize, context,2,isTabletOrMobile)),
                InkWell(
                    highlightColor: Colors.transparent,  // Remove the highlight shadow
                    splashColor: Colors.transparent,
                    hoverColor:  Colors.transparent,
                    onTap: () {
                      homeController.selectedMenuIndex = 3;
                      homeController.scrollToSection(controller.projectsKey);
                      homeController.update();
                    },
                    child: _menuItem("Projects", screenSize, context,3,isTabletOrMobile)),
                InkWell(
                    highlightColor: Colors.transparent,  // Remove the highlight shadow
                    splashColor: Colors.transparent,
                    hoverColor:  Colors.transparent,
                    onTap: () {
                      homeController.selectedMenuIndex = 4;
                      homeController.scrollToSection(controller.blogKey);
                      homeController.update();
                    },
                    child: _menuItem("Blogs", screenSize, context,4,isTabletOrMobile)),

                InkWell(
                    highlightColor: Colors.transparent,  // Remove the highlight shadow
                    splashColor: Colors.transparent,
                    hoverColor:  Colors.transparent,
                    onTap: () {
                      homeController.selectedMenuIndex = 5;
                      homeController.scrollToSection(controller.contactKey);
                      homeController.update();
                    },
                    child: _menuItem("Contact", screenSize, context,5,isTabletOrMobile)),
                SizedBox(
                  width:
                  ResponsiveSize.getSize(context, screenSize.width * 0.02),
                ),
              ],
            ),
            drawer: isTabletOrMobile
                ? Drawer(
              backgroundColor: ColorConstants.whiteColor,
              child: Padding(
                padding:  EdgeInsets.only(top:  ResponsiveSize.getSize(context, screenSize.height * 0.08),),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    AnimatedTextKit(
                      animatedTexts: [
                        TyperAnimatedText(
                          "GIRITHAR K",
                          textStyle: TextStyle(
                              fontSize:isTabletOrMobile?22:24,
                              color: ColorConstants.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Airbeat'

                          ),
                          textAlign: TextAlign.center,
                          speed: Duration(milliseconds: 60), // Adjust typing speed
                        ),
                      ],
                      isRepeatingAnimation: false,
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    _drawerItem(isTabletOrMobile,"About", context, controller.aboutKey),
                    Divider(color: Colors.grey[200],height: 0,thickness: 2,),
                    _drawerItem(isTabletOrMobile,"Experience", context, controller.experienceKey),
                    Divider(color: Colors.grey[200],height: 0,thickness: 2,),
                    _drawerItem(isTabletOrMobile,"Tools", context, controller.toolsKey),
                    Divider(color: Colors.grey[200],height: 0,thickness: 2,),
                    _drawerItem(isTabletOrMobile,"Projects", context, controller.projectsKey),
                    Divider(color: Colors.grey[200],height: 0,thickness: 2,),
                    _drawerItem(isTabletOrMobile,"Blogs", context, controller.blogKey),
                    Divider(color: Colors.grey[200],height: 0,thickness: 2,),
                    _drawerItem(isTabletOrMobile,"Contact", context, controller.contactKey),
                  ],
                ),
              ),
            )
                : null,
            body: LayoutBuilder(builder: (context, constraints) {
              return NotificationListener<ScrollNotification>(
                onNotification: (scrollNotification) {
                  double scrollPosition = scrollNotification.metrics.extentBefore;

                  // Show Second Segment
                  if (scrollPosition > constraints.maxHeight * 0.5) {
                    showSecondSegment.value = true;
                  } else {
                    showSecondSegment.value = false;
                  }

                  // Show Third Segment
                  if (scrollPosition > constraints.maxHeight * 0.9) {
                    showThirdSegment.value = true;
                  } else {
                    showThirdSegment.value = false;
                  }

                  return true;
                },
                child: SingleChildScrollView(
                  physics: ScrollPhysics(),
                  // padding: const EdgeInsets.all(16.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: isTabletOrMobile ?100:160, // Keep vertical spacing consistent
                          ),
                          child: isTabletOrMobile
                              ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: ColorConstants.primaryColor,
                                radius: isTabletOrMobile ? 140 : 190,
                                // ResponsiveSize.getSize(context, 130),
                                child: CircleAvatar(
                                  backgroundColor: ColorConstants.whiteColor,
                                  radius: isTabletOrMobile ? 130 : 180,
                                  // ResponsiveSize.getSize(context, 120),
                                  //isMobile ? 100 : 170, // Adjust for mobile
                                  backgroundImage:
                                  AssetImage(AssetConstants.profileImage),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: AnimatedTextKit(
                                      animatedTexts: [
                                        TyperAnimatedText(
                                          "Hello, I'm",
                                          textStyle: TextStyle(
                                              fontSize:isTabletOrMobile ? 16 : 18,
                                              color: ColorConstants.darkGreyColor,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: FontConstants.fontFamily

                                          ),
                                          speed: Duration(milliseconds: 60), // Adjust typing speed
                                        ),
                                      ],
                                      isRepeatingAnimation: false,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  AnimatedTextKit(
                                    animatedTexts: [
                                      TyperAnimatedText(
                                        "GIRITHAR K",
                                        textStyle: TextStyle(
                                            fontSize:isTabletOrMobile ? 20 : 24,
                                            color: ColorConstants.primaryColor,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: FontConstants.fontFamily

                                        ),
                                        speed: Duration(milliseconds: 60), // Adjust typing speed
                                      ),
                                    ],
                                    isRepeatingAnimation: false,
                                  ),

                                  SizedBox(
                                    height: 10,
                                  ),
                                  AnimatedTextKit(
                                    animatedTexts: [
                                      TyperAnimatedText(
                                        "Software Developer",
                                        textStyle: TextStyle(
                                            fontSize:isTabletOrMobile ? 20 : 24,
                                            color: ColorConstants.darkGreyColor,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: FontConstants.fontFamily

                                        ),
                                        speed: Duration(milliseconds: 60), // Adjust typing speed
                                      ),
                                    ],
                                    isRepeatingAnimation: false,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        highlightColor: Colors.transparent,  // Remove the highlight shadow
                                        splashColor: Colors.transparent,
                                        hoverColor:  Colors.transparent,
                                        onTap: () {
                                          homeController.resumeDriveLink();
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 5,
                                              bottom: 5),
                                          decoration: BoxDecoration(
                                              color:
                                              ColorConstants.primaryColor,
                                              borderRadius:
                                              BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: ColorConstants
                                                      .lightGrey)),
                                          child: Text(
                                            "Download CV",
                                            style: TextStyle(
                                                fontSize:isTabletOrMobile ? 16 : 20,
                                                fontFamily:
                                                FontConstants.fontFamily,
                                                color:
                                                ColorConstants.whiteColor,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      InkWell(
                                        highlightColor: Colors.transparent,  // Remove the highlight shadow
                                        splashColor: Colors.transparent,
                                        hoverColor:  Colors.transparent,
                                        onTap: () {
                                          HomeController.openEmailApp(
                                              toMail: "girithardev@gmail.com");
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 5,
                                              bottom: 5),
                                          decoration: BoxDecoration(
                                              color:
                                              ColorConstants.primaryColor,
                                              borderRadius:
                                              BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: ColorConstants
                                                      .lightGrey)),
                                          child: Text(
                                            "Contact Info",
                                            style: TextStyle(
                                                fontSize:isTabletOrMobile ? 16 : 20,
                                                fontFamily:
                                                FontConstants.fontFamily,
                                                color:
                                                ColorConstants.whiteColor,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Wrap(
                                        spacing: 0,
                                        alignment: WrapAlignment.center,
                                        children: [
                                          InkWell(
                                            highlightColor: Colors.transparent,  // Remove the highlight shadow
                                            splashColor: Colors.transparent,
                                            hoverColor:  Colors.transparent,
                                            onTap: () {
                                              homeController.linkedInLink();
                                            },
                                            child: Lottie.asset(
                                              'assets/images/lotties/linkedin.json',
                                              width:isTabletOrMobile?60:80,
                                              // ResponsiveSize.getSize(
                                              //     context, 50),
                                              height: isTabletOrMobile?60:80,
                                              // ResponsiveSize.getSize(
                                              //     context, 50),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          InkWell(
                                            highlightColor: Colors.transparent,  // Remove the highlight shadow
                                            splashColor: Colors.transparent,
                                            hoverColor:  Colors.transparent,
                                            onTap: () {
                                              homeController.gitHubLink();
                                            },
                                            child: Lottie.asset(
                                              'assets/images/lotties/github.json',
                                              width: isTabletOrMobile?60:80,
                                              // ResponsiveSize.getSize(
                                              //     context, 50),
                                              height: isTabletOrMobile?60:80,
                                                // ResponsiveSize.getSize(
                                                //   context, 50),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          )
                              : Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal:
                              getHorizontalPadding(constraints.maxWidth),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor: ColorConstants.primaryColor,
                                  radius: isTabletOrMobile ? 140 : 190,
                                  // ResponsiveSize.getSize(context, 130),
                                  child: CircleAvatar(
                                    backgroundColor: ColorConstants.whiteColor,
                                    radius:isTabletOrMobile ? 130 : 180,
                                    // ResponsiveSize.getSize(context, 120),
                                    //isMobile ? 100 : 170, // Adjust for mobile
                                    backgroundImage:
                                    AssetImage(AssetConstants.profileImage),
                                  ),
                                ),
                                SizedBox(
                                  width: screenSize.width * 0.04,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.only(top: 15),
                                        child:  AnimatedTextKit(
                                          animatedTexts: [
                                            TyperAnimatedText(
                                              "Hello, I'm",
                                              textStyle: TextStyle(
                                                  fontSize:isTabletOrMobile ? 16 : 18,
                                                  color: ColorConstants.darkGreyColor,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: FontConstants.fontFamily

                                              ),
                                              speed: Duration(milliseconds: 60), // Adjust typing speed
                                            ),
                                          ],
                                          isRepeatingAnimation: false,
                                        )
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    AnimatedTextKit(
                                      animatedTexts: [
                                        TyperAnimatedText(
                                          "GIRITHAR K",
                                          textStyle: TextStyle(
                                              fontSize:isTabletOrMobile ? 20 : 24,
                                              color: ColorConstants.primaryColor,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: FontConstants.fontFamily

                                          ),
                                          speed: Duration(milliseconds: 60), // Adjust typing speed
                                        ),
                                      ],
                                      isRepeatingAnimation: false,
                                    ),

                                    SizedBox(
                                      height: 10,
                                    ),
                                    AnimatedTextKit(
                                      animatedTexts: [
                                        TyperAnimatedText(
                                          "Software Developer",
                                          textStyle: TextStyle(
                                              fontSize:isTabletOrMobile ? 20 : 24,
                                              color: ColorConstants.darkGreyColor,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: FontConstants.fontFamily

                                          ),
                                          speed: Duration(milliseconds: 60), // Adjust typing speed
                                        ),
                                      ],
                                      isRepeatingAnimation: false,
                                    ),

                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          highlightColor: Colors.transparent,  // Remove the highlight shadow
                                          splashColor: Colors.transparent,
                                          hoverColor:  Colors.transparent,
                                          onTap: () {
                                            homeController.resumeDriveLink();
                                          },
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                top: 5,
                                                bottom: 5),
                                            decoration: BoxDecoration(
                                                color:
                                                ColorConstants.primaryColor,
                                                borderRadius:
                                                BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: ColorConstants
                                                        .lightGrey)),
                                            child: Text(
                                              "Download CV",
                                              style: TextStyle(
                                                  fontSize:isTabletOrMobile ? 16 : 20,
                                                  fontFamily:
                                                  FontConstants.fontFamily,
                                                  color:
                                                  ColorConstants.whiteColor,
                                                  fontWeight:
                                                  FontWeight.normal),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        InkWell(
                                          highlightColor: Colors.transparent,  // Remove the highlight shadow
                                          splashColor: Colors.transparent,
                                          hoverColor:  Colors.transparent,
                                          onTap: () {
                                            HomeController.openEmailApp(
                                                toMail:
                                                "girithardev@gmail.com");
                                          },
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                top: 5,
                                                bottom: 5),
                                            decoration: BoxDecoration(
                                                color:
                                                ColorConstants.primaryColor,
                                                borderRadius:
                                                BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: ColorConstants
                                                        .lightGrey)),
                                            child: Text(
                                              "Contact Info",
                                              style: TextStyle(
                                                  fontSize:isTabletOrMobile ? 16 : 20,
                                                  fontFamily:
                                                  FontConstants.fontFamily,
                                                  color:
                                                  ColorConstants.whiteColor,
                                                  fontWeight:
                                                  FontWeight.normal),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Wrap(
                                          spacing: 0,
                                          alignment: WrapAlignment.center,
                                          children: [
                                            InkWell(
                                              highlightColor: Colors.transparent,  // Remove the highlight shadow
                                              splashColor: Colors.transparent,
                                              hoverColor:  Colors.transparent,
                                              onTap: () {
                                                homeController.linkedInLink();
                                              },
                                              child: Lottie.asset(
                                                'assets/images/lotties/linkedin.json',
                                                width: isTabletOrMobile?60:80,
                                                // ResponsiveSize.getSize(
                                                //     context, 50),
                                                height: isTabletOrMobile?60:80,
                                                // ResponsiveSize.getSize(
                                                //     context, 50),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            InkWell(
                                              highlightColor: Colors.transparent,  // Remove the highlight shadow
                                              splashColor: Colors.transparent,
                                              hoverColor:  Colors.transparent,
                                              onTap: () {
                                                homeController.gitHubLink();
                                              },
                                              child: Lottie.asset(
                                                'assets/images/lotties/github.json',
                                                width: isTabletOrMobile?60:80,
                                                // ResponsiveSize.getSize(
                                                //     context, 50),
                                                height: isTabletOrMobile?60:80,
                                                // ResponsiveSize.getSize(
                                                //     context, 50),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: screenSize.height * 0.2),

                        // **Second Segment (Appears on Scroll)**
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: getHorizontalPadding(constraints.maxWidth),
                          ),
                          child: _buildSecondSegment(
                              isTabletOrMobile, context, screenSize),
                        ),
                        SizedBox(height: screenSize.height * 0.1),
                        _buildThirdSegment(
                          isTabletOrMobile,
                        ),
                        SizedBox(height: screenSize.height * 0.1),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: getHorizontalPadding(constraints.maxWidth),
                          ),
                          child: _buildToolsSegment(isTabletOrMobile, screenSize,context),
                        ),
                        SizedBox(height: screenSize.height * 0.1),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: getHorizontalPadding(constraints.maxWidth),
                          ),
                          child: _buildProjectsCarousel(isTabletOrMobile,context),
                        ),
                        SizedBox(height: screenSize.height * 0.1),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: getHorizontalPadding(constraints.maxWidth),
                          ),
                          child: _buildBloGGrid(isTabletOrMobile),
                        ),
                        SizedBox(height: screenSize.height * 0.1),
                        SizedBox(
                            child: _buildContact(isTabletOrMobile,screenSize,context))
                      ],
                    ),
                  ),
                ),
              );
            }),
            floatingActionButton: Container(
              color: Colors.transparent,
              width: isTabletOrMobile ? 90 : 120,
              height: isTabletOrMobile ? 90 : 120,
              margin: EdgeInsets.only(bottom: isTabletOrMobile ? 10 : 50, right: isTabletOrMobile ? 10 : 50),
              child: Theme(
                data: Theme.of(context).copyWith(
                  floatingActionButtonTheme: FloatingActionButtonThemeData(
                    hoverElevation: 0, // Removes hover elevation
                    splashColor: Colors.transparent, // Removes splash effect
                    focusColor: Colors.transparent,
                    highlightElevation: 0,
                  ),
                ),
                child: FloatingActionButton(
                  elevation: 0,
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  highlightElevation: 0,
                  shape: CircleBorder(),
                  backgroundColor: Colors.transparent,
                  onPressed: () async {
                    final Uri whatsappUrl = Uri.parse("https://wa.me/+918838304677");
                    try {
                      if (await canLaunchUrl(whatsappUrl)) {
                        await launchUrl(whatsappUrl);
                      }
                    } catch (e) {
                      Get.snackbar("Error", "Could not share on WhatsApp: $e", snackPosition: SnackPosition.BOTTOM);
                    }
                  },
                  child: Lottie.asset(
                    'assets/images/lotties/whatsapp.json',
                    width: isTabletOrMobile ? 90 : 120,
                    height: isTabletOrMobile ? 90 : 120,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),


          );
        }
      ),
    );
  }

  Widget _menuItem(String title, Size screenSize, context,int index,bool isMobile) {
    bool isSelected = homeController.selectedMenuIndex == index;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.01),
      child: Container(
        padding: EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isSelected?ColorConstants.whiteColor:Colors.transparent,

        ),
        child: Text(
          title,
          style: TextStyle(
              fontSize:isMobile?18:20,
              // ResponsiveSize.getSize(context, 16),
              fontFamily: FontConstants.fontFamily,
              fontWeight: FontWeight.bold,
              color: ColorConstants.primaryColor),
        ),
      ),
    );
  }

  Widget _drawerItem(bool isMobile,String title, context, scrollNavigationKey) {
    return   Builder(builder: (context) {
      return ListTile(
        title: Text(title,
            style: TextStyle(
              fontSize: isMobile?18:20,
              fontFamily: FontConstants.fontFamily,
            )),
        onTap: () {
          Scaffold.of(context).closeDrawer();
          homeController.scrollToSection(scrollNavigationKey);
        },
      );
    }
    );
  }

  /// 🌟 Second Segment - About Me, Experience, Projects
  Widget _buildSecondSegment(bool isMobile, context, Size screenSize) {
    return VisibilityDetector(
      key: Key('portfolio_section'),
      onVisibilityChanged: (info) {
        homeController.triggerAnimation(info.visibleFraction > 0.3);
      },
      child: SlideTransition(
        position: homeController.slideFromBottom,
        child: Container(
          margin: EdgeInsets.only(top: ResponsiveSize.getSize(context, 40)),
          key: homeController.aboutKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 🌟 About Me Section
              ReusableTextWidget(
                text: 'Get To Know More',
                color: Colors.grey.shade600,
                fontSize:  isMobile ? 22 : 24,
              ),
              SizedBox(
                height: 10,
              ),
              ReusableTextWidget(
                  text: "About Me",
                  fontSize:  isMobile ? 24 : 26,
                  fontWeight: FontWeight.w700),
              SizedBox(
                height: ResponsiveSize.getSize(context, screenSize.height * 0.10),
              ),
              ResponsiveCardSection(),
              SizedBox(
                height: ResponsiveSize.getSize(
                    context, screenSize.height * 0.08),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ReusableTextWidget(
                  text:
                  """My name is Girithar, and I am a Flutter Developer at Nearle Technologies Pvt Ltd. I have four years of experience in mobile application development within a Flutter environment. 
My skill set includes live tracking, Flutter charts, reusable widgets, dynamic links, deep links, and Firebase integration, among others. Currently, my team is developing both an e-commerce application and a staff booking application using a cross-platform approach. Daily, I focus on fixing bugs and enhancing features in our existing projects. I also manage data fetching from the backend, integrating APIs into the front end. Additionally, I train junior developers according to our business practices. 
\n As a startup, our responsibilities extend beyond development; we also handle design and testing before production. For development, we primarily use Android Studio, and for design, we utilize Figma. Our project management tool is Jira, while we rely on Bitbucket and Git for version control. For API testing, we use Postman, and for database management, we utilize HeidiSQL. 
We also follow the Model-View-Controller (MVC) pattern for our project development. Thank you!""",
                  fontSize: isMobile ? 16 : 18,
                  color: Colors.grey.shade700,
                  textAlign: TextAlign.start,
                  maxLines: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThirdSegment(bool isMobile) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isWideScreen =
            constraints.maxWidth > 600; // Adjust breakpoint as needed
        return Container(
          margin: EdgeInsets.only(top: ResponsiveSize.getSize(context, 40)),
          key: homeController.experienceKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title
              ReusableTextWidget(
                text: 'Explore My',
                color: Colors.grey.shade600,
                fontSize: isMobile ? 22 : 24,
              ),
              SizedBox(height: 10),
              ReusableTextWidget(
                  text: "Experience",
                  fontSize: isMobile ? 24 : 26,
                  fontWeight: FontWeight.w700),
              SizedBox(
                height: ResponsiveSize.getSize(context, 50),
              ),

              // Responsive Row/Column Layout
              isWideScreen
                  ? Row(
                children: [
                  Expanded(
                    child: _buildSkillContainer(
                        "Languages and Frameworks",
                        homeController.languagesAndFrameworks,
                        isMobile,
                        context),
                  ),
                  // SizedBox(width: 20),
                  // Expanded(child:  _buildSkillContainer("Tools, IDEs, and Others", homeController.toolsAndIDEs, isMobile,context)),
                ],
              )
                  : Column(
                children: [
                  _buildSkillContainer(
                      "Languages and Frameworks",
                      homeController.languagesAndFrameworks,
                      isMobile,
                      context),
                  // SizedBox(height: 20),
                  // _buildSkillContainer("Tools, IDEs, and Database", homeController.toolsAndIDEs, isMobile,context),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildToolsSegment(bool isMobile, Size screenSize,context) {

    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount;
        double width = constraints.maxWidth;

        if (width < 400) {
          crossAxisCount = 2;
        } else if (width < 700) {
          crossAxisCount = 3;
        } else {
          crossAxisCount = 2;
        }
        return Container(
          margin: EdgeInsets.only(top: ResponsiveSize.getSize(context, 40)),
          key: homeController.toolsKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title
              ReusableTextWidget(
                text: 'Explore My',
                color: Colors.grey.shade600,
                fontSize: isMobile ? 22 : 24,
              ),
              SizedBox(height: 10),
              ReusableTextWidget(
                  text: "Tools, IDEs, and Others",
                  fontSize:isMobile ? 24 : 26,
                  fontWeight: FontWeight.w700),
              SizedBox(
                height: ResponsiveSize.getSize(context, 60),
              ),

              SizedBox(
                height:width < 400 ?screenSize.height * 0.60:width < 700?screenSize.height * 0.85:screenSize.height * 0.90,
                child: GridView.builder(
                  controller: homeController.scrollController,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: width < 400 ? 3 : 2.5,
                    mainAxisExtent:width < 400 ?150:width < 700?300:400,

                    // ResponsiveSize.getSize(context, 300),
                  ),

                  scrollDirection: Axis.horizontal,
                  itemCount: homeController.toolsAndIDEs.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: screenSize.width *
                          0.2, // Ensure items have enough width
                      margin: EdgeInsets.symmetric(
                        horizontal: ResponsiveSize.getSize(context, 10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: ResponsiveSize.getSize(context, 100),
                            backgroundColor: ColorConstants.secondaryColor,
                            child: CircleAvatar(
                                backgroundColor: ColorConstants.whiteColor,
                                radius: ResponsiveSize.getSize(context, 90),
                                child: Image.asset(
                                  homeController.toolsAndIDEs[index]['image'] ??
                                      '',
                                  height: ResponsiveSize.getSize(context, 100),
                                  width: ResponsiveSize.getSize(context, 100),
                                )),
                          ),
                          SizedBox(
                            height: ResponsiveSize.getSize(context, 20),
                          ),
                          Expanded(
                            // Ensures text does not overflow
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ReusableTextWidget(
                                  text: homeController.toolsAndIDEs[index]
                                  ['name'] ??
                                      '',
                                  fontSize:isMobile ? 18 : 22, // Slightly reduced for better responsiveness
                                  fontWeight: FontWeight.bold,
                                  // overflow: TextOverflow.ellipsis, // Prevents text from overflowing
                                ),
                                ReusableTextWidget(
                                  text: homeController.toolsAndIDEs[index]
                                  ['level'] ??
                                      '',
                                  fontSize: isMobile ? 16 : 20,
                                  // overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }

  /// **Skill Container**
  Widget _buildSkillContainer(String title, List<Map<String, String>> skillList,
      bool isMobile, context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Column(
        children: [
          ReusableTextWidget(
            text: title,
            fontWeight: FontWeight.bold,
            fontSize: isMobile ? 22 : 24,
            color: Colors.grey.shade600,
          ),
          SizedBox(height: 30),
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount;
              double width = constraints.maxWidth;

              if (width < 400) {
                crossAxisCount = 2;
              } else if (width < 700) {
                crossAxisCount = 2;
              } else {
                crossAxisCount = 3;
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: width < 400 ? 3 : 2.5,
                  mainAxisExtent: isMobile?180:300,
                  // ResponsiveSize.getSize(context, 300),
                ),
                itemCount: skillList.length,
                itemBuilder: (context, index) {
                  return SkillWidget(
                    skillName: skillList[index]['name'] ?? '',
                    skillLogo: skillList[index]['image'] ?? '',
                    experienceLevel: skillList[index]['level'] ?? '',
                    isMobile: isMobile,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  double getHorizontalPadding(double screenWidth) {
    if (screenWidth < 600) return 16; // Mobile
    if (screenWidth < 1200) return 50; // Tablet
    return 150; // Large screens
  }

  // Widget _buildProjectsGrid() {
  //   return LayoutBuilder(
  //     builder: (context, constraints) {
  //       double width = constraints.maxWidth;
  //       int crossAxisCount = width < 600
  //           ? 1
  //           : width < 1000
  //               ? 2
  //               : 3; // Adjust grid columns
  //
  //       return Container(
  //         margin: EdgeInsets.only(top: ResponsiveSize.getSize(context, 40)),
  //         key: projectsKey,
  //         child: Column(
  //           children: [
  //             ReusableTextWidget(
  //               text: 'Browse My',
  //               color: Colors.grey.shade600,
  //               fontSize: ResponsiveSize.getSize(context, 20),
  //             ),
  //             SizedBox(height: 10),
  //             ReusableTextWidget(
  //                 text: "Projects",
  //                 fontSize: ResponsiveSize.getSize(context, 24),
  //                 fontWeight: FontWeight.w700),
  //             SizedBox(
  //               height: ResponsiveSize.getSize(context, 50),
  //             ),
  //             GridView.builder(
  //               shrinkWrap: true,
  //               physics:
  //                   NeverScrollableScrollPhysics(), // Prevents nested scrolling
  //               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //                 crossAxisCount: crossAxisCount,
  //                 crossAxisSpacing: 20,
  //                 mainAxisSpacing: 20,
  //                 mainAxisExtent: ResponsiveSize.getSize(context, 550),
  //                 childAspectRatio: 1.2, // Adjust for proper card proportions
  //               ),
  //               itemCount: homeController.projects.length,
  //               itemBuilder: (context, index) {
  //                 return _buildProjectCard(
  //                     homeController.projects[index], context);
  //               },
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  Widget _buildProjectsCarousel(bool isMobile,context) {
    return Container(
      key: homeController.projectsKey,
      margin: EdgeInsets.only(top: ResponsiveSize.getSize(context, 40)),
      child:GetBuilder<HomeController>(
          builder: (controller) {
            return Column(
              children: [
                ReusableTextWidget(text: 'Browse My', color: Colors.grey.shade600, fontSize:isMobile ? 22 : 24,),
                SizedBox(height: ResponsiveSize.getSize(context, 10)),

                ReusableTextWidget(
                    text: "Projects",  fontSize: isMobile ? 24 : 26, fontWeight: FontWeight.w700),
                SizedBox(height: ResponsiveSize.getSize(context, 50)),

                CarouselSlider(
                  carouselController: homeController.carouselController,
                  options: CarouselOptions(
                    height: isMobile ? 300 : 500, // Adjust as needed
                    onPageChanged: (index, reason) {
                      homeController.currentIndex = index;
                      homeController.update();
                    },
                    enlargeCenterPage: true, // Makes the current item bigger
                    autoPlay: true, // Enables auto sliding
                    autoPlayInterval: Duration(seconds: 3), // Time for auto slide
                    viewportFraction: 0.5, // Controls how much of the next/prev items are shown
                  ),
                  items:  homeController.projects.map((project) {
                    return _buildProjectCard(project);
                  }).toList(),
                ),

                SizedBox(height: ResponsiveSize.getSize(context, 60)),


                // SmoothPageIndicator for carousel dots
                AnimatedSmoothIndicator(
                  activeIndex: homeController.currentIndex,
                  count: homeController.projects.length,
                  effect: ExpandingDotsEffect(
                    dotHeight: 8,
                    dotWidth: 8,
                    activeDotColor: ColorConstants.primaryColor, // Customize as needed
                  ),
                  onDotClicked: (index) {
                    homeController.carouselController.animateToPage(index,);

                  },
                ),

              ],
            );
          }
      ),
    );
  }


  Widget _buildProjectCard(Project project) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: project.backgroundColor,
        // boxShadow: [
        //   BoxShadow(color: project.backgroundColor, blurRadius: 5, spreadRadius: 2),
        // ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                project.imagePath,
                fit: BoxFit.contain,

              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: ReusableTextWidget(
                text: project.title,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }



  Widget _buildBloGGrid(bool isMobile) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        int crossAxisCount = width < 600
            ? 1
            : width < 1000
            ? 2
            : 3; // Adjust grid columns

        return Container(
          margin: EdgeInsets.only(top: ResponsiveSize.getSize(context, 40)),
          key: homeController.blogKey,
          child: Column(
            children: [
              ReusableTextWidget(
                text: 'Explore My',
                color: Colors.grey.shade600,
                fontSize: isMobile ? 22 : 24,
              ),
              SizedBox(height: 10),
              ReusableTextWidget(
                  text: "Project Case Studies",
                  fontSize: isMobile ? 24 : 26,
                  fontWeight: FontWeight.w700),
              SizedBox(
                height: ResponsiveSize.getSize(context, 50),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics:
                NeverScrollableScrollPhysics(), // Prevents nested scrolling
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1.2, // Adjust for proper card proportions
                ),
                itemCount: homeController.blogs.length,
                itemBuilder: (context, index) {
                  return _buildBlocCard(
                    isMobile,
                      homeController.blogs[index],context);
                },
              ),
            ],
          ),
        );
      },
    );
  }



  Widget _buildBlocCard(bool isMobile,Project project, context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(width: 0.2, color: Colors.black)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: InkWell(
          highlightColor: Colors.transparent,  // Remove the highlight shadow
          splashColor: Colors.transparent,
          hoverColor:  Colors.transparent,
          onTap: ()async{
            final Uri blogUrl = Uri.parse(
              project.blogUrl,
            );

            try {
              if (await canLaunchUrl(blogUrl)) {
                await launchUrl(blogUrl);
              } else {}
            } catch (e) {
              logger.i('catchErrorBlog $e');
              // Handle any errors gracefully

            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child:    ReusableTextWidget(
                      text: project.imagePath,
                      fontSize: isMobile ? 22 : 26,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.primaryColor,
                      fontFamily: FontConstants.fontFamily,
                    ),
                    // Image.asset(
                    //   project.imagePath,
                    //   fit: BoxFit.contain, // Shows the full image without cropping
                    //   width: 400,
                    //   height: 200,
                    // ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              ReusableTextWidget(
                text: project.title,
                fontSize: isMobile ? 18 : 20,
                fontWeight: FontWeight.bold,
                fontFamily: FontConstants.fontFamily,
              ),
              SizedBox(
                height: 10,
              ),
              ReusableTextWidget(
                text: project.description,
                maxLines: 5,
                fontSize: isMobile ? 16 : 18,
                fontFamily: FontConstants.fontFamily,
              ),
              SizedBox(width: 5,),
              ReusableTextWidget(
                text: 'Read more....',
                fontSize: isMobile ? 16 : 18,
                color: ColorConstants.primaryColor,
                fontWeight: FontWeight.bold,
                fontFamily: FontConstants.fontFamily,
              ),
            ],
          ),
        ),
      ),
    );
  }


  ///Contact Info

  Widget _buildContact(bool isMobile,Size screenSize,context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return LayoutBuilder(
          builder: (context, constraints) {
            bool isWide = constraints.maxWidth > 600;
            double padding = constraints.maxWidth * (isWide ? 0.3 : 0.05);
            double formHeight = constraints.maxHeight * 0.7; // Adjust height dynamically
            return Center(
              child: SingleChildScrollView(
                child: Container(
                  height: isMobile?620:652,
                  width: screenSize.width,
                  padding: EdgeInsets.only(top: screenSize.height*0.08),
                  decoration: BoxDecoration(
                    color: ColorConstants.primaryColor,
                    gradient: LinearGradient(
                      colors: [Color(0XFFB1F0F7),Color(0XFFB1F0F7),], // Gradient colors

                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.transparent, // Light shadow
                        spreadRadius: 0,
                        blurRadius: 5,
                        offset: Offset(0, 3), // Moves shadow **only down**
                      ),
                    ],
                  ),
                  key:controller.contactKey,
                  child: SizedBox(
                    width:  constraints.maxWidth * 1,
                    height: formHeight, // Set height dynamically
                    child: Padding(
                      padding:  EdgeInsets.only(left:  padding, right: padding),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ReusableTextWidget(
                              text: 'Contact with me to sizzle your projects',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              color: ColorConstants.primaryColor,
                            ),
                            const SizedBox(height: 10),
                            ReusableTextWidget(
                              text: "Feel free to contact me if you have any questions. "
                                  "I'm available for new projects or just for chatting.",
                              textAlign: TextAlign.center,
                              fontSize: 16,
                              maxLines: 3,
                              color: ColorConstants.primaryColor,


                            ),
                            const SizedBox(height: 20),

                            // Responsive Name & Email Fields
                            isWide
                                ? Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: controller.nameController,
                                    style: TextStyle(color: ColorConstants.primaryColor,),
                                    decoration: const InputDecoration(
                                      labelText: "Name",
                                      labelStyle: TextStyle(color: ColorConstants.primaryColor,),
                                      focusedBorder:OutlineInputBorder(
                                        borderSide:  BorderSide(
                                          color: ColorConstants.primaryColor,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:  BorderSide(
                                          color: ColorConstants.primaryColor,
                                        ),
                                      ),
                                      border: OutlineInputBorder(),
                                      focusColor: ColorConstants.primaryColor,
                                      hoverColor: ColorConstants.primaryColor,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Enter your name";
                                      }
                                      return null;
                                    }
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: TextFormField(
                                    controller: controller.emailController,
                                    style: TextStyle(color: ColorConstants.primaryColor,),
                                    decoration: const InputDecoration(
                                      labelText: "Email",
                                      labelStyle: TextStyle(color: ColorConstants.primaryColor,),
                                      border: OutlineInputBorder(),
                                      focusedBorder:OutlineInputBorder(
                                        borderSide:  BorderSide(
                                          color: ColorConstants.primaryColor,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:  BorderSide(
                                          color: ColorConstants.primaryColor,
                                        ),
                                      ),
                                      focusColor: ColorConstants.primaryColor,
                                      hoverColor: ColorConstants.primaryColor,
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Enter a valid email";
                                      }
                                      return null;
                                    }
                                  ),
                                ),
                              ],
                            )
                                : Column(
                              children: [
                                TextFormField(
                                  controller: controller.nameController,
                                    focusNode: controller.nameFocusNode,
                                    onTap: () {
                                      controller.nameFocusNode.requestFocus();
                                    },
                                  style: TextStyle(color: ColorConstants.primaryColor,),
                                  decoration: const InputDecoration(
                                    labelText: "Name",
                                    labelStyle: TextStyle(color: ColorConstants.primaryColor,),
                                    border: OutlineInputBorder(),
                                    focusedBorder:OutlineInputBorder(
                                      borderSide:  BorderSide(
                                        color: ColorConstants.primaryColor,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:  BorderSide(
                                        color: ColorConstants.primaryColor,
                                      ),
                                    ),
                                    focusColor: ColorConstants.primaryColor,
                                    hoverColor: ColorConstants.primaryColor,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Enter your name";
                                    }
                                    return null;
                                  }
                                ),
                                const SizedBox(height: 15),
                                TextFormField(
                                  controller: controller.emailController,
                                  style: TextStyle(color: ColorConstants.primaryColor,),
                                  decoration: const InputDecoration(
                                    labelText: "Email",
                                    labelStyle: TextStyle(color: ColorConstants.primaryColor,),
                                    border: OutlineInputBorder(),
                                    focusedBorder:OutlineInputBorder(
                                      borderSide:  BorderSide(
                                        color: ColorConstants.primaryColor,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:  BorderSide(
                                        color: ColorConstants.primaryColor,
                                      ),
                                    ),
                                    focusColor: ColorConstants.primaryColor,
                                    hoverColor: ColorConstants.primaryColor,
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Enter a valid email";
                                    }
                                    return null;
                                  }
                                ),
                              ],
                            ),

                            const SizedBox(height: 15),
                            TextFormField(
                              controller: controller.descriptionController,
                              style: TextStyle(color: ColorConstants.primaryColor,),
                              decoration: const InputDecoration(
                                labelText: "Description...",
                                labelStyle: TextStyle(color: ColorConstants.primaryColor,),
                                border: OutlineInputBorder(),
                                focusedBorder:OutlineInputBorder(
                                  borderSide:  BorderSide(
                                    color: ColorConstants.primaryColor,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:  BorderSide(
                                    color: ColorConstants.primaryColor,
                                  ),
                                ),
                                focusColor: ColorConstants.primaryColor,
                                hoverColor: ColorConstants.primaryColor,

                              ),
                              maxLines: 4,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Enter work details name";
                                }
                                return null;
                              }
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              // height: ResponsiveSize.getSize(context, screenSize.height*0.05),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorConstants.primaryColor,
                                  foregroundColor: ColorConstants.primaryColor,
                                  padding: const EdgeInsets.symmetric(vertical: 15),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {

                                    controller.sendEmail(controller.nameController.text,controller.emailController.text,controller.descriptionController.text);
                                    // Toast.showToast('Form Submitted');
                                    // Handle form submission
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text("Form Submitted",style: TextStyle(color: ColorConstants.primaryColor),),backgroundColor: ColorConstants.primaryColor,),
                                    );
                                  }
                                },
                                child:  Text("Submit",style: TextStyle(fontWeight: FontWeight.bold,color: ColorConstants.whiteColor),),
                              ),
                            ),
                            const SizedBox(height: 20),
                            ReusableTextWidget(
                              text: '© Copyrights. All Rights Reserved.',
                              fontSize: isMobile?14:20,
                                // ResponsiveSize.getSize(context, 15),
                              color: ColorConstants.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }
    );



  }


}



class SkillWidget extends StatelessWidget {
  final String skillName;
  final String skillLogo;
  final String experienceLevel;
  final bool isMobile;

  const SkillWidget({
    super.key,
    required this.skillName,
    required this.skillLogo,
    required this.experienceLevel,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min, // Prevent excessive width usage
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Image.asset(
                skillLogo,
                height: ResponsiveSize.getSize(context, 100),
                width: ResponsiveSize.getSize(context, 100),
              ),
            ),
            SizedBox(height: 10), // Reduced spacing to prevent overflow
            Expanded(
              // Ensures text does not overflow
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ReusableTextWidget(
                    text: skillName,
                    fontSize:isMobile ? 22 : 24, // Slightly reduced for better responsiveness
                    fontWeight: FontWeight.bold,
                    // overflow: TextOverflow.ellipsis, // Prevents text from overflowing
                  ),
                  ReusableTextWidget(
                    text: experienceLevel,
                    fontSize: isMobile ? 20 : 22,
                    // overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}



class ResponsiveCardSection extends StatelessWidget {
  ResponsiveCardSection({super.key});

  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    int crossAxisCount = width > 900 ? 4 : (width > 600 ? 2 : 2);
    double aspectRatio = width > 1400 ? 2.6 : (width > 900 ? 1.5 : (width > 600 ? 2.0 : 1.5));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: aspectRatio,
        ),
        itemCount: homeController.cardData.length,
        itemBuilder: (context, index) {
          return _buildCard(homeController.cardData[index]['title']!,homeController.cardData[index]['subtitle']!);
        },
      ),
    );
  }

  Widget _buildCard(String title, String subtitle) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide( // Added border
          color: Colors.grey.shade200, // Border color
          width: 1, // Border width
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //mainAxisSize: MainAxisSize.min,
          children: [
            ReusableTextWidget(text: title, fontSize: 24, fontWeight: FontWeight.bold, color: ColorConstants.primaryColor,fontFamily: FontConstants.fontFamily,),
            SizedBox(height: 5),
            ReusableTextWidget(text: subtitle, fontSize: 16, color: Colors.grey.shade600,)

          ],
        ),
      ),
    );
  }

}

