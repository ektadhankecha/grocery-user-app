import 'package:flutter/material.dart';
import 'package:grocery_app/screen/main_page/bottom_navigation/bottom_navigation_provider.dart';
import 'package:grocery_app/screen/home_page/featured_product/card/product_provider.dart';
import 'package:grocery_app/screen/cart_page/orders_process/shipping_methods_1_screen.dart';
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
  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();

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
            ? EmptyScreenWidget(
                icon: MyIcon.shoppingBag,
                title: "Your cart is empty!",
                description: "Add items to your cart to start shopping!",
              )
            : Column(
                children: [
                  Expanded(
                    child: Container(
                      color: MyColor.bg3,
                      child: Padding(
                        padding: EdgeInsets.all(17.r),
                        child: ListView.builder(
                          itemCount: productProvider.cartItems.length,
                          itemBuilder: (context, index) {
                            final item = productProvider.cartItems[index];
                            return Padding(
                              padding: EdgeInsets.only(bottom: 12.h),
                              child: SizedBox(
                                height: 100.h,
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
                                          width: 80.w,
                                          child: Icon(
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
                                      left: openedIndex == index ? -80.w : 0,
                                      right: openedIndex == index ? 80.w : 0,
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
                                          height: 100.h,
                                          width: double.infinity,
                                          color: MyColor.bg1,
                                          child: Row(
                                            children: [
                                              ///leading
                                              Padding(
                                                padding: EdgeInsets.all(11.r),
                                                child: SizedBox(
                                                  width: 70.w,
                                                  height: 100.h,
                                                  child: Stack(
                                                    alignment: Alignment.center,
                                                    clipBehavior: Clip.none,
                                                    children: [
                                                      Container(
                                                        height: 64.r,
                                                        width: 64.r,
                                                        decoration:
                                                            BoxDecoration(
                                                              color:
                                                                  item.bgColor,
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                      ),
                                                      Positioned(
                                                        bottom: -8.h,
                                                        top: 16.h,
                                                        child: Image.asset(
                                                          item.image,
                                                          width: 85.w,
                                                          height: 80.h,
                                                          fit: BoxFit.contain,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              ///middle content
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsets.all(11.r),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "\$${item.price.toStringAsFixed(2)}",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 10,
                                                          color: MyColor
                                                              .animationGreen,
                                                        ),
                                                      ),
                                                      SizedBox(height: 2.h),
                                                      Text(
                                                        item.name,
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      Text(
                                                        item.quantity,
                                                        style: TextStyle(
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

                                              ///trailing
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      context
                                                          .read<
                                                            ProductProvider
                                                          >()
                                                          .increaseQuantity(
                                                            item,
                                                          );
                                                    },
                                                    child: Icon(
                                                      MyIcon.add,
                                                      size: 20.sp,
                                                      color: MyColor
                                                          .animationGreen,
                                                    ),
                                                  ),
                                                  Text(
                                                    "${productProvider.cartQuantities[item.id] ?? 1}",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 12,
                                                      color: MyColor.textGraey,
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      context
                                                          .read<
                                                            ProductProvider
                                                          >()
                                                          .decreaseQuantity(
                                                            item,
                                                          );
                                                    },
                                                    child: Icon(
                                                      MyIcon.remove,
                                                      size: 20.sp,
                                                      color: MyColor
                                                          .animationGreen,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(width: 10.w),
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
                  Container(
                    padding: EdgeInsets.all(20.r),
                    color: MyColor.bg1,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Subtotal",
                              style: TextStyle(
                                color: MyColor.textGraey,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "\$${productProvider.subTotal}",
                              style: TextStyle(
                                color: MyColor.textGraey,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Shipping charges",
                              style: TextStyle(
                                color: MyColor.textGraey,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "\$${productProvider.shipping}",
                              style: TextStyle(
                                color: MyColor.textGraey,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Divider(height: 30.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "\$${productProvider.total}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 17.h),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ShippingMethods1Screen(),
                              ),
                            );
                          },
                          child: SizedBox(
                            width: double.infinity,
                            height: 55.h,
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
                              ),
                              child: Center(
                                child: Text(
                                  "Checkout",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    color: MyColor.bg1,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 17.h),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
