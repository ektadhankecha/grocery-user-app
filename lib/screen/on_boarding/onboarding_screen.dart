import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'onboarding_window.dart';
import 'package:grocery_app/screen/on_boarding/onboarding_provider.dart';

import 'package:provider/provider.dart';
import '../../data/onboarding_data.dart';
import 'onboarding_item_widget.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {


  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context,constraints){
          final isWindowDesktop = constraints.maxWidth >= 900;
          return PageView.builder(
            controller: pageController,
            itemCount: onboardingData.length,
            onPageChanged: (index) {
              context.read<OnboardingProvider>().changePage(index);
            },
            itemBuilder: (context, index) {
              if(isWindowDesktop){
                return OnboardingWindow(model: onboardingData[index], pageController: pageController);
              }

              return OnboardingItem(model: onboardingData[index],
                pageController: pageController,
              );
            },
          );
        },

      ),
    );
  }
}
