import 'package:flutter/material.dart';
import 'package:my_tienda/utils/app_textstyles.dart';

class ContactSupportSection extends StatelessWidget {
  const ContactSupportSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(
            Icons.headset_mic_outlined,
            color: Theme.of(context).primaryColor,
            size: 48,
          ),
          SizedBox(height: 16),
          Text(
            'Still need help?',
            style: AppTextStyles.withColor(
              AppTextStyles.h3,
              Theme.of(context).textTheme.bodyLarge!.color!,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Contact ur support team',
            style: AppTextStyles.withColor(
              AppTextStyles.bodyMedium,
              isDark ? Colors.grey[400]! : Colors.grey[600]!,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(12),
              ),
            ),
            child: Text(
              'Contact Support',
              style: AppTextStyles.withColor(
                AppTextStyles.buttonMedium,
                Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
