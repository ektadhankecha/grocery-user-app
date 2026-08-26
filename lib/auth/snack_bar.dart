import 'package:flutter/material.dart';
import 'package:grocery_app/utils/app_colors.dart';

void showTopSnackBar(
  BuildContext context, {
  required String message,
  required IconData preIcon,
  Color backgroundColor = MyColor.gradientGreen,
  Duration duration = const Duration(seconds: 2),
}) {
  late OverlayEntry overlayEntry;

  final animationController = AnimationController(
    vsync: Navigator.of(context),
    duration: const Duration(milliseconds: 350),
  );

  final animation = Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero)
      .animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut),
      );

  overlayEntry = OverlayEntry(
    builder: (context) => SafeArea(
      child: Material(
        color: Colors.transparent,
        child: Align(
          alignment: Alignment.topCenter,
          child: SlideTransition(
            position: animation,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(preIcon, color: Colors.white),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      message,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );

  Overlay.of(context).insert(overlayEntry);

  animationController.forward();

  Future.delayed(duration, () async {
    await animationController.reverse();
    overlayEntry.remove();
    animationController.dispose();
  });
}
