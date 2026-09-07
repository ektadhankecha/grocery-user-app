import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_app/auth/responsive_layout.dart';
import 'package:grocery_app/utils/app_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/utils/app_colors.dart';

class VerifyNumber extends StatefulWidget {
  const VerifyNumber({super.key});

  @override
  State<VerifyNumber> createState() => _VerifyNumberState();
}

class _VerifyNumberState extends State<VerifyNumber> {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.bg3,
      appBar: AppBar(
        backgroundColor: MyColor.bg3,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(MyIcon.arrowBack),
        ),
        title: const Text(
          "Verify Number",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17),
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
                "Enter the verification code sent to your email.",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: MyColor.textGraey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 30.h),

            TextFormField(
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
              keyboardType: TextInputType.phone,
              initialValue: "2055550145",
              readOnly: true,
              decoration: InputDecoration(
                hintText: "2055550145",
                hintStyle: const TextStyle(
                  color: Colors.black87,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),

                prefixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: 12),

                    const Text("🇺🇸", style: TextStyle(fontSize: 20)),

                    const SizedBox(width: 6),

                    const Text(
                      "+1",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const Icon(MyIcon.arrowDropDown, size: 20),

                    const SizedBox(width: 8),

                    Container(
                      height: 28,
                      width: 1,
                      color: Colors.grey.shade300,
                    ),

                    const SizedBox(width: 8),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15.h),
            GestureDetector(
              onTap: () {
                context.push("/otp");
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
              "Resend confirmation code (1:23)",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 12,
                color: Colors.black,
              ),
            ),
          ],
        ),
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
                  SizedBox(height: 10.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "Enter the verification code sent to your email.",
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
                    child: TextFormField(
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                      keyboardType: TextInputType.phone,
                      initialValue: "2055550145",
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: "2055550145",
                        hintStyle: const TextStyle(
                          color: Colors.black87,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),

                        prefixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(width: 12),

                            const Text("🇺🇸", style: TextStyle(fontSize: 20)),

                            const SizedBox(width: 6),

                            const Text(
                              "+1",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            const Icon(MyIcon.arrowDropDown, size: 20),

                            const SizedBox(width: 8),

                            Container(
                              height: 28,
                              width: 1,
                              color: Colors.grey.shade300,
                            ),

                            const SizedBox(width: 8),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  GestureDetector(
                    onTap: () {
                      context.push("/otp");
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
                  SizedBox(height: 20.h),
                  Text(
                    "Resend confirmation code (1:23)",
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
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
}
