import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../model/onboarding_model.dart';
import '../../utils/app_colors.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_app/screen/on_boarding/onboarding_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingItem extends StatelessWidget {
  final OnboardingModel model;
  final PageController pageController;
  const OnboardingItem({
    super.key,
    required this.model,

    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 171.h),
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 400, minWidth: 400),
          child: Image.asset(model.image, fit: BoxFit.contain),
        ),
        SizedBox(height: 45.h),
        Text(
          model.title,
          style: TextStyle(
            fontSize: 24,
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
        Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 27),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              TextButton(
                onPressed: () async {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  await pref.setBool("onBoardingComplete", true);
                  if (context.mounted) context.go("/auth");
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

              TextButton(
                onPressed: () async {
                  if (context.read<OnboardingProvider>().isLastPage(3)) {
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    await pref.setBool("onBoardingComplete", true);

                    // Last onboarding page
                    if (context.mounted) context.go("/auth");
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
            ],
          ),
        ),
      ],
    );
  }
}
