import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_app/utils/app_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/model/product_model.dart';
import 'package:grocery_app/utils/app_colors.dart';
import 'package:grocery_app/screen/home_page/featured_product/card/product_card.dart';
import 'package:grocery_app/screen/home_page/featured_product/product_detail_screen.dart';

class ProductScreen extends StatefulWidget {
  final List<ProductModel> product;
  const ProductScreen({super.key, required this.product});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75.h,
        backgroundColor: MyColor.bg1,

        leading: IconButton(
          onPressed: () {
            context.pop();
            //Navigator.pop(context);
          },
          icon: Icon(MyIcon.arrowBack, size: 22.sp),
        ),
        title: Center(
          child: Text(
            "Vegetables",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: MyColor.bg3,
        child: Padding(
          padding: EdgeInsets.all(17.r),
          child: GridView.builder(
            shrinkWrap: false,
            physics: const BouncingScrollPhysics(),
            itemCount: widget.product.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15.w,
              mainAxisSpacing: 15.h,
              childAspectRatio: 0.71,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          ProductDetailScreen(product: widget.product[index]),
                    ),
                  );
                  if (mounted) setState(() {});
                },
                child: ProductCard(product: widget.product[index]),
              );
            },
          ),
        ),
      ),
    );
  }
}
