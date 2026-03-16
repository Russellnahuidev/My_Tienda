import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_tienda/features/help_center/widgets/contact_support_section.dart';
import 'package:my_tienda/features/help_center/widgets/help_categories_section.dart';
import 'package:my_tienda/features/help_center/widgets/popular_question_section.dart';
import 'package:my_tienda/utils/app_textstyles.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          'Help center',
          style: AppTextStyles.withColor(
            AppTextStyles.h3,
            isDark ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSearchBar(context, isDark),
            SizedBox(height: 24),
            PopularQuestionSection(),
            SizedBox(height: 24),
            HelpCategoriesSection(),
            SizedBox(height: 24),
            ContactSupportSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context, bool isDark) {
    return Container(
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
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
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search for help',
          helperStyle: AppTextStyles.withColor(
            AppTextStyles.bodyMedium,
            isDark ? Colors.grey[400]! : Colors.grey[600]!,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: isDark ? Colors.grey[400] : Colors.grey[600],
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Theme.of(context).cardColor,
        ),
      ),
    );
  }
}
