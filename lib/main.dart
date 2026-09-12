import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/auth/auth_page.dart';
import 'package:grocery_app/auth/forget_password.dart';
import 'package:grocery_app/auth/login_page.dart';
import 'package:grocery_app/auth/otp_screen.dart';
import 'package:grocery_app/auth/signup_page.dart';
import 'package:grocery_app/auth/verify_number.dart';
import 'package:grocery_app/model/category_model.dart';
import 'package:grocery_app/model/product_model.dart';
import 'package:grocery_app/auth/auth_provider.dart';
import 'package:grocery_app/screen/cart_page/cart_screen.dart';
import 'package:grocery_app/screen/cart_page/orders_process/order_sucess_screen.dart';
import 'package:grocery_app/screen/cart_page/orders_process/payment_screen.dart';
import 'package:grocery_app/screen/cart_page/orders_process/shipping_address_screen.dart';
import 'package:grocery_app/screen/cart_page/orders_process/shipping_methods_1_screen.dart';
import 'package:grocery_app/screen/cart_page/orders_process/teack_order/track_order_screen.dart';
import 'package:grocery_app/screen/favorite_page/favourite_screen.dart';
import 'package:grocery_app/screen/home_page/categories/categories_screen.dart';
import 'package:grocery_app/screen/home_page/categories/category_provider.dart';
import 'package:grocery_app/screen/home_page/featured_product/product_detail_screen.dart';
import 'package:grocery_app/screen/home_page/featured_product/product_screen.dart';
import 'package:grocery_app/screen/home_page/search/search_screen.dart';
import 'package:grocery_app/screen/main_page/main_screen.dart';
import 'package:grocery_app/screen/on_boarding/onboarding_screen.dart';
import 'package:grocery_app/screen/profile_page/about_me/about_me_screen.dart';
import 'package:grocery_app/screen/profile_page/address/address_provider.dart';
import 'package:grocery_app/screen/home_page/banner/banner_provider.dart';
import 'package:grocery_app/screen/profile_page/address/address_screen.dart';
import 'package:grocery_app/screen/profile_page/address/my_address_screen.dart';
import 'package:grocery_app/screen/profile_page/card/add_card_screen.dart';
import 'package:grocery_app/screen/profile_page/card/card_provider.dart';
import 'package:grocery_app/screen/on_boarding/onboarding_provider.dart';
import 'package:grocery_app/screen/home_page/featured_product/card/product_provider.dart';
import 'package:grocery_app/screen/main_page/bottom_navigation/bottom_navigation_provider.dart';
import 'package:grocery_app/screen/profile_page/card/my_cards_screen.dart';
import 'package:grocery_app/screen/profile_page/notification/notification_screen.dart';
import 'package:grocery_app/screen/profile_page/order/order_screen.dart';
import 'package:grocery_app/screen/profile_page/transaction/transaction_provider.dart';
import 'package:grocery_app/screen/profile_page/transaction/transactions_screen.dart';
import 'package:grocery_app/screen/splash/splash_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:grocery_app/utils/app_colors.dart';
import 'package:grocery_app/screen/cart_page/orders_process/order_provider.dart';
import 'package:go_router/go_router.dart';
import 'firebase_options.dart';
//import 'package:device_preview/device_preview.dart';
//import 'package:flutter/foundation.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            final provider = ProductProvider() ..listenProducts();
            provider.loadCart();
            provider.loadFavorite();
            provider.loadSearchHistory();
            return provider;
          },
        ),
        ChangeNotifierProvider(create: (_) => CategoryProvider()..listenToCategories()),
        ChangeNotifierProvider(create: (_) => BottomNavigationProvider()),
        ChangeNotifierProvider(create: (_) => BannerProvider()),
        ChangeNotifierProvider(create: (_) => CardProvider()..loadCard()),
        ChangeNotifierProvider(
          create: (_) => AddressProvider()..loadAddresses(),
        ),
        ChangeNotifierProvider(create: (_) => OrderProvider()..listenToOrders()),
        ChangeNotifierProvider(
          create: (_) => TransactionProvider()..loadTransactions(),
        ),
        //ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => AuthhProvider()..loadUserData()),
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
final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: ((context, state) => SplashScreen())),
    GoRoute(
      path: "/onBoarding",
      builder: ((context, state) => OnboardingScreen()),
    ),
    GoRoute(path: "/auth", builder: ((context, state) => AuthPage())),
    GoRoute(path: "/login", builder: ((context, state) => LoginPage())),
    GoRoute(path: "/signup", builder: ((context, state) => SignupPage())),
    GoRoute(
      path: "/forgetPassword",
      builder: ((context, state) => ForgetPassword()),
    ),
    GoRoute(path: "/otp", builder: ((context, state) => OtpScreen())),
    GoRoute(path: "/verify", builder: ((context, state) => VerifyNumber())),
    GoRoute(
      path: "/trackOrder",
      builder: ((context, state) => TrackOrderScreen()),
    ),
    GoRoute(
      path: "/orderSuccess",
      builder: ((context, state) => OrderSuccessScreen()),
    ),
    GoRoute(path: "/payment", builder: ((context, state) => PaymentScreen())),
    GoRoute(path: "/addCard", builder: ((context, state) => AddCard())),
    GoRoute(
      path: "/shippingAddress",
      builder: ((context, state) => ShippingAddressScreen()),
    ),
    GoRoute(path: "/address", builder: ((context, state) => AddressScreen())),
    GoRoute(
      path: "/myAddress",
      builder: ((context, state) => MyAddressScreen()),
    ),
    GoRoute(
      path: "/shippingMethod",
      builder: ((context, state) => ShippingMethods1Screen()),
    ),
    GoRoute(path: "/cart", builder: ((context, state) => CartPage())),
    GoRoute(path: "/favourite", builder: ((context, state) => FavouritePage())),
    GoRoute(
      path: "/main",
      builder: ((context, state) {
        final successType = state.extra as String?;
        // final showLoginSuccess = state.extra as bool? ?? false;
        return MainScreen(
          showLoginSuccess: successType == "login",
          showSignupSuccess: successType == "signup",
        );
      }),
    ),
    GoRoute(
      path: "/category",
      builder: (context, state) {
        final categories = state.extra as List<CategoryModel>;
        return CategoriesScreen(categories: categories);
      },
    ),
    GoRoute(
      path: "/productDetail",
      builder: (context, state) {
        final product = state.extra as ProductModel;
        return ProductDetailScreen(product: product);
      },
    ),
    GoRoute(
      path: "/product",
      builder: (context, state) {
        final product = state.extra as List<ProductModel>;
        return ProductScreen(product: product);
      },
    ),
    GoRoute(path: "/search", builder: ((context, state) => SearchScreen())),
    GoRoute(path: "/favourite", builder: ((context, state) => FavouritePage())),
    GoRoute(path: "/aboutMe", builder: ((context, state) => AboutMeScreen())),
    GoRoute(path: "/order", builder: ((context, state) => OrderScreen())),
    GoRoute(path: "/myCard", builder: ((context, state) => MyCardsScreen())),
    GoRoute(
      path: "/transaction",
      builder: ((context, state) => TransactionsScreen()),
    ),
    GoRoute(
      path: "/notification",
      builder: ((context, state) => NotificationScreen()),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
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
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: 'poppins',
                color: Colors.black,
              ),
            ),
            scaffoldBackgroundColor: MyColor.bg3,
          ),
          routerConfig: appRouter,

          // locale: DevicePreview.locale(context),
          // builder: DevicePreview.appBuilder,
        );
      },
      //child: WriteReviewsScreen(),
      //  child: SplashScreen(),
    );
  }
}
