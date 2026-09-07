import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../model/onboarding_model.dart';
import '../../utils/app_colors.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_app/screen/on_boarding/onboarding_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class OnboardingWindow extends StatelessWidget {
  final OnboardingModel model;
  final PageController pageController;
  const OnboardingWindow({super.key,
  required this.model,
    required this.pageController
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 45,
            child: Column(
              children: [
                SizedBox(
                  height: 120,
                ),

            Padding(
              padding:  EdgeInsets.only(left: 70,top: 30,bottom: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset("assets/images/app_icon.png",height: 50,width: 50,),
                       SizedBox(width: 20,),
                       Text("Grocery App",style: TextStyle(fontSize:24,fontWeight: FontWeight.bold),)
                    ],
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Text(model.title,style: TextStyle(fontSize: 48,fontWeight: FontWeight.bold,color: MyColor.animationGreen),),
                  SizedBox(
                    height: 30,
                  ),
                  Text(model.description,style: TextStyle(color: MyColor.textGraey,fontSize: 20,fontWeight: FontWeight.w500),),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    children: [

                      Column(
                        children: [
                          Icon(Icons.energy_savings_leaf_outlined,color: MyColor.animationGreen,size: 35,),
                          SizedBox(height: 5,),
                          Text("Fresh Product",style: TextStyle(fontSize: 13,color: MyColor.textGraey),)
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.price_change_outlined,color: MyColor.animationGreen,size: 35,),
                          SizedBox(height: 5,),
                          Text("Best Price",style: TextStyle(fontSize: 13,color: MyColor.textGraey),)
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.shopping_cart_outlined,color: MyColor.animationGreen,size: 35,),
                          SizedBox(height: 5,),
                          Text("Fast Delivery",style: TextStyle(fontSize: 13,color: MyColor.textGraey),)
                        ],
                      )
                    ],
                  ),

                ],
              ),
            ),
            SizedBox(
              height: 150,
            ),

            Padding(
              padding:  EdgeInsets.only(left: 45),
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
                        fontSize: 15,
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
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )),
        Expanded(
            flex: 55,
            child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 700,
                  maxWidth: 800
                ),
                child: Image.asset(model.image)))
      ],
    );
  }
}
