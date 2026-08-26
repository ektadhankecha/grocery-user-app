import 'package:flutter/material.dart';
import 'package:grocery_app/screen/home_page/featured_product/card/product_provider.dart';
import 'package:grocery_app/utils/app_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/utils/app_colors.dart';
import 'package:grocery_app/screen/home_page/featured_product/card/product_card.dart';
import 'package:grocery_app/screen/home_page/featured_product/product_detail_screen.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<ProductProvider>();
      provider.nothingSearch();
      provider.loadSearchHistory();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();
    return Scaffold(
      backgroundColor: MyColor.bg3,
      appBar: AppBar(
        backgroundColor: MyColor.bg1,
        toolbarHeight: 91,
        leadingWidth: 50,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(MyIcon.arrowBack, size: 22.sp),
        ),
        titleSpacing: 0,
        title: TextField(
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
          controller: searchController,
          textInputAction: TextInputAction.search,
          onSubmitted: (value) {
            context.read<ProductProvider>().searchProducts(value);
          },
          onChanged: (value) {
            if (value.isEmpty) {
              context.read<ProductProvider>().nothingSearch();
            }
          },
          decoration: InputDecoration(
            fillColor: MyColor.searchGraey,
            hintText: "Search keywords..",
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            hintStyle: TextStyle(
              color: MyColor.textGraey,
              fontSize: 12,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w400,
            ),
            suffixIcon: const Icon(
              MyIcon.search,
              color: MyColor.textGraey,
              size: 22,
            ),
          ),
          cursorColor: Colors.black,
        ),
        actions: [SizedBox(width: 20)],
      ),
      body: !productProvider.hasSearched
          //default screen
          ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (productProvider.searchHistory.isNotEmpty) ...[
                    SizedBox(height: 10.h),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 17,
                        vertical: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Search History",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              context
                                  .read<ProductProvider>()
                                  .clearSearchHistory();
                            },
                            child: const Text(
                              "Clear",
                              style: TextStyle(
                                color: MyColor.blue,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 17),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: productProvider.searchHistory.map((item) {
                          return GestureDetector(
                            onTap: () {
                              searchController.text = item;
                              context.read<ProductProvider>().searchProducts(
                                item,
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: MyColor.bg1,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                item,
                                style: TextStyle(
                                  color: MyColor.textGraey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 10.h),
                  ],
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 17,
                      vertical: 10,
                    ),
                    child: const Text(
                      "Discover More",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 17),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: productProvider.discoverMore.map((item) {
                        return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: MyColor.bg1,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              item,
                              style: TextStyle(
                                color: MyColor.textGraey,
                                fontWeight: FontWeight.w500,
                                fontSize: 10,
                              ),
                            ),
                          );

                      }).toList(),
                    ),
                  ),
                ],
              ),
            )
          //search after screen
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 17,
                      bottom: 17,
                      left: 17,
                      right: 17,
                    ),
                    child: productProvider.searchResults.isEmpty
                        //empty screen
                        ? Container(

                            width: double.infinity,
                            color: MyColor.bg3,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 200),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      MyIcon.searchOff,
                                      size: 100,
                                      color: MyColor.animationGreen,
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      "No Product found",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'poppins',
                                      ),
                                    ),
                                    Text(
                                      "Try searching with different name",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'poppins',
                                        color: MyColor.textGraey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        //filterData show
                        : GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: productProvider.searchResults.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 15,
                                  childAspectRatio: 0.62,
                                ),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ProductDetailScreen(
                                        product: productProvider
                                            .searchResults[index],
                                      ),
                                    ),
                                  );
                                  // if (mounted) setState(() {});
                                },
                                child: ProductCard(
                                  product: productProvider.searchResults[index],
                                ),
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
