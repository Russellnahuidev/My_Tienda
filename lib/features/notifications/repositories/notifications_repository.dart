import 'package:my_tienda/features/notifications/models/notifications_type.dart';

class NotificationsRepository {
  List<NotificationItem> getNotificcations() {
    return [
      NotificationItem(
        title: 'Order Confirmed',
        message:
            'Your order #123456 has been confirmed and is beign processed.',
        time: '2 minutes ago',
        type: NotificationsType.order,
        isRead: true,
      ),
      NotificationItem(
        title: 'Special Offer!',
        message: 'Get 20% off an shoes this weekend!',
        time: '1 hour ago',
        type: NotificationsType.promo,
      ),
      NotificationItem(
        title: 'Order Confirmed',
        message: 'Your order #987654 is out for delivery.',
        time: '3 hours ago',
        type: NotificationsType.delivery,
        isRead: true,
      ),
      NotificationItem(
        title: 'Payment Successful',
        message: 'Payment for order #456321 was successful',
        time: '2 minutes ago',
        type: NotificationsType.payment,
        isRead: true,
      ),
    ];
  }
}
