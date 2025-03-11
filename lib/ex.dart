import 'package:flutter/material.dart';

import 'Helper/appDescriptionConstants.dart';
import 'globalWidgets/textWidget.dart';

class AnimatedPortfolioSection extends StatefulWidget {
  final bool isMobile;
  const AnimatedPortfolioSection({super.key, required this.isMobile});

  @override
  _AnimatedPortfolioSectionState createState() => _AnimatedPortfolioSectionState();
}

class _AnimatedPortfolioSectionState extends State<AnimatedPortfolioSection>
    with TickerProviderStateMixin {
  late AnimationController _sectionController;
  late Animation<Offset> _slideFromBottom;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();

    _sectionController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    _slideFromBottom = Tween<Offset>(begin: Offset(0, 0.5), end: Offset(0, 0)).animate(
      CurvedAnimation(parent: _sectionController, curve: Curves.easeOut),
    );
  }

  void _triggerAnimation(bool visible) {
    if (visible && !_isVisible) {
      setState(() {
        _isVisible = true;
      });
      _sectionController.forward();
    }
  }

  @override
  void dispose() {
    _sectionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('portfolio_section'),
      onVisibilityChanged: (info) {
        _triggerAnimation(info.visibleFraction > 0.3);
      },
      child: SlideTransition(
        position: _slideFromBottom,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Get To Know More', style: TextStyle(color: Colors.grey.shade600)),
              SizedBox(height: 10),
              Text("About Me", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700)),
              SizedBox(height: 50),
              ResponsiveCardSection(),
              SizedBox(height: 30),
              _aboutMe()
            ],
          ),
        ),
      ),
    );
  }
  Widget _aboutMe() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 20,
      children: [
        ReusableTextWidget(
          text: TextConst.education,
          maxLines: 20,
          fontSize: 18,
          color: Colors.grey.shade600,
        ),
        ReusableTextWidget(
          text: TextConst.nearleExp,
          maxLines: 20,
          fontSize: 18,
          color: Colors.grey.shade600,
        ),
        ReusableTextWidget(
          text: TextConst.mallowExp,
          maxLines: 20,
          fontSize: 18,
          color: Colors.grey.shade600,
        ),
        ReusableTextWidget(
          text: TextConst.aboutExp,
          maxLines: 20,
          fontSize: 18,
          color: Colors.grey.shade600,
        ),
      ],
    );
  }
}

class ResponsiveCardSection extends StatelessWidget {
  const ResponsiveCardSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    int crossAxisCount = width > 900 ? 4 : (width > 600 ? 2 : 2);
    double aspectRatio = width > 1400 ? 2.6 : (width > 900 ? 1.5 : (width > 600 ? 2.0 : 1.5));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: aspectRatio,
        ),
        itemCount: _cardData.length,
        itemBuilder: (context, index) {
          return _buildCard(_cardData[index]['title']!, _cardData[index]['subtitle']!);
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
            ReusableTextWidget(text: title, fontSize: 24, fontWeight: FontWeight.bold, color: Colors.orange,),
            SizedBox(height: 5),
            ReusableTextWidget(text: subtitle, fontSize: 16, color: Colors.grey.shade600,)

          ],
        ),
      ),
    );
  }

}

final List<Map<String, String>> _cardData = [
  {'title': "B.E ECE", 'subtitle': "Education"},
  {'title': "7.98", 'subtitle': "CGPA"},
  {'title': "1.5+", 'subtitle': "Experience"},
  {'title': "5+", 'subtitle': "Projects"},
];