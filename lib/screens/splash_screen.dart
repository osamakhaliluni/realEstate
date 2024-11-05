import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/style/colors.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:tbib_splash_screen/splash_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, "home");
    });
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateWhere: isLoaded,
      backgroundColor: Colors.white,
      navigateRoute: const HomeScreen(),
      text: WavyAnimatedText(
        "Splash Screen",
        textStyle: TextStyle(
          color: primaryColor,
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      imageSrc: "assets/images/logo.png",
    );
  }
}
