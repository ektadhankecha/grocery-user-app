import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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

  Widget _buildImageSection(
    BuildContext context,
    bool isWide,
    double screenWidth,
  ) {
    if (isWide) {
      return Center(
        child: Container(
          height: screenWidth > 1200 ? 450 : 380,
          width: screenWidth > 1200 ? 450 : 380,
          decoration: BoxDecoration(
            color: widget.product.bgColor,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Image.network(
            widget.product.image,
            height: screenWidth > 1200 ? 320 : 280,
            width: screenWidth > 1200 ? 320 : 280,
            fit: BoxFit.contain,
          ),
        ),
      );
    }

    return Stack(
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
            child: Image.network(
              widget.product.image,
              height: 324.h,
              width: 324.w,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailsSection(
    BuildContext context,
    double screenWidth,
    bool isWide,
    ProductProvider productProvider,
    int cartQuantity,
    int displayQuantity,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 26, 20, 20),
      decoration: BoxDecoration(
        color: MyColor.bg3,
        borderRadius: isWide
            ? BorderRadius.circular(16)
            : const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
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
                  fontSize: screenWidth < 400
                      ? 16
                      : screenWidth <= 1200
                      ? 18
                      : 20,

                  color: MyColor.textgreen,
                ),
              ),
              const Spacer(),
              Consumer<ProductProvider>(
                builder: (context, provider, child) {
                  return InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      provider.toggleFavorite(widget.product);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Icon(
                        widget.product.isFavorite
                            ? MyIcon.favorite
                            : MyIcon.favoriteBorderSimple,
                        size: 25,
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
            style: TextStyle(
              fontSize: screenWidth < 400
                  ? 18
                  : screenWidth <= 1200
                  ? 20
                  : 22,
              // fontSize: screenWidth > 400 ? 20 : 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            widget.product.quantity,
            style: TextStyle(
              fontSize: screenWidth < 400
                  ? 10
                  : screenWidth <= 1200
                  ? 12
                  : 14,
              fontWeight: FontWeight.w500,
              color: MyColor.textGraey,
            ),
          ),
          const SizedBox(height: 6),
          // Row(
          //   children: [
          //     Text(
          //       widget.product.rating.toString(),
          //       style: TextStyle(
          //         fontWeight: FontWeight.w600,
          //         fontSize: screenWidth < 400
          //             ? 10
          //             : screenWidth <= 1200
          //             ? 12
          //             : 14,
          //       ),
          //     ),
          //     const SizedBox(width: 4),
          //     Row(
          //       children: List.generate(5, (index) {
          //         if (index < widget.product.rating.floor()) {
          //           return Icon(
          //             MyIcon.star,
          //             color: MyColor.staryellow,
          //             size: screenWidth < 400
          //                 ? 15
          //                 : screenWidth <= 1200
          //                 ? 17
          //                 : 19,
          //           );
          //         } else if (index < widget.product.rating) {
          //           return Icon(
          //             MyIcon.starHalf,
          //             color: MyColor.staryellow,
          //             size: screenWidth < 400
          //                 ? 15
          //                 : screenWidth <= 1200
          //                 ? 17
          //                 : 19,
          //           );
          //         } else {
          //           return Icon(
          //             MyIcon.starBorder,
          //             color: MyColor.staryellow,
          //             size: screenWidth < 400
          //                 ? 15
          //                 : screenWidth <= 1200
          //                 ? 17
          //                 : 19,
          //           );
          //         }
          //       }),
          //     ),
          //     const SizedBox(width: 4),
          //     Text(
          //       "(${widget.product.reviews} reviews)",
          //       style: TextStyle(
          //         fontSize: screenWidth < 400
          //             ? 10
          //             : screenWidth <= 1200
          //             ? 12
          //             : 14,
          //         fontWeight: FontWeight.w500,
          //         color: MyColor.textGraey,
          //       ),
          //     ),
          //   ],
          // ),
          const SizedBox(height: 16),
          Text(
            widget.product.description,
            maxLines: isWide ? null : (isExpanded ? null : 3),
            overflow: isWide || isExpanded
                ? TextOverflow.visible
                : TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: screenWidth < 400
                  ? 10
                  : screenWidth <= 1200
                  ? 12
                  : 14,
              fontWeight: FontWeight.w400,
              color: MyColor.textGraey,
            ),
          ),
          if (!isWide) ...[
            const SizedBox(height: 4),
            GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Text(
                isExpanded ? "see less" : "see more",
                style: TextStyle(
                  fontSize: screenWidth < 400
                      ? 10
                      : screenWidth <= 1200
                      ? 12
                      : 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ],
          const SizedBox(height: 12),
          Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: MyColor.bg1,
            ),
            child: Row(
              children: [
                const SizedBox(width: 17),
                Text(
                  "Quantity",
                  style: TextStyle(
                    fontSize: screenWidth < 400
                        ? 10
                        : screenWidth <= 1200
                        ? 12
                        : 14,
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
                  iconSize: screenWidth < 400
                      ? 21
                      : screenWidth <= 1200
                      ? 23
                      : 25,
                ),
                VerticalDivider(width: 1, color: MyColor.borderGray),
                SizedBox(
                  width: 50,
                  child: Text(
                    "$displayQuantity",
                    style: TextStyle(
                      fontSize: screenWidth < 400
                          ? 16
                          : screenWidth <= 1200
                          ? 18
                          : 20,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                VerticalDivider(width: 1, color: MyColor.borderGray),
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
                  iconSize: screenWidth < 400
                      ? 21
                      : screenWidth <= 1200
                      ? 23
                      : 25,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              context.read<ProductProvider>().addToCart(
                widget.product,
                quantity,
              );

              ScaffoldMessenger.of(context).hideCurrentSnackBar();

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Center(
                    child: Text(
                      "Product added",
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                  duration: const Duration(seconds: 1),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: MyColor.animationGreen,
                  margin: EdgeInsets.all(isWide ? 20 : 130),
                  dismissDirection: DismissDirection.up,
                ),
              );
            },
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [MyColor.gradientGreen, MyColor.animationGreen],
                ),
                boxShadow: [
                  BoxShadow(
                    color: MyColor.animationGreen.withAlpha(40),
                    blurRadius: 9,
                    spreadRadius: 0,
                    offset: const Offset(0, 10),
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
                        fontSize: screenWidth < 400
                            ? 12
                            : screenWidth <= 1200
                            ? 14
                            : 16,
                        color: MyColor.bg1,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 14,
                    child: Icon(
                      MyIcon.shoppingBag,
                      color: MyColor.bg1,
                      size: screenWidth < 400
                          ? 21
                          : screenWidth <= 1200
                          ? 23
                          : 25,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 13),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    final bool isWide = screenWidth > 800;
    final productProvider = context.watch<ProductProvider>();
    final cartQuantity = productProvider.cartQuantities[widget.product.productId] ?? 0;
    final displayQuantity = cartQuantity > 0 ? cartQuantity : quantity;

    return Scaffold(
      backgroundColor: MyColor.bg1,
      body: SafeArea(
        top: isWide,
        child: Stack(
          children: [
            isWide
                ? Row(
                    children: [
                      Expanded(
                        flex: screenWidth > 1000 ? 6 : 5,
                        child: _buildImageSection(context, isWide, screenWidth),
                      ),
                      Expanded(
                        flex: screenWidth > 1000 ? 4 : 5,
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(24),
                          child: _buildDetailsSection(
                            context,
                            screenWidth,
                            isWide,
                            productProvider,
                            cartQuantity,
                            displayQuantity,
                          ),
                        ),
                      ),
                      screenWidth > 1000
                          ? const Expanded(flex: 1, child: SizedBox())
                          : const SizedBox(width: 0),
                    ],
                  )
                : SingleChildScrollView(
                    child: Flex(
                      direction: Axis.vertical,
                      children: [
                        _buildImageSection(context, isWide, screenWidth),
                        _buildDetailsSection(
                          context,
                          screenWidth,
                          isWide,
                          productProvider,
                          cartQuantity,
                          displayQuantity,
                        ),
                      ],
                    ),
                  ),

            // Pinned Top-Left Back Button for all screen sizes
            Positioned(
              top: isWide ? 16 : 38.h,
              left: isWide ? 20 : 16.w,
              child: IconButton(
                onPressed: () => context.pop(),
                icon: Icon(MyIcon.arrowBack, size: isWide ? 24 : 22),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
