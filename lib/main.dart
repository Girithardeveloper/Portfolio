import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:portfolio/View/home.dart';

import 'Controller/orientationController/orientationController.dart';
import 'globalWidgets/responsiveSizeWidget.dart';

void main() async{
  // await dotenv.load(fileName: ".env");
  Get.testMode = true;
  runApp(MyApp());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  // This widget is the root of your application.

  OrientationController orientationController = Get.put(OrientationController());

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return LayoutBuilder(
      builder: (context, constraints) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ResponsiveSize.getSize(context,double.parse(screenSize.width.toString()));
          orientationController.updateOrientation(context);
        });
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Portfolio',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home:  HomeView(),
        );
      }
    );
  }
}


/// Key Generate

// keytool -genkey -v -keystore D:\Portfolio\portfolio-keystore.jks `
// -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 `
// -alias portfolio