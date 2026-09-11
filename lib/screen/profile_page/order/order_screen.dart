import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_app/screen/empty_screen_widget.dart';
import 'package:grocery_app/utils/app_icons.dart';
import 'package:grocery_app/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:grocery_app/screen/cart_page/orders_process/order_provider.dart';
import 'package:intl/intl.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool isExpanded = false;
  Widget buildTimeline({
    required String title,
    required String date,
    required bool completed,
  }) {
    return Container(
      color: MyColor.bg1,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        child: Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: completed
                    ? MyColor.animationGreen
                    : Colors.grey.shade300,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                  color: completed ? Colors.black : Colors.grey,
                ),
              ),
            ),

            Text(
              date,
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w400,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isWide = MediaQuery.of(context).size.width > 600;
    final orderProvider = context.watch<OrderProvider>();

    return Scaffold(
      backgroundColor: MyColor.bg3,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(MyIcon.arrowBack),
        ),
        title: const Text("My Order"),
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
          child: orderProvider.orderList.isEmpty
              ? EmptyScreenWidget(
                  icon: MyIcon.shoppingBag,
                  title: "No Orders Yet",
                  description: "You haven't placed any orders yet.",
                )
              : ListView.builder(
                itemCount: orderProvider.orderList.length,
                itemBuilder: (context, index) {
                  final order = orderProvider.orderList[index];
                  final item = order.items.first;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      color: isWide ? MyColor.bg3 : MyColor.bg1,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              children: [
                                Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: 33,
                                      backgroundColor: Color(item.bgColor),
                                      child: Image.network(
                                        item.productImage,
                                        width: 70,
                                        height: 70,
                                      ),
                                    ),
                                    // Show badge only if there is more than 1 item in the order
                                    if (order.items.length > 1)
                                      Positioned(
                                        right: 0,
                                        bottom: 0,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 5,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: MyColor.animationGreen,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: Text(
                                            "+${order.items.length - 1}",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 8,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Order #${order.orderNumber}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      "Placed on ${order.orderDate}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 8,
                                        color: MyColor.textGraey,
                                      ),
                                    ),
                                    SizedBox(height: 3),
                                    Row(
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "Items: ",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              TextSpan(
                                                text: order.totalItems
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "Total Amount: ",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              TextSpan(
                                                text: order.totalPrice
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
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
    );
  }
}
