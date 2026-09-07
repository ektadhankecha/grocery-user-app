import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/screen/home_page/featured_product/card/product_provider.dart';
import 'package:grocery_app/utils/app_icons.dart';
import 'package:grocery_app/utils/app_colors.dart';
import 'package:provider/provider.dart';

class BottomNavigator extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const BottomNavigator({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final List<IconData> icons = [
      MyIcon.home,
      MyIcon.favoriteBorder,
      MyIcon.shoppingBag,
      MyIcon.profileCircle,
    ];

    return SizedBox(
      height: 60.h,
      child: LayoutBuilder(
        builder: (context, constraints) {
          double itemWidth = constraints.maxWidth / icons.length;
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                decoration: const BoxDecoration(color: Colors.white),

                child: Row(
                  children: List.generate(icons.length, (index) {
                    return Expanded(
                      child: InkWell(
                        onTap: () {
                          onTap(index);
                        },

                        child: Center(
                          child: index == 2
                              ? Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Icon(
                                      icons[index],
                                      color: MyColor.textGraey,
                                      size: 25,
                                    ),
                                    Consumer<ProductProvider>(
                                      builder:
                                          (context, productProvider, child) {
                                            final count =
                                                productProvider.cartBadgeCount;
                                            if (count == 0) {
                                              return const SizedBox();
                                            }

                                            return Positioned(
                                              right: -8,
                                              top: -8,
                                              child: Container(
                                                width: 18,
                                                height: 18,
                                                decoration: const BoxDecoration(
                                                  color: MyColor.animationGreen,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "$count",
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                    ),
                                  ],
                                )
                              : Icon(
                                  icons[index],
                                  color: MyColor.textGraey,
                                  size: 25,
                                ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                left: selectedIndex * itemWidth + (itemWidth - 65) / 2,
                top: -20,

                child: Container(
                  width: 65,
                  height: 65,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: MyColor.animationGreen,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.withValues(alpha: 0.3),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: selectedIndex == 2
                            ? Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Icon(
                                    icons[selectedIndex],
                                    color: MyColor.bg1,
                                    size: 28,
                                  ),

                                  Consumer<ProductProvider>(
                                    builder: (context, productProvider, child) {
                                      final count =
                                          productProvider.cartBadgeCount;
                                      if (count == 0) return const SizedBox();

                                      return Positioned(
                                        right: -8,
                                        top: -8,
                                        child: Container(
                                          width: 18,
                                          height: 18,
                                          decoration: const BoxDecoration(
                                            color: MyColor.bg1,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Center(
                                            child: Text(
                                              "$count",
                                              style: const TextStyle(
                                                color: MyColor.animationGreen,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              )
                            : Icon(
                                icons[selectedIndex],
                                color: MyColor.bg1,
                                size: 28,
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
    );
  }
}
