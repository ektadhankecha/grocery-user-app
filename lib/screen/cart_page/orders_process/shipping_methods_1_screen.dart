import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_app/utils/app_icons.dart';
import 'package:grocery_app/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/data/shipping_data.dart';

class ShippingMethods1Screen extends StatefulWidget {
  const ShippingMethods1Screen({super.key});

  @override
  State<ShippingMethods1Screen> createState() => _ShippingMethods1ScreenState();
}

class _ShippingMethods1ScreenState extends State<ShippingMethods1Screen> {
  int? selectedShippingIndex;
  @override
  Widget build(BuildContext context) {
    final bool isWide = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      backgroundColor: MyColor.bg3,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(MyIcon.arrowBack),
        ),
        title: const Text("Shipping Method"),
      ),
      body: Center(
        child: Container(
          width: isWide ? 500 : double.infinity,
       height: double.infinity,
       //   height: isWide ? 560 : double.infinity,
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
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: MyColor.animationGreen,
                      foregroundColor: MyColor.bg1,
                      child: const Text(
                        "1",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                      Expanded(
                        child: Divider(color: MyColor.animationGreen, thickness: 1),
                      ),
                      CircleAvatar(
                        backgroundColor: isWide ? MyColor.bg3 : MyColor.bg1,
                        foregroundColor: MyColor.textGraey,
                        child: Text(
                          "2",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(color: MyColor.dividergrey, thickness: 1),
                      ),
                      CircleAvatar(
                        backgroundColor: isWide ? MyColor.bg3 : MyColor.bg1,
                        foregroundColor: MyColor.textGraey,
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
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: shippingData.length,
                  itemBuilder: (context, index) {
                    //  final item = shippingData[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedShippingIndex = index;
                        });
                      },

                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        margin: EdgeInsets.symmetric(vertical: 5),

                        decoration: BoxDecoration(
                          color: isWide ? MyColor.bg3 : MyColor.bg1,
                          border: Border.all(
                            color: selectedShippingIndex == index
                                ? MyColor.animationGreen
                                : Colors.transparent,
                          ),
                        ),
                        child: ListTile(
                          title: Text(
                            shippingData[index].title,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            shippingData[index].description,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: MyColor.textGraey,
                            ),
                          ),
                          trailing: Text(
                            shippingData[index].amount,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: MyColor.animationGreen,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Spacer(),
                GestureDetector(
                  onTap: selectedShippingIndex == null
                      ? null
                      : () {
                    context.push("/shippingAddress");
                    },
                  child: Container(
                    height: 60.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      gradient: selectedShippingIndex == null
                          ? LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [Colors.grey.shade400, Colors.grey.shade500],
                            )
                          : LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                MyColor.gradientGreen,
                                MyColor.animationGreen,
                              ],
                            ),
                      boxShadow: selectedShippingIndex == null
                          ? [
                              BoxShadow(
                                color: Colors.grey.shade500.withAlpha(40),
                                blurRadius: 9,
                                spreadRadius: 0,
                                offset: const Offset(0, 10),
                              ),
                            ]
                          : [
                              BoxShadow(
                                color: MyColor.animationGreen.withAlpha(40),
                                blurRadius: 9,
                                spreadRadius: 0,
                                offset: const Offset(0, 10),
                              ),
                            ],
                    ),
                    child: Center(
                      child: Text(
                        "Next",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: isWide ? 14 : 12,
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
