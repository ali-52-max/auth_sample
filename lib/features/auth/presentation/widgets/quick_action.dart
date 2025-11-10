import 'package:auth_sample/core/constants/app_values.dart';
import 'package:flutter/material.dart';
import 'package:auth_sample/core/utils/responsive_util.dart';

class QuickAction extends StatelessWidget {
  final String text;
  final String action;
  final VoidCallback onTap;
  final ResponsiveUtil r;

  const QuickAction({
    required this.text,
    required this.action,
    required this.onTap,
    required this.r,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: r.padOnly(bottom: AppDimens.spacingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              text,
              style: TextStyle(
                color: AppColors.grey500,
                fontSize: r.font(AppDimens.fontMedium),
              ),
            ),
            GestureDetector(
              onTap: onTap,
              child: Text(
                action,
                style: TextStyle(
                  color: AppColors.darkText,
                  fontWeight: AppStyles.fontWeightBold,
                  fontSize: r.font(AppDimens.fontLarge),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
