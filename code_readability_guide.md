# Flutter Code Readability & Cleanup - Status Report

* **Target Project:** `grocery_app`
* **Target Role:** Junior Flutter Developer (UI-focused)
* **Review Date:** 2026-07-31

This report shows the current status of code readability improvements.

---

## 1. Completed Tasks (Done)

### [DONE] Task 1: Set Font Family Globally in `ThemeData`
* **Change:** Added `fontFamily: 'poppins'` in [main.dart](file:///c:/Users/pc/AndroidStudioProjects/grocery_app/lib/main.dart)'s `ThemeData`.
* **Cleanup:** Removed **187** redundant `fontFamily: 'poppins'` parameter references across 30 Dart files.

### [DONE] Task 6: Remove Unused Imports & Dead Code Comments
* **Action:** Ran global Dart cleanup to automatically optimize imports, resolve duplicate imports, remove unnecessary final keywords, and delete the unused `_timer` field inside [otp_screen.dart](file:///c:/Users/pc/AndroidStudioProjects/grocery_app/lib/auth/otp_screen.dart) and `//int cart = 1;` in [cart_screen.dart](file:///c:/Users/pc/AndroidStudioProjects/grocery_app/lib/screen/cart_screen.dart).
* **Extra:** Resolved unnecessary `Container` wrapping a `Column` inside [card_widget.dart](file:///c:/Users/pc/AndroidStudioProjects/grocery_app/lib/widget/card_widget.dart), and resolved multiple deprecated API warnings (e.g. `activeColor`, `withOpacity`).

---

## 2. Pending Tasks (TODO)

### [PENDING] Task 2: Deconstruct Large Widget Trees (Extract Sub-widgets)
* **Action:** Extract individual card components (like the items inside `ListView.builder` in [cart_screen.dart](file:///c:/Users/pc/AndroidStudioProjects/grocery_app/lib/screen/cart_screen.dart) and [product_detail_screen.dart](file:///c:/Users/pc/AndroidStudioProjects/grocery_app/lib/screen/product_detail_screen.dart)) into independent widgets.

### [PENDING] Task 3: Fix Dart Variables and Model Properties Casing
* **Action:** Rename non-camelCase variables/properties (e.g., `Title` in [banner_model.dart](file:///c:/Users/pc/AndroidStudioProjects/grocery_app/lib/model/banner_model.dart) $\rightarrow$ `title`, `profiledata` $\rightarrow$ `profileData`, `notification_data` $\rightarrow$ `notificationData`).

### [PENDING] Task 4: Clean Up Color Names and Spellings in `app_colors.dart`
* **Action:** Rename inconsistent color constants in [app_colors.dart](file:///c:/Users/pc/AndroidStudioProjects/grocery_app/lib/utils/app_colors.dart) (e.g., `textGraey` $\rightarrow$ `textGrey`, `BeveYellow` $\rightarrow$ `beverageYellow`).

### [PENDING] Task 5: Use Trailing Commas for Auto-Formatting
* **Action:** Put trailing commas `,` at the end of nested widget parameters for cleaner vertical formatting.
