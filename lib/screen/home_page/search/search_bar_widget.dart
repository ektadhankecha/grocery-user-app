import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_app/utils/app_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/app_colors.dart';
import 'package:grocery_app/screen/home_page/search/search_screen.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(17.w, 0, 17.w, 0),
      child: TextField(
        readOnly: true,
        onTap: () {
          context.push("/search");
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => SearchScreen()),
          // );
        },
        decoration: InputDecoration(
          fillColor: MyColor.searchGraey,

          hintText: "Search keywords..",
          hintStyle: TextStyle(
            color: MyColor.textGraey,
            fontSize: 12,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w400,
          ),

          prefixIcon: Builder(
            builder: (context) {
              return IconButton(
                splashRadius: 25,
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(
                  MyIcon.menu,
                  color: MyColor.textGraey,
                  size: 22,
                ),
              );
            },
          ),
          suffixIcon: const Icon(
            MyIcon.search,
            color: MyColor.textGraey,
            size: 22,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        ),
      ),
    );
  }
}
