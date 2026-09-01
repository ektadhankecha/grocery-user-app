import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_app/screen/profile_page/about_me/user_provider.dart';
import 'package:grocery_app/screen/profile_page/card/my_cards_screen.dart';
import 'package:grocery_app/screen/profile_page/notification/notification_screen.dart';
import 'package:grocery_app/screen/profile_page/order/order_screen.dart';
import 'package:grocery_app/screen/profile_page/transaction/transactions_screen.dart';
import 'package:grocery_app/utils/app_icons.dart';
import 'package:grocery_app/screen/profile_page/about_me/about_me_screen.dart';
import 'package:grocery_app/screen/profile_page/address/my_address_screen.dart';
import 'package:grocery_app/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/data/profile_data.dart';
import 'package:grocery_app/screen/favorite_page/favourite_screen.dart';
import 'package:grocery_app/auth/auth_page.dart';
import 'package:grocery_app/screen/main_page/bottom_navigation/bottom_navigation_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:grocery_app/screen/profile_page/profile_provider.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatelessWidget {
  final VoidCallback? onBack;
  const ProfilePage({super.key, this.onBack});

  void showProfilePictureSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      builder: (sheetContext) {
        return Container(
          padding: const EdgeInsets.only(top: 12, bottom: 25),
          decoration: const BoxDecoration(
            color: MyColor.bg3,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Small drag indicator
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: MyColor.textgreen,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              const SizedBox(height: 20),

              // Title row
              Row(
                children: [
                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      context.pop();
                      //Navigator.pop(context);
                    },
                    child: const Icon(Icons.close, color: Colors.black),
                  ),

                  const Expanded(
                    child: Center(
                      child: Text(
                        "Profile Picture",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'poppins',
                        ),
                      ),
                    ),
                  ),

                  // Keeps title centered
                  const SizedBox(width: 40),
                ],
              ),

              const SizedBox(height: 25),

              // Camera
              ListTile(
                leading: CircleAvatar(
                  radius: 35,
                  backgroundColor: MyColor.vegiGreen,
                  foregroundColor: MyColor.animationGreen,
                  child: Icon(Icons.camera_alt_outlined, size: 30),
                ),

                title: const Text(
                  "Camera",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    fontFamily: 'poppins',
                  ),
                ),
                subtitle: Text(
                  "Take a new photo",
                  style: TextStyle(
                    fontFamily: 'poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: MyColor.textGraey,
                  ),
                ),
                trailing: Icon(
                  MyIcon.arrowForward,
                  color: MyColor.textGraey,
                  size: 20,
                ),
                onTap: () {
                  Navigator.pop(sheetContext);

                  context.read<ProfileProvider>().pickProfileImage(
                    ImageSource.camera,
                  );
                },
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 8,
                ),
                child: Divider(
                  thickness: 2,
                  height: 1,
                  color: MyColor.dividergrey,
                ),
              ),

              // Gallery
              ListTile(
                leading: CircleAvatar(
                  radius: 35,

                  backgroundColor: MyColor.vegiGreen,
                  foregroundColor: MyColor.animationGreen,
                  child: Icon(Icons.image_outlined, size: 30),
                ),

                title: const Text(
                  "Gallery",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    fontFamily: 'poppins',
                  ),
                ),
                subtitle: Text(
                  "Choose from gallery",
                  style: TextStyle(
                    fontFamily: 'poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: MyColor.textGraey,
                  ),
                ),
                trailing: Icon(
                  MyIcon.arrowForward,
                  color: MyColor.textGraey,
                  size: 20,
                ),
                onTap: () {
                  Navigator.pop(sheetContext);

                  context.read<ProfileProvider>().pickProfileImage(
                    ImageSource.gallery,
                  );
                },
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: ((didPop, result) {
        if (didPop) return;
        context.read<BottomNavigationProvider>().changeIndex(0);
      }),
      child: Scaffold(
        body: Stack(
          children: [
            Container(height: double.infinity, color: MyColor.bg3),
            Container(height: 145.h, color: MyColor.bg1),
            Positioned(
              top: 70.h,
              left: 110.w,
              right: 110.w,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Consumer<ProfileProvider>(
                    builder: (context, provider, child) {
                      return CircleAvatar(
                        backgroundImage: provider.profileImage != null
                            ? FileImage(provider.profileImage!)
                            : const AssetImage("assets/images/profile.png")
                                  as ImageProvider,

                        radius: 60,
                      );
                    },
                  ),

                  Text(
                    userProvider.name,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    userProvider.email,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: MyColor.textGraey,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 162.h,
              left: 232.w,
              child: GestureDetector(
                onTap: () {
                  showProfilePictureSheet(context);
                },
                child: CircleAvatar(
                  backgroundColor: MyColor.textgreen,
                  radius: 15,
                  child: Icon(MyIcon.camera, color: MyColor.bg1, size: 18),
                ),
              ),
            ),
            Positioned(
              top: 220.h,
              left: 0,
              right: 0,
              bottom: 0,
              child: ListView.builder(
                itemCount: profileData.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(
                      profileData[index].icon,
                      color: MyColor.textgreen,
                    ),
                    title: Text(
                      profileData[index].title,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                      ),
                    ),
                    trailing: index == profileData.length - 1
                        ? null
                        : Icon(
                            MyIcon.arrowForward,
                            color: MyColor.textGraey,
                            size: 20,
                          ),
                    onTap: () async {
                      switch (profileData[index].id) {
                        case "logout":
                          SharedPreferences pref =
                              await SharedPreferences.getInstance();
                          await pref.setBool("LoginSuccess", false);
                         context.go('/auth');
                          // context.push("/auth");
                          // Navigator.pushAndRemoveUntil(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => AuthPage()),
                          //   (route) => false,
                          // );
                          break;
                        case "fav":
                          context.push("/favourite");
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => FavouritePage(),
                          //   ),
                          // );
                          break;
                        case "about":
                          context.push("/aboutMe");
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => AboutMeScreen(),
                          //   ),
                          // );
                          break;
                        case "add":
                          context.push("/myAddress");
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => MyAddressScreen(),
                          //   ),
                          // );
                          break;
                        case "order":
                          context.push("/order");
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => OrderScreen(),
                          //   ),
                          // );
                          break;
                        case "cards":
                          context.push("/myCard");
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => MyCardsScreen(),
                          //   ),
                          // );
                          break;
                        case "transaction":
                          context.push("/transaction");
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => TransactionsScreen(),
                          //   ),
                          // );
                          break;
                        case "notification":
                          context.push("/notification");
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => NotificationScreen(),
                          //   ),
                          // );
                          break;
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
