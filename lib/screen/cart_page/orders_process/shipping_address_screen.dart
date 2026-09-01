import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_app/screen/profile_page/address/address_provider.dart';
import 'package:grocery_app/screen/cart_page/orders_process/payment_screen.dart';
import 'package:grocery_app/utils/app_colors.dart';
import 'package:grocery_app/utils/app_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/screen/empty_screen_widget.dart';
import 'package:provider/provider.dart';
import 'package:grocery_app/screen/profile_page/address/address_widget.dart';
import 'package:grocery_app/screen/profile_page/address/address_screen.dart';

class ShippingAddressScreen extends StatefulWidget {
  const ShippingAddressScreen({super.key});

  @override
  State<ShippingAddressScreen> createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {
  int? selectedIndex;
  @override
  @override
  Widget build(BuildContext context) {
    final addressProvider = context.watch<AddressProvider>();
    final bool canSelect =
        addressProvider.addresses.isNotEmpty && selectedIndex != null;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            //Navigator.pop(context);
          },
          icon: Icon(MyIcon.arrowBack),
        ),
        title: Text("Shipping Address"),
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
                    child: Icon(MyIcon.check),
                  ),
                  Expanded(
                    child: Divider(color: MyColor.animationGreen, thickness: 1),
                  ),
                  CircleAvatar(
                    backgroundColor: MyColor.animationGreen,
                    foregroundColor: MyColor.bg1,
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
            addressProvider.addresses.isEmpty
                ? Expanded(
                    child: EmptyScreenWidget(
                      icon: MyIcon.noAddress,
                      title: "No saved addresses",
                      description:
                          "You haven't added any delivery address yet. Add an address to make checkout faster.",
                      buttonText: "Add Address",
                      onButtonPressed: () {
                        context.push("/address");
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => AddressScreen(),
                        //   ),
                        // );
                      },
                    ),
                  )
                : Expanded(
                    child: SingleChildScrollView(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: addressProvider.addresses.length,
                        itemBuilder: (context, index) {
                          final address = addressProvider.addresses[index];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 5),
                              decoration: BoxDecoration(
                                color: MyColor.bg1,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: selectedIndex == index
                                      ? MyColor.animationGreen
                                      : Colors.transparent,
                                ),
                              ),
                              child: AddressWidget(address: address),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

            GestureDetector(
              onTap: canSelect
                  ? () {
                   context.push("/payment");
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => PaymentScreen(),
                      //   ),
                      // );
                    }
                  : null,
              child: Container(
                height: 60.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  gradient: canSelect
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
                  boxShadow: canSelect
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
