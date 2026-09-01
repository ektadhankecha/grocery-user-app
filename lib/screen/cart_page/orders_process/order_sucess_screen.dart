import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_app/screen/cart_page/orders_process/teack_order/track_order_screen.dart';
import 'package:grocery_app/utils/app_colors.dart';
import 'package:grocery_app/utils/app_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/screen/main_page/main_screen.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: ((didPop, result) {
        if (didPop) return;
        context.go("/main");
        // Navigator.pushAndRemoveUntil(
        //   context,
        //   MaterialPageRoute(builder: (_) => const MainScreen()),
        //   (route) => false,
        // );
      }),
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(17, 0, 17, 25),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(80, 180, 80, 180),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      MyIcon.shoppingBag,
                      size: 140,
                      color: MyColor.animationGreen,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Your order was Successful!",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 15),
                    Text(
                      "You will get a response within a few minutes.",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: MyColor.textGraey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  context.push("/trackOrder");
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => TrackOrderScreen()),
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
                      "Track Order ",
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
    );
  }
}
