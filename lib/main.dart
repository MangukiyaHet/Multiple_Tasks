import 'package:flutter/material.dart';
import 'package:logic_app/views/screen/HomePage.dart';
import 'package:logic_app/views/screen/LoginPage.dart';
import 'package:logic_app/views/screen/TaskFour.dart';
import 'package:logic_app/views/screen/TaskOne.dart';
import 'package:logic_app/views/screen/TaskThree.dart';
import 'package:logic_app/views/screen/TaskTwo.dart';
import 'package:logic_app/views/utils/VariableUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLogin = prefs.getBool(UserKey) ?? false;

  runApp(MyApp(isLogin: isLogin));
}

class MyApp extends StatelessWidget {
  final bool isLogin;

  const MyApp({Key? key, required this.isLogin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: isLogin ? '/' : 'LoginPage',
      routes: {
        'LoginPage': (context) => const LoginPage(),
        '/': (context) => const HomePage(),
        'Task1': (context) => const TaskOne(),
        'Task2': (context) => const TaskTwo(),
        'Task3': (context) => const TaskThree(),
        'Task4': (context) => const TaskFour(),
      },
    );
  }
}
