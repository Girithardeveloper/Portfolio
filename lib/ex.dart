import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'globalWidgets/textWidget.dart';


void main() {
  runApp(const MyApp());
}

class ThemeProvider with ChangeNotifier {
  bool isDarkMode = false;

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeProvider.isDarkMode ? ThemeData.dark() : ThemeData.light(),
            home: const PortfolioScreen(),
          );
        },
      ),
    );
  }
}


class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  ValueNotifier<bool> showSecondSegment = ValueNotifier<bool>(false);
  ValueNotifier<bool> showThirdSegment = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isMobile = screenWidth < 800;

    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              double scrollPosition = scrollNotification.metrics.extentBefore;

              // Show Second Segment
              if (scrollPosition > constraints.maxHeight * 0.4) {
                showSecondSegment.value = true;
              } else {
                showSecondSegment.value = false;
              }

              // Show Third Segment
              if (scrollPosition > constraints.maxHeight * 0.8) {
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
                    vertical: 50,  // Keep vertical spacing consistent
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // First Segment (Profile)
                      _buildFirstSegment(isMobile),

                      // **Adaptive Space Before Second Segment**
                      SizedBox(height: screenHeight * 0.3),

                      // **Second Segment (Appears on Scroll)**
                      ValueListenableBuilder<bool>(
                        valueListenable: showSecondSegment,
                        builder: (context, isVisible, child) {
                          return AnimatedOpacity(
                            duration: Duration(milliseconds: 500),
                            opacity: isVisible ? 1.0 : 0.0,
                            child: _buildSecondSegment(isMobile),
                          );
                        },
                      ),

                      SizedBox(height: screenHeight * 0.3),

                      // **Third Segment (Appears Later on Scroll)**
                      ValueListenableBuilder<bool>(
                        valueListenable: showThirdSegment,
                        builder: (context, isVisible, child) {
                          return AnimatedOpacity(
                            duration: Duration(milliseconds: 500),
                            opacity: isVisible ? 1.0 : 0.0,
                            child: _buildThirdSegment(isMobile),
                          );
                        },
                      ),

                      SizedBox(height: screenHeight * 0.3),
                      _buildProjectsGrid(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFirstSegment(bool isMobile) {
    return Column(
      children: [
        // 🌟 Navbar
        Align(
          alignment: Alignment.centerRight,
          child: Wrap(
            spacing: 20,
            alignment: WrapAlignment.end,
            children: [
              ReusableTextWidget(text: 'About', fontSize: isMobile ? 18 : 22),
              ReusableTextWidget(text: 'Experience', fontSize: isMobile ? 18 : 22),
              ReusableTextWidget(text: 'Projects', fontSize: isMobile ? 18 : 22),
              ReusableTextWidget(text: 'Contact', fontSize: isMobile ? 18 : 22),
            ],
          ),
        ),

        SizedBox(height: isMobile ? 100 : 250),

        // 🌟 Profile Section
        LayoutBuilder(
          builder: (context, constraints) {
            return isMobile
                ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildProfileSection(isMobile),
            )
                : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildProfileSection(isMobile),
              ),
            );

          },
        ),
      ],
    );
  }
  List<Widget> _buildProfileSection(bool isMobile) {
    return [
      CircleAvatar(
        backgroundColor: Colors.grey,
        radius: isMobile ? 100 : 170, // Adjust for mobile
        backgroundImage: AssetImage('assets/images/profile_image.jpg'),
      ),
      SizedBox(width: isMobile ? 0 : 40, height: isMobile ? 20 : 0),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ReusableTextWidget(
              text: "Hello, I'm",
              fontSize: isMobile ? 12 : 15,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600),
          SizedBox(height: 5),
          ReusableTextWidget(
              text: 'Johnson',
              fontSize: isMobile ? 25 : 35,
              fontWeight: FontWeight.w700),
          ReusableTextWidget(
              text: 'Software Developer',
              fontSize: isMobile ? 18 : 25,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600),
          SizedBox(height: 10),

          // 🌟 Buttons
          Wrap(
            spacing: 10,
            alignment: WrapAlignment.center,
            children: [
              _buildButton("Download CV", Colors.white, Colors.black),
              _buildButton("Contact Info", Colors.grey.shade800, Colors.white),
            ],
          ),

          SizedBox(height: 10),

          // 🌟 Social Media Links
          Wrap(
            spacing: 10,
            alignment: WrapAlignment.center,
            children: [
              Lottie.asset(
                'assets/images/lotties/linkedin.json',
                width: isMobile ? 40 : 50,
                height: isMobile ? 40 : 50,
                fit: BoxFit.cover,
              ),
              Lottie.asset(
                'assets/images/lotties/github.json',
                width: isMobile ? 40 : 50,
                height: isMobile ? 40 : 50,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ],
      ),
    ];
  }

  Widget _buildButton(String text, Color bgColor, Color textColor) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: Colors.black, width: 0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.all(8),
      child: ReusableTextWidget(text: text, color: textColor),
    );
  }

  /// 🌟 Second Segment - About Me, Experience, Projects
  Widget _buildSecondSegment(bool isMobile) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 🌟 About Me Section
        ReusableTextWidget(text: 'Get To Know More',color: Colors.grey.shade600,),
        SizedBox(height: 10,),
        ReusableTextWidget(text: "About Me", fontSize: 30, fontWeight: FontWeight.w700),
        SizedBox(height: 100),
        Row(
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
                  padding: EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 20),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/experience.png',
                        height: 50,
                        width: 50,
                      ),
                      ReusableTextWidget(
                        text: 'Experience',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      ReusableTextWidget(
                        text: '1.5+ years',
                        fontSize: 15,
                        color: Colors.grey.shade700,
                      ),
                      ReusableTextWidget(
                        text: 'Flutter Application Development',
                        fontSize: 15,
                        color: Colors.grey.shade700,
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
                  padding: EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 20),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/education_logo.png',
                        height: 50,
                        width: 50,
                      ),
                      ReusableTextWidget(
                        text: 'Project',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      ReusableTextWidget(
                        text: '1.5+ years',
                        fontSize: 15,
                        color:Colors.grey.shade700,
                      ),
                      ReusableTextWidget(
                        text: 'Flutter Application Development',
                        fontSize: 15,
                        color: Colors.grey.shade700,
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
                  padding: EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 20),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/projects.png',
                        height: 50,
                        width: 50,
                      ),
                      ReusableTextWidget(
                        text: 'Education',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      ReusableTextWidget(
                        text: 'B.E',
                        fontSize: 15,
                        color: Colors.grey.shade700,
                      ),
                      ReusableTextWidget(
                        text: 'Flutter Application Development',
                        fontSize: 15,
                        color: Colors.grey.shade700,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 30,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ReusableTextWidget(
            text:
            """I am a Flutter developer passionate about building high-performance, cross-platform apps with Dart and Flutter. I also have experience with FastAPI in Python for efficient backend solutions.My skills in Figma help me craft intuitive UI/UX designs, while my knowledge of manual testing ensures product quality. I am deeply interested in product development, from ideation to execution, aiming to create impactful user experiences. Always eager to learn and innovate—let’s build something amazing! 🚀""",
            fontSize: isMobile ? 16 : 18,
            color: Colors.grey.shade700,
            textAlign: TextAlign.center,
            maxLines: 6,
          ),
        ),
        SizedBox(height: 50),
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
            ReusableTextWidget(text: 'Explore My', color: Colors.grey.shade600),
            SizedBox(height: 10),
            ReusableTextWidget(
                text: "Experience", fontSize: 30, fontWeight: FontWeight.w700),
            SizedBox(height: 100),

            // Responsive Row/Column Layout
            isWideScreen
                ? Row(
              children: [
                Expanded(child: _buildSkillContainer("Languages and Frameworks", languagesAndFrameworks, isMobile),),
                SizedBox(width: 20),
                Expanded(child:  _buildSkillContainer("Tools, IDEs, and Others", toolsAndIDEs, isMobile)),
              ],
            )
                : Column(
              children: [
                _buildSkillContainer("Languages and Frameworks", languagesAndFrameworks, isMobile),
                SizedBox(height: 20),
                _buildSkillContainer("Tools, IDEs, and Database", toolsAndIDEs, isMobile),
              ],
            ),
          ],
        );
      },
    );
  }

  final List<Map<String, String>> languagesAndFrameworks = [
    {'name': 'C', 'level': 'Intermediate'},
    {'name': 'Dart', 'level': 'Experienced'},
    {'name': 'Kotlin', 'level': 'Beginner'},
    {'name': 'Python', 'level': 'Intermediate'},
    {'name': 'SQL', 'level': 'Intermediate'},
    {'name': 'Flutter', 'level': 'Advanced'},
    {'name': 'FastAPI', 'level': 'Advanced'},
  ];

  final List<Map<String, String>> toolsAndIDEs = [
    {'name': 'VS Code', 'level': 'Expert'},
    {'name': 'Android Studio', 'level': 'Experienced'},
    {'name': 'Git', 'level': 'Advanced'},
    {'name': 'Postman', 'level': 'Intermediate'},
    {'name': 'Firebase', 'level': 'Intermediate'},
    {'name': 'Postgresql', 'level': 'Intermediate'},
    {'name': 'cloudinary', 'level': 'Intermediate'},

  ];



// **Skill Container**
  Widget _buildSkillContainer(String title, List<Map<String, String>> skillList, bool isMobile) {
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
              fontSize: isMobile ? 18 : 25,
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


  final List<Map<String, String>> skills = [
    {'name': 'C', 'level': 'Intermediate'},
    {'name': 'Dart', 'level': 'Experienced'},
    {'name': 'Kotlin', 'level': 'Beginner'},
    {'name': 'Python', 'level': 'Intermediate'},
    {'name': 'SQL', 'level': 'Intermediate'},
    {'name': 'Flutter', 'level': 'Advanced'},
    {'name': 'FastAPI', 'level': 'Advanced'},
  ];


  Widget _buildProjectsGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        int crossAxisCount = width < 600 ? 1 : width < 1000 ? 2 : 3; // Adjust grid columns

        return Column(
          children: [
            ReusableTextWidget(text: 'Browse My', color: Colors.grey.shade600),
            SizedBox(height: 10),
            ReusableTextWidget(
                text: "projects", fontSize: 30, fontWeight: FontWeight.w700),
            SizedBox(height: 100),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(), // Prevents nested scrolling
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 1.2, // Adjust for proper card proportions
              ),
              itemCount: projects.length,
              itemBuilder: (context, index) {
                return _buildProjectCard(projects[index]);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildProjectCard(Project project) {
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
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 10,),
            ReusableTextWidget(
              text: project.description,
              maxLines: 5,
              fontSize: 15,
            ),
          ],
        ),
      ),
    );
  }

  final List<Project> projects = [
    Project(imagePath: Assets.kwickmetrics, title: 'KwickMetrics', description: TextConst.aboutKwickmetrics),
    Project(imagePath: Assets.fuse, title: 'Fuse', description: TextConst.aboutFuse),
    Project(imagePath: Assets.plotrol, title: 'Plotrol', description: TextConst.aboutPlotrol),
    Project(imagePath: Assets.dealsBusiness, title: 'Deals Business', description: TextConst.aboutDeals),

  ];


  double getHorizontalPadding(double screenWidth) {
    if (screenWidth < 600) return 16;  // Mobile
    if (screenWidth < 1200) return 50; // Tablet
    return 150; // Large screens
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
                'assets/images/tick.jpg',
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
                    fontSize: 18, // Slightly reduced for better responsiveness
                    fontWeight: FontWeight.bold,
                    // overflow: TextOverflow.ellipsis, // Prevents text from overflowing
                  ),
                  ReusableTextWidget(
                    text: experienceLevel,
                    fontSize: 14,
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


class Project {
  final String imagePath;
  final String title;
  final String description;

  Project({required this.imagePath, required this.title, required this.description});
}

