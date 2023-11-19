import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:thiran_task/views/home/home_page.dart';

class SplashScreenView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Lottie.asset("assets/splash_logo.json"),
      nextScreen: HomePage(),
      backgroundColor: Colors.red,
      duration: 4000,
      splashIconSize: 250,
      splashTransition: SplashTransition.sizeTransition,
      animationDuration: (Duration(seconds: 4)),
    );
  }
}
