import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_app/screen/main_page/bottom_navigation/bottom_navigation_provider.dart';
import 'package:grocery_app/screen/home_page/featured_product/card/product_provider.dart';
import 'package:grocery_app/utils/app_icons.dart';
import 'package:grocery_app/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/screen/home_page/featured_product/product_detail_screen.dart';
import 'package:grocery_app/screen/empty_screen_widget.dart';
import 'package:grocery_app/screen/home_page/featured_product/card/product_card.dart';
import 'package:provider/provider.dart';

class FavouritePage extends StatelessWidget {
  final bool fromBottomNav;
  const FavouritePage({super.key, this.fromBottomNav = false});

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();
    final favoriteProduct = productProvider.productList
        .where((product) => product.isFavorite)
        .toList();

    return PopScope(
      canPop: !fromBottomNav,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        context.read<BottomNavigationProvider>().changeIndex(0);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              if (fromBottomNav) {
                context.read<BottomNavigationProvider>().changeIndex(0);
              } else {
                context.pop();
              }
            },
            icon: const Icon(MyIcon.arrowBack),
          ),
          title: const Text("Favorites"),
        ),
        body: favoriteProduct.isEmpty
            ? EmptyScreenWidget(icon: MyIcon.heartRemove, title: "No Favorites Yet", description: "Save products you love here and find them easily later.")
            : Container(
                height: double.infinity,
                width: double.infinity,
                color: MyColor.bg3,
                child: Padding(
                  padding: EdgeInsets.all(17.r),
                  child: GridView.builder(
                    shrinkWrap: false,
                    physics: const BouncingScrollPhysics(),
                    itemCount: favoriteProduct.length,
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 180,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 0.74,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProductDetailScreen(
                                product: favoriteProduct[index],
                              ),
                            ),
                          );
                        },
                        child: ProductCard(product: favoriteProduct[index]),
                      );
                    },
                  ),
                ),
              ),
      ),
    );
  }
}
