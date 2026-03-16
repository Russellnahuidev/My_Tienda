enum NotificationsType { order, delivery, promo, payment }

class NotificationItem {
  final String title;
  final String message;
  final String time;
  final NotificationsType type;
  final bool isRead;

  const NotificationItem({
    required this.title,
    required this.message,
    required this.time,
    required this.type,
    this.isRead = false,
  });
}
