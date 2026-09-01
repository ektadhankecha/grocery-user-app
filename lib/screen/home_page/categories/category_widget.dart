import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_app/utils/app_icons.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/data/dummy_data.dart';
import 'package:grocery_app/utils/app_colors.dart';
import 'categories_screen.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Title Row
        Padding(
          padding: EdgeInsets.only(left: 17.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Categories",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              IconButton(
                splashRadius: 50,
                onPressed: () {
                  context.push("/category",extra:categories);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (_) => CategoriesScreen(categories: categories),
                  //   ),
                  // );
                },
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
                icon: Icon(
                  MyIcon.arrowForward,
                  size: 18.sp,
                  color: MyColor.textGraey,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 4.h),

        /// Category List
        SizedBox(
          height: 78.h,
          child: ListView.builder(
            //   padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  left: 17.w,
                  right: index == categories.length - 1 ? 17.w : 0,
                ),
                child: Column(
                  children: [
                    Container(
                      height: 50.r,
                      width: 50.r,
                      decoration: BoxDecoration(
                        color: categories[index].bgColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          categories[index].image,
                          height: 25.h,
                          width: 25.w,
                        ),
                      ),
                    ),

                    SizedBox(height: 8.h),

                    Text(
                      categories[index].name,
                      style: TextStyle(
                        fontSize: 9,
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
      ],
    );
  }
}
