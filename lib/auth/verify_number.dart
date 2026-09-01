import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_app/utils/app_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/utils/app_colors.dart';
import 'otp_screen.dart';

class VerifyNumber extends StatefulWidget {
  const VerifyNumber({super.key});

  @override
  State<VerifyNumber> createState() => _VerifyNumberState();
}

class _VerifyNumberState extends State<VerifyNumber> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.bg3,
      appBar: AppBar(
        toolbarHeight: 81.h,
        backgroundColor: MyColor.bg3,
        leading: IconButton(
          onPressed: () {
            context.pop();
            //Navigator.pop(context);
          },
          icon: Icon(MyIcon.arrowBack, size: 25.sp),
        ),
        centerTitle: true,
        title: Text(
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
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => OtpScreen()),
                // );
              },
              child: Container(
                height: 60.h,
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
