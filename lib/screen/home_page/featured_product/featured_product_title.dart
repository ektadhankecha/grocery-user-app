import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_app/utils/app_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/data/dummy_data.dart';
import 'package:grocery_app/screen/home_page/featured_product/card/product_card.dart';
import 'package:grocery_app/utils/app_colors.dart';

class FeaturedProductWidget extends StatefulWidget {
  const FeaturedProductWidget({super.key});

  @override
  State<FeaturedProductWidget> createState() => _FeaturedProductWidgetState();
}

class _FeaturedProductWidgetState extends State<FeaturedProductWidget> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Title
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Featured products",
                style: TextStyle(
                  fontSize: screenWidth > 550 ? 22 : 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                splashRadius: 50,
                onPressed: () {
                  context.push("/product", extra: products);
                },
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
                icon: Icon(
                  MyIcon.arrowForward,
                  size: screenWidth > 550 ? 22 : 18,
                  color: MyColor.textGraey,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 8.h),

        /// Product Grid
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 17.w),
          child: GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 180,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.74,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  context.push("/productDetail", extra: products[index]);
                },
                child: ProductCard(product: products[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}
