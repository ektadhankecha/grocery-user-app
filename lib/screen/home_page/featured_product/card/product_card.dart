import 'package:flutter/material.dart';
import 'package:grocery_app/screen/home_page/featured_product/card/product_provider.dart';
import 'package:grocery_app/utils/app_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/model/product_model.dart';
import 'package:grocery_app/utils/app_colors.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatefulWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});
  @override
  State<StatefulWidget> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int quantity = 1;

  Color getBadgeColor(String badge) {
    switch (badge) {
      case "New":
        return MyColor.newclr;

      case "-16%":
        return MyColor.offclr;

      default:
        return Colors.grey;
    }
  }

  Color getBadgeTextColor(String badge) {
    switch (badge) {
      case "New":
        return MyColor.newtext;

      case "-16%":
        return MyColor.offtext;

      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 181.w,
      height: 234.h,
      decoration: const BoxDecoration(color: MyColor.bg1),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(8, 8, 8, 4),
            child: Column(
              children: [
                /// Favourite Icon
                Align(
                  alignment: Alignment.topRight,
                  child: Consumer<ProductProvider>(
                    builder: (context, provider, child) {
                      return InkWell(
                        borderRadius: BorderRadius.circular(20.r),
                        onTap: () {
                          provider.toggleFavorite(widget.product);
                          //  widget.onFavoriteChanged?.call();
                        },
                        child: Padding(
                          padding: EdgeInsets.all(0.r),
                          child: Icon(
                            widget.product.isFavorite
                                ? MyIcon.favorite
                                : MyIcon.favoriteBorderSimple,
                            size: 25.sp,
                            color: widget.product.isFavorite
                                ? MyColor.faviourtred
                                : MyColor.textGraey,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                /// Product Image
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 15, left: 47),
                      height: 84,
                      width: 84,
                      decoration: BoxDecoration(
                        color: widget.product.bgColor,
                        shape: BoxShape.circle,
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 21.h),
                      child: Image.asset(
                        widget.product.image,
                        width: 130.w,
                        height: 84.h,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8.h),

                /// Price
                Text(
                  "\$${widget.product.price.toStringAsFixed(2)}",
                  style: TextStyle(
                    color: MyColor.animationGreen,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                /// Product Name
                Text(
                  widget.product.name,
                  style: TextStyle(
                    fontFamily: 'poppinsbold',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 1.h),

                /// Quantity
                Text(
                  widget.product.quantity,
                  style: TextStyle(
                    color: MyColor.textGraey,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const Spacer(),

                Divider(height: 1.h, color: MyColor.dividerLine),
                SizedBox(height: 1),

                GestureDetector(
                  onTap: () {
                    context.read<ProductProvider>().addToCart(
                      widget.product,
                      quantity,
                    );

                    ScaffoldMessenger.of(context).hideCurrentSnackBar();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Center(
                          child: const Text(
                            "Product added",
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                        duration: const Duration(seconds: 1),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: MyColor.animationGreen,
                        margin: EdgeInsets.symmetric(
                          horizontal: 130,
                          vertical: 50,
                        ),
                        dismissDirection: DismissDirection.up,
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          MyIcon.shoppingBag,
                          size: 16.sp,
                          color: MyColor.animationGreen,
                        ),

                        SizedBox(width: 8.w),

                        Text(
                          "Add to cart",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          if (widget.product.badge != null)
            Positioned(
              child: Container(
                width: 38.w,
                height: 18.h,
                decoration: BoxDecoration(
                  color: getBadgeColor(widget.product.badge!),
                ),
                child: Center(
                  child: Text(
                    widget.product.badge!,
                    style: TextStyle(
                      color: getBadgeTextColor(widget.product.badge!),
                      fontSize: 8,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
