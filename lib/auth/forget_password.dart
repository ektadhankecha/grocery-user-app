import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_app/auth/responsive_layout.dart';
import 'package:grocery_app/utils/app_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/utils/app_colors.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: Mobile(),
      tablet: Mobile(),
      desktop: Desktop(),
    );
  }
}

class Mobile extends StatelessWidget {
  Mobile({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.bg3,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(MyIcon.arrowBack),
        ),
        title: Text("Password Recovery"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 17.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            SizedBox(height: 80.h),
            Text(
              "Forgot Password",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "Enter your email address to receive a verification code.",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: MyColor.textGraey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 30.h),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  //email
                  TextFormField(
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Colors.black,
                    enableInteractiveSelection: true,
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: "Email Address",
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Icon(MyIcon.email, color: MyColor.textGraey),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your email";
                      }
                      if (!RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      ).hasMatch(value)) {
                        return "Enter a valid email";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15.h),
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        context.push("/verify");
                      }
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

                      child: Center(
                        child: Text(
                          "Send link",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: MyColor.bg1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Desktop extends StatelessWidget {
  Desktop({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 800,
              width: double.infinity,
              child: Image.asset(
                "assets/images/login.png",
                fit: BoxFit.contain,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: 100, left: 50, right: 50),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  SizedBox(height: 50),
                  SizedBox(
                    width: 500,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            context.pop();
                          },
                          icon: Icon(MyIcon.arrowBack, size: 25),
                        ),
                        Spacer(flex: 1),
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
                        Spacer(flex: 1),
                      ],
                    ),
                  ),
                  SizedBox(height: 200),
                  Text(
                    "Forgot Password",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                    //   textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "Enter your email address to receive a verification code.",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: MyColor.textGraey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 30.h),
                  SizedBox(
                    width: 500,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          //email
                          TextFormField(
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: Colors.black,
                            enableInteractiveSelection: true,
                            controller: emailController,
                            decoration: InputDecoration(
                              hintText: "Email Address",
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Icon(
                                  MyIcon.email,
                                  color: MyColor.textGraey,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your email";
                              }
                              if (!RegExp(
                                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                              ).hasMatch(value)) {
                                return "Enter a valid email";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 15.h),
                          GestureDetector(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                context.push("/verify");
                              }
                            },
                            child: Container(
                              height: 50.h,
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

                              child: Center(
                                child: Text(
                                  "Send link",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    color: MyColor.bg1,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
