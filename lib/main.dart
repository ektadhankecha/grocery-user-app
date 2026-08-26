import 'package:flutter/material.dart';
import 'package:grocery_app/data/dummy_data.dart';
import 'package:grocery_app/screen/profile_page/address/address_provider.dart';
import 'package:grocery_app/screen/home_page/banner/banner_provider.dart';
import 'package:grocery_app/screen/home_page/featured_product/card/card_provider.dart';
import 'package:grocery_app/screen/on_boarding/onboarding_provider.dart';
import 'package:grocery_app/screen/home_page/featured_product/card/product_provider.dart';
import 'package:grocery_app/screen/main_page/bottom_navigation/bottom_navigation_provider.dart';
import 'package:grocery_app/screen/profile_page/transaction/transaction_provider.dart';
import 'package:grocery_app/screen/profile_page/about_me/user_provider.dart';
import 'package:grocery_app/screen/splash/splash_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:grocery_app/utils/app_colors.dart';
import 'screen/profile_page/profile_provider.dart';
import 'package:grocery_app/screen/cart_page/orders_process/order_provider.dart';
//import 'package:device_preview/device_preview.dart';
//import 'package:flutter/foundation.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            final provider = ProductProvider(productList: products);
            provider.showData();
            provider.loadFavorite();
            provider.loadSearchHistory();
            return provider;
          },
        ),
        ChangeNotifierProvider(
          create: (_) => ProfileProvider()..loadProfileImage(),
        ),
        ChangeNotifierProvider(create: (_) => BottomNavigationProvider()),
        ChangeNotifierProvider(create: (_) => BannerProvider()),
        ChangeNotifierProvider(create: (_) => CardProvider()..loadCard()),
        ChangeNotifierProvider(
          create: (_) => AddressProvider()..loadAddresses(),
        ),
        ChangeNotifierProvider(create: (_) => OrderProvider()..loadOrders()),
        ChangeNotifierProvider(
          create: (_) => TransactionProvider()..loadTransactions(),
        ),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => OnboardingProvider(totalPage: 3)),
      ],
      child: MyApp(),
    ),
  );
}
//const MyApp()
// void main() {
//   runApp(
//     DevicePreview(
//       enabled: !kReleaseMode,
//       builder: (context) => const MyApp(),
//     ),
//   );
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: MyColor.bg1,
              contentPadding: const EdgeInsets.symmetric(vertical: 18),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(5),
              ),
              hintStyle: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: MyColor.textGraey,
              ),
            ),

            fontFamily: 'poppins',
            useMaterial3: true,
            appBarTheme: const AppBarTheme(
              surfaceTintColor: Colors.transparent,
              scrolledUnderElevation: 0,
              backgroundColor: MyColor.bg1,
              //foregroundColor: Colors.black,
              toolbarHeight: 81,
              elevation: 0,
              centerTitle: true,
              iconTheme: IconThemeData(size: 22, color: Colors.black),
              titleTextStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontFamily: 'poppins',
              ),
            ),
            scaffoldBackgroundColor: MyColor.bg3,
          ),

          // locale: DevicePreview.locale(context),
          // builder: DevicePreview.appBuilder,
          home: child,
        );
      },
      //child: WriteReviewsScreen(),
      child: const SplashScreen(),
    );
  }
}
