import 'package:flutter/material.dart';
import 'package:grocery_app/utils/app_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/data/dummy_data.dart';
import 'package:grocery_app/screen/home_page/featured_product/product_detail_screen.dart';
import 'package:grocery_app/screen/home_page/featured_product/card/product_card.dart';
import 'package:grocery_app/utils/app_colors.dart';
import 'package:grocery_app/screen/home_page/featured_product/product_screen.dart';

class FeaturedProductWidget extends StatefulWidget {
  const FeaturedProductWidget({super.key});

  @override
  State<FeaturedProductWidget> createState() => _FeaturedProductWidgetState();
}

class _FeaturedProductWidgetState extends State<FeaturedProductWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Title
        Padding(
          padding: const EdgeInsets.only(left: 17),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Featured products",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              IconButton(
                splashRadius: 50,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => VegetableScreen(product: products),
                    ),
                  );
                },
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
                icon: Icon(
                  MyIcon.arrowForward,
                  size: 18.sp,
                  color: MyColor.textGraey,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 8.h),

        /// Product Grid
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 17.w,
              mainAxisSpacing: 20.h,
              childAspectRatio: 0.71,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          ProductDetailScreen(product: products[index]),
                    ),
                  );
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
