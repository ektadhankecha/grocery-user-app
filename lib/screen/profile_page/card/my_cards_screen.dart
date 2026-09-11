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
 // bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final bool isWide = MediaQuery.of(context).size.width > 600;
    final cardProvider = context.watch<CardProvider>();
    return Scaffold(
      backgroundColor: MyColor.bg3,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(MyIcon.arrowBack),
        ),
        title: const Text("My Cards"),
      ),
      body: Center(
        child: Container(
          width: isWide ? 500 : double.infinity,
          margin: isWide
              ? const EdgeInsets.symmetric(vertical: 24, horizontal: 16)
              : EdgeInsets.zero,
          padding: EdgeInsets.fromLTRB(17, 20, 17, isWide ? 20 : 25),
          decoration: isWide
              ? BoxDecoration(
            color: MyColor.bg1,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(12),
                blurRadius: 16,
                spreadRadius: 2,
                offset: Offset(0, 4),
              ),
            ],
          )
              : null,
          child: cardProvider.cards.isEmpty
              ? EmptyScreenWidget(
                  icon: MyIcon.noCard,
                  title: "No saved payment methods",
                  description:
                      "You haven't added a payment card yet. Add a card for faster checkout.",
                  buttonText: "Add Card",
                  onButtonPressed: () {
                    context.push("/addCard");
                    },
                )
              : Column(
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
                              color: isWide ? MyColor.bg3 : MyColor.bg1,
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
                    },

                    child: Container(
                      height: 60,
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
      ),
    );
  }
}
