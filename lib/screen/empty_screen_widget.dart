import 'package:flutter/material.dart';
import 'package:grocery_app/utils/app_colors.dart';

class EmptyScreenWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String? buttonText;
  final VoidCallback? onButtonPressed;
  const EmptyScreenWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.buttonText,
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: MyColor.bg3,
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: MyColor.vegiGreen,
                radius: 90,
                child: Icon(icon, size: 100, color: MyColor.animationGreen),
              ),

              SizedBox(height: 20),
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: MyColor.textGraey,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              if (buttonText != null) ...[
                const SizedBox(height: 20),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: MyColor.bg1,
                    backgroundColor: MyColor.animationGreen,
                    shadowColor: MyColor.animationGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(20),
                    ),
                  ),
                  onPressed: onButtonPressed,
                  child: Text(buttonText!),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
