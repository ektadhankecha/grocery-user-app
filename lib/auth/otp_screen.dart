import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_app/auth/responsive_layout.dart';
import 'package:grocery_app/utils/app_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/utils/app_colors.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: Mobile(),
      tablet: Mobile(),
      desktop: Desktop(),
    );
  }
}

class Mobile extends StatefulWidget {
  const Mobile({super.key});

  @override
  State<Mobile> createState() => _MobileState();
}

class _MobileState extends State<Mobile> {
  late final List<bool> isObscured = [false, false, false, false, false, false];
  final List<Timer?> timers = [null, null, null, null, null, null];
  final c1 = TextEditingController();
  final c2 = TextEditingController();
  final c3 = TextEditingController();
  final c4 = TextEditingController();
  final c5 = TextEditingController();
  final c6 = TextEditingController();
  final f1 = FocusNode();
  final f2 = FocusNode();
  final f3 = FocusNode();
  final f4 = FocusNode();
  final f5 = FocusNode();
  final f6 = FocusNode();

  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    for (final timer in timers) {
      timer?.cancel();
    }

    c1.dispose();
    c2.dispose();
    c3.dispose();
    c4.dispose();
    c5.dispose();
    c6.dispose();
    f1.dispose();
    f2.dispose();
    f3.dispose();
    f4.dispose();
    f5.dispose();
    f6.dispose();
    super.dispose();
  }

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
        centerTitle: true,
        title: Text("Verify Number"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 17.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 80.h),
            Text(
              "Verify your number",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "Enter your OTP code below",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: MyColor.textGraey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 40.h),
            //otp
            Form(
              key: _formKey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  otpField(context, 0, c1, f1, f2, null),
                  otpField(context, 1, c2, f2, f3, f1),
                  otpField(context, 2, c3, f3, f4, f2),
                  otpField(context, 3, c4, f4, f5, f3),
                  otpField(context, 4, c5, f5, f6, f4),
                  otpField(context, 5, c6, f6, null, f5),
                ],
              ),
            ),

            SizedBox(height: 15.h),
            GestureDetector(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  context.go("/login");
                }
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [MyColor.gradientGreen, MyColor.animationGreen],
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
                    "Next",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: MyColor.bg1,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              "Didn't receive the code ?",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 12,
                color: Colors.black,
              ),
            ),
            Text(
              "Resend a new code",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget otpField(
    BuildContext context,
    int index,
    TextEditingController controller,
    FocusNode currentFocus,
    FocusNode? nextFocus,
    FocusNode? previousFocus,
  ) {
    return SizedBox(
      width: 50.w,
      height: 50.h,
      child: TextFormField(
        controller: controller,
        focusNode: currentFocus,
        cursorColor: Colors.black,
        enableInteractiveSelection: false,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: TextStyle(fontSize: 15, height: 1),
        obscureText: isObscured[index],
        obscuringCharacter: "●",
        decoration: InputDecoration(
          counterText: "",
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide.none,
          ),

          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyColor.dltRed),
          ),
          errorStyle: TextStyle(fontSize: 0),
        ),

        onChanged: (value) {
          if (value.isNotEmpty) {
            setState(() {
              isObscured[index] = false;
            });

            timers[index]?.cancel();

            timers[index] = Timer(const Duration(milliseconds: 200), () {
              setState(() {
                isObscured[index] = true;
              });
            });

            if (nextFocus != null) {
              FocusScope.of(context).requestFocus(nextFocus);
            }
          } else {
            if (previousFocus != null) {
              FocusScope.of(context).requestFocus(previousFocus);
            }
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter the OTP code";
          }
          return null;
        },
      ),
    );
  }
}

class Desktop extends StatefulWidget {
  const Desktop({super.key});

  @override
  State<Desktop> createState() => _DesktopState();
}

class _DesktopState extends State<Desktop> {
  late final List<bool> isObscured = [false, false, false, false, false, false];
  final List<Timer?> timers = [null, null, null, null, null, null];
  final c1 = TextEditingController();
  final c2 = TextEditingController();
  final c3 = TextEditingController();
  final c4 = TextEditingController();
  final c5 = TextEditingController();
  final c6 = TextEditingController();
  final f1 = FocusNode();
  final f2 = FocusNode();
  final f3 = FocusNode();
  final f4 = FocusNode();
  final f5 = FocusNode();
  final f6 = FocusNode();

  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    for (final timer in timers) {
      timer?.cancel();
    }

    c1.dispose();
    c2.dispose();
    c3.dispose();
    c4.dispose();
    c5.dispose();
    c6.dispose();
    f1.dispose();
    f2.dispose();
    f3.dispose();
    f4.dispose();
    f5.dispose();
    f6.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
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
            flex: 1,
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
                    "Verify your number",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "Enter your OTP code below",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: MyColor.textGraey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 40),
                  //otp
                  Form(
                    key: _formKey,
                    child: SizedBox(
                      width: 500,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          otpField(context, 0, c1, f1, f2, null),
                          otpField(context, 1, c2, f2, f3, f1),
                          otpField(context, 2, c3, f3, f4, f2),
                          otpField(context, 3, c4, f4, f5, f3),
                          otpField(context, 4, c5, f5, f6, f4),
                          otpField(context, 5, c6, f6, null, f5),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        context.go("/login");
                      }
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
                      child: Center(
                        child: Text(
                          "Next",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: MyColor.bg1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Didn't receive the code ?",
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "Resend a new code",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: Colors.black,
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

  Widget otpField(
    BuildContext context,
    int index,
    TextEditingController controller,
    FocusNode currentFocus,
    FocusNode? nextFocus,
    FocusNode? previousFocus,
  ) {
    return SizedBox(
      width: 50,
      height: 50,
      child: TextFormField(
        controller: controller,
        focusNode: currentFocus,
        cursorColor: Colors.black,
        enableInteractiveSelection: false,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: TextStyle(fontSize: 12, height: 1),
        obscureText: isObscured[index],
        obscuringCharacter: "●",
        decoration: InputDecoration(
          counterText: "",
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide.none,
          ),

          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyColor.dltRed),
          ),
          errorStyle: TextStyle(fontSize: 0),
        ),

        onChanged: (value) {
          if (value.isNotEmpty) {
            setState(() {
              isObscured[index] = false;
            });

            timers[index]?.cancel();

            timers[index] = Timer(const Duration(milliseconds: 200), () {
              setState(() {
                isObscured[index] = true;
              });
            });

            if (nextFocus != null) {
              FocusScope.of(context).requestFocus(nextFocus);
            }
          } else {
            if (previousFocus != null) {
              FocusScope.of(context).requestFocus(previousFocus);
            }
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter the OTP code";
          }
          return null;
        },
      ),
    );
  }
}
