import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_app/auth/responsive_layout.dart';
import 'package:grocery_app/utils/app_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/utils/app_colors.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: Mobile(),
      tablet: Tablet(),
      desktop: Desktop(),
    );
  }
}

class Mobile extends StatelessWidget {
  const Mobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //Image
          Image.asset(
            'assets/images/welcome.png',
            width: double.infinity,
            height: 620.h,
            fit: BoxFit.cover,
          ),
          //back and welcome
          Positioned(
            top: 50,
            child: Row(
              children: [
                //back
                IconButton(
                  onPressed: () {},
                  icon: Icon(MyIcon.arrowBack, size: 25, color: MyColor.bg1),
                ),
                //welcome
                SizedBox(width: MediaQuery.of(context).size.width * 0.27),
                Text(
                  "Welcome",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: MyColor.bg1,
                  ),
                ),
              ],
            ),
          ),
          //bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(17),
                constraints: BoxConstraints(minHeight: 358.h),
                // height: 358.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  color: MyColor.bg3,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(height: 15.h),
                    //title
                    Text(
                      "Welcome",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2),
                    //description
                    Text(
                      "Discover fresh groceries delivered right to your doorstep.",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: MyColor.textGraey,
                      ),
                    ),
                    SizedBox(height: 27.h),
                    //google signup
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        color: MyColor.bg1,
                        width: 380.w,
                        height: 50,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Center(
                              child: Text(
                                "Continue with google",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 22,
                              child: Image.asset(
                                'assets/images/googlelogo2.png',
                                height: 25,
                                width: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    //sign up button
                    GestureDetector(
                      onTap: () {
                        context.push("/signup");
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),

                          gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              MyColor.gradientGreen,
                              MyColor.animationGreen,
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: MyColor.animationGreen.withAlpha(40),
                              blurRadius: 9,
                              spreadRadius: 0,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Center(
                              child: Text(
                                "Create an account",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: MyColor.bg1,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 22.w,
                              child: Icon(
                                MyIcon.profileCircle,
                                color: MyColor.bg1,
                                size: 25.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    //login text button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account ?",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: MyColor.textGraey,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            context.push("/login");
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Desktop extends StatelessWidget {
  const Desktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 800,
              width: double.infinity,
              child: Image.asset(
                'assets/images/welcome.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: MyColor.bg3,
              padding: EdgeInsets.all(25),
              child: Padding(
                padding: const EdgeInsets.only(top: 150, left: 70, right: 70),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  //  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: .center,
                      children: [
                        Image.asset(
                          "assets/images/app_icon.png",
                          height: 40,
                          width: 40,
                        ),
                        SizedBox(width: 20),
                        Text(
                          "Grocery App",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 90.h),
                    //title
                    Text(
                      "Welcome",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 15),
                    //description
                    Text(
                      "Discover fresh groceries delivered right to your doorstep.",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: MyColor.textGraey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 35.h),
                    //google signup
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        color: MyColor.bg1,

                        height: 50,
                        width: 500,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Center(
                              child: Text(
                                "Continue with google",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 22,
                              child: Image.asset(
                                'assets/images/googlelogo2.png',
                                height: 25,
                                width: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 25.h),
                    //sign up button
                    GestureDetector(
                      onTap: () {
                        context.push("/signup");
                      },
                      child: Container(
                        height: 50,
                        width: 500,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),

                          gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              MyColor.gradientGreen,
                              MyColor.animationGreen,
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: MyColor.animationGreen.withAlpha(40),
                              blurRadius: 9,
                              spreadRadius: 0,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Center(
                              child: Text(
                                "Create an account",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: MyColor.bg1,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 22,
                              child: Icon(
                                MyIcon.profileCircle,
                                color: MyColor.bg1,
                                size: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 35),
                    //login text button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account ?",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                            color: MyColor.textGraey,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            context.push("/login");
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Tablet extends StatelessWidget {
  const Tablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Container(
              height: 800,
              width: double.infinity,
              child: Image.asset(
                'assets/images/welcome.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                SizedBox(height: 400),
                Container(
                  width: 400,
                  height: 375,
                  color: MyColor.bg3,
                  padding: EdgeInsets.all(25),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 30,
                      left: 30,
                      right: 30,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      //  mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: .center,
                          children: [
                            Image.asset(
                              "assets/images/app_icon.png",
                              height: 30,
                              width: 30,
                            ),
                            SizedBox(width: 15),
                            Text(
                              "Grocery App",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        //title
                        Text(
                          "Welcome",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8),
                        //description
                        Text(
                          "Discover fresh groceries delivered right to your doorstep.",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: MyColor.textGraey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 12),
                        //google signup
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            color: MyColor.bg1,
                            height: 50,
                            width: 250,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Center(
                                  child: Text(
                                    "Continue with google",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 20,
                                  child: Image.asset(
                                    'assets/images/googlelogo2.png',
                                    height: 25,
                                    width: 25,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        //sign up button
                        GestureDetector(
                          onTap: () {
                            context.push("/signup");
                          },
                          child: Container(
                            height: 50,
                            width: 250,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),

                              gradient: const LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  MyColor.gradientGreen,
                                  MyColor.animationGreen,
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: MyColor.animationGreen.withAlpha(40),
                                  blurRadius: 9,
                                  spreadRadius: 0,
                                  offset: Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Center(
                                  child: Text(
                                    "Create an account",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                      color: MyColor.bg1,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 22,
                                  child: Icon(
                                    MyIcon.profileCircle,
                                    color: MyColor.bg1,
                                    size: 25,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        //login text button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account ?",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w300,
                                color: MyColor.textGraey,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                context.push("/login");
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
