import 'package:flutter/material.dart';
import 'package:grocery_app/screen/profile_page/profile_provider.dart';
import 'package:grocery_app/screen/home_page/home_screen.dart';
import 'package:grocery_app/screen/cart_page/cart_screen.dart';
import 'package:grocery_app/screen/favorite_page/favourite_screen.dart';
import 'package:grocery_app/screen/profile_page/profile_screen.dart';
import 'package:grocery_app/utils/app_icons.dart';
import 'package:grocery_app/screen/profile_page/about_me/user_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/utils/app_colors.dart';
import 'package:grocery_app/data/drawer_data.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.65,
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
                    Consumer<ProfileProvider>(
                      builder: (context, provider, child) {
                        return CircleAvatar(
                          radius: 40.r,
                          backgroundColor: MyColor.textGraey,
                          foregroundColor: MyColor.bg1,
                          backgroundImage: provider.profileImage != null
                              ? FileImage(provider.profileImage!)
                              : const AssetImage("assets/images/profile.png")
                                    as ImageProvider,
                        );
                      },
                    ),

                    SizedBox(height: 10.h),
                    Text(
                      userProvider.name,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      userProvider.email,
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
                        switch (drawer[index].id) {
                          case "home":
                            // Navigator.pushAndRemoveUntil(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => HomeScreen(),
                            //   ),
                            //   (route) => false,
                            // );
                            break;
                          case "profile":
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => ProfilePage(),
                            //   ),
                            // );
                            break;
                          case "like":
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => FavouritePage(),
                            //   ),
                            // );
                            break;
                          case "cart":
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => CartPage(),
                            //   ),
                            // );
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
