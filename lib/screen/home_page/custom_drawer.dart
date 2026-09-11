import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grocery_app/auth/auth_provider.dart';
import 'package:grocery_app/screen/main_page/bottom_navigation/bottom_navigation_provider.dart';
import 'package:grocery_app/utils/app_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/utils/app_colors.dart';
import 'package:grocery_app/data/drawer_data.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isWide = MediaQuery.of(context).size.width > 600;
    final authProvider = context.watch<AuthhProvider>();
    return Drawer(
      //   width: MediaQuery.of(context).size.width * 0.65,
      width: isWide ? 400 : MediaQuery.of(context).size.width * 0.65,
      backgroundColor: MyColor.searchGraey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(35),
          bottomRight: Radius.circular(35),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.20,
              width: double.infinity,

              child: Padding(
                padding: const EdgeInsets.only(left: 28),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    Consumer<AuthhProvider>(
                      builder: (context, provider, child) {
                        return CircleAvatar(
                          radius: 40.r,
                          backgroundColor: MyColor.textGraey,
                          foregroundColor: MyColor.bg1,
                          // backgroundImage: provider.profileImage != null
                          //     ? FileImage(provider.profileImage!)
                          backgroundImage:
                          authProvider.userImage != null &&
                              authProvider.userImage!.isNotEmpty
                              ? MemoryImage(
                            base64Decode(authProvider.userImage!),
                          )
                              : const AssetImage("assets/images/profile.png")
                                    as ImageProvider,
                        );
                      },
                    ),

                    SizedBox(height: 10.h),
                    Text(
                      authProvider.userName ?? '',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      authProvider.userEmail ?? '',
                      style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w300,
                        color: MyColor.textGraey,
                      ),
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
            ),
            const Divider(indent: 25, endIndent: 25, thickness: 2),
            Expanded(
              child: ListView.builder(
                itemCount: drawer.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 11),
                    child: ListTile(
                      title: Text(
                        drawer[index].name,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                        ),
                      ),
                      leading: Icon(drawer[index].icon),
                      onTap: () {
                        Scaffold.of(context).closeDrawer();
                        switch (drawer[index].id) {
                          case "home":
                            context
                                .read<BottomNavigationProvider>()
                                .changeIndex(0);
                            break;
                          case "profile":
                            context
                                .read<BottomNavigationProvider>()
                                .changeIndex(3);
                            break;
                          case "like":
                            context
                                .read<BottomNavigationProvider>()
                                .changeIndex(1);
                            break;
                          case "cart":
                            context
                                .read<BottomNavigationProvider>()
                                .changeIndex(2);
                            break;
                        }
                      },
                    ),
                  );
                },
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.10,
              child: Padding(
                padding: const EdgeInsets.only(left: 11),
                child: Row(
                  children: [
                    SizedBox(width: 8),
                    IconButton(onPressed: () {}, icon: Icon(MyIcon.settings)),
                    Text(
                      "Setting",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
