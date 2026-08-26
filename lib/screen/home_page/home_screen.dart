import 'package:flutter/material.dart';
import 'package:grocery_app/screen/home_page/banner/banner_widget.dart';
import 'package:grocery_app/screen/home_page/search/search_bar_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/screen/home_page/categories/category_widget.dart';
import 'package:grocery_app/screen/home_page/featured_product/featured_product_title.dart';
import 'package:grocery_app/utils/app_colors.dart';
import 'package:grocery_app/screen/home_page/custom_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [MyColor.bg1, MyColor.bg3, MyColor.bg3],
        ),
      ),
      child: Scaffold(
        drawer: const CustomDrawer(),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 41.h),
              SearchBarWidget(),
              SizedBox(height: 8.h),
              BannerWidget(),
              SizedBox(height: 8.h),
              CategoryWidget(),
              SizedBox(height: 20.h),
              FeaturedProductWidget(),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }
}
