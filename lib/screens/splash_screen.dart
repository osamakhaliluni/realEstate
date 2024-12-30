import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/style/colors.dart';
import 'package:frontend/cubits/products/products_cubit.dart';
import 'package:frontend/cubits/user/user_cubit.dart';
import 'package:frontend/screens/home/home_screen.dart';
import 'package:tbib_splash_screen/splash_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoaded = false;

  void didChangeDependencies() {
    _initPage();
    super.didChangeDependencies();
  }

  void _initPage() async {
    await UserCubit.get(context).checkLogin();
    await ProductsCubit.get(context).getProducts();
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, "main");
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
