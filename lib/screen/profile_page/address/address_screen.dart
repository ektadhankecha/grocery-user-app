import 'package:flutter/material.dart';
import 'package:grocery_app/screen/profile_page/address/address_provider.dart';
import 'package:grocery_app/utils/app_icons.dart';
import 'package:grocery_app/auth/snack_bar.dart';
import 'package:grocery_app/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/model/address_model.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  bool isButtonEnabled = false;
  bool saveThis = true;
  String? selectedCountry;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController zipController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  List<String> countries = [
    "India",
    "United States",
    "United Kingdom",
    "Canada",
    "Australia",
    "Germany",
    "France",
    "Japan",
    "China",
    "Brazil",
  ];
  void checkFields() {
    setState(() {
      isButtonEnabled =
          nameController.text.trim().isNotEmpty &&
          emailController.text.trim().isNotEmpty &&
          phoneController.text.trim().isNotEmpty &&
          addressController.text.trim().isNotEmpty &&
          cityController.text.trim().isNotEmpty &&
          selectedCountry != null &&
          zipController.text.trim().isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    nameController.addListener(checkFields);
    emailController.addListener(checkFields);
    phoneController.addListener(checkFields);
    addressController.addListener(checkFields);
    cityController.addListener(checkFields);
    zipController.addListener(checkFields);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    cityController.dispose();
    countryController.dispose();
    zipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 81.h,
        backgroundColor: MyColor.bg1,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(MyIcon.arrowBack, size: 22.sp),
        ),
        centerTitle: true,
        title: Text(
          "Add Address",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: MyColor.bg3,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(17, 30, 17, 37),
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                        controller: nameController,
                        keyboardType: TextInputType.text,
                        cursorColor: Colors.black,
                        cursorHeight: 24,
                        cursorWidth: 2,
                        selectionControls: null,
                        enableInteractiveSelection: true,
                        decoration: InputDecoration(
                          errorStyle: const TextStyle(fontSize: 0, height: 0),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 2),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 2),
                          ),
                          prefixIcon: Icon(
                            MyIcon.profileCircle,
                            size: 24,
                            color: MyColor.lightGray,
                          ),
                          hintText: "Name",
                        ),

                        validator: ((value) {
                          if (value == null || value.isEmpty) {
                            return "";
                          }
                          return null;
                        }),
                      ),
                      SizedBox(height: 5),
                      TextFormField(
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Colors.black,
                        cursorHeight: 24,
                        cursorWidth: 2,
                        selectionControls: null,
                        enableInteractiveSelection: true,
                        decoration: InputDecoration(
                          errorStyle: const TextStyle(fontSize: 0, height: 0),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 2),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 2),
                          ),
                          prefixIcon: Icon(
                            MyIcon.email,
                            size: 24,
                            color: MyColor.lightGray,
                          ),
                          hintText: "Email address",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "";
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
                      TextFormField(
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                        controller: phoneController,
                        maxLength: 10,

                        keyboardType: TextInputType.number,
                        cursorColor: Colors.black,
                        cursorHeight: 24,
                        cursorWidth: 2,
                        selectionControls: null,
                        enableInteractiveSelection: true,
                        decoration: InputDecoration(
                          errorStyle: const TextStyle(fontSize: 0, height: 0),
                          counterText: "",
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 2),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 2),
                          ),
                          prefixIcon: Icon(
                            MyIcon.phone,
                            size: 24,
                            color: MyColor.lightGray,
                          ),
                          hintText: "Phone number",
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "";
                          }
                          if (value.length != 10) {
                            return "";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 5),
                      TextFormField(
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                        controller: addressController,

                        cursorColor: Colors.black,
                        cursorHeight: 24,
                        cursorWidth: 2,
                        selectionControls: null,
                        enableInteractiveSelection: true,
                        decoration: InputDecoration(
                          errorStyle: const TextStyle(fontSize: 0, height: 0),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 2),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 2),
                          ),
                          prefixIcon: Icon(
                            MyIcon.location,
                            size: 24,
                            color: MyColor.lightGray,
                          ),
                          hintText: "Address",
                        ),
                        validator: ((value) {
                          if (value == null || value.isEmpty) {
                            return "";
                          }
                          return null;
                        }),
                      ),
                      SizedBox(height: 5),
                      TextFormField(
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                        controller: zipController,
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.black,
                        cursorHeight: 24,
                        cursorWidth: 2,
                        maxLength: 6,
                        selectionControls: null,
                        enableInteractiveSelection: true,
                        decoration: InputDecoration(
                          errorStyle: const TextStyle(fontSize: 0, height: 0),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 2),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 2),
                          ),
                          prefixIcon: Icon(
                            MyIcon.pin,
                            size: 24,
                            color: MyColor.lightGray,
                          ),
                          hintText: "Zip code",
                          counterText: "",
                        ),
                        validator: ((value) {
                          if (value == null || value.isEmpty) {
                            return "";
                          }
                          if (value.length != 6) {
                            return "";
                          }
                          return null;
                        }),
                      ),
                      SizedBox(height: 5),
                      TextFormField(
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                        controller: cityController,
                        keyboardType: TextInputType.text,
                        cursorColor: Colors.black,
                        cursorHeight: 24,
                        cursorWidth: 2,
                        selectionControls: null,
                        enableInteractiveSelection: true,
                        decoration: InputDecoration(
                          errorStyle: const TextStyle(fontSize: 0, height: 0),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 2),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 2),
                          ),
                          prefixIcon: Icon(
                            MyIcon.map,
                            size: 24,
                            color: MyColor.lightGray,
                          ),
                          hintText: "City",
                        ),
                        validator: ((value) {
                          if (value == null || value.isEmpty) {
                            return "";
                          }
                          return null;
                        }),
                      ),
                      SizedBox(height: 5),
                      DropdownButtonFormField<String>(
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'poppins',
                          color: MyColor.textGraey,
                        ),
                        dropdownColor: MyColor.bg1,
                        menuMaxHeight: MediaQuery.of(context).size.height * 0.4,

                        decoration: InputDecoration(
                          errorStyle: const TextStyle(fontSize: 0, height: 0),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 2),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 2),
                          ),

                          hintText: "Country",

                          prefixIcon: Icon(
                            MyIcon.language,
                            size: 24,
                            color: MyColor.lightGray,
                          ),
                        ),
                        icon: Icon(MyIcon.arrowDropDownOutlined),
                        iconSize: 30,
                        iconDisabledColor: MyColor.lightGray,
                        iconEnabledColor: MyColor.lightGray,
                        initialValue: selectedCountry,
                        items: countries.map((country) {
                          return DropdownMenuItem<String>(
                            value: country,
                            child: Text(
                              country,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedCountry = value;
                          });
                          checkFields();
                        },

                        validator: ((value) {
                          if (value == null || value.isEmpty) {
                            return "";
                          }
                          return null;
                        }),
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          //remember me
                          Transform.scale(
                            scale: 0.6,
                            child: Switch(
                              value: saveThis,
                              onChanged: (value) {
                                setState(() {
                                  saveThis = value;
                                });
                              },
                              activeThumbColor: MyColor.bg1,
                              activeTrackColor: MyColor.animationGreen,
                              inactiveTrackColor: MyColor.bg3,
                              inactiveThumbColor: MyColor.animationGreen,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                          //  SizedBox(width: 1,),
                          Text(
                            "Save this address",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 140.h),
                GestureDetector(
                  onTap: isButtonEnabled
                      ? () async {
                          if (_formKey.currentState!.validate()) {
                            final AddressModel newAddress = AddressModel(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                              address: addressController.text,
                              zipCode: zipController.text,
                              city: cityController.text,
                              country: selectedCountry ?? "",
                            );
                            await context.read<AddressProvider>().addAddresses(
                              newAddress,
                            );
                            Navigator.pop(context);
                          } else {
                            showTopSnackBar(
                              context,
                              message: "Please fill all fields correct",
                              preIcon: MyIcon.error,
                              backgroundColor: MyColor.dltRed,
                            );
                          }
                        }
                      : null,
                  child: Container(
                    height: 60.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      gradient: isButtonEnabled
                          ? LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                MyColor.gradientGreen,
                                MyColor.animationGreen,
                              ],
                            )
                          : LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Colors.grey.shade400,
                                Colors.grey.shade500,
                              ],
                            ),
                      boxShadow: [
                        BoxShadow(
                          color: isButtonEnabled
                              ? MyColor.animationGreen.withAlpha(40)
                              : Colors.grey.withAlpha(40),
                          blurRadius: 9,
                          spreadRadius: 0,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        "Save Address",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: isButtonEnabled ? MyColor.bg1 : Colors.white70,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
