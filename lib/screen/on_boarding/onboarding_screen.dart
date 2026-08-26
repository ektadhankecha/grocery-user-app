import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/auth/auth_page.dart';
import 'package:grocery_app/screen/on_boarding/onboarding_provider.dart';
import 'package:grocery_app/utils/app_colors.dart';
import 'package:provider/provider.dart';
import '../../data/onboarding_data.dart';
import 'onboarding_item_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: onboardingData.length,
              onPageChanged: (index) {
                context.read<OnboardingProvider>().changePage(index);
              },
              itemBuilder: (context, index) {
                return OnboardingItem(model: onboardingData[index]);
              },
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Padding(
                padding: EdgeInsets.only(left: 26.w),
                child: TextButton(
                  onPressed: () async {
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    await pref.setBool("onBoardingComplete", true);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AuthPage()),
                    );
                  },
                  child: Text(
                    "Skip",
                    style: TextStyle(
                      color: MyColor.lightGraey,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),

              Consumer<OnboardingProvider>(
                builder: (context, provider, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      3,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 2.5),
                        width: 7,
                        height: 7,

                        decoration: BoxDecoration(
                          color: provider.currentIndex == index
                              ? MyColor.animationGreen
                              : MyColor.aniGray,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  );
                },
              ),

              Padding(
                padding: EdgeInsets.only(right: 26.w),
                child: TextButton(
                  onPressed: () async {
                    if (context.read<OnboardingProvider>().isLastPage(3)) {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      await pref.setBool("onBoardingComplete", true);

                      // Last onboarding page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AuthPage(),
                        ),
                      );
                    } else {
                      // Go to next onboarding page
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },

                  child: Text(
                    "Next",
                    style: TextStyle(
                      color: MyColor.animationGreen,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 75.h),
        ],
      ),
    );
  }
}
