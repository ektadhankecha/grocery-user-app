import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_app/screen/profile_page/card/card_provider.dart';
import 'package:grocery_app/screen/profile_page/card/add_card_screen.dart';
import 'package:grocery_app/utils/app_colors.dart';
import 'package:grocery_app/utils/app_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/screen/profile_page/card/card_widget.dart';
import 'package:grocery_app/screen/empty_screen_widget.dart';
import 'package:provider/provider.dart';

class MyCardsScreen extends StatefulWidget {
  const MyCardsScreen({super.key});

  @override
  State<MyCardsScreen> createState() => _MyCardsScreenState();
}

class _MyCardsScreenState extends State<MyCardsScreen> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final cardProvider = context.watch<CardProvider>();
    return Scaffold(
      backgroundColor: MyColor.bg3,
      appBar: AppBar(
        toolbarHeight: 81.h,
        backgroundColor: MyColor.bg1,
        leading: IconButton(
          onPressed: () {
            context.pop();
            //Navigator.pop(context);
          },
          icon: Icon(MyIcon.arrowBack, size: 22.sp),
        ),
        centerTitle: true,
        title: Text(
          "My Cards",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      body: cardProvider.cards.isEmpty
          ? EmptyScreenWidget(
              icon: MyIcon.noCard,
              title: "No saved payment methods",
              description:
                  "You haven't added a payment card yet. Add a card for faster checkout.",
              buttonText: "Add Card",
              onButtonPressed: () {
                context.push("/addCard");
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => AddCard()),
                // );
              },
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 20),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: cardProvider.cards.length,
                        itemBuilder: (context, index) {
                          final card = cardProvider.cards[index];
                          return Container(
                            margin: EdgeInsets.only(bottom: 5),
                            decoration: BoxDecoration(
                              color: MyColor.bg1,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: CardWidget(card: card),
                          );
                        },
                      ),
                    ),
                  ),

                  SizedBox(height: 10),

                  GestureDetector(
                    onTap: () {
                      context.push("/addCard");
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => AddCard()),
                      // );
                    },

                    child: Container(
                      height: 60.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            MyColor.gradientGreen,
                            MyColor.animationGreen,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: MyColor.animationGreen.withAlpha(40),
                            blurRadius: 9,
                            spreadRadius: 0,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "Add Card",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: MyColor.bg1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
