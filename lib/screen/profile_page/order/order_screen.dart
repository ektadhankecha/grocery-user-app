import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_app/screen/empty_screen_widget.dart';
import 'package:grocery_app/screen/profile_page/order/order_widget.dart';
import 'package:grocery_app/utils/app_icons.dart';
import 'package:grocery_app/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:grocery_app/screen/cart_page/orders_process/order_provider.dart';

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
                    child: OrderWidget(order: order),
                  );
                },
              ),
        ),
      ),
    );
  }
}
