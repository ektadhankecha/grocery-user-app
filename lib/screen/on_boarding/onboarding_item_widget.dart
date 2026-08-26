import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../model/onboarding_model.dart';
import '../../utils/app_colors.dart';

class OnboardingItem extends StatelessWidget {
  const OnboardingItem({super.key, required this.model});

  final OnboardingModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 171.h),
          child: Image.asset(model.image, fit: BoxFit.contain),
        ),
        SizedBox(height: 45.h),
        Text(
          model.title,
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'poppinsbold',
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 12.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Text(
            model.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: MyColor.textGraey,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
