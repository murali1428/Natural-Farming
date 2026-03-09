import 'package:flutter/material.dart';
import 'Welcome_section/splash.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Total ERP',
      theme: ThemeData(
        primaryColor: const Color(0xFF2BAE9E),
        fontFamily: 'Roboto',
      ),
      home: const SplashScreen(),
    );
  }
}