import 'dart:async';
import 'package:grocery_app/data/dummy_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/screen/home_page/banner/banner_provider.dart';
import 'package:grocery_app/utils/app_colors.dart';
import 'package:provider/provider.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  final PageController _pageController = PageController();
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 3), (_) {
      if (!_pageController.hasClients) return;
      final bannerProvider = context.read<BannerProvider>();
      bannerProvider.nextBanner(banners.length);
      _pageController.animateToPage(
        bannerProvider.currentIndex,
        duration: Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bannerProvider = context.watch<BannerProvider>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.w),
      child: SizedBox(
        height: 283.h,
        child: PageView.builder(
          controller: _pageController,
          itemCount: banners.length,
          onPageChanged: (index) {
            context.read<BannerProvider>().changeBanner(index);
          },
          itemBuilder: (context, index) {
            return Stack(
              children: [
                ClipRRect(
                  child: Image.asset(
                    banners[index].image,
                    height: 283.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 143.h,
                  left: 46.w,
                  child: SizedBox(
                    height: 60.h,
                    width: 160.w,
                    child: Text(
                      banners[index].title,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 247.h,
                  left: 16.w,

                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        banners.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          width: bannerProvider.currentIndex == index ? 20 : 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: bannerProvider.currentIndex == index
                                ? MyColor.animationGreen
                                : MyColor.bg1,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
