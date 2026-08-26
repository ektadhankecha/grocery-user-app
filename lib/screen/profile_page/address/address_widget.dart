import 'package:flutter/material.dart';
import 'package:grocery_app/model/address_model.dart';
import 'package:grocery_app/utils/app_icons.dart';
import 'package:grocery_app/utils/app_colors.dart';

class AddressWidget extends StatefulWidget {
  final AddressModel address;
  const AddressWidget({super.key, required this.address});

  @override
  State<AddressWidget> createState() => _AddressWidgetState();
}

class _AddressWidgetState extends State<AddressWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(25),
          child: Row(
            children: [
              CircleAvatar(
                radius: 35,
                backgroundColor: MyColor.locationgreen,
                foregroundColor: MyColor.animationGreen,
                child: Icon(MyIcon.location, size: 35),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.address.name,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 1),
                    Text(
                      widget.address.address,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                        color: MyColor.textGraey,
                      ),
                    ),
                    Text(
                      "${widget.address.city}, ${widget.address.country}, ${widget.address.zipCode}",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                        color: MyColor.textGraey,
                      ),
                    ),
                    SizedBox(height: 1),
                    Text(
                      widget.address.phone,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
