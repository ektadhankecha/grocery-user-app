import 'package:flutter/material.dart';
import 'package:grocery_app/model/order_model.dart';
import 'package:grocery_app/utils/app_colors.dart';
import 'package:grocery_app/utils/app_icons.dart';


class OrderWidget extends StatefulWidget {
  final OrderModel order;

  const OrderWidget({super.key, required this.order});

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  bool isExpanded = false;

  // Stages of order
  final List<String> orderStages = [
    "Order placed",
    // "Order confirmed",
    "Order shipped",
    "Out for delivery",
    "Order delivered",
  ];

  // Helper to calculate stage index from Firebase order status
  int getStageIndex(String status) {
    switch (status.toLowerCase()) {
      case "placed":
      case "pending" :
      case "order placed":
        return 0;
      // case "confirmed":
      // case "order confirmed":
      //   return 1;
      case "shipped":
      case "processing" :
      case "order shipped":
        return 1;
      case "out for delivery":
      case "out of delivery" :
      case "out_for_delivery":
        return 2;
      case "delivered":
        case "order delivered":
        return 3;
      default:
        return 0;
    }
  }

  Widget buildTimeline({
    required String title,
    required String date,
    required bool completed,
    required bool isLast,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Step dot & vertical connecting line
          Column(
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
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: completed
                        ? MyColor.animationGreen
                        : Colors.grey.shade300,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          // Title
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                  color: completed ? Colors.black : Colors.grey,
                ),
              ),
            ),
          ),
          // Date / Status
          Text(
            date,
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w400,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isWide = MediaQuery.of(context).size.width > 600;
    final item = widget.order.items.first;
    final int currentStage = getStageIndex(widget.order.status);

    return Container(
      color: isWide ? MyColor.bg3 : MyColor.bg1,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                // Order Image + Badge
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
                    if (widget.order.items.length > 1)
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                          decoration: BoxDecoration(
                            color: MyColor.animationGreen,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "+${widget.order.items.length - 1}",
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
                const SizedBox(width: 10),

                // Order Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Order #${widget.order.orderNumber}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "Placed on ${widget.order.orderDate}",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 8,
                          color: MyColor.textGraey,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: "Items: ",
                                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: Colors.black),
                                ),
                                TextSpan(
                                  text: widget.order.totalItems.toString(),
                                  style: const TextStyle(fontSize: 10, color: Colors.black, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: "Total Amount: ",
                                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: Colors.black),
                                ),
                                TextSpan(
                                  text: "\$${widget.order.totalPrice.toStringAsFixed(2)}",
                                  style: const TextStyle(fontSize: 10, color: Colors.black, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Arrow Button (exact same icon from CardWidget)
                IconButton(
                  onPressed: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  icon: Icon(
                    isExpanded
                        ? MyIcon.arrowUpDownCircle
                        : MyIcon.arrowDropDownCircle,
                    color: MyColor.animationGreen,
                  ),
                ),
              ],
            ),
          ),

          // Expanded Process Section
          if (isExpanded) ...[
            Divider(height: 0, thickness: 2, color: isWide ? MyColor.bg1 : MyColor.bg3),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: isWide ? MyColor.bg3 : MyColor.bg1,
              child: Column(
                children: List.generate(orderStages.length, (index) {
                  final bool isCompleted = index <= currentStage;
                  final String dateText = isCompleted ? widget.order.orderDate : "pending";

                  return buildTimeline(
                    title: orderStages[index],
                    date: dateText,
                    completed: isCompleted,
                    isLast: index == orderStages.length - 1,
                  );
                }),
              ),
            ),
          ],
        ],
      ),
    );
  }
}