import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/auth/auth_page.dart';
import 'package:grocery_app/screen/main_page/main_screen.dart';
import 'package:grocery_app/screen/on_boarding/onboarding_screen.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';
import '../../../utils/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      bool isComplete = pref.getBool("onBoardingComplete") ?? false;
      bool isLogin = pref.getBool("LoginSuccess") ?? false;
      if (isComplete) {
        if (isLogin) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MainScreen()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AuthPage()),
          );
        }
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OnboardingScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset(
              'assets/images/splash_screen.png',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 96.h, left: 50.w, right: 50.w),
            child: Column(
              children: [
                Text(
                  "Buy Premium Quality Fruits",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'poppinsbold',
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 17.h),
                Text(
                  "Order premium quality fruits at affordable prices and enjoy fast, reliable home delivery.",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    color: MyColor.textGraey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child: ColorFiltered(
                colorFilter: const ColorFilter.mode(
                  MyColor.animationGreen,
                  BlendMode.srcATop,
                ),
                child: Lottie.asset(
                  "assets/lottie/Loading Dots Blue.json",
                  height: 130.h,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
