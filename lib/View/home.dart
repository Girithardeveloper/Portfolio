import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:portfolio/Controller/Home/homeController.dart';
import 'package:portfolio/Helper/assetConstants.dart';
import 'package:portfolio/Helper/colorConstants.dart';
import 'package:portfolio/Helper/fontConstants.dart';

import '../Model/projectModel.dart';
import '../globalWidgets/responsiveSizeWidget.dart';
import '../globalWidgets/textWidget.dart';

class HomeView extends StatelessWidget {
   HomeView({super.key});


  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {

    ///Scroll
    ValueNotifier<bool> showSecondSegment = ValueNotifier<bool>(false);
    ValueNotifier<bool> showThirdSegment = ValueNotifier<bool>(false);

    ///Responsive
    Size screenSize = MediaQuery.of(context).size;
    bool isTabletOrMobile = screenSize.width <= ResponsiveSize.tabletWidth;

    return  Scaffold(
      backgroundColor: ColorConstants.whiteColor,
      appBar: AppBar(
        toolbarHeight: ResponsiveSize.getSize(context, screenSize.height*0.08),
        backgroundColor: ColorConstants.primaryColor,
        leading: isTabletOrMobile ? Container() : null,

        flexibleSpace:Padding(
          padding:  EdgeInsets.only(left: ResponsiveSize.getSize(context, screenSize.width * 0.04),right:  ResponsiveSize.getSize(context, screenSize.width * 0.02),top: ResponsiveSize.getSize(context, screenSize.height*0.02)),
          child: Text("Portfolio",style: TextStyle(fontSize:  ResponsiveSize.getSize(context, 30),fontFamily: FontConstants.fontFamily,color: ColorConstants.whiteColor,),),
        ),
        actions: isTabletOrMobile
            ? [


          Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu, color: Colors.white,size: 40,),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            }
          ),
          SizedBox(width: ResponsiveSize.getSize(context, screenSize.width * 0.02),),

        ] // Hide actions in AppBar, show them in Drawer
            : [
          _menuItem("About",screenSize,context),
          _menuItem("Experience",screenSize,context),
          _menuItem("Projects",screenSize,context),
          _menuItem("Contact",screenSize,context),
          SizedBox(width: ResponsiveSize.getSize(context, screenSize.width * 0.02),),
        ],



      ),
      drawer: isTabletOrMobile
          ? Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: ColorConstants.primaryColor),
              child: Text(
                "Menu",
                style: TextStyle(fontSize: ResponsiveSize.getSize(context, 24), color: Colors.white),
              ),
            ),
            _drawerItem("About",context),
            _drawerItem("Experience",context),
            _drawerItem("Projects",context),
            _drawerItem("Contact",context),
          ],
        ),
      )
          : null,
      body: LayoutBuilder(
          builder: (context, constraints) {
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
              padding: const EdgeInsets.all(16.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getHorizontalPadding(constraints.maxWidth),
                    vertical: 170,  // Keep vertical spacing consistent
                  ),                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      isTabletOrMobile
                          ?Column(
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
                              backgroundImage: AssetImage(AssetConstants.profileImage),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Text("Hello I'm",style: TextStyle(fontSize:ResponsiveSize.getSize(context, 18) ,fontFamily: FontConstants.fontFamily,color: ColorConstants.darkGreyColor),),
                              ),
                              SizedBox(height: 10,),
                              Text("Girithar K",style: TextStyle(fontSize:ResponsiveSize.getSize(context, 26),fontFamily: FontConstants.fontFamily,color: ColorConstants.primaryColor),),
                              SizedBox(height: 10,),
                              Text("Flutter Developer",style: TextStyle(fontSize:ResponsiveSize.getSize(context, 26),fontFamily: FontConstants.fontFamily,color: ColorConstants.darkGreyColor,fontWeight: FontWeight.bold),),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      homeController.resumeDriveLink();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                                      decoration: BoxDecoration(color: ColorConstants.primaryColor,borderRadius: BorderRadius.circular(10),border: Border.all(color: ColorConstants.lightGrey)),
                                      child:Text("Download CV",style: TextStyle(fontSize:ResponsiveSize.getSize(context, 16),fontFamily: FontConstants.fontFamily,color: ColorConstants.whiteColor,fontWeight: FontWeight.normal),),

                                    ),
                                  ),
                                  SizedBox(width: 5,),
                                  InkWell(
                                    onTap: (){
                                      HomeController.openEmailApp(toMail: "girithardev@gmail.com");
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                                      decoration: BoxDecoration(color: ColorConstants.primaryColor,borderRadius: BorderRadius.circular(10),border: Border.all(color: ColorConstants.lightGrey)),
                                      child:Text("Contact Info",style: TextStyle(fontSize: ResponsiveSize.getSize(context, 16),fontFamily: FontConstants.fontFamily,color: ColorConstants.whiteColor,fontWeight: FontWeight.normal),),

                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10,),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Wrap(
                                    spacing: 0,
                                    alignment: WrapAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: (){
                                          homeController.linkedInLink();

                                        },
                                        child: Lottie.asset(
                                          'images/lotties/linkedin.json',
                                          width:ResponsiveSize.getSize(context, 50),
                                          height: ResponsiveSize.getSize(context, 50),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: (){
                                          homeController.gitHubLink();
                                        },
                                        child: Lottie.asset(
                                          'images/lotties/github.json',
                                          width: ResponsiveSize.getSize(context, 50),
                                          height: ResponsiveSize.getSize(context, 50),
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
                      ): Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: getHorizontalPadding(constraints.maxWidth),
                          vertical: 170,  // Keep vertical spacing consistent
                        ),                       child: Row(
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
                                backgroundImage: AssetImage(AssetConstants.profileImage),
                              ),
                            ),
                            SizedBox(width: screenSize.width * 0.04,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: Text("Hello I'm",style: TextStyle(fontSize:ResponsiveSize.getSize(context, 18) ,fontFamily: FontConstants.fontFamily,color: ColorConstants.darkGreyColor),),
                                ),
                                SizedBox(height: 10,),
                                Text("Girithar K",style: TextStyle(fontSize:ResponsiveSize.getSize(context, 26),fontFamily: FontConstants.fontFamily,color: ColorConstants.primaryColor),),
                                SizedBox(height: 10,),
                                Text("Flutter Developer",style: TextStyle(fontSize:ResponsiveSize.getSize(context, 26),fontFamily: FontConstants.fontFamily,color: ColorConstants.darkGreyColor,fontWeight: FontWeight.bold),),
                                SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        homeController.resumeDriveLink();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                                        decoration: BoxDecoration(color: ColorConstants.primaryColor,borderRadius: BorderRadius.circular(10),border: Border.all(color: ColorConstants.lightGrey)),
                                        child:Text("Download CV",style: TextStyle(fontSize:ResponsiveSize.getSize(context, 16),fontFamily: FontConstants.fontFamily,color: ColorConstants.whiteColor,fontWeight: FontWeight.normal),),

                                      ),
                                    ),
                                    SizedBox(width: 5,),
                                    InkWell(
                                      onTap: (){
                                        HomeController.openEmailApp(toMail: "girithardev@gmail.com");
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                                        decoration: BoxDecoration(color: ColorConstants.primaryColor,borderRadius: BorderRadius.circular(10),border: Border.all(color: ColorConstants.lightGrey)),
                                        child:Text("Contact Info",style: TextStyle(fontSize: ResponsiveSize.getSize(context, 16),fontFamily: FontConstants.fontFamily,color: ColorConstants.whiteColor,fontWeight: FontWeight.normal),),

                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10,),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Wrap(
                                      spacing: 0,
                                      alignment: WrapAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: (){
                                            homeController.linkedInLink();
                                          },
                                          child: Lottie.asset(
                                            'images/lotties/linkedin.json',
                                            width:ResponsiveSize.getSize(context, 50),
                                            height: ResponsiveSize.getSize(context, 50),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: (){
                                            homeController.gitHubLink();
                                          },
                                          child: Lottie.asset(
                                            'images/lotties/github.json',
                                            width: ResponsiveSize.getSize(context, 50),
                                            height: ResponsiveSize.getSize(context, 50),
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
                      SizedBox(height: screenSize.height * 0.3),

                      // **Second Segment (Appears on Scroll)**
                      _buildSecondSegment(isTabletOrMobile,context,screenSize),
                      SizedBox(height: screenSize.height * 0.2),
                      _buildThirdSegment(isTabletOrMobile,),
                      SizedBox(height: screenSize.height * 0.2),
                      _buildProjectsGrid(),

                    ],
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }


  Widget _menuItem(String title,Size screenSize,context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal:screenSize.width * 0.01),
      child: Text(
        title,
        style: TextStyle(fontSize:ResponsiveSize.getSize(context, 16) , fontFamily: FontConstants.fontFamily, color: ColorConstants.whiteColor),
      ),
    );
  }

  Widget _drawerItem(String title,context) {
    return ListTile(
      title: Text(title, style: TextStyle(fontSize:ResponsiveSize.getSize(context, 24),fontFamily: FontConstants.fontFamily,)),
      onTap: () {},
    );
  }

   /// 🌟 Second Segment - About Me, Experience, Projects
   Widget _buildSecondSegment(bool isMobile,context,Size screenSize) {
     return Column(
       mainAxisAlignment: MainAxisAlignment.start,
       crossAxisAlignment: CrossAxisAlignment.center,
       children: [
         // 🌟 About Me Section
         ReusableTextWidget(text: 'Get To Know More',color: Colors.grey.shade600,fontSize: ResponsiveSize.getSize(context, 20),),
         SizedBox(height: 10,),
         ReusableTextWidget(text: "About Me", fontSize: ResponsiveSize.getSize(context, 24), fontWeight: FontWeight.w700),
         SizedBox(height: ResponsiveSize.getSize(context, screenSize.height * 0.10),),
         isMobile?Column(
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
                   margin: EdgeInsets.only(left:  ResponsiveSize.getSize(context, screenSize.width * 0.005), right: ResponsiveSize.getSize(context, screenSize.width * 0.005), top: ResponsiveSize.getSize(context, screenSize.height * 0.01), bottom: ResponsiveSize.getSize(context, screenSize.height * 0.01),),

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
                     padding: EdgeInsets.only(left:  ResponsiveSize.getSize(context, screenSize.width * 0.005), right: ResponsiveSize.getSize(context, screenSize.width * 0.005), top: ResponsiveSize.getSize(context, screenSize.height * 0.01), bottom: ResponsiveSize.getSize(context, screenSize.height * 0.01),),
                     child: ClipRRect(
                       borderRadius: BorderRadius.circular(10),
                         child: Image.asset(AssetConstants.profileImageOne,height: ResponsiveSize.getSize(context, screenSize.height * 0.45),fit: BoxFit.fill,)),
                   )),
             ),
             SizedBox(height: ResponsiveSize.getSize(context, screenSize.height * 0.08),),
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
                         )
                     ),
                     child: Padding(
                       padding: EdgeInsets.only(left:  ResponsiveSize.getSize(context, screenSize.width * 0.04), right: ResponsiveSize.getSize(context, screenSize.width * 0.04), top: ResponsiveSize.getSize(context, screenSize.height * 0.02), bottom: ResponsiveSize.getSize(context, screenSize.height * 0.02),),
                       child: Column(
                         children: [
                           Image.asset(
                             AssetConstants.experienceLogo,
                             height: ResponsiveSize.getSize(context, 50),
                             width:ResponsiveSize.getSize(context, 50),
                           ),
                           ReusableTextWidget(
                             text: 'Experience',
                             fontWeight: FontWeight.bold,
                             fontSize: ResponsiveSize.getSize(context, 18),
                             color: Colors.black,
                           ),
                           ReusableTextWidget(
                             text: '3.2+ years',
                             fontSize:ResponsiveSize.getSize(context, 15),
                             color: Colors.grey.shade700,
                           ),
                           ReusableTextWidget(
                             text: 'Flutter Application Development',
                             fontSize: ResponsiveSize.getSize(context, 15),
                             color: Colors.grey.shade700,
                             maxLines: 2,
                             textAlign: TextAlign.center,
                           ),
                         ],
                       ),
                     ),
                   ),
                 ),
                 SizedBox(width: 10,),

                 Expanded(
                   child: Container(
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(10),
                         border: Border.all(
                           width: 0.5,
                           color: Colors.black,
                         )
                     ),
                     child: Padding(
                       padding: EdgeInsets.only(left: ResponsiveSize.getSize(context, screenSize.width * 0.04), right: ResponsiveSize.getSize(context, screenSize.width * 0.04), top: ResponsiveSize.getSize(context, screenSize.height * 0.02), bottom: ResponsiveSize.getSize(context, screenSize.height * 0.02),),
                       child: Column(
                         children: [
                           Image.asset(
                             AssetConstants.educationLogo,
                             height:  ResponsiveSize.getSize(context, 50),
                             width: ResponsiveSize.getSize(context, 50),
                           ),
                           ReusableTextWidget(
                             text: 'Education',
                             fontWeight: FontWeight.bold,
                             fontSize:ResponsiveSize.getSize(context, 18),
                             color: Colors.black,
                             textAlign: TextAlign.center,
                           ),
                           ReusableTextWidget(
                             text: 'BCA Degree',
                             fontSize: ResponsiveSize.getSize(context, 15),
                             color: Colors.grey.shade700,
                             textAlign: TextAlign.center,

                           ),
                           ReusableTextWidget(
                             text: 'Flutter Application Development',
                             fontSize:ResponsiveSize.getSize(context, 15),
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
             SizedBox(height: ResponsiveSize.getSize(context, screenSize.height * 0.08),),
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
         ):Row(
           mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             Container(
               width:  ResponsiveSize.getSize(context, screenSize.width * 0.20),
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
                   margin: EdgeInsets.only(left:  ResponsiveSize.getSize(context, screenSize.width * 0.005), right: ResponsiveSize.getSize(context, screenSize.width * 0.005), top: ResponsiveSize.getSize(context, screenSize.height * 0.01), bottom: ResponsiveSize.getSize(context, screenSize.height * 0.01),),
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(10),
                     color: ColorConstants.whiteColor,
                     border: Border.all(
                       width: 0.5,
                       color: Colors.black,
                     ),

                   ),
                   child: Padding(
                     padding: EdgeInsets.only(left:  ResponsiveSize.getSize(context, screenSize.width * 0.005), right: ResponsiveSize.getSize(context, screenSize.width * 0.005), top: ResponsiveSize.getSize(context, screenSize.height * 0.01), bottom: ResponsiveSize.getSize(context, screenSize.height * 0.01),),
                     child: ClipRRect(
                         borderRadius: BorderRadius.circular(10),
                         child: Image.asset(AssetConstants.profileImageOne,height: ResponsiveSize.getSize(context, screenSize.height * 0.45),fit: BoxFit.fill,)),
                   )),
             ),
             SizedBox(width: ResponsiveSize.getSize(context, screenSize.width * 0.04),),
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
                               left: ResponsiveSize.getSize(context, screenSize.width * 0.04),
                               right: ResponsiveSize.getSize(context, screenSize.width * 0.04),
                               top: ResponsiveSize.getSize(context, screenSize.height * 0.02),
                               bottom: ResponsiveSize.getSize(context, screenSize.height * 0.02),
                             ),
                             child: Column(
                               mainAxisSize: MainAxisSize.min, // Ensures Column takes only needed space
                               children: [
                                 Image.asset(
                                   AssetConstants.experienceLogo,
                                   height: ResponsiveSize.getSize(context, 50),
                                   width: ResponsiveSize.getSize(context, 50),
                                 ),
                                 ReusableTextWidget(
                                   text: 'Experience',
                                   fontWeight: FontWeight.bold,
                                   fontSize: ResponsiveSize.getSize(context, 18),
                                   color: Colors.black,
                                 ),
                                 ReusableTextWidget(
                                   text: '3.2+ years',
                                   fontSize: ResponsiveSize.getSize(context, 15),
                                   color: Colors.grey.shade700,
                                 ),
                                 ReusableTextWidget(
                                   text: 'Flutter Application Development',
                                   fontSize: ResponsiveSize.getSize(context, 15),
                                   color: Colors.grey.shade700,
                                   maxLines: 2,
                                   textAlign: TextAlign.center,
                                 ),
                               ],
                             ),
                           ),
                         ),
                       ),
                       SizedBox(width: ResponsiveSize.getSize(context, screenSize.width * 0.02),),
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
                               left: ResponsiveSize.getSize(context, screenSize.width * 0.04),
                               right: ResponsiveSize.getSize(context, screenSize.width * 0.04),
                               top: ResponsiveSize.getSize(context, screenSize.height * 0.02),
                               bottom: ResponsiveSize.getSize(context, screenSize.height * 0.02),
                             ),
                             child: Column(
                               mainAxisSize: MainAxisSize.min, // Ensures Column takes only needed space
                               children: [
                                 Image.asset(
                                   AssetConstants.educationLogo,
                                   height: ResponsiveSize.getSize(context, 50),
                                   width: ResponsiveSize.getSize(context, 50),
                                 ),
                                 ReusableTextWidget(
                                   text: 'Education',
                                   fontWeight: FontWeight.bold,
                                   fontSize: ResponsiveSize.getSize(context, 18),
                                   color: Colors.black,
                                   textAlign: TextAlign.center,
                                 ),
                                 ReusableTextWidget(
                                   text: 'BCA Degree',
                                   fontSize: ResponsiveSize.getSize(context, 15),
                                   color: Colors.grey.shade700,
                                   textAlign: TextAlign.center,
                                 ),
                                 ReusableTextWidget(
                                   text: 'Flutter Application Development',
                                   fontSize: ResponsiveSize.getSize(context, 15),
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
                   SizedBox(height: ResponsiveSize.getSize(context, screenSize.height * 0.08),),
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


         SizedBox(height: 50,)

       ],
     );
   }


   Widget _buildThirdSegment(bool isMobile) {
     return LayoutBuilder(
       builder: (context, constraints) {
         bool isWideScreen = constraints.maxWidth > 600; // Adjust breakpoint as needed
         return Column(
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             // Title
             ReusableTextWidget(text: 'Explore My', color: Colors.grey.shade600,fontSize: ResponsiveSize.getSize(context, 20),),
             SizedBox(height: 10),
             ReusableTextWidget(
                 text: "Experience", fontSize: ResponsiveSize.getSize(context, 24), fontWeight: FontWeight.w700),
             SizedBox(height: ResponsiveSize.getSize(context, 50),),

             // Responsive Row/Column Layout
             isWideScreen
                 ? Row(
               children: [
                 Expanded(child: _buildSkillContainer("Languages and Frameworks", homeController.languagesAndFrameworks, isMobile,context),),
                 SizedBox(width: 20),
                 Expanded(child:  _buildSkillContainer("Tools, IDEs, and Others", homeController.toolsAndIDEs, isMobile,context)),
               ],
             )
                 : Column(
               children: [
                 _buildSkillContainer("Languages and Frameworks", homeController.languagesAndFrameworks, isMobile,context),
                 SizedBox(height: 20),
                 _buildSkillContainer("Tools, IDEs, and Database", homeController.toolsAndIDEs, isMobile,context),
               ],
             ),
           ],
         );
       },
     );
   }



/// **Skill Container**
  Widget _buildSkillContainer(String title, List<Map<String, String>> skillList, bool isMobile,context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 0.5, color: Colors.black),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          children: [
            ReusableTextWidget(
              text: title,
              fontWeight: FontWeight.bold,
              fontSize:ResponsiveSize.getSize(context, 22),
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
                  ),
                  itemCount: skillList.length,
                  itemBuilder: (context, index) {
                    return SkillWidget(
                      skillName: skillList[index]['name'] ?? '',
                      experienceLevel: skillList[index]['level'] ?? '',
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }





   double getHorizontalPadding(double screenWidth) {
     if (screenWidth < 600) return 16;  // Mobile
     if (screenWidth < 1200) return 50; // Tablet
     return 150; // Large screens
   }


   Widget _buildProjectsGrid() {
     return LayoutBuilder(
       builder: (context, constraints) {
         double width = constraints.maxWidth;
         int crossAxisCount = width < 600 ? 1 : width < 1000 ? 2 : 3; // Adjust grid columns

         return Column(
           children: [
             ReusableTextWidget(text: 'Browse My', color: Colors.grey.shade600,fontSize: ResponsiveSize.getSize(context, 20),),
             SizedBox(height: 10),
             ReusableTextWidget(
                 text: "Projects", fontSize:ResponsiveSize.getSize(context, 24), fontWeight: FontWeight.w700),
             SizedBox(height:  ResponsiveSize.getSize(context, 50),),
             GridView.builder(
               shrinkWrap: true,
               physics: NeverScrollableScrollPhysics(), // Prevents nested scrolling
               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                 crossAxisCount: crossAxisCount,
                 crossAxisSpacing: 20,
                 mainAxisSpacing: 20,
                 childAspectRatio: 1.2, // Adjust for proper card proportions
               ),
               itemCount: homeController.projects.length,
               itemBuilder: (context, index) {
                 return _buildProjectCard( homeController.projects[index],context);
               },
             ),
           ],
         );
       },
     );
   }

   Widget _buildProjectCard(Project project,context) {
     return Card(
       color: Colors.white,
       elevation: 0,
       shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(10),
           side: BorderSide(
               width: 0.2,
               color: Colors.black
           )
       ),
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
                   fit: BoxFit.fitWidth, // Shows the full image without cropping
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
             SizedBox(height: 10,),
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


}

class SkillWidget extends StatelessWidget {
  final String skillName;
  final String experienceLevel;

  const SkillWidget({
    super.key,
    required this.skillName,
    required this.experienceLevel,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // Prevent excessive width usage
          children: [
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Image.asset(
                AssetConstants.verifiedLogo,
                height: 25,
                width: 25,
              ),
            ),
            SizedBox(width: 10), // Reduced spacing to prevent overflow
            Expanded( // Ensures text does not overflow
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReusableTextWidget(
                    text: skillName,
                    fontSize:ResponsiveSize.getSize(context, 20), // Slightly reduced for better responsiveness
                    fontWeight: FontWeight.bold,
                    // overflow: TextOverflow.ellipsis, // Prevents text from overflowing
                  ),
                  ReusableTextWidget(
                    text: experienceLevel,
                    fontSize:ResponsiveSize.getSize(context, 16) ,
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


