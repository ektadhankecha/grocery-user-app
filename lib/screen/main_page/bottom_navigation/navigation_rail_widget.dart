import 'package:flutter/material.dart';
import 'package:grocery_app/screen/home_page/featured_product/card/product_provider.dart';
import 'package:grocery_app/utils/app_icons.dart';
import 'package:grocery_app/utils/app_colors.dart';
import 'package:provider/provider.dart';

class NavigationRailWidget extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;
  final bool? isExpanded;

  const NavigationRailWidget({
    super.key,
    required this.selectedIndex,
    required this.onTap,
    this.isExpanded,
  });

  @override
  Widget build(BuildContext context) {
    // Condition: On tablet/compact width show only icons, on desktop show icon with name
    final bool expanded =
        isExpanded ?? (MediaQuery.of(context).size.width >= 1100);

    final List<IconData> icons = [
      MyIcon.home,
      MyIcon.favoriteBorder,
      MyIcon.shoppingBag,
      MyIcon.profileCircle,
    ];

    final List<String> labels = [
      "Home",
      "Favorites",
      "Cart",
      "Profile",
    ];

    if (expanded) {
      return _buildDesktopExpandedRail(context, icons, labels);
    } else {
      return _buildTabletCompactRail(context, icons);
    }
  }

  /// Desktop view: App Icon + App Name at top, and icon with label name for items
  Widget _buildDesktopExpandedRail(
    BuildContext context,
    List<IconData> icons,
    List<String> labels,
  ) {
    const double railWidth = 200.0;

    return Container(
      width: railWidth,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          right: BorderSide(color: MyColor.dividerLine, width: 1),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Header: App Icon + App Name
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/app_icon.png',
                      height: 34,
                      width: 34,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        "Grocery App",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),
              const Divider(color: MyColor.dividerLine, height: 1),
              const SizedBox(height: 16),

              // Rail Navigation Items
              Expanded(
                child: ListView.separated(
                  itemCount: icons.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final bool isSelected = index == selectedIndex;
                    return Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => onTap(index),
                        borderRadius: BorderRadius.circular(12),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? MyColor.animationGreen
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: Colors.green.withValues(alpha: 0.25),
                                      blurRadius: 8,
                                      offset: const Offset(0, 3),
                                    ),
                                  ]
                                : null,
                          ),
                          child: Row(
                            children: [
                              // Icon with Cart Badge
                              index == 2
                                  ? Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Icon(
                                          icons[index],
                                          size: 22,
                                          color: isSelected
                                              ? Colors.white
                                              : MyColor.textGraey,
                                        ),
                                        Consumer<ProductProvider>(
                                          builder: (context, productProvider, child) {
                                            final count = productProvider.cartBadgeCount;
                                            if (count == 0) return const SizedBox();

                                            return Positioned(
                                              right: -8,
                                              top: -8,
                                              child: Container(
                                                width: 17,
                                                height: 17,
                                                decoration: BoxDecoration(
                                                  color: isSelected
                                                      ? Colors.white
                                                      : MyColor.animationGreen,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "$count",
                                                    style: TextStyle(
                                                      color: isSelected
                                                          ? MyColor.animationGreen
                                                          : Colors.white,
                                                      fontSize: 9,
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
                                      icons[index],
                                      size: 22,
                                      color: isSelected
                                          ? Colors.white
                                          : MyColor.textGraey,
                                    ),
                              const SizedBox(width: 14),
                              // Label Name
                              Expanded(
                                child: Text(
                                  labels[index],
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.w500,
                                    color: isSelected
                                        ? Colors.white
                                        : MyColor.textGraey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Tablet view: Compact rail with Top App Icon, and only icons with floating circle indicator
  Widget _buildTabletCompactRail(BuildContext context, List<IconData> icons) {
    const double railWidth = 72.0;
    const double itemHeight = 70.0;
    const double circleOuterSize = 58.0;
    const double circleInnerSize = 50.0;

    return Container(
      width: railWidth,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          right: BorderSide(color: MyColor.dividerLine, width: 1),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            // Top App Icon (Tablet Compact Header)
            Center(
              child: Image.asset(
                'assets/images/app_icon.png',
                height: 32,
                width: 32,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 16),
            const Divider(color: MyColor.dividerLine, height: 1, indent: 12, endIndent: 12),
            const SizedBox(height: 16),

            Expanded(
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  // Animated Floating Active Indicator
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    top: selectedIndex * itemHeight +
                        (itemHeight - circleOuterSize) / 2,
                    left: (railWidth - circleOuterSize) / 2,
                    child: Container(
                      width: circleOuterSize,
                      height: circleOuterSize,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Container(
                          width: circleInnerSize,
                          height: circleInnerSize,
                          decoration: BoxDecoration(
                            color: MyColor.animationGreen,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.green.withValues(alpha: 0.3),
                                blurRadius: 6,
                                offset: const Offset(0, 4),
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
                                        size: 24,
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
                                    size: 24,
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Column of Rail Icon Items
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(icons.length, (index) {
                      final bool isSelected = index == selectedIndex;
                      return SizedBox(
                        width: railWidth,
                        height: itemHeight,
                        child: InkWell(
                          onTap: () => onTap(index),
                          child: Center(
                            child: isSelected
                                ? const SizedBox() // Active icon is rendered inside AnimatedPositioned
                                : index == 2
                                    ? Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          Icon(
                                            icons[index],
                                            color: MyColor.textGraey,
                                            size: 24,
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
                                        icons[index],
                                        color: MyColor.textGraey,
                                        size: 24,
                                      ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
