import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_app/utils/app_icons.dart';
import 'package:grocery_app/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/data/notification_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  Future<void> loadNotificationSettings() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      for (int i = 0; i < notificationData.length; i++) {
        notificationData[i].isEnable =
            prefs.getBool('notification_$i') ?? false;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadNotificationSettings();
  }

  @override
  Widget build(BuildContext context) {
    final bool isWide = MediaQuery.of(context).size.width > 600;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(MyIcon.arrowBack),
        ),
        title: const Text("Notification"),
      ),
      backgroundColor: MyColor.bg3,
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
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: notificationData.length,
                  itemBuilder: (context, index) {
                    return Container(
                      color: isWide ? MyColor.bg3 : MyColor.bg1,
                      padding: EdgeInsets.fromLTRB(0, 10, 8, 10),
                      margin: EdgeInsets.symmetric(vertical: 7),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: ListTile(
                          title: Text(
                            notificationData[index].title,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                          subtitle: Text(
                            notificationData[index].description,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                            ),
                          ),
                          trailing: Transform.scale(
                            scale: 0.6,
                            child: Switch(
                              value: notificationData[index].isEnable,
                              onChanged: (value) async {
                                setState(() {
                                  notificationData[index].isEnable = value;
                                });
                                SharedPreferences pref =
                                    await SharedPreferences.getInstance();
                                await pref.setBool("notification_$index", value);
                              },
                              activeThumbColor: MyColor.bg1,
                              activeTrackColor: MyColor.animationGreen,
                              inactiveTrackColor: MyColor.bg1,
                              inactiveThumbColor: MyColor.animationGreen,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                          // horizontalTitleGap: 12,
                          contentPadding: EdgeInsets.only(left: 12),
                        ),
                      ),
                    );
                  },
                ),
              ),
              GestureDetector(
                onTap: () {
                  context.push("/main");
                  },
                child: Container(
                  height: 60.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [MyColor.gradientGreen, MyColor.animationGreen],
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
                      "Save Setting",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
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
