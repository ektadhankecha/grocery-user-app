import 'package:grocery_app/model/notification_model.dart';

List<NotificationModel> notificationData = [
  NotificationModel(
    title: "Allow Notifications",
    description:
        "Receive important updates, alerts, and announcements from the app.",
    isEnable: true,
  ),
  NotificationModel(
    title: "Email Notifications",
    description:
        "Get order updates, promotions, and important information sent to your email.",
    isEnable: false,
  ),
  NotificationModel(
    title: "Order Notifications",
    description:
        "Stay informed about your order status, shipping updates, and delivery progress.",
    isEnable: false,
  ),
  NotificationModel(
    title: "General Notifications",
    description:
        "Receive app news, feature updates, personalized recommendations, and special offers.",
    isEnable: true,
  ),
];
