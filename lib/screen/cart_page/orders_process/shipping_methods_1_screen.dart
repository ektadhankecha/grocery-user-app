import 'package:flutter/material.dart';
import 'package:grocery_app/screen/cart_page/orders_process/shipping_address_screen.dart';
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(MyIcon.arrowBack),
        ),
        title: Text("Shipping Method"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(17, 20, 17, 25),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: MyColor.animationGreen,
                    foregroundColor: MyColor.bg1,
                    child: Text(
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
                    backgroundColor: MyColor.bg1,
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
                    backgroundColor: MyColor.bg1,
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
                      color: MyColor.bg1,
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShippingAddressScreen(),
                        ),
                      );
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
                            offset: Offset(0, 10),
                          ),
                        ]
                      : [
                          BoxShadow(
                            color: MyColor.animationGreen.withAlpha(40),
                            blurRadius: 9,
                            spreadRadius: 0,
                            offset: Offset(0, 10),
                          ),
                        ],
                ),
                child: Center(
                  child: Text(
                    "Next",
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
    );
  }
}
