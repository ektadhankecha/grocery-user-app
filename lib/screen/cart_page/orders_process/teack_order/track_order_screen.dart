import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_app/utils/app_icons.dart';
import 'package:grocery_app/utils/app_colors.dart';
import 'package:grocery_app/data/track_order_data.dart';
import 'package:grocery_app/screen/cart_page/orders_process/teack_order/track_step_widget.dart';
import 'package:grocery_app/screen/main_page/main_screen.dart';

class TrackOrderScreen extends StatelessWidget {
  const TrackOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isWide = MediaQuery.of(context).size.width > 600;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: ((didPop, result) {
        if (didPop) return;
        context.go("/main");
      }),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              context.go("/main");
              },
            icon: Icon(MyIcon.arrowBack),
          ),
          title: Text("Track Order"),
        ),
        body: Center(
          child: Container(
            width: isWide ? 500 : double.infinity,
            height: double.infinity,
            // height: isWide ? 560 : double.infinity,
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
                  offset: const Offset(0, 4),
                ),
              ],
            )
                : null,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 15, 2, 15),
                  color:  isWide ? MyColor.bg3 : MyColor.bg1,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 33,
                        backgroundColor: MyColor.locationgreen,
                        foregroundColor: MyColor.animationGreen,
                        child: Icon(MyIcon.box, size: 33),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Order #90897 ",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            "Placed on October 19 2021",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 8,
                              color: MyColor.textGraey,
                            ),
                          ),
                          SizedBox(height: 6),
                          Row(
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Items: ",
                                      style: TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "10",
                                      style: TextStyle(
                                        fontSize: 8,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 15),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Items: ",
                                      style: TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "\$16.90",
                                      style: TextStyle(
                                        fontSize: 8,
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
                SizedBox(height: 25),
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 20, 0, 20),
                  color: MyColor.bg1,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: trackOrderList.length,
                    itemBuilder: (context, index) {
                      final track = trackOrderList[index];

                      return TrackStep(
                        icon: track.icon,
                        title: track.title,
                        date: track.date,
                        isCompleted: track.isCompleted,
                        isLast: index == trackOrderList.length - 1,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
