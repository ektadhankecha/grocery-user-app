import 'package:flutter/material.dart';
import 'package:grocery_app/screen/home_page/featured_product/card/product_provider.dart';
import 'package:grocery_app/utils/app_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/model/product_model.dart';
import 'package:grocery_app/utils/app_colors.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.product});
  final ProductModel product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool isExpanded = false;
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();
    final cartQuantity = productProvider.cartQuantities[widget.product.id] ?? 0;
    final displayQuantity = cartQuantity > 0 ? cartQuantity : quantity;

    return Scaffold(
      backgroundColor: MyColor.bg1,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Positioned(
                  top: -150.h,
                  left: -41.w,
                  right: -41.w,
                  child: Container(
                    height: 490.r,
                    width: 490.r,
                    decoration: BoxDecoration(
                      color: widget.product.bgColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 34.w,
                    top: 101.h,
                    right: 34.w,
                    bottom: 75.h,
                  ),
                  child: Center(
                    child: Image.asset(
                      widget.product.image,
                      height: 324.h,
                      width: 324.w,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Positioned(
                  top: 38.h,
                  left: 16.w,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(MyIcon.arrowBack, size: 22.sp),
                  ),
                ),
              ],
            ),

            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(16.w, 26.h, 16.w, 16.h),
              decoration: BoxDecoration(
                color: MyColor.bg3,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.r),
                  topRight: Radius.circular(10.r),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "\$${widget.product.price}",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: MyColor.textgreen,
                        ),
                      ),
                      const Spacer(),
                      Consumer<ProductProvider>(
                        builder: (context, provider, child) {
                          return InkWell(
                            borderRadius: BorderRadius.circular(20.r),
                            onTap: () {
                              provider.toggleFavorite(widget.product);
                            },
                            child: Padding(
                              padding: EdgeInsets.all(12.r),
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
                    ],
                  ),
                  Text(
                    widget.product.name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    widget.product.quantity,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: MyColor.textGraey,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      Text(
                        widget.product.rating.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Row(
                        children: List.generate(5, (index) {
                          if (index < widget.product.rating.floor()) {
                            return Icon(
                              MyIcon.star,
                              color: MyColor.staryellow,
                              size: 15.sp,
                            );
                          } else if (index < widget.product.rating) {
                            return Icon(
                              MyIcon.starHalf,
                              color: MyColor.staryellow,
                              size: 15.sp,
                            );
                          } else {
                            return Icon(
                              MyIcon.starBorder,
                              color: MyColor.staryellow,
                              size: 15.sp,
                            );
                          }
                        }),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        "(${widget.product.reviews} reviews)",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: MyColor.textGraey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    widget.product.description,
                    maxLines: isExpanded ? null : 3,
                    overflow: isExpanded
                        ? TextOverflow.visible
                        : TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: MyColor.textGraey,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: Text(
                      isExpanded ? "see less" : "see more",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 7.h),
                  Container(
                    height: 50.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      color: MyColor.bg1,
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 17.w),
                        Text(
                          "Quantity",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: MyColor.textGraey,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            if (cartQuantity > 0) {
                              productProvider.decreaseQuantity(widget.product);
                            } else {
                              if (quantity > 1) {
                                setState(() {
                                  quantity--;
                                });
                              }
                            }
                          },
                          icon: const Icon(MyIcon.remove),
                          color: MyColor.animationGreen,
                          iconSize: 21.sp,
                        ),
                        VerticalDivider(width: 1.w, color: MyColor.borderGray),
                        SizedBox(
                          width: 50.w,
                          child: Text(
                            "$displayQuantity",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        VerticalDivider(width: 1.w, color: MyColor.borderGray),
                        IconButton(
                          onPressed: () {
                            if (cartQuantity > 0) {
                              productProvider.increaseQuantity(widget.product);
                            } else {
                              setState(() {
                                quantity++;
                              });
                            }
                          },
                          icon: const Icon(MyIcon.add),
                          color: MyColor.animationGreen,
                          iconSize: 21.sp,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 13.h),

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
                          margin: EdgeInsets.all(130),
                          dismissDirection: DismissDirection.up,
                        ),
                      );
                    },
                    child: Container(
                      height: 60.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            MyColor.gradientGreen,
                            MyColor.animationGreen,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: MyColor.animationGreen.withAlpha(40),
                            blurRadius: 9,
                            spreadRadius: 0,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Center(
                            child: Text(
                              "Add to cart",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: MyColor.bg1,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 14.w,
                            child: Icon(
                              MyIcon.shoppingBag,
                              color: MyColor.bg1,
                              size: 21.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 13.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
