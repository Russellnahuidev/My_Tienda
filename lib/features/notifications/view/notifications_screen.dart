import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_tienda/features/notifications/models/notifications_type.dart';
import 'package:my_tienda/features/notifications/repositories/notifications_repository.dart';
import 'package:my_tienda/features/notifications/utils/notifications_utils.dart';
import 'package:my_tienda/utils/app_textstyles.dart';

class NotificationsScreen extends StatelessWidget {
  final NotificationsRepository _repository = NotificationsRepository();
  NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final notifications = _repository.getNotificcations();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        title: Text(
          'Settings',
          style: AppTextStyles.withColor(
            AppTextStyles.h3,
            isDark ? Colors.white : Colors.black,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Mark all as read',
              style: AppTextStyles.withColor(
                AppTextStyles.bodyMedium,
                Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (context, index) =>
            _buildNotificationCard(context, notifications[index]),
      ),
    );
  }
}

Widget _buildNotificationCard(
  BuildContext context,
  NotificationItem notification,
) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  return Container(
    margin: EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      color: notification.isRead
          ? Theme.of(context).cardColor
          : Theme.of(context).primaryColor.withOpacity(0.1),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: isDark
              ? Colors.black.withOpacity(0.2)
              : Colors.grey.withOpacity(0.1),
        ),
      ],
    ),
    child: ListTile(
      contentPadding: EdgeInsets.all(16),
      leading: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: NotificationsUtils.getIconBackgroundColor(
            context,
            notification.type,
          ),
          shape: BoxShape.circle,
        ),
        child: Icon(
          NotificationsUtils.getNotificationIcon(notification.type),
          color: NotificationsUtils.getIconColor(context, notification.type),
        ),
      ),
      title: Text(
        notification.title,
        style: AppTextStyles.withColor(
          AppTextStyles.bodyLarge,
          Theme.of(context).textTheme.bodyLarge!.color!,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 4),
          Text(
            notification.message,
            style: AppTextStyles.withColor(
              AppTextStyles.bodySmall,
              isDark ? Colors.grey[400]! : Colors.grey[600]!,
            ),
          ),
        ],
      ),
    ),
  );
}
