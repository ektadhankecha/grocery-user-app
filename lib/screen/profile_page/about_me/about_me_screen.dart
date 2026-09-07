import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_app/screen/profile_page/about_me/user_provider.dart';
import 'package:grocery_app/utils/app_icons.dart';
import 'package:grocery_app/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AboutMeScreen extends StatefulWidget {
  const AboutMeScreen({super.key});

  @override
  State<AboutMeScreen> createState() => _AboutMeScreenState();
}

class _AboutMeScreenState extends State<AboutMeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      nameController.text = userProvider.name;
      emailController.text = userProvider.email;
      phoneController.text = userProvider.contact;
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void showEditDialog({
    required String title,
    required String subtitle,
    required IconData icon,
    required TextEditingController controller,
    required String? Function(String?) validator,
    required TextInputType keyboardType,
    required bool isWide,
  }) {
    final tempController = TextEditingController(text: controller.text);
    final dialogFormKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, dialogSetState) {
            return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: isWide
                  ? const EdgeInsets.symmetric(horizontal: 40, vertical: 24)
                  : const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Container(
                width: isWide ? 400 : double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: MyColor.bg1,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: MyColor.locationgreen,
                      foregroundColor: MyColor.animationGreen,
                      child: Icon(MyIcon.edit),
                    ),
                    SizedBox(height: 5),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                        color: MyColor.lightGray,
                      ),
                    ),
                    SizedBox(height: 10),
                    Form(
                      key: dialogFormKey,
                      child: TextFormField(
                        enableInteractiveSelection: true,
                        controller: tempController,
                        onChanged: (value) {
                          dialogSetState(() {});
                        },
                        selectionControls: null,
                        keyboardType: keyboardType,

                        autofocus: true,
                        validator: validator,
                        cursorColor: MyColor.animationGreen,
                        cursorWidth: 1,
                        cursorHeight: 24,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: MyColor.dltRed,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: MyColor.animationGreen,
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: MyColor.animationGreen,
                              width: 1,
                            ),
                          ),
                          prefixIcon: Icon(
                            icon,
                            size: 22,
                            color: MyColor.lightGray,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            context.pop();
                            //Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyColor.bg1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(color: MyColor.lightGraey),
                            ),
                            elevation: 0,
                            shadowColor: Colors.transparent,
                            splashFactory: NoSplash.splashFactory,
                          ),
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              color: MyColor.lightGray,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed:
                              tempController.text.trim() ==
                                  controller.text.trim()
                              ? null
                              : () {
                                  if (dialogFormKey.currentState!.validate()) {
                                    setState(() {
                                      controller.text = tempController.text;
                                    });
                                    context.pop();
                                    //Navigator.pop(context);
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                tempController.text.trim() ==
                                    controller.text.trim()
                                ? Colors.grey.shade500
                                : MyColor.animationGreen,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            elevation: 0,
                            shadowColor: Colors.transparent,
                            splashFactory: NoSplash.splashFactory,
                          ),
                          child: Text(
                            "Save Changes",
                            style: TextStyle(
                              color: MyColor.bg1,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
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
          icon: Icon(MyIcon.arrowBack),
        ),
        title: Text("About Me"),
      ),
      body: Center(
        child: Container(
          height: double.infinity,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Personal Details",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    TextFormField(
                      enableInteractiveSelection: false,
                      controller: nameController,
                      readOnly: true,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),

                      decoration: InputDecoration(
                        fillColor: isWide ? MyColor.bg3 : MyColor.bg1,
                        prefixIcon: const Icon(
                          MyIcon.profileCircle,
                          size: 24,
                          color: Colors.black,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            showEditDialog(
                              isWide: isWide,
                              keyboardType: TextInputType.text,
                              title: "Edit Name",
                              icon: MyIcon.profileCircle,
                              subtitle: "Update your name below.",
                              controller: nameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter name";
                                }
                                return null;
                              },
                            );
                          },
                          icon: const Icon(
                            MyIcon.edit,
                            size: 24,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      controller: emailController,
                      enableInteractiveSelection: false,
                      readOnly: true,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),

                      decoration: InputDecoration(
                        fillColor: isWide ? MyColor.bg3 : MyColor.bg1,
                        prefixIcon: const Icon(
                          MyIcon.email,
                          size: 24,
                          color: Colors.black,
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(
                            MyIcon.edit,
                            size: 24,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            showEditDialog(
                              isWide: isWide,
                              keyboardType: TextInputType.emailAddress,
                              title: "Edit Email",
                              icon: MyIcon.email,
                              subtitle: "Update your email below.",
                              controller: emailController,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Please enter your email";
                                }

                                if (!RegExp(
                                  r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$',
                                ).hasMatch(value)) {
                                  return "Enter a valid email";
                                }

                                return null;
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      enableInteractiveSelection: false,
                      controller: phoneController,
                      readOnly: true,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),

                      // enabled: false,
                      decoration: InputDecoration(
                        fillColor: isWide ? MyColor.bg3 : MyColor.bg1,
                        prefixIcon: const Icon(
                          MyIcon.call,
                          size: 24,
                          color: Colors.black,
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(
                            MyIcon.edit,
                            size: 24,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            showEditDialog(
                              isWide: isWide,
                              keyboardType: TextInputType.number,
                              title: "Edit Contact",
                              icon: MyIcon.phone,
                              subtitle: "Update your phone number below.",
                              controller: phoneController,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Please enter phone number";
                                }

                                if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                                  return "Enter a valid 10-digit phone number";
                                }

                                return null;
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<UserProvider>().setUserData(
                      name: nameController.text,
                      email: emailController.text,
                      contact: phoneController.text,
                    );
                    context.pop();
                    //Navigator.pop(context);
                  }
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
                      "Save settings",
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
