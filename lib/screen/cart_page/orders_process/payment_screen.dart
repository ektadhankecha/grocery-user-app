import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_app/model/order_item_model.dart';
import 'package:grocery_app/model/order_model.dart';
import 'package:grocery_app/model/transactions_model.dart';
import 'package:grocery_app/auth/auth_provider.dart';
import 'package:grocery_app/screen/profile_page/address/address_provider.dart';
import 'package:grocery_app/screen/profile_page/card/card_provider.dart';
import 'package:grocery_app/screen/cart_page/orders_process/order_provider.dart';
import 'package:grocery_app/screen/home_page/featured_product/card/product_provider.dart';
import 'package:grocery_app/screen/profile_page/transaction/transaction_provider.dart';
import 'package:grocery_app/screen/cart_page/orders_process/order_sucess_screen.dart';
import 'package:grocery_app/utils/app_icons.dart';
import 'package:grocery_app/utils/app_colors.dart';
import 'package:grocery_app/screen/profile_page/card/card_widget.dart';
import 'package:grocery_app/screen/empty_screen_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../profile_page/card/add_card_screen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int? selectedIndex;
  @override
  Widget build(BuildContext context) {
    final bool isWide = MediaQuery.of(context).size.width > 600;
    final cardProvider = context.watch<CardProvider>();
    final productProvider = context.read<ProductProvider>();
    final orderProvider = context.read<OrderProvider>();
    final transactionProvider = context.read<TransactionProvider>();
    final bool canPay = cardProvider.cards.isNotEmpty && selectedIndex != null;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
            },
          icon: Icon(MyIcon.arrowBack),
        ),
        title: Text("Payment Method"),
      ),
      body: Center(
        child: Container(
          width: isWide ? 500 : double.infinity,
          margin: isWide
              ? const EdgeInsets.symmetric(vertical: 24, horizontal: 16)
              : EdgeInsets.zero,
          padding: EdgeInsets.fromLTRB(17, 20, 17, isWide ? 20 : 25),
          decoration: isWide
              ? BoxDecoration(
            color: MyColor.bg1,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(12),
                blurRadius: 16,
                spreadRadius: 2,
                offset: Offset(0, 4),
              ),
            ],
          )
              : null,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: MyColor.animationGreen,
                      foregroundColor: MyColor.bg1,
                      child: Icon(MyIcon.check),
                    ),
                    Expanded(
                      child: Divider(color: MyColor.animationGreen, thickness: 1),
                    ),
                    CircleAvatar(
                      backgroundColor: MyColor.animationGreen,
                      foregroundColor: MyColor.bg1,
                      child: Icon(MyIcon.check),
                    ),
                    Expanded(
                      child: Divider(color: MyColor.animationGreen, thickness: 1),
                    ),
                    CircleAvatar(
                      backgroundColor: MyColor.animationGreen,
                      foregroundColor: MyColor.bg1,
                      child: Text(
                        "3",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "DELIVERY",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 9,
                        color: MyColor.textGraey,
                      ),
                    ),
                    Text(
                      "ADDRESS",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 9,
                        color: MyColor.textGraey,
                      ),
                    ),
                    Text(
                      "PAYMENT",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 9,
                        color: MyColor.textGraey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              cardProvider.cards.isEmpty
                  ? Expanded(
                      child: EmptyScreenWidget(
                        icon: MyIcon.noCard,
                        title: "No saved payment methods",
                        description:
                            "You haven't added a payment card yet. Add a card for faster checkout.",
                        buttonText: "Add Card",
                        onButtonPressed: () {
                          context.push("/addCard");

                        },
                      ),
                    )
                  : Expanded(
                      child: SingleChildScrollView(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: cardProvider.cards.length,
                          itemBuilder: (context, index) {
                            final card = cardProvider.cards[index];
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color:  isWide ? MyColor.bg3 : MyColor.bg1,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: selectedIndex == index
                                        ? MyColor.animationGreen
                                        : Colors.transparent,
                                  ),
                                ),
                                child: CardWidget(card: card),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

              GestureDetector(
                onTap: canPay
                    ? () async {
                  try {
                    final authProvider = context.read<AuthhProvider>().user;
                    final selectedAddress = context.read<AddressProvider>().selectedAddress;
                    if (selectedAddress == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please select an address first")),
                      );
                      return;
                    }
                    List<OrderItemModel> orderItems = productProvider.cartItems.map((product) {
                      return OrderItemModel(
                        productId: product.id,
                        productName: product.name,
                        productImage: product.image,
                        bgColor: product.bgColor.toARGB32(), // or product.bgColor.value for older Flutter
                        price: product.price,
                        quantity: productProvider.cartQuantities[product.id] ?? 1,
                      );
                    }).toList();
                    int totalItems = orderItems.fold(
                      0,
                          (sum, item) => sum + item.quantity,
                    );
                    String orderNum = await orderProvider.generateOrderNumber();
                    double totalPrice = productProvider.total;
                    OrderModel order = OrderModel(
                      userId: FirebaseAuth.instance.currentUser?.uid,
                      orderNumber: orderNum,
                      items: orderItems,
                      totalItems: totalItems,
                      totalPrice: totalPrice,
                      orderDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
                      status: "Pending",
                      paymentMethod: "Cash On delivery",
                      user: authProvider,
                      address: selectedAddress,
                    );
                    await orderProvider.addOrder(order);
                    double totalAmount = productProvider.total;
                    TransactionsModel transaction = TransactionsModel(
                      title: "MasterCard",
                      transactionDate: DateTime.now(),
                      amount: totalAmount,
                    );
                    await transactionProvider.addTransaction(transaction);
                    productProvider.clearCart();
                    if (mounted) {
                      context.push("/orderSuccess");
                    }
                  } catch (e) {
                    debugPrint("Payment error: $e");
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Error placing order: $e")),
                      );
                    }
                  }
                }
                //     () async {
                //
                // final authProvider = context.read<AuthhProvider>().user ;
                //   final selectedAddress = context.read<AddressProvider>().selectedAddress;
                //         List<OrderItemModel> orderItems = productProvider
                //             .cartItems
                //             .map((product) {
                //               return OrderItemModel(
                //                 productId: product.id,
                //                 productName: product.name,
                //                 productImage: product.image,
                //                 bgColor: product.bgColor.toARGB32(),
                //                 price: product.price,
                //                 quantity:
                //                     productProvider.cartQuantities[product.id] ??
                //                     1,
                //               );
                //             })
                //             .toList();
                //
                //         int totalItems = orderItems.fold(
                //           0,
                //           (sum, item) => sum + item.quantity,
                //         );
                //         String orderNum = await orderProvider
                //             .generateOrderNumber();
                //         double totalPrice = productProvider.total;
                //         OrderModel order = OrderModel(
                //           orderNumber: orderNum,
                //           items: orderItems,
                //           totalItems: totalItems,
                //           totalPrice: totalPrice,
                //           orderDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
                //           status: "Pending",
                //           paymentMethod: "Cash On delivery",
                //           user: authProvider,
                //           address:selectedAddress!,
                //         );
                //         await orderProvider.addOrder(order);
                //
                //         double totalAmount = productProvider.total;
                //         TransactionsModel transaction = TransactionsModel(
                //           title: "MasterCard",
                //           transactionDate: DateTime.now(),
                //           amount: totalAmount,
                //         );
                //         await transactionProvider.addTransaction(transaction);
                //         productProvider.clearCart();
                //         context.push("/orderSuccess");
                //         // Navigator.push(
                //         //   context,
                //         //   MaterialPageRoute(
                //         //     builder: (context) => OrderSucessScreen(),
                //         //   ),
                //         // );
                //       }
                    : null,
                child: Container(
                  height: 60.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),
                    gradient: canPay
                        ? LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              MyColor.gradientGreen,
                              MyColor.animationGreen,
                            ],
                          )
                        : LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Colors.grey.shade400, Colors.grey.shade500],
                          ),
                    boxShadow: canPay
                        ? [
                            BoxShadow(
                              color: MyColor.animationGreen.withAlpha(40),
                              blurRadius: 9,
                              spreadRadius: 0,
                              offset: Offset(0, 10),
                            ),
                          ]
                        : [
                            BoxShadow(
                              color: Colors.grey.shade500.withAlpha(40),
                              blurRadius: 9,
                              spreadRadius: 0,
                              offset: Offset(0, 10),
                            ),
                          ],
                  ),
                  child: Center(
                    child: Text(
                      "Make a Payment",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: MyColor.bg1,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
