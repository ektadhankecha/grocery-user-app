import 'package:flutter/material.dart';
import 'package:grocery_app/screen/main_page/bottom_navigation/bottom_navigation_provider.dart';
import 'package:grocery_app/screen/home_page/home_screen.dart';
import 'package:grocery_app/screen/favorite_page/favourite_screen.dart';
import 'package:grocery_app/screen/cart_page/cart_screen.dart';
import 'package:grocery_app/screen/profile_page/profile_screen.dart';
import 'package:grocery_app/screen/main_page/bottom_navigation/bottom_navigation_widget.dart';
import 'package:grocery_app/screen/main_page/bottom_navigation/navigation_rail_widget.dart';
import 'package:grocery_app/auth/responsive_layout.dart';
import 'package:grocery_app/auth/snack_bar.dart';
import 'package:grocery_app/utils/app_icons.dart';
import 'package:grocery_app/utils/app_colors.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  final bool showLoginSuccess;
  final bool showSignupSuccess;
  const MainScreen({
    super.key,
    this.showLoginSuccess = false,
    this.showSignupSuccess = false,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final List<Widget> screens;
  @override
  void initState() {
    super.initState();
    screens = [
      const HomeScreen(),
      FavouritePage(fromBottomNav: true),
      const CartPage(),
      const ProfilePage(),
    ];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BottomNavigationProvider>().resetIndex(0);
    });

    if (widget.showLoginSuccess) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showTopSnackBar(
          context,
          message: "Login Successful",
          preIcon: MyIcon.checkCircle,
          backgroundColor: MyColor.animationGreen,
        );
      });
    }
    if (widget.showSignupSuccess) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showTopSnackBar(
          context,
          message: "Signup Successful",
          preIcon: MyIcon.checkCircle,
          backgroundColor: MyColor.animationGreen,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final navigationProvider = context.watch<BottomNavigationProvider>();
    final int selectedIndex = navigationProvider.selectedIndex;
    final Widget currentScreen = screens[selectedIndex];

    return ResponsiveLayout(
      // Mobile: Bottom Navigation Bar
      mobile: Scaffold(
        body: currentScreen,
        bottomNavigationBar: BottomNavigator(
          selectedIndex: selectedIndex,
          onTap: (index) {
            context.read<BottomNavigationProvider>().changeIndex(index);
          },
        ),
      ),

      // Tablet: Navigation Rail with only icons
      tablet: Scaffold(
        body: Row(
          children: [
            NavigationRailWidget(
              selectedIndex: selectedIndex,
              isExpanded: false,
              onTap: (index) {
                context.read<BottomNavigationProvider>().changeIndex(index);
              },
            ),
            Expanded(child: currentScreen),
          ],
        ),
      ),

      // Desktop: Navigation Rail with icon and name
      desktop: Scaffold(
        body: Row(
          children: [
            NavigationRailWidget(
              selectedIndex: selectedIndex,
              isExpanded: true,
              onTap: (index) {
                context.read<BottomNavigationProvider>().changeIndex(index);
              },
            ),
            Expanded(child: currentScreen),
          ],
        ),
      ),
    );
  }
}
