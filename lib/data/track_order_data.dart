import "package:grocery_app/model/track_order_model.dart";
import "package:grocery_app/utils/app_icons.dart";

List<TrackOrderModel> trackOrderList = [
  TrackOrderModel(
    icon: MyIcon.box2,
    title: "Order Placed",
    date: "October 21 2021",
    isCompleted: true,
  ),
  TrackOrderModel(
    icon: MyIcon.checkCircle,
    title: "Order Confirmed",
    date: "October 21 2021",
    isCompleted: true,
  ),
  TrackOrderModel(
    icon: MyIcon.location,
    title: "Order Shipped",
    date: "October 21 2021",
    isCompleted: true,
  ),
  TrackOrderModel(
    icon: MyIcon.delivery_truck,
    title: "Out for Delivery",
    date: "Pending",
    isCompleted: false,
  ),
  TrackOrderModel(
    icon: MyIcon.shoppingBag,
    title: "Order Delivered",
    date: "Pending",
    isCompleted: false,
  ),
];
