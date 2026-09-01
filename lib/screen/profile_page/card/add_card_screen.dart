import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_app/screen/profile_page/card/card_provider.dart';
import 'package:grocery_app/utils/app_icons.dart';
import 'package:grocery_app/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/model/card_model.dart';
import 'package:grocery_app/auth/snack_bar.dart';
import 'package:provider/provider.dart';

class AddCard extends StatefulWidget {
  const AddCard({super.key});

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  bool isButtonEnabled = false;
  bool saveThis = true;
  String? selectedCountry;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  void checkFields() {
    setState(() {
      isButtonEnabled =
          nameController.text.trim().isNotEmpty &&
          dateController.text.trim().isNotEmpty &&
          cvvController.text.trim().isNotEmpty &&
          cardNumberController.text.trim().isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    nameController.addListener(checkFields);
    cardNumberController.addListener(checkFields);
    dateController.addListener(checkFields);
    cvvController.addListener(checkFields);
  }

  @override
  void dispose() {
    nameController.dispose();
    cardNumberController.dispose();
    dateController.dispose();
    cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          "Add Credit Card",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 25),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
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
                      hintText: "Name on the card",
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
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),

                    controller: cardNumberController,
                    keyboardType: TextInputType.number,
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
                        MyIcon.cardbox,
                        size: 24,
                        color: MyColor.lightGray,
                      ),
                      hintText: "Card number",
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CardNumberFormatter(),
                    ],

                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return "";
                      }
                      if (value.length != 19) {
                        return "";
                      }
                      return null;
                    }),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                          controller: dateController,
                          maxLength: 5,
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.black,
                          cursorHeight: 24,
                          cursorWidth: 2,
                          selectionControls: null,
                          enableInteractiveSelection: true,
                          decoration: InputDecoration(
                            errorStyle: const TextStyle(fontSize: 0, height: 0),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 2,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 2,
                              ),
                            ),
                            prefixIcon: Icon(
                              MyIcon.calender,
                              size: 24,
                              color: MyColor.lightGray,
                            ),
                            hintText: "MM/YY",
                            counterText: '',
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            ExpiryDateFormatter(),
                          ],
                          validator: expiryDateValidator,
                        ),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: TextFormField(
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                          controller: cvvController,
                          maxLength: 3,
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.black,
                          cursorHeight: 24,
                          cursorWidth: 2,
                          selectionControls: null,
                          enableInteractiveSelection: true,
                          decoration: InputDecoration(
                            errorStyle: const TextStyle(fontSize: 0, height: 0),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 2,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 2,
                              ),
                            ),
                            prefixIcon: Icon(
                              MyIcon.lock,
                              size: 24,
                              color: MyColor.lightGray,
                            ),
                            hintText: "CVV",
                            counterText: '',
                          ),

                          validator: ((value) {
                            if (value == null || value.isEmpty) {
                              return "";
                            }
                            if (value.length != 3) {
                              return "";
                            }
                            return null;
                          }),
                        ),
                      ),
                    ],
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
                        "Save this card",
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
            Spacer(),
            GestureDetector(
              onTap: isButtonEnabled
                  ? () {
                      if (_formKey.currentState!.validate()) {
                        final CardModel newCard = CardModel(
                          name: nameController.text,
                          cardNumber: cardNumberController.text,
                          date: dateController.text,
                          cvv: cvvController.text,
                        );
                        context.read<CardProvider>().addCard(newCard);
                        context.pop();
                        //Navigator.pop(context);
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
                          colors: [Colors.grey.shade400, Colors.grey.shade500],
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
                    "Add credit card",
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
    );
  }
}

String? expiryDateValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "";
  }
  if (!RegExp(r'^(0[1-9]|1[0-2])\/\d{2}$').hasMatch(value)) {
    return "";
  }
  final parts = value.split("/");
  int month = int.parse(parts[0]);
  int year = 2000 + int.parse(parts[1]);
  DateTime expiryDate = DateTime(year, month + 1, 0);
  if (expiryDate.isBefore(DateTime.now())) {
    return "";
  }
  return null;
}

class ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text;

    if (text.length > 2 && !text.contains('/')) {
      text = '${text.substring(0, 2)}/${text.substring(2)}';
    }

    if (text.length > 5) {
      text = text.substring(0, 5);
    }

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Remove existing spaces
    String text = newValue.text.replaceAll(' ', '');

    // Maximum 16 digits
    if (text.length > 16) {
      text = text.substring(0, 16);
    }

    // Add a space after every 4 digits
    String formatted = '';
    for (int i = 0; i < text.length; i++) {
      if (i > 0 && i % 4 == 0) {
        formatted += ' ';
      }
      formatted += text[i];
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
