import 'package:grocery_app/utils/app_icons.dart';
import 'package:grocery_app/model/profile_model.dart';

List<ProfileModel> profileData = [
  const ProfileModel(
    id: "about",
    icon: MyIcon.profileCircle,
    title: "About me",
  ),

  const ProfileModel(id: "order", icon: MyIcon.box, title: "My Orders"),
  const ProfileModel(
    id: "fav",
    icon: MyIcon.favoriteBorderSimple,
    title: "My Favorites",
  ),
  const ProfileModel(id: "add", icon: MyIcon.location, title: "My Address"),
  const ProfileModel(
    id: "cards",
    icon: MyIcon.creditCard,
    title: "Credit Cards",
  ),
  const ProfileModel(
    id: "transaction",
    icon: MyIcon.wallet,
    title: "Transactions",
  ),
  const ProfileModel(
    id: "notification",
    icon: MyIcon.notifications,
    title: "Notification",
  ),
  const ProfileModel(id: "logout", icon: MyIcon.logout, title: "Sign Out"),
];
