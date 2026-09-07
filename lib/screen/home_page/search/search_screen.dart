import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_app/screen/empty_screen_widget.dart';
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
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MyColor.bg3,
      appBar: AppBar(
        backgroundColor: MyColor.bg1,
        toolbarHeight: 91,
        leadingWidth: 50,
        leading: IconButton(
          onPressed: () {
            context.pop();
            },
          icon: Icon(MyIcon.arrowBack, size: 22),
        ),
        titleSpacing: 0,
        title: TextField(
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: screenWidth > 550 ? 15 : 13),
          controller: searchController,
          onSubmitted: (value) {
            if (value.trim().isNotEmpty) {
              context.read<ProductProvider>().searchProducts(value.trim());
            } else {
              context.read<ProductProvider>().nothingSearch();
            }
          },
          onChanged: (value) {
            if (value.trim().isEmpty) {
              context.read<ProductProvider>().nothingSearch();
            }
          },
          decoration: InputDecoration(
            fillColor: MyColor.searchGraey,
            hintText: "Search keywords..",
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            hintStyle: TextStyle(
              color: MyColor.textGraey,
              fontSize: screenWidth > 550 ? 14 : 12,
              fontWeight: FontWeight.w400,
            ),
            suffixIcon: InkWell(
              onTap: () {
                final query = searchController.text.trim();
                if (query.isNotEmpty) {
                  context.read<ProductProvider>().searchProducts(query);
                } else {
                  context.read<ProductProvider>().nothingSearch();
                }
              },
              child: const Icon(
                MyIcon.search,
                color: MyColor.textGraey,
                size: 22,
              ),
            ),
          ),
          cursorColor: Colors.black,
        ),
        actions: const [SizedBox(width: 20)],
      ),
      body: !productProvider.hasSearched
          // Default screen (History & Discover More)
          ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (productProvider.searchHistory.isNotEmpty) ...[
                    SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 17,
                        vertical: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Search History",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: screenWidth > 550 ? 18 : 15,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              context
                                  .read<ProductProvider>()
                                  .clearSearchHistory();
                            },
                            child: Text(
                              "Clear",
                              style: TextStyle(
                                color: MyColor.blue,
                                fontSize: screenWidth > 550 ? 15 : 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 17),
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
                                  fontSize: screenWidth > 550 ? 12 : 10,
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
                    padding: EdgeInsets.symmetric(
                      horizontal: 17,
                      vertical: 10,
                    ),
                    child: Text(
                      "Discover More",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: screenWidth > 550 ? 18 : 15,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 17),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: productProvider.discoverMore.map((item) {
                        return GestureDetector(
                          onTap: () {
                            searchController.text = item;
                            context.read<ProductProvider>().searchProducts(item);
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
                                fontSize: screenWidth > 550 ? 12 : 10,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            )
          // Search Results Empty State
          : productProvider.searchResults.isEmpty
              ? const EmptyScreenWidget(
                  icon: MyIcon.searchOff,
                  title: "No Product found",
                  description: "Try searching with different name",
                )
              // Search Results Grid
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(17),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: productProvider.searchResults.length,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
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
                                  product: productProvider
                                      .searchResults[index],
                                ),
                              ),
                            );
                          },
                          child: ProductCard(
                            product: productProvider.searchResults[index],
                          ),
                        );
                      },
                    ),
                  ),
                ),
    );
  }
}
