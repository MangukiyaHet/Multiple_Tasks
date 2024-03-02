import 'package:flutter/material.dart';
import 'package:logic_app/views/screen/HomePage.dart';
import 'package:logic_app/views/screen/LoginPage.dart';
import 'package:logic_app/views/screen/TaskOne.dart';
import 'package:logic_app/views/screen/TaskThree.dart';
import 'package:logic_app/views/screen/TaskTwo.dart';

void main() {
  runApp(const MyApp(),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'LoginPage',
      routes: {
        'LoginPage' : (context) => const LoginPage(),
        '/' : (context) => const HomePage(),
        'Task1' : (context) => const TaskOne(),
        'Task2' : (context) => const TaskTwo(),
        'Task3' : (context) => const TaskThree(),
      },

    );
  }
}
