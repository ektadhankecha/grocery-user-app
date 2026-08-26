import 'package:flutter/material.dart';
import 'package:grocery_app/utils/app_colors.dart';
import 'package:grocery_app/utils/app_icons.dart';

class WriteReviewsScreen extends StatelessWidget {
  const WriteReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(MyIcon.arrowBack),
        ),
        title: Text("Write Reviews"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(60, 50, 60, 50),
            child: Column(
              children: [
                Text(
                  "What do you think ?",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  "please give your rating by clicking on the stars below",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: MyColor.textGraey,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(MyIcon.star, color: MyColor.staryellow, size: 45),
                    Icon(MyIcon.star, color: MyColor.staryellow, size: 45),
                    Icon(MyIcon.star, color: MyColor.staryellow, size: 45),
                    Icon(MyIcon.star, color: MyColor.staryellow, size: 45),
                    Icon(MyIcon.star, color: MyColor.bg1, size: 45),
                  ],
                ),
              ],
            ),
          ),
          TextFormField(
            cursorColor: Colors.black,
            showCursor: true,
            enableInteractiveSelection: true,
            maxLines: 5,
            decoration: InputDecoration(
              prefix: Padding(
                padding: const EdgeInsets.only(left: 10, top: 12, right: 8),
                child: Icon(MyIcon.edit, color: MyColor.textGraey),
              ),

              hintText: "Tell us about your experience",
            ),
          ),
        ],
      ),
    );
  }
}
