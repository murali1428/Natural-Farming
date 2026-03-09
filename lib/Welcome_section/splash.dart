import 'dart:async';
import 'package:farm/Welcome_section/walkthrough.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WalkthroughScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: media.width * 0.45,
          height: media.width * 0.45,
          child: Image.asset(
            'assets/splash_logo.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
