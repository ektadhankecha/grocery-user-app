import 'package:flutter/material.dart';
import 'package:grocery_app/model/card_model.dart';
import 'package:grocery_app/utils/app_icons.dart';
import 'package:grocery_app/utils/app_colors.dart';

class CardWidget extends StatefulWidget {
  final CardModel card;

  const CardWidget({super.key, required this.card});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  bool isExpanded = false;
  bool saveThis = true;

  @override
  Widget build(BuildContext context) {
    final bool isWide = MediaQuery.of(context).size.width > 600;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(25),
          child: Row(
            children: [
              CircleAvatar(
                radius: 35,
                backgroundColor: MyColor.bggray,
                // foregroundColor: MyColor.animationGreen,
                child: Image.asset(
                  "assets/images/cardicon.png",
                  height: 22,
                  width: 39,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.card.name,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 1),
                    Text(
                      widget.card.cardNumber,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                        color: MyColor.textGraey,
                      ),
                    ),
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Expiry: ",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: widget.card.date,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 35),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "CVV: ",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: widget.card.cvv,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Spacer(),
              IconButton(
                onPressed: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                icon: Icon(
                  isExpanded
                      ? MyIcon.arrowUpDownCircle
                      : MyIcon.arrowDropDownCircle,
                  color: MyColor.animationGreen,
                ),
              ),
            ],
          ),
        ),
        if (isExpanded) ...[
          Divider(height: 0, thickness: 2, color:  isWide ? MyColor.bg1 : MyColor.bg3,),
          Container(
            margin: EdgeInsets.only(top: 12),
            padding: EdgeInsets.all(16),
            color: isWide ? MyColor.bg3 : MyColor.bg1,

            child: Column(
              children: [
                TextFormField(
                  initialValue: widget.card.name,
                  readOnly: true,
                  style: TextStyle(
                    color: MyColor.lightGray,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    fillColor:  isWide ? MyColor.bg1 : MyColor.bg3,
                    prefixIcon: Icon(
                      MyIcon.profileCircle,
                      size: 24,
                      color: MyColor.lightGray,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                TextFormField(
                  cursorColor: Colors.black,
                  enableInteractiveSelection: true,
                  initialValue: widget.card.cardNumber,
                  readOnly: true,
                  style: TextStyle(
                    color: MyColor.lightGray,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    fillColor:  isWide ? MyColor.bg1 : MyColor.bg3,
                    prefixIcon: Icon(
                      MyIcon.cardbox,
                      size: 24,
                      color: MyColor.lightGray,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        cursorColor: Colors.black,
                        enableInteractiveSelection: true,
                        initialValue: widget.card.date,
                        readOnly: true,
                        style: TextStyle(
                          color: MyColor.lightGray,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          fillColor: isWide ? MyColor.bg1 : MyColor.bg3,
                          prefixIcon: Icon(
                            MyIcon.calender,
                            size: 24,
                            color: MyColor.lightGray,
                          ),
                          hintText: "MM/YY",
                          counterText: '',
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: TextFormField(
                        cursorColor: Colors.black,
                        enableInteractiveSelection: true,
                        initialValue: widget.card.cvv,
                        readOnly: true,
                        style: TextStyle(
                          color: MyColor.lightGray,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          fillColor:  isWide ? MyColor.bg1 : MyColor.bg3,
                          prefixIcon: Icon(
                            MyIcon.lock,
                            size: 24,
                            color: MyColor.lightGray,
                          ),
                        ),
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
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                    //  SizedBox(width: 1,),
                    Text(
                      "Make Default",
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
        ],
      ],
    );
  }
}
