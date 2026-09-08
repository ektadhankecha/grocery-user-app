import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_app/utils/app_icons.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/utils/app_colors.dart';
import 'categories_screen.dart';
import 'category_provider.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    final categoryProvider = context.watch<CategoryProvider>();
   final categories = categoryProvider.categoryList;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Title Row
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Categories",
                style: TextStyle(
                  fontSize: screenWidth > 550 ? 22 : 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                splashRadius: 50,
                onPressed: () {
                  context.push("/category", extra: categories);
                },
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
                icon: Icon(
                  MyIcon.arrowForward,
                  size: screenWidth > 550 ? 22 : 18,
                  color: MyColor.textGraey,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 8.h),

        /// Category List
        Padding(
          padding: EdgeInsets.only(left: 17.w),
          child: SizedBox(
            height: screenWidth > 550 ? 87.h : 78.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: screenWidth > 550 ? 20 : 17),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: screenWidth > 550 ? 30.r : 25.r,
                        backgroundColor: categories[index].bgColor,
                        child: Image.network(
                          categories[index].image,
                          height: screenWidth > 550 ? 30.h : 25.h,
                          width: screenWidth > 550 ? 30.w : 25.w,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        categories[index].name,
                        style: TextStyle(
                          fontSize: screenWidth > 550 ? 11 : 9,
                          fontWeight: FontWeight.w500,
                          color: MyColor.textGraey,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
