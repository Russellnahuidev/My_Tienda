import 'package:flutter/material.dart';
import 'package:my_tienda/utils/app_textstyles.dart';

class InfoSection extends StatelessWidget {
  final String title;
  final String content;
  const InfoSection({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.only(bottom: 24),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.2)
                : Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.withColor(
              AppTextStyles.h3,
              Theme.of(context).textTheme.bodyLarge!.color!,
            ),
          ),
          SizedBox(height: 12),
          Text(
            content,
            style: AppTextStyles.withColor(
              AppTextStyles.bodyMedium,
              isDark ? Colors.grey[300]! : Colors.grey[700]!,
            ),
          ),
        ],
      ),
    );
  }
}
