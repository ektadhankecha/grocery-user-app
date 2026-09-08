import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_app/screen/main_page/bottom_navigation/bottom_navigation_provider.dart';
import 'package:grocery_app/screen/home_page/featured_product/card/product_provider.dart';
import 'package:grocery_app/utils/app_icons.dart';
import 'package:grocery_app/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/screen/empty_screen_widget.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int openedIndex = -1;

  Widget _buildPaymentSummary(
    BuildContext context,
    ProductProvider productProvider,
    bool isWide,
  ) {
    return Container(
      padding: EdgeInsets.all(isWide ? 24 : 20.r),
      decoration: BoxDecoration(
        color: MyColor.bg1,
        borderRadius: isWide ? BorderRadius.circular(12) : null,
        boxShadow: isWide
            ? [
                BoxShadow(
                  color: Colors.black.withAlpha(10),
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isWide) ...[
            const Text(
              "Order Summary",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Subtotal",
                style: TextStyle(
                  color: MyColor.textGraey,
                  fontSize: isWide ? 13 : 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "\$${productProvider.subTotal.toStringAsFixed(2)}",
                style: TextStyle(
                  color: MyColor.textGraey,
                  fontSize: isWide ? 13 : 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: isWide ? 12 : 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Shipping charges",
                style: TextStyle(
                  color: MyColor.textGraey,
                  fontSize: isWide ? 13 : 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "\$${productProvider.shipping.toStringAsFixed(2)}",
                style: TextStyle(
                  color: MyColor.textGraey,
                  fontSize: isWide ? 13 : 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Divider(height: isWide ? 32 : 30.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total",
                style: TextStyle(
                  fontSize: isWide ? 18 : 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "\$${productProvider.total.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: isWide ? 18 : 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: isWide ? 24 : 17.h),
          GestureDetector(
            onTap: () {
              context.push("/shippingMethod");
            },
            child: SizedBox(
              width: double.infinity,
              height: isWide ? 50 : 55.h,
              child: Container(
                height: isWide ? 50 : 60.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(isWide ? 8 : 5.r),
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      MyColor.gradientGreen,
                      MyColor.animationGreen,
                    ],
                  ),
                ),
                child: Center(
                  child: Text(
                    "Checkout",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: isWide ? 14 : 12,
                      color: MyColor.bg1,
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (!isWide) SizedBox(height: 17.h),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();
    double screenWidth = MediaQuery.of(context).size.width;
    final bool isWide = screenWidth > 800;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: ((didPop, result) {
        if (didPop) return;
        context.read<BottomNavigationProvider>().changeIndex(0);
      }),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              context.read<BottomNavigationProvider>().changeIndex(0);
            },
            icon: const Icon(MyIcon.arrowBack),
          ),
          title: const Text("Shopping Cart"),
        ),
        body: productProvider.cartItems.isEmpty
            ? const EmptyScreenWidget(
                icon: MyIcon.shoppingBag,
                title: "Your cart is empty!",
                description: "Add items to your cart to start shopping!",
              )
            : Flex(
                direction: isWide ? Axis.horizontal : Axis.vertical,
                crossAxisAlignment: isWide
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.stretch,
                children: [
                  // 1. Cart Items List (flex: 5 on wide screens)
                  Expanded(
                    flex: isWide ? 5 : 1,
                    child: Container(
                      color: MyColor.bg3,
                      child: Padding(
                        padding: EdgeInsets.all(isWide ? 20 : 17.r),
                        child: ListView.builder(
                          itemCount: productProvider.cartItems.length,
                          itemBuilder: (context, index) {
                            final item = productProvider.cartItems[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: SizedBox(
                                height: isWide ? 100 : 100.h,
                                child: Stack(
                                  children: [
                                    // 1. Red delete button (behind)
                                    GestureDetector(
                                      onTap: () {
                                        openedIndex = -1;
                                        context
                                            .read<ProductProvider>()
                                            .productRemove(item);
                                      },
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        color: MyColor.dltRed,
                                        child: SizedBox(
                                          width: isWide ? 80 : 80.w,
                                          child: const Icon(
                                            MyIcon.trash,
                                            color: MyColor.bg1,
                                          ),
                                        ),
                                      ),
                                    ),

                                    // 2. Sliding cart item
                                    AnimatedPositioned(
                                      duration: const Duration(
                                        milliseconds: 250,
                                      ),
                                      left: openedIndex == index
                                          ? (isWide ? -80 : -80.w)
                                          : 0,
                                      right: openedIndex == index
                                          ? (isWide ? 80 : 80.w)
                                          : 0,
                                      top: 0,
                                      bottom: 0,
                                      child: GestureDetector(
                                        onHorizontalDragUpdate: (details) {
                                          if (details.delta.dx < -1) {
                                            setState(() {
                                              openedIndex = index;
                                            });
                                          } else if (details.delta.dx > 1) {
                                            setState(() {
                                              openedIndex = -1;
                                            });
                                          }
                                        },
                                        child: Container(
                                          height: isWide ? 100 : 100.h,
                                          width: double.infinity,
                                          color: MyColor.bg1,
                                          child: Row(
                                            children: [
                                              /// Leading
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(11),
                                                child: SizedBox(
                                                  width: isWide ? 70 : 70.w,
                                                  height: isWide ? 100 : 100.h,
                                                  child: Stack(
                                                    alignment:
                                                        Alignment.center,
                                                    clipBehavior:
                                                        Clip.none,
                                                    children: [
                                                      Container(
                                                        height: isWide
                                                            ? 64
                                                            : 64.r,
                                                        width: isWide
                                                            ? 64
                                                            : 64.r,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: item.bgColor,
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                      ),
                                                      Positioned(
                                                        bottom: isWide
                                                            ? -8
                                                            : -8.h,
                                                        top: isWide
                                                            ? 16
                                                            : 16.h,
                                                        child: Image.network(
                                                          item.image,
                                                          width: isWide
                                                            ? 85
                                                            : 85.w,
                                                          height: isWide
                                                            ? 80
                                                            : 80.h,
                                                          fit: BoxFit.contain,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              /// Middle Content
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(11),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        "\$${item.price.toStringAsFixed(2)}",
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 10,
                                                          color: MyColor
                                                              .animationGreen,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: isWide ? 2 : 2.h,
                                                      ),
                                                      Text(
                                                        item.name,
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      Text(
                                                        item.quantity,
                                                        style: const TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              MyColor.textGraey,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              /// Trailing Stepper
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      context
                                                          .read<ProductProvider>()
                                                          .increaseQuantity(
                                                            item,
                                                          );
                                                    },
                                                    child: const Icon(
                                                      MyIcon.add,
                                                      size: 20,
                                                      color: MyColor
                                                          .animationGreen,
                                                    ),
                                                  ),
                                                  Text(
                                                    "${productProvider.cartQuantities[item.id] ?? 1}",
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 12,
                                                      color: MyColor.textGraey,
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      context
                                                          .read<ProductProvider>()
                                                          .decreaseQuantity(
                                                            item,
                                                          );
                                                    },
                                                    child: const Icon(
                                                      MyIcon.remove,
                                                      size: 20,
                                                      color: MyColor
                                                          .animationGreen,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: isWide ? 10 : 10.w,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  isWide
                      ? Expanded(
                          flex: 2,
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(20),
                            child: _buildPaymentSummary(
                              context,
                              productProvider,
                              isWide,
                            ),
                          ),
                        )
                      : _buildPaymentSummary(context, productProvider, isWide),
                ],
              ),
      ),
    );
  }
}
