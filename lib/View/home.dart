import 'package:flutter/material.dart';
import 'package:portfolio/Helper/colorConstants.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: ColorConstants.secondaryColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.secondaryColor,
        leading: Text('Girithar'),
      ),
    );
  }
}
