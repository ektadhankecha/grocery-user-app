import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/data/dummy_data.dart';
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
    timer = Timer.periodic(const Duration(seconds: 3), (_) {
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

    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        // Height dynamically scales with width (35%), clamped between 180 and 360
        double bannerHeight = (screenWidth * 0.35).clamp(180.0, 450.0);
        double titleFontSize = screenWidth < 600 ? 16 : (screenWidth < 1000 ? 22 : 25);

        return Center(
          child: Container(
          //  constraints: BoxConstraints(maxWidth: 1800),
            padding: EdgeInsets.symmetric(horizontal: 17.w),
            height: bannerHeight,
            child: PageView.builder(
              controller: _pageController,
              itemCount: banners.length,
              onPageChanged: (index) {
                context.read<BannerProvider>().changeBanner(index);
              },
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    // Banner Image
                    ClipRRect(
                      child: Image.asset(
                        banners[index].image,
                        height: bannerHeight,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),

                    // Banner Text
                    Positioned(
                      top: bannerHeight * 0.45,
                      left: screenWidth < 600 ? 30 : 50,
                      child: SizedBox(
                        width: screenWidth < 600 ? 180 : 250,
                        child: Text(
                          banners[index].title,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: titleFontSize,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),

                    // Page Indicator Dots (Centered at bottom)
                    Positioned(
                      bottom: 12,
                      left: 16,

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
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
