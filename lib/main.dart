import 'package:altkamul_task/models/owner.dart';
import 'package:altkamul_task/models/question.dart';
import 'package:altkamul_task/screens/Splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {

  await Hive.initFlutter();
  Hive.registerAdapter(QuestionModelAdapter());
  Hive.registerAdapter(OwnerAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Altkamul Task',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Color(0xffFF911B),
        ),
        primaryColor: const Color(0xffFF911B)
      ),
      home: const SplashScreen(),
    );
  }
}
