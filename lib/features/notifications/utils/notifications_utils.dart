import 'package:flutter/material.dart';
import 'package:my_tienda/features/notifications/models/notifications_type.dart';

class NotificationsUtils {
  static IconData getNotificationIcon(NotificationsType type) {
    switch (type) {
      case NotificationsType.order:
        return Icons.shopping_bag_outlined;
      case NotificationsType.delivery:
        return Icons.local_shipping_outlined;
      case NotificationsType.promo:
        return Icons.local_offer_outlined;
      case NotificationsType.payment:
        return Icons.payment_outlined;
    }
  }

  static Color getIconBackgroundColor(
    BuildContext context,
    NotificationsType type,
  ) {
    switch (type) {
      case NotificationsType.order:
        return Theme.of(context).primaryColor.withOpacity(0.1);
      case NotificationsType.delivery:
        return Colors.green[100]!;
      case NotificationsType.promo:
        return Colors.orange[100]!;
      case NotificationsType.payment:
        return Colors.red[100]!;
    }
  }

  static Color getIconColor(BuildContext context, NotificationsType type) {
    switch (type) {
      case NotificationsType.order:
        return Theme.of(context).primaryColor;
      case NotificationsType.delivery:
        return Colors.green;
      case NotificationsType.promo:
        return Colors.orange;
      case NotificationsType.payment:
        return Colors.red;
    }
  }
}
