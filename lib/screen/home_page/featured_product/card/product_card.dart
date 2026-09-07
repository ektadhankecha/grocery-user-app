import 'package:flutter/material.dart';
import 'package:grocery_app/screen/home_page/featured_product/card/product_provider.dart';
import 'package:grocery_app/utils/app_icons.dart';
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
      decoration: BoxDecoration(
        color: MyColor.bg1,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// Favourite Icon
                Align(
                  alignment: Alignment.topRight,
                  child: Consumer<ProductProvider>(
                    builder: (context, provider, child) {
                      return InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          provider.toggleFavorite(widget.product);
                        },
                        child: Icon(
                          widget.product.isFavorite
                              ? MyIcon.favorite
                              : MyIcon.favoriteBorderSimple,
                          size: 22,
                          color: widget.product.isFavorite
                              ? MyColor.faviourtred
                              : MyColor.textGraey,
                        ),
                      );
                    },
                  ),
                ),

                /// Product Image
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final availableHeight = constraints.maxHeight;
                          final availableWidth = constraints.maxWidth;
                          final baseSize = (availableHeight * 0.70).clamp(50.0, availableWidth * 0.62);

                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: baseSize,
                                width: baseSize,
                                decoration: BoxDecoration(
                                  color: widget.product.bgColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Image.asset(
                                widget.product.image,
                                height: baseSize * 1.05,
                                width: baseSize * 1.35,
                                fit: BoxFit.contain,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 4),

                /// Price
                Text(
                  "\$${widget.product.price.toStringAsFixed(2)}",
                  style: const TextStyle(
                    color: MyColor.animationGreen,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 2),

                /// Product Name
                Text(
                  widget.product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 1),

                /// Quantity
                Text(
                  widget.product.quantity,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: MyColor.textGraey,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 6),

                const Divider(height: 1, color: MyColor.dividerLine),

                /// Add to Cart
                GestureDetector(
                  onTap: () {
                    context.read<ProductProvider>().addToCart(
                      widget.product,
                      quantity,
                    );

                    ScaffoldMessenger.of(context).hideCurrentSnackBar();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Center(
                          child: Text(
                            "Product added",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        duration: Duration(seconds: 1),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: MyColor.animationGreen,
                        margin: EdgeInsets.symmetric(
                          horizontal: 100,
                          vertical: 40,
                        ),
                        dismissDirection: DismissDirection.up,
                      ),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          MyIcon.shoppingBag,
                          size: 15,
                          color: MyColor.animationGreen,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "Add to cart",
                          style: TextStyle(
                            fontSize: 11,
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

          /// Badge
          if (widget.product.badge != null)
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: 38,
                height: 18,
                decoration: BoxDecoration(
                  color: getBadgeColor(widget.product.badge!),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                  ),
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
