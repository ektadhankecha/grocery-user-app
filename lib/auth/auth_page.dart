import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_app/utils/app_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/utils/app_colors.dart';
import 'package:grocery_app/auth/login_page.dart';
import 'package:grocery_app/auth/signup_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

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
            top: 50.h,
            child: Row(
              children: [
                //back
                IconButton(
                  onPressed: () {},
                  icon: Icon(MyIcon.arrowBack, size: 25.sp, color: MyColor.bg1),
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
                        height: 60.h,
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
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => SignupPage()),
                        // );
                      },
                      child: Container(
                        height: 60.h,
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
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => LoginPage(),
                            //   ),
                            // );
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
