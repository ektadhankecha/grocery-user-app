import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/utils/app_colors.dart';

class TrackStep extends StatelessWidget {
  final IconData icon;
  final String title;
  final String date;
  final bool isCompleted;
  final bool isLast;

  const TrackStep({
    super.key,
    required this.icon,
    required this.title,
    required this.date,
    required this.isCompleted,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// LEFT SIDE (Circle + Vertical Line)
          Column(
            children: [
              CircleAvatar(
                radius: 33,
                backgroundColor: isCompleted
                    ? MyColor.locationgreen
                    : MyColor.bggray,
                foregroundColor: MyColor.animationGreen,

                child: Icon(
                  icon,
                  size: 33,
                  color: isCompleted
                      ? MyColor.animationGreen
                      : MyColor.textGraey,
                ),
              ),

              /// Vertical Divider
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 1.w,
                    height: 40.h,
                    color: MyColor.dividerLine,
                  ),
                ),
            ],
          ),

          SizedBox(width: 16.w),

          /// RIGHT SIDE (Text)
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 0.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(height: 5.h),

                  Text(
                    date,
                    style: TextStyle(fontSize: 10.sp, color: MyColor.textGraey),
                  ),

                  SizedBox(height: 15.h),

                  /// Horizontal Divider
                  if (!isLast)
                    Divider(thickness: 1, color: MyColor.dividerLine),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
