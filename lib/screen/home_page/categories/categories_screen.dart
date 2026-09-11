import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(MyIcon.arrowBack),
        ),
        title: const Text("Categories"),
      ),

      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: MyColor.bg3,
        child: GridView.builder(
        //  shrinkWrap: false,
        //  physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 17,vertical: 17),
          itemCount: categories.length,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 130,
            crossAxisSpacing: 17,
            mainAxisSpacing: 17,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            return
              Container(
                color: MyColor.bg1,
                child: Column(
                  children: [
                    Spacer(),
                    CircleAvatar(
                      radius: 30.r,
                      backgroundColor: categories[index].bgColor,
                   child: Image.network(categories[index].image,width: 25.w,height: 25.h,),

                    ),

                    SizedBox(height: 9),
                    Text(
                      categories[index].name,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: MyColor.textGraey,
                      ),
                    ),

                    Spacer(),
                  ],
                ),
              );
          },
        ),
      ),
    );
  }
}
