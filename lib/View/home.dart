import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:portfolio/Controller/Home/homeController.dart';
import 'package:portfolio/Helper/assetConstants.dart';
import 'package:portfolio/Helper/colorConstants.dart';
import 'package:portfolio/Helper/fontConstants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Model/projectModel.dart';
import '../globalWidgets/responsiveSizeWidget.dart';
import '../globalWidgets/textWidget.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  HomeController homeController = Get.put(HomeController());

  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey experienceKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey toolsKey = GlobalKey();
  final GlobalKey blogKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ///Scroll
    ValueNotifier<bool> showSecondSegment = ValueNotifier<bool>(false);
    ValueNotifier<bool> showThirdSegment = ValueNotifier<bool>(false);

    ///Responsive
    Size screenSize = MediaQuery.of(context).size;
    bool isTabletOrMobile = screenSize.width <= ResponsiveSize.tabletWidth;

    return Scaffold(
      backgroundColor: ColorConstants.whiteColor,
      appBar: AppBar(
        toolbarHeight:
            ResponsiveSize.getSize(context, screenSize.height * 0.08),
        backgroundColor: ColorConstants.primaryColor,
        leading: isTabletOrMobile ? Image.asset(AssetConstants.GiritharLogoImage,height: ResponsiveSize.getSize(context, screenSize.height * 0.08),width: ResponsiveSize.getSize(context, screenSize.width * 0.04),fit: BoxFit.fill,): null,
        title: isTabletOrMobile
            ?Container():Image.asset(AssetConstants.GiritharLogoImage,height: ResponsiveSize.getSize(context, screenSize.height * 0.08),width: ResponsiveSize.getSize(context, screenSize.width * 0.04),fit: BoxFit.fill,),
        // flexibleSpace: Padding(
        //   padding: EdgeInsets.only(
        //       left: ResponsiveSize.getSize(context, screenSize.width * 0.04),
        //       right: ResponsiveSize.getSize(context, screenSize.width * 0.02),
        //       top: ResponsiveSize.getSize(context, screenSize.height * 0.02)),
        //   child: Row(
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       Image.asset(AssetConstants.GiritharLogoImage,height: ResponsiveSize.getSize(context, screenSize.height * 0.06),width: ResponsiveSize.getSize(context, screenSize.width * 0.06),),
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
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.white,
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
                    onTap: () {
                      homeController.scrollToSection(aboutKey);
                    },
                    child: _menuItem("About", screenSize, context)),
                InkWell(
                    onTap: () {
                      homeController.scrollToSection(experienceKey);
                    },
                    child: _menuItem("Experience", screenSize, context)),
                InkWell(
                    onTap: () {
                      homeController.scrollToSection(projectsKey);
                    },
                    child: _menuItem("Projects", screenSize, context)),
                InkWell(
                    onTap: () {
                      homeController.scrollToSection(blogKey);
                    },
                    child: _menuItem("Blogs", screenSize, context)),
                InkWell(
                    onTap: () {
                      homeController.scrollToSection(toolsKey);
                    },
                    child: _menuItem("Tools", screenSize, context)),
                InkWell(
                    onTap: () {
                      homeController.scrollToSection(contactKey);
                    },
                    child: _menuItem("Contact", screenSize, context)),
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
                              fontSize:ResponsiveSize.getSize(
                                  context, 26),
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

                    _drawerItem("About", context, aboutKey),
                    Divider(color: Colors.grey[200],height: 0,thickness: 2,),
                    _drawerItem("Experience", context, experienceKey),
                    Divider(color: Colors.grey[200],height: 0,thickness: 2,),
                    _drawerItem("Projects", context, projectsKey),
                    Divider(color: Colors.grey[200],height: 0,thickness: 2,),
                    _drawerItem("Blogs", context, blogKey),
                    Divider(color: Colors.grey[200],height: 0,thickness: 2,),
                    _drawerItem("Tools", context, toolsKey),
                    Divider(color: Colors.grey[200],height: 0,thickness: 2,),
                    _drawerItem("Contact", context, contactKey),
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
                      vertical: 200, // Keep vertical spacing consistent
                    ),
                    child: isTabletOrMobile
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: ColorConstants.primaryColor,
                                radius: ResponsiveSize.getSize(context, 130),
                                child: CircleAvatar(
                                  backgroundColor: ColorConstants.whiteColor,
                                  radius: ResponsiveSize.getSize(context, 120),
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
                                              fontSize:ResponsiveSize.getSize(
                                                  context, 18),
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
                                        "Girithar K",
                                        textStyle: TextStyle(
                                            fontSize:
                                            ResponsiveSize.getSize(context, 26),
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
                                            fontSize:
                                            ResponsiveSize.getSize(context, 26),
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
                                                fontSize:
                                                    ResponsiveSize.getSize(
                                                        context, 16),
                                                fontFamily:
                                                    FontConstants.fontFamily,
                                                color:
                                                    ColorConstants.whiteColor,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      InkWell(
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
                                                fontSize:
                                                    ResponsiveSize.getSize(
                                                        context, 16),
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
                                            onTap: () {
                                              homeController.linkedInLink();
                                            },
                                            child: Lottie.asset(
                                              'assets/images/lotties/linkedin.json',
                                              width: ResponsiveSize.getSize(
                                                  context, 50),
                                              height: ResponsiveSize.getSize(
                                                  context, 50),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              homeController.gitHubLink();
                                            },
                                            child: Lottie.asset(
                                              'assets/images/lotties/github.json',
                                              width: ResponsiveSize.getSize(
                                                  context, 50),
                                              height: ResponsiveSize.getSize(
                                                  context, 50),
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
                                  radius: ResponsiveSize.getSize(context, 130),
                                  child: CircleAvatar(
                                    backgroundColor: ColorConstants.whiteColor,
                                    radius:
                                        ResponsiveSize.getSize(context, 120),
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
                                                fontSize:ResponsiveSize.getSize(
                                                    context, 18),
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
                                          "Girithar K",
                                          textStyle: TextStyle(
                                              fontSize:
                                              ResponsiveSize.getSize(context, 26),
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
                                              fontSize:
                                              ResponsiveSize.getSize(context, 26),
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
                                                  fontSize:
                                                      ResponsiveSize.getSize(
                                                          context, 16),
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
                                          width: 5,
                                        ),
                                        InkWell(
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
                                                  fontSize:
                                                      ResponsiveSize.getSize(
                                                          context, 16),
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
                                              onTap: () {
                                                homeController.linkedInLink();
                                              },
                                              child: Lottie.asset(
                                                'assets/images/lotties/linkedin.json',
                                                width: ResponsiveSize.getSize(
                                                    context, 50),
                                                height: ResponsiveSize.getSize(
                                                    context, 50),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                homeController.gitHubLink();
                                              },
                                              child: Lottie.asset(
                                                'assets/images/lotties/github.json',
                                                width: ResponsiveSize.getSize(
                                                    context, 50),
                                                height: ResponsiveSize.getSize(
                                                    context, 50),
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
                  SizedBox(height: screenSize.height * 0.3),

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
                    child: _buildToolsSegment(isTabletOrMobile, screenSize),
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
                    child: _buildBloGGrid(),
                  ),
                  SizedBox(height: screenSize.height * 0.2),
                  SizedBox(
                    height: 600,
                      child: _buildContact(isTabletOrMobile,screenSize,context))
                ],
              ),
            ),
          ),
        );
      }),
      floatingActionButton: Container(
        width: ResponsiveSize.getSize(
            context, 90),
        height: ResponsiveSize.getSize(
            context, 90),
        margin: EdgeInsets.only(bottom:ResponsiveSize.getSize(
            context, 50),right: ResponsiveSize.getSize(
            context, 50) ),
        child: FloatingActionButton(
          elevation: 0,
          shape: CircleBorder(),
          backgroundColor: ColorConstants.whiteColor,
          onPressed: () async {
            // Create WhatsApp URL with the phone number and encoded message
            final Uri whatsappUrl = Uri.parse(
              "https://wa.me/+918838304677",
            );

            try {
              // Check if the WhatsApp URL can be launched
              if (await canLaunchUrl(whatsappUrl)) {
                await launchUrl(whatsappUrl);
              } else {}
            } catch (e) {
              // Handle any errors gracefully
              Get.snackbar(
                "Error",
                "Could not share on WhatsApp: $e",
                snackPosition: SnackPosition.BOTTOM,
              );
            }
          },
          child: Lottie.asset(
            'assets/images/lotties/whatsapp.json',
            width: ResponsiveSize.getSize(
                context, 80),
            height: ResponsiveSize.getSize(
                context, 80),
            fit: BoxFit.fill,
          ),
          // Image.asset(AssetConstants.whatsappLogo,),
        ),
      ),
    );
  }

  Widget _menuItem(String title, Size screenSize, context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.01),
      child: Text(
        title,
        style: TextStyle(
            fontSize: ResponsiveSize.getSize(context, 16),
            fontFamily: FontConstants.fontFamily,
            color: ColorConstants.whiteColor),
      ),
    );
  }

  Widget _drawerItem(String title, context, scrollNavigationKey) {
    return   Builder(builder: (context) {
        return ListTile(
          title: Text(title,
              style: TextStyle(
                fontSize: ResponsiveSize.getSize(context, 24),
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
    return Container(
      margin: EdgeInsets.only(top: ResponsiveSize.getSize(context, 40)),
      key: aboutKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 🌟 About Me Section
          ReusableTextWidget(
            text: 'Get To Know More',
            color: Colors.grey.shade600,
            fontSize: ResponsiveSize.getSize(context, 20),
          ),
          SizedBox(
            height: 10,
          ),
          ReusableTextWidget(
              text: "About Me",
              fontSize: ResponsiveSize.getSize(context, 24),
              fontWeight: FontWeight.w700),
          SizedBox(
            height: ResponsiveSize.getSize(context, screenSize.height * 0.10),
          ),
          isMobile
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorConstants.primaryColor,
                        border: Border.all(
                          width: 0.5,
                          color: Colors.black,
                        ),
                      ),
                      child: Container(
                          margin: EdgeInsets.only(
                            left: ResponsiveSize.getSize(
                                context, screenSize.width * 0.005),
                            right: ResponsiveSize.getSize(
                                context, screenSize.width * 0.005),
                            top: ResponsiveSize.getSize(
                                context, screenSize.height * 0.01),
                            bottom: ResponsiveSize.getSize(
                                context, screenSize.height * 0.01),
                          ),

                          // margin: EdgeInsets.only(left:  ResponsiveSize.getSize(context, screenSize.width * 0.01), right: ResponsiveSize.getSize(context, screenSize.width * 0.01), top: ResponsiveSize.getSize(context, screenSize.height * 0.01), bottom: ResponsiveSize.getSize(context, screenSize.height * 0.01),),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorConstants.whiteColor,
                            border: Border.all(
                              width: 0.5,
                              color: Colors.black,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: ResponsiveSize.getSize(
                                  context, screenSize.width * 0.005),
                              right: ResponsiveSize.getSize(
                                  context, screenSize.width * 0.005),
                              top: ResponsiveSize.getSize(
                                  context, screenSize.height * 0.01),
                              bottom: ResponsiveSize.getSize(
                                  context, screenSize.height * 0.01),
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  AssetConstants.profileImageOne,
                                  height: ResponsiveSize.getSize(
                                      context, screenSize.height * 0.45),
                                  fit: BoxFit.fill,
                                )),
                          )),
                    ),
                    SizedBox(
                      height: ResponsiveSize.getSize(
                          context, screenSize.height * 0.08),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 0.5,
                                  color: Colors.black,
                                )),
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: ResponsiveSize.getSize(
                                    context, screenSize.width * 0.04),
                                right: ResponsiveSize.getSize(
                                    context, screenSize.width * 0.04),
                                top: ResponsiveSize.getSize(
                                    context, screenSize.height * 0.02),
                                bottom: ResponsiveSize.getSize(
                                    context, screenSize.height * 0.02),
                              ),
                              child: Column(
                                children: [
                                  Image.asset(
                                    AssetConstants.experienceLogo,
                                    height: ResponsiveSize.getSize(context, 50),
                                    width: ResponsiveSize.getSize(context, 50),
                                  ),
                                  ReusableTextWidget(
                                    text: 'Experience',
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        ResponsiveSize.getSize(context, 18),
                                    color: Colors.black,
                                  ),
                                  ReusableTextWidget(
                                    text: '3.2+ years',
                                    fontSize:
                                        ResponsiveSize.getSize(context, 15),
                                    color: Colors.grey.shade700,
                                  ),
                                  ReusableTextWidget(
                                    text: 'Flutter Application Development',
                                    fontSize:
                                        ResponsiveSize.getSize(context, 15),
                                    color: Colors.grey.shade700,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 0.5,
                                  color: Colors.black,
                                )),
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: ResponsiveSize.getSize(
                                    context, screenSize.width * 0.04),
                                right: ResponsiveSize.getSize(
                                    context, screenSize.width * 0.04),
                                top: ResponsiveSize.getSize(
                                    context, screenSize.height * 0.02),
                                bottom: ResponsiveSize.getSize(
                                    context, screenSize.height * 0.02),
                              ),
                              child: Column(
                                children: [
                                  Image.asset(
                                    AssetConstants.educationLogo,
                                    height: ResponsiveSize.getSize(context, 50),
                                    width: ResponsiveSize.getSize(context, 50),
                                  ),
                                  ReusableTextWidget(
                                    text: 'Education',
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        ResponsiveSize.getSize(context, 18),
                                    color: Colors.black,
                                    textAlign: TextAlign.center,
                                  ),
                                  ReusableTextWidget(
                                    text: 'BCA Degree',
                                    fontSize:
                                        ResponsiveSize.getSize(context, 15),
                                    color: Colors.grey.shade700,
                                    textAlign: TextAlign.center,
                                  ),
                                  ReusableTextWidget(
                                    text: 'Flutter Application Development',
                                    fontSize:
                                        ResponsiveSize.getSize(context, 15),
                                    color: Colors.grey.shade700,
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: ResponsiveSize.getSize(
                          context, screenSize.height * 0.08),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ReusableTextWidget(
                        text:
                            """I am a Flutter developer passionate about building high-performance, cross-platform apps with Dart and Flutter. I also have experience with FastAPI in Python for efficient backend solutions.My skills in Figma help me craft intuitive UI/UX designs, while my knowledge of manual testing ensures product quality. I am deeply interested in product development, from ideation to execution, aiming to create impactful user experiences. Always eager to learn and innovate—let’s build something amazing! 🚀""",
                        fontSize: isMobile ? 16 : 18,
                        color: Colors.grey.shade700,
                        textAlign: TextAlign.center,
                        maxLines: 10,
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: ResponsiveSize.getSize(
                          context, screenSize.width * 0.20),
                      // margin: EdgeInsets.only(right:  ResponsiveSize.getSize(context, screenSize.width * 0.12),   ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorConstants.primaryColor,
                        border: Border.all(
                          width: 0.5,
                          color: Colors.black,
                        ),
                      ),

                      child: Container(
                          margin: EdgeInsets.only(
                            left: ResponsiveSize.getSize(
                                context, screenSize.width * 0.005),
                            right: ResponsiveSize.getSize(
                                context, screenSize.width * 0.005),
                            top: ResponsiveSize.getSize(
                                context, screenSize.height * 0.01),
                            bottom: ResponsiveSize.getSize(
                                context, screenSize.height * 0.01),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorConstants.whiteColor,
                            border: Border.all(
                              width: 0.5,
                              color: Colors.black,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: ResponsiveSize.getSize(
                                  context, screenSize.width * 0.005),
                              right: ResponsiveSize.getSize(
                                  context, screenSize.width * 0.005),
                              top: ResponsiveSize.getSize(
                                  context, screenSize.height * 0.01),
                              bottom: ResponsiveSize.getSize(
                                  context, screenSize.height * 0.01),
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  AssetConstants.profileImageOne,
                                  height: ResponsiveSize.getSize(
                                      context, screenSize.height * 0.45),
                                  fit: BoxFit.fill,
                                )),
                          )),
                    ),
                    SizedBox(
                      width: ResponsiveSize.getSize(
                          context, screenSize.width * 0.04),
                    ),
                    Expanded(
                      // width: ResponsiveSize.getSize(context, screenSize.width * 0.4), // Adjust height as needed
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      width: 0.5,
                                      color: Colors.black,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: ResponsiveSize.getSize(
                                          context, screenSize.width * 0.04),
                                      right: ResponsiveSize.getSize(
                                          context, screenSize.width * 0.04),
                                      top: ResponsiveSize.getSize(
                                          context, screenSize.height * 0.02),
                                      bottom: ResponsiveSize.getSize(
                                          context, screenSize.height * 0.02),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize
                                          .min, // Ensures Column takes only needed space
                                      children: [
                                        Image.asset(
                                          AssetConstants.experienceLogo,
                                          height: ResponsiveSize.getSize(
                                              context, 50),
                                          width: ResponsiveSize.getSize(
                                              context, 50),
                                        ),
                                        ReusableTextWidget(
                                          text: 'Experience',
                                          fontWeight: FontWeight.bold,
                                          fontSize: ResponsiveSize.getSize(
                                              context, 18),
                                          color: Colors.black,
                                        ),
                                        ReusableTextWidget(
                                          text: '3.2+ years',
                                          fontSize: ResponsiveSize.getSize(
                                              context, 15),
                                          color: Colors.grey.shade700,
                                        ),
                                        ReusableTextWidget(
                                          text:
                                              'Flutter Application Development',
                                          fontSize: ResponsiveSize.getSize(
                                              context, 15),
                                          color: Colors.grey.shade700,
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: ResponsiveSize.getSize(
                                    context, screenSize.width * 0.02),
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      width: 0.5,
                                      color: Colors.black,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: ResponsiveSize.getSize(
                                          context, screenSize.width * 0.04),
                                      right: ResponsiveSize.getSize(
                                          context, screenSize.width * 0.04),
                                      top: ResponsiveSize.getSize(
                                          context, screenSize.height * 0.02),
                                      bottom: ResponsiveSize.getSize(
                                          context, screenSize.height * 0.02),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize
                                          .min, // Ensures Column takes only needed space
                                      children: [
                                        Image.asset(
                                          AssetConstants.educationLogo,
                                          height: ResponsiveSize.getSize(
                                              context, 50),
                                          width: ResponsiveSize.getSize(
                                              context, 50),
                                        ),
                                        ReusableTextWidget(
                                          text: 'Education',
                                          fontWeight: FontWeight.bold,
                                          fontSize: ResponsiveSize.getSize(
                                              context, 18),
                                          color: Colors.black,
                                          textAlign: TextAlign.center,
                                        ),
                                        ReusableTextWidget(
                                          text: 'BCA Degree',
                                          fontSize: ResponsiveSize.getSize(
                                              context, 15),
                                          color: Colors.grey.shade700,
                                          textAlign: TextAlign.center,
                                        ),
                                        ReusableTextWidget(
                                          text:
                                              'Flutter Application Development',
                                          fontSize: ResponsiveSize.getSize(
                                              context, 15),
                                          color: Colors.grey.shade700,
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: ResponsiveSize.getSize(
                                context, screenSize.height * 0.08),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: ReusableTextWidget(
                              text:
                                  """I am a Flutter developer passionate about building high-performance, cross-platform apps with Dart and Flutter. I also have experience with FastAPI in Python for efficient backend solutions.My skills in Figma help me craft intuitive UI/UX designs, while my knowledge of manual testing ensures product quality. I am deeply interested in product development, from ideation to execution, aiming to create impactful user experiences. Always eager to learn and innovate—let’s build something amazing! 🚀""",
                              fontSize: isMobile ? 16 : 18,
                              color: Colors.grey.shade700,
                              textAlign: TextAlign.center,
                              maxLines: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

          SizedBox(
            height: 50,
          )
        ],
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
          key: experienceKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title
              ReusableTextWidget(
                text: 'Explore My',
                color: Colors.grey.shade600,
                fontSize: ResponsiveSize.getSize(context, 20),
              ),
              SizedBox(height: 10),
              ReusableTextWidget(
                  text: "Experience",
                  fontSize: ResponsiveSize.getSize(context, 24),
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

  Widget _buildToolsSegment(bool isMobile, Size screenSize) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isWideScreen =
            constraints.maxWidth > 600; // Adjust breakpoint as needed
        return Container(
          margin: EdgeInsets.only(top: ResponsiveSize.getSize(context, 40)),
          key: toolsKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title
              ReusableTextWidget(
                text: 'Explore My',
                color: Colors.grey.shade600,
                fontSize: ResponsiveSize.getSize(context, 20),
              ),
              SizedBox(height: 10),
              ReusableTextWidget(
                  text: "Tools, IDEs, and Others",
                  fontSize: ResponsiveSize.getSize(context, 24),
                  fontWeight: FontWeight.w700),
              SizedBox(
                height: ResponsiveSize.getSize(context, 60),
              ),

              SizedBox(
                height: screenSize.height * 0.35,
                child: ListView.builder(
                  controller: homeController.scrollController,
                  physics: BouncingScrollPhysics(),
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
                                  fontSize: ResponsiveSize.getSize(context,
                                      20), // Slightly reduced for better responsiveness
                                  fontWeight: FontWeight.bold,
                                  // overflow: TextOverflow.ellipsis, // Prevents text from overflowing
                                ),
                                ReusableTextWidget(
                                  text: homeController.toolsAndIDEs[index]
                                          ['level'] ??
                                      '',
                                  fontSize: ResponsiveSize.getSize(context, 16),
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
            fontSize: ResponsiveSize.getSize(context, 22),
            color: Colors.grey.shade600,
          ),
          SizedBox(height: 40),
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount;
              double width = constraints.maxWidth;

              if (width < 400) {
                crossAxisCount = 1;
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
                  mainAxisExtent: ResponsiveSize.getSize(context, 200),
                ),
                itemCount: skillList.length,
                itemBuilder: (context, index) {
                  return SkillWidget(
                    skillName: skillList[index]['name'] ?? '',
                    skillLogo: skillList[index]['image'] ?? '',
                    experienceLevel: skillList[index]['level'] ?? '',
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
      key: projectsKey,
      margin: EdgeInsets.only(top: ResponsiveSize.getSize(context, 40)),
      child:GetBuilder<HomeController>(
        builder: (controller) {
          return Column(
            children: [
              ReusableTextWidget(text: 'Browse My', color: Colors.grey.shade600, fontSize: ResponsiveSize.getSize(context, 20),),
              SizedBox(height: ResponsiveSize.getSize(context, 10)),

              ReusableTextWidget(
                  text: "Projects",  fontSize: ResponsiveSize.getSize(context, 24), fontWeight: FontWeight.w700),
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



  Widget _buildBloGGrid() {
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
          key: blogKey,
          child: Column(
            children: [
              ReusableTextWidget(
                text: 'Explore My',
                color: Colors.grey.shade600,
                fontSize: ResponsiveSize.getSize(context, 20),
              ),
              SizedBox(height: 10),
              ReusableTextWidget(
                  text: "Blogs",
                  fontSize: ResponsiveSize.getSize(context, 24),
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
                itemCount: homeController.projects.length,
                itemBuilder: (context, index) {
                  return _buildBlocCard(
                      homeController.projects[index],context);
                },
              ),
            ],
          ),
        );
      },
    );
  }



  Widget _buildBlocCard(Project project, context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(width: 0.2, color: Colors.black)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  project.imagePath,
                  fit: BoxFit.fill, // Shows the full image without cropping
                  width: double.infinity,
                  height: 250,
                ),
              ),
            ),
            SizedBox(height: 10),
            ReusableTextWidget(
              text: project.title,
              fontSize: ResponsiveSize.getSize(context, 18),
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: 10,
            ),
            ReusableTextWidget(
              text: project.description,
              maxLines: 5,
              fontSize: ResponsiveSize.getSize(context, 15),
            ),
          ],
        ),
      ),
    );
  }


  ///Contact Info

  Widget _buildContact(bool isMobile,Size screenSize,context) {
    return Container(
      width: screenSize.width,
      decoration: BoxDecoration(color: ColorConstants.primaryColor,),
      key:contactKey,
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isWide = constraints.maxWidth > 600;
          double padding = constraints.maxWidth * (isWide ? 0.3 : 0.05);
          double formHeight = constraints.maxHeight * 0.7; // Adjust height dynamically
          return Center(
            child: SingleChildScrollView(
              child: SizedBox(
                width:  constraints.maxWidth * 1,
                height: formHeight, // Set height dynamically
                child: Padding(
                  padding:  EdgeInsets.only(left:  padding, right: padding),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ReusableTextWidget(
                          text: 'Contact with me to sizzle your project',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          color: ColorConstants.whiteColor,
                        ),
                        const SizedBox(height: 10),
                        ReusableTextWidget(
                          text: "Feel free to contact me if you have any questions. "
                              "I'm available for new projects or just for chatting.",
                          textAlign: TextAlign.center,
                          fontSize: 16,
                          maxLines: 3,
                          color: ColorConstants.whiteColor,


                        ),
                        const SizedBox(height: 20),

                        // Responsive Name & Email Fields
                        isWide
                            ? Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: homeController.nameController,
                                style: TextStyle(color: ColorConstants.whiteColor,),
                                decoration: const InputDecoration(
                                  labelText: "Name",
                                  labelStyle: TextStyle(color: ColorConstants.whiteColor,),
                                  focusedBorder:OutlineInputBorder(
                                    borderSide:  BorderSide(
                                      color: ColorConstants.whiteColor,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:  BorderSide(
                                      color: ColorConstants.whiteColor,
                                    ),
                                  ),
                                  border: OutlineInputBorder(),
                                  focusColor: ColorConstants.whiteColor,
                                  hoverColor: ColorConstants.whiteColor,
                                ),
                                validator: (value) =>
                                value!.isEmpty ? "Enter your name" : null,
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: TextFormField(
                                controller: homeController.emailController,
                                style: TextStyle(color: ColorConstants.whiteColor,),
                                decoration: const InputDecoration(
                                  labelText: "Email",
                                  labelStyle: TextStyle(color: ColorConstants.whiteColor,),
                                  border: OutlineInputBorder(),
                                  focusedBorder:OutlineInputBorder(
                                    borderSide:  BorderSide(
                                      color: ColorConstants.whiteColor,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:  BorderSide(
                                      color: ColorConstants.whiteColor,
                                    ),
                                  ),
                                  focusColor: ColorConstants.whiteColor,
                                  hoverColor: ColorConstants.whiteColor,
                                ),
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) =>
                                value!.isEmpty ? "Enter a valid email" : null,
                              ),
                            ),
                          ],
                        )
                            : Column(
                          children: [
                            TextFormField(
                              controller: homeController.nameController,
                              style: TextStyle(color: ColorConstants.whiteColor,),
                              decoration: const InputDecoration(
                                labelText: "Name",
                                labelStyle: TextStyle(color: ColorConstants.whiteColor,),
                                border: OutlineInputBorder(),
                                focusedBorder:OutlineInputBorder(
                                  borderSide:  BorderSide(
                                    color: ColorConstants.whiteColor,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:  BorderSide(
                                    color: ColorConstants.whiteColor,
                                  ),
                                ),
                                focusColor: ColorConstants.whiteColor,
                                hoverColor: ColorConstants.whiteColor,
                              ),
                              validator: (value) =>
                              value!.isEmpty ? "Enter your name" : null,
                            ),
                            const SizedBox(height: 15),
                            TextFormField(
                              controller: homeController.emailController,
                              style: TextStyle(color: ColorConstants.whiteColor,),
                              decoration: const InputDecoration(
                                labelText: "Email",
                                labelStyle: TextStyle(color: ColorConstants.whiteColor,),
                                border: OutlineInputBorder(),
                                focusedBorder:OutlineInputBorder(
                                  borderSide:  BorderSide(
                                    color: ColorConstants.whiteColor,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:  BorderSide(
                                    color: ColorConstants.whiteColor,
                                  ),
                                ),
                                focusColor: ColorConstants.whiteColor,
                                hoverColor: ColorConstants.whiteColor,
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) =>
                              value!.isEmpty ? "Enter a valid email" : null,
                            ),
                          ],
                        ),

                        const SizedBox(height: 15),
                        TextFormField(
                          controller: homeController.descriptionController,
                          style: TextStyle(color: ColorConstants.whiteColor,),
                          decoration: const InputDecoration(
                            labelText: "Description...",
                            labelStyle: TextStyle(color: ColorConstants.whiteColor,),
                            border: OutlineInputBorder(),
                            focusedBorder:OutlineInputBorder(
                              borderSide:  BorderSide(
                                color: ColorConstants.whiteColor,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:  BorderSide(
                                color: ColorConstants.whiteColor,
                              ),
                            ),
                            focusColor: ColorConstants.whiteColor,
                            hoverColor: ColorConstants.whiteColor,

                          ),
                          maxLines: 4,
                          validator: (value) =>
                          value!.isEmpty ? "Enter work details" : null,
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          // height: ResponsiveSize.getSize(context, screenSize.height*0.05),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorConstants.whiteColor,
                              foregroundColor: ColorConstants.primaryColor,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                homeController.sendEmail(homeController.nameController.text,homeController.emailController.text,homeController.descriptionController.text);
                                // Handle form submission
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Form Submitted",style: TextStyle(color: ColorConstants.primaryColor),),backgroundColor: ColorConstants.whiteColor,),
                                );
                              }
                            },
                            child:  Text("Submit",style: TextStyle(fontWeight: FontWeight.bold),),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );



  }


}


class ContactFormScreen extends StatelessWidget {
  ContactFormScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.grey,
        child: LayoutBuilder(
          builder: (context, constraints) {
            bool isWide = constraints.maxWidth > 600;
            double padding = constraints.maxWidth * (isWide ? 0.3 : 0.05);
            double formHeight = constraints.maxHeight * 0.7; // Adjust height dynamically
            return Center(
              child: SingleChildScrollView(
                child: SizedBox(
                  width:  constraints.maxWidth * 1,
                  height: formHeight, // Set height dynamically
                  child: Padding(
                    padding:  EdgeInsets.only(left:  padding, right: padding),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ReusableTextWidget(
                            text: 'Contact with me to sizzle your project',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          ReusableTextWidget(
                            text: "Feel free to contact me if you have any questions. "
                                "I'm available for new projects or just for chatting.",
                            textAlign: TextAlign.center,
                            fontSize: 16,
                            maxLines: 3,

                          ),
                          const SizedBox(height: 20),

                          // Responsive Name & Email Fields
                          isWide
                              ? Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: "Name",
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) =>
                                  value!.isEmpty ? "Enter your name" : null,
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: "Email",
                                    border: OutlineInputBorder(),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) =>
                                  value!.isEmpty ? "Enter a valid email" : null,
                                ),
                              ),
                            ],
                          )
                              : Column(
                            children: [
                              TextFormField(
                                decoration: const InputDecoration(
                                  labelText: "Name",
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) =>
                                value!.isEmpty ? "Enter your name" : null,
                              ),
                              const SizedBox(height: 15),
                              TextFormField(
                                decoration: const InputDecoration(
                                  labelText: "Email",
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) =>
                                value!.isEmpty ? "Enter a valid email" : null,
                              ),
                            ],
                          ),

                          const SizedBox(height: 15),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: "Description...",
                              border: OutlineInputBorder(),
                            ),
                            maxLines: 4,
                            validator: (value) =>
                            value!.isEmpty ? "Enter work details" : null,
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 15),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  // Handle form submission
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Form Submitted")),
                                  );
                                }
                              },
                              child: const Text("Submit"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class SkillWidget extends StatelessWidget {
  final String skillName;
  final String skillLogo;
  final String experienceLevel;

  const SkillWidget({
    super.key,
    required this.skillName,
    required this.skillLogo,
    required this.experienceLevel,
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
            SizedBox(height: 20), // Reduced spacing to prevent overflow
            Expanded(
              // Ensures text does not overflow
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ReusableTextWidget(
                    text: skillName,
                    fontSize: ResponsiveSize.getSize(context,
                        20), // Slightly reduced for better responsiveness
                    fontWeight: FontWeight.bold,
                    // overflow: TextOverflow.ellipsis, // Prevents text from overflowing
                  ),
                  ReusableTextWidget(
                    text: experienceLevel,
                    fontSize: ResponsiveSize.getSize(context, 16),
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
