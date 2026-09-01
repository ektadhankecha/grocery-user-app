import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_app/screen/profile_page/address/address_provider.dart';
import 'package:grocery_app/utils/app_icons.dart';
import 'package:grocery_app/screen/profile_page/address/address_screen.dart';
import 'package:grocery_app/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/screen/empty_screen_widget.dart';
import 'package:provider/provider.dart';
import 'package:grocery_app/screen/profile_page/address/address_widget.dart';

class MyAddressScreen extends StatefulWidget {
  const MyAddressScreen({super.key});

  @override
  State<MyAddressScreen> createState() => _MyAddressScreenState();
}

class _MyAddressScreenState extends State<MyAddressScreen> {
  @override
  Widget build(BuildContext context) {
    final addressProvider = context.watch<AddressProvider>();
    return Scaffold(
      backgroundColor: MyColor.bg3,
      appBar: AppBar(
        toolbarHeight: 81.h,
        backgroundColor: MyColor.bg1,
        leading: IconButton(
          onPressed: () {
            context.pop();
            //Navigator.pop(context);
          },
          icon: Icon(MyIcon.arrowBack, size: 22.sp),
        ),
        centerTitle: true,
        title: Text(
          "My Address",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      body: addressProvider.addresses.isEmpty
          ? EmptyScreenWidget(
              icon: MyIcon.noAddress,
              title: "No saved addresses",
              description:
                  "You haven't added any delivery address yet. Add an address to make checkout faster.",
              buttonText: "Add Address",
              onButtonPressed: () {
                context.push("/address");
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => AddressScreen()),
                // );
              },
            )
          : Padding(
              padding: const EdgeInsets.fromLTRB(17, 20, 17, 20),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: addressProvider.addresses.length,
                        itemBuilder: (context, index) {
                          final address = addressProvider.addresses[index];
                          return Container(
                            margin: EdgeInsets.only(bottom: 5),
                            decoration: BoxDecoration(
                              color: MyColor.bg1,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: AddressWidget(address: address),
                          );
                        },
                      ),
                    ),
                  ),

                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      context.push("/address");
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => AddressScreen(),
                      //   ),
                      // );
                    },

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
                        boxShadow: [
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
                          "Add address",
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
