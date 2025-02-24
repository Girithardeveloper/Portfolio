import 'package:get/get.dart';

class HomeController extends GetxController{

  final List<Map<String, String>> languagesAndFrameworks = [
    {'name': 'C', 'level': 'Intermediate'},
    {'name': 'Dart', 'level': 'Experienced'},
    {'name': 'Kotlin', 'level': 'Beginner'},
    {'name': 'SQL', 'level': 'Intermediate'},
    {'name': 'Flutter', 'level': 'Advanced'},
  ];

  final List<Map<String, String>> toolsAndIDEs = [
    {'name': 'Android Studio', 'level': 'Experienced'},
    {'name': 'Git', 'level': 'Advanced'},
    {'name': 'Postman', 'level': 'Intermediate'},
    {'name': 'Firebase', 'level': 'Intermediate'},
    {'name': 'Cloudinary', 'level': 'Intermediate'},
    {'name': 'Figma', 'level': 'Intermediate'},
    {'name': 'Jira', 'level': 'Intermediate'},

  ];
}