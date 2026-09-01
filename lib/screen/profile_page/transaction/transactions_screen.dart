import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_app/screen/profile_page/transaction/transaction_provider.dart';
import 'package:grocery_app/utils/app_icons.dart';
import 'package:grocery_app/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/screen/empty_screen_widget.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  @override
  Widget build(BuildContext context) {
    final transactionProvider = context.watch<TransactionProvider>();
    return Scaffold(
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
          "Transactions",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: MyColor.bg3,
      body: transactionProvider.transactionList.isEmpty
          ? EmptyScreenWidget(
              icon: MyIcon.noTransaction,
              title: "No transactions yet",
              description:
                  "Your completed orders payment transactions will appear here.",
            )
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ListView.builder(
                itemCount: transactionProvider.transactionList.length,
                itemBuilder: (context, index) {
                  final transaction =
                      transactionProvider.transactionList[index];

                  return Container(
                    color: MyColor.bg1,
                    padding: EdgeInsets.fromLTRB(0, 10, 8, 10),
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 35,
                        backgroundColor: MyColor.bggray,
                        // foregroundColor: MyColor.animationGreen,
                        child: Image.asset(
                          "assets/images/cardicon.png",
                          height: 22,
                          width: 39,
                        ),
                      ),

                      title: Text(
                        transaction.title,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                      subtitle: Text(
                        DateFormat(
                          'MMM dd yyyy \'at\' h:mm a',
                        ).format(transaction.transactionDate),
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 10,
                        ),
                      ),
                      trailing: Text(
                        transaction.amount.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: MyColor.textgreen,
                        ),
                      ),
                      horizontalTitleGap: 12,
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
