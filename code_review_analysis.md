# Flutter UI Code Review & Reliability Analysis (Updated Status)

* **Target Project:** `grocery_app`
* **Target Role:** Junior Flutter Developer (UI-focused)
* **Review Date:** 2026-07-31

---

## Congratulations!
You have successfully fixed the vast majority of critical logical typos, navigation stack leaks, spelling mistakes, and visual mismatches yourself! Your code is now significantly cleaner and much closer to a production-ready UI layout.

Here is the updated list of the remaining minor issues you should address to finish up your task.

---

## Remaining Issues to Fix

### 1. Verify Number Labels & ReadOnly Field
* **File:** [verify_number.dart](file:///c:/Users/pc/AndroidStudioProjects/grocery_app/lib/auth/verify_number.dart#L60-L85)
* **Remaining Typos:**
  - The subtitle on line 62 still says: `"Enter the verification code sent to your email."` (Change to `"phone number"` or `"mobile number"`).
  - The telephone text input on line 79 has `readOnly: true`, which means the user cannot edit the prefilled phone number if there is a mistake. Remove `readOnly: true` or make it editable.

### 2. Duplicated "Items: " Labels in Order Screen
* **File:** [order_screen.dart](file:///c:/Users/pc/AndroidStudioProjects/grocery_app/lib/screen/order_screen.dart#L161)
* **Remaining Typo:**
  - In lines 161, 300, and 429, the RichText label next to the total price still says:
    ```dart
    text: "Items: "
    ```
  - **Result:** This prints `"Items: 10  Items: $16.90"`. The second label should be changed to `"Total: "` or `"Price: "`.

### 3. Mixed Products in Vegetable Screen
* **File:** [featured_product_title.dart](file:///c:/Users/pc/AndroidStudioProjects/grocery_app/lib/widget/home/featured_product_title.dart#L42-L43)
* **Remaining Design Issue:**
  - Clicking the arrow next to "Featured products" on line 42 still passes the unfiltered `products` list (which includes fruits like peaches and pineapples) to the `VegetableScreen`.
  - **Fix:** Filter the array (e.g. `products.where((p) => p.name.contains("Broccoli") || p.quantity.contains("kg")).toList()`) before passing it.

### 4. Static "Add to Cart" on Card
* **File:** [product_card.dart](file:///c:/Users/pc/AndroidStudioProjects/grocery_app/lib/widget/home/product_card.dart#L166-L188)
* **Remaining Design Issue:**
  - The "Add to cart" row on line 166 has no `GestureDetector` or `InkWell` wrapped around it. Clicking it opens the details page instead of directly adding the item to the cart.
  - **Fix:** Wrap the row in an `InkWell` or `GestureDetector` to call your add-to-cart logic.

### 5. Hardcoded Names on Profile & Side Drawer
* **Files:** [profile_screen.dart](file:///c:/Users/pc/AndroidStudioProjects/grocery_app/lib/screen/profile_screen.dart#L54) and [custom_drawer.dart](file:///c:/Users/pc/AndroidStudioProjects/grocery_app/lib/widget/home/custom_drawer.dart#L58)
* **Remaining Visual Sync Issue:**
  - The Profile screen name is hardcoded as `"Olivia Austin"` and custom drawer is hardcoded as `"Olivia Austin"`. However, editing details in the "About Me" screen defaults to `"Russell Austin"`. 
  - **Fix:** Declare global string variables in `lib/data/profile_data.dart` (such as `String currentUserName = "Russell Austin";`) and use them in all three screens to keep them in sync.

### 6. Password Recovery to Phone Verification Disconnect
* **File:** [forget_password.dart](file:///c:/Users/pc/AndroidStudioProjects/grocery_app/lib/auth/forget_password.dart#L115)
* **Logical UX Bug:**
  - Tapping "Send Link" after entering an email on the `ForgetPassword` screen navigates to `VerifyNumber`, which displays a prefilled telephone number input rather than verifying the email.
  - **Fix:** Redirect to a verification page matching the recovery method (email-focused).

### 7. Potential Layout Overflow in Search Screen
* **File:** [search_screen.dart](file:///c:/Users/pc/AndroidStudioProjects/grocery_app/lib/screen/search_screen.dart#L61)
* **Layout Safety Bug:**
  - The search screen body uses a standard `Column` to render search history and discover items. If the search history wrap list grows too large, the screen will throw a layout height overflow exception.
  - **Fix:** Wrap the `Column` inside a `SingleChildScrollView` to make it scrollable.

### 8. Static Carousel Dots Count
* **File:** [banner_widget.dart](file:///c:/Users/pc/AndroidStudioProjects/grocery_app/lib/widget/home/banner_widget.dart#L110-L111)
* **Correctness Bug:**
  - The banner dots generation has a hardcoded length of `3` (`List.generate(3, ...)`). If the size of the `banners` list changes, it will show the wrong number of dots.
  - **Fix:** Replace `3` with `banners.length`.

---

## Remaining Warnings & Lints

1. **Deprecated Switch parameters (`activeColor`):**
   - Replace with `activeThumbColor` in standard Switch components.
2. **Deprecated Opacity (`withOpacity`):**
   - Replace with `color.withValues(alpha: 0.5)` in `bottom_navigation_widget.dart`.
3. **Production Prints:**
   - Clean up `print("pressed")` in `about_me_screen.dart`.
