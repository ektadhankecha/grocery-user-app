import 'package:flutter/material.dart';
import 'package:grocery_app/utils/app_icons.dart';
import 'package:grocery_app/utils/app_colors.dart';
import 'package:grocery_app/data/track_order_data.dart';
import 'package:grocery_app/screen/cart_page/orders_process/teack_order/track_step_widget.dart';
import 'package:grocery_app/screen/main_page/main_screen.dart';

class TrackOrderScreen extends StatelessWidget {
  const TrackOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: ((didPop, result) {
        if (didPop) return;
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const MainScreen()),
          (route) => false,
        );
      }),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: ((context) => MainScreen())),
                (route) => false,
              );
            },
            icon: Icon(MyIcon.arrowBack),
          ),
          title: Text("Track Order"),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(17, 25, 17, 0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(15, 15, 2, 15),
                color: MyColor.bg1,
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
                                      fontFamily: 'poppins',
                                    ),
                                  ),
                                  TextSpan(
                                    text: "10",
                                    style: TextStyle(
                                      fontSize: 8,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'poppins',
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
                                      fontFamily: 'poppins',
                                    ),
                                  ),
                                  TextSpan(
                                    text: "\$16.90",
                                    style: TextStyle(
                                      fontSize: 8,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'poppins',
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
    );
  }
}
