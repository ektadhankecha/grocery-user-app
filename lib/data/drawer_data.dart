import 'package:grocery_app/utils/app_icons.dart';
import 'package:grocery_app/model/drawer_model.dart';

List<DrawerModel> drawer = [
  const DrawerModel(id: "home", name: "Home", icon: MyIcon.home),
  const DrawerModel(id: 'profile', name: "Profile", icon: MyIcon.profileCircle),
  const DrawerModel(id: "like", name: "Favorite", icon: MyIcon.favoriteBorder),
  const DrawerModel(id: "cart", name: "Cart", icon: MyIcon.shoppingBag),
];
