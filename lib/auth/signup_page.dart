import 'package:flutter/material.dart';
import 'package:grocery_app/utils/app_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';
import 'package:flutter/services.dart';
import 'package:grocery_app/screen/main_page/main_screen.dart';
import 'package:grocery_app/screen/profile_page/about_me/user_provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isChecked = false;
  bool isPasswordVisible = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //image
          Image.asset(
            'assets/images/signup.png',
            width: double.infinity,
            height: 481.h,
            fit: BoxFit.cover,
          ),

          //back and welcome
          Positioned(
            top: 50.h,
            child: Row(
              children: [
                //back
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(MyIcon.arrowBack, size: 25.sp, color: MyColor.bg1),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.27),
                //welcome
                Text(
                  "Welcome",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: MyColor.bg1,
                  ),
                ),
              ],
            ),
          ),

          //bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 500.h,
              child: SingleChildScrollView(
                child: Container(
                  constraints: BoxConstraints(minHeight: 470.h),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    color: MyColor.bg3,
                  ),
                  padding: EdgeInsets.all(17),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(height: 15.h),

                      //heading
                      Text(
                        "Create account",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      SizedBox(height: 2),

                      //description
                      Text(
                        "Quickly create account",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: MyColor.textGraey,
                        ),
                      ),

                      SizedBox(height: 10.h),

                      //form
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            //name
                            TextFormField(
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                              ),
                              cursorColor: Colors.black,
                              enableInteractiveSelection: true,
                              controller: nameController,
                              keyboardType: TextInputType.name,
                             // maxLength: 10,
                              inputFormatters: [
                                FilteringTextInputFormatter.singleLineFormatter,
                              ],
                              decoration: InputDecoration(
                                hintText: "Name",

                              //  counterText: "",
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Icon(
                                    MyIcon.profileCircle,
                                    color: MyColor.textGraey,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Please enter your name";
                                }

                                return null;
                              },
                            ),

                            SizedBox(height: 5),

                            //email
                            TextFormField(
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                              ),
                              keyboardType: TextInputType.emailAddress,
                              cursorColor: Colors.black,
                              enableInteractiveSelection: true,
                              controller: emailController,
                              decoration: InputDecoration(
                                hintText: "Email Address",
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Icon(
                                    MyIcon.email,
                                    color: MyColor.textGraey,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your email";
                                }
                                if (!RegExp(
                                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                ).hasMatch(value)) {
                                  return "Enter a valid email";
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 5),

                            //phone number
                            TextFormField(
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                              ),
                              cursorColor: Colors.black,
                              enableInteractiveSelection: true,
                              controller: mobileController,
                              keyboardType: TextInputType.phone,
                              maxLength: 10,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: InputDecoration(
                                hintText: "Phone number",

                                counterText: "",
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Icon(
                                    MyIcon.call,
                                    color: MyColor.textGraey,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Please enter mobile number";
                                }
                                if (value.length != 10) {
                                  return "Mobile number must be 10 digits";
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 5),

                            // password
                            TextFormField(
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                              ),
                              cursorColor: Colors.black,
                              enableInteractiveSelection: false,
                              controller: passwordController,
                              obscureText: !isPasswordVisible,
                              decoration: InputDecoration(
                                hintText: "Your password",
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Icon(
                                    MyIcon.lock,
                                    color: MyColor.textGraey,
                                  ),
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isPasswordVisible = !isPasswordVisible;
                                    });
                                  },
                                  icon: Icon(
                                    isPasswordVisible
                                        ? MyIcon.visibility
                                        : MyIcon.visibilityOff,
                                  ),
                                  color: MyColor.textGraey,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter password";
                                }
                                if (value.length < 6) {
                                  return "Password must be at least 6 characters";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15.h),

                      //signup button
                      GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            SharedPreferences pref =
                                await SharedPreferences.getInstance();
                            await pref.setBool("LoginSuccess", true);
                            context.read<UserProvider>().setUserData(
                              name: nameController.text,
                              email: emailController.text,
                              contact: mobileController.text,
                            );

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MainScreen(showSignupSuccess: true),
                              ),
                            );
                          }
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
                              "Signup",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: MyColor.bg1,
                              ),
                            ),
                          ),
                        ),
                      ),

                      //log in text button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Do you have an account ?",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: MyColor.textGraey,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                              );
                            },
                            child: Text(
                              "Log in",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
