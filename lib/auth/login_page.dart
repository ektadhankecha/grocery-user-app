import 'package:flutter/material.dart';
import 'package:grocery_app/screen/main_page/main_screen.dart';
import 'package:grocery_app/utils/app_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/auth/forget_password.dart';
import 'package:grocery_app/auth/signup_page.dart';
import 'package:grocery_app/utils/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  bool isChecked = false;
  bool rememberMe = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //image
          Image.asset(
            'assets/images/login.png',
            width: double.infinity,
            height: 515.h,
            fit: BoxFit.cover,
          ),
          // Back Button
          Positioned(
            top: 50.h,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(MyIcon.arrowBack, size: 25.sp, color: MyColor.bg1),
                ),
                //welcome
                SizedBox(width: MediaQuery.of(context).size.width * 0.27),
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
              height: 453.h,
              child: SingleChildScrollView(
                child: Container(
                  constraints: BoxConstraints(minHeight: 453.h),
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

                      //title
                      Text(
                        "Welcome back !",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      SizedBox(height: 2),

                      //description
                      Text(
                        "Sign in to your account",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: MyColor.textGraey,
                        ),
                      ),

                      SizedBox(height: 10.h),

                      //form text box
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            //email
                            TextFormField(
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13
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

                            //password
                            TextFormField(
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13
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
                      //remember me & forget password
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          children: [
                            //remember me
                            Transform.scale(
                              scale: 0.7,
                              child: Switch(
                                value: rememberMe,
                                onChanged: (value) {
                                  setState(() {
                                    rememberMe = value;
                                  });
                                },
                                activeThumbColor: MyColor.bg1,
                                activeTrackColor: MyColor.textGraey,
                                inactiveTrackColor: MyColor.bg3,
                                inactiveThumbColor: MyColor.textGraey,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                              ),
                            ),
                            Text(
                              "Remember me",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: MyColor.textGraey,
                              ),
                            ),
                            Spacer(),
                            //forget password
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ForgetPassword(),
                                  ),
                                );
                              },
                              child: Text(
                                "Forgot password",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: MyColor.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      //login
                      GestureDetector(
                        onTap: ()async {

                          if (_formKey.currentState!.validate()) {
                            SharedPreferences pref =await SharedPreferences.getInstance();
                            await pref.setBool("LoginSuccess", true);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MainScreen(showLoginSuccess: true,),
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
                              "Login",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: MyColor.bg1,
                              ),
                            ),
                          ),
                        ),
                      ),

                      //signup text button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account ?",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: MyColor.textGraey,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignupPage(),
                                ),
                              );
                            },
                            child: Text(
                              "Sign up",
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
