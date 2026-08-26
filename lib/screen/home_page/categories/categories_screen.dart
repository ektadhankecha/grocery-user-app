import 'package:flutter/material.dart';
import 'package:grocery_app/utils/app_icons.dart';
import 'package:grocery_app/model/category_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/utils/app_colors.dart';

class CategoriesScreen extends StatelessWidget {
  final List<CategoryModel> categories;
  const CategoriesScreen({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75.h,
        backgroundColor: MyColor.bg1,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(MyIcon.arrowBack, size: 22.sp),
        ),
        title: Center(
          child: Text(
            "Categories",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
      ),

      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: MyColor.bg3,
        child: GridView.builder(
          shrinkWrap: false,
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.all(17.r),
          itemCount: categories.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10.w,
            mainAxisSpacing: 14.h,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            return Container(
              width: 120.w,
              height: 120.h,

              color: MyColor.catebg,
              child: Center(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 16.h),
                      width: 66.r,
                      height: 66.r,
                      decoration: BoxDecoration(
                        color: categories[index].bgColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: SvgPicture.asset(categories[index].image),
                      ),
                    ),
                    SizedBox(height: 9.h),
                    Text(
                      categories[index].name,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: MyColor.textGraey,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
