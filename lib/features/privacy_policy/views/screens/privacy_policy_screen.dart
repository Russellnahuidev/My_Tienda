import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_tienda/features/privacy_policy/views/widgets/info_section.dart';
import 'package:my_tienda/utils/app_textstyles.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
          'Privacy Policy',
          style: AppTextStyles.withColor(
            AppTextStyles.h3,
            isDark ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(screenSize.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InfoSection(
                title: 'Information We Collect',
                content:
                    'We collecct that you provide directly to us, including name, email address, and shipping information.',
              ),
              InfoSection(
                title: 'How we Use Your Information',
                content:
                    'We use the information  we collect to provide, maintain, and improve oour servicec, proces your transactions, and send you updates.',
              ),
              InfoSection(
                title: 'Information Sharing',
                content:
                    'We collecct that you provide directly to us, including name, email address, and shipping information.',
              ),
              InfoSection(
                title: 'Data segurity',
                content:
                    'We collecct that you provide directly to us, including name, email address, and shipping information.',
              ),
              InfoSection(
                title: 'Your Rights',
                content:
                    'We collecct that you provide directly to us, including name, email address, and shipping information.',
              ),
              InfoSection(
                title: 'Ccookies Policy',
                content:
                    'We collecct that you provide directly to us, including name, email address, and shipping information.',
              ),
              SizedBox(height: 24),
              Text(
                'Last Updated: March 2025',
                style: AppTextStyles.withColor(
                  AppTextStyles.bodySmall,
                  isDark ? Colors.grey[400]! : Colors.grey[600]!,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
