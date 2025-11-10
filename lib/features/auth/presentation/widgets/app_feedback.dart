import 'package:flutter/material.dart';
import 'package:auth_sample/core/constants/app_values.dart';
import 'package:auth_sample/core/localization/app_localization.dart';
import 'package:auth_sample/core/utils/responsive_util.dart';

void showErrorSnack(
  BuildContext context, {
  String? failureKey,
  String? message,
}) {
  final responsive = ResponsiveUtil(context);
  final errorText = failureKey != null
      ? AppLocalization.of(context)!.translate(failureKey)
      : message ?? 'An unknown error occurred';

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: AppColors.white,
            size: responsive.ui(20),
          ),
          SizedBox(width: responsive.w(12)),
          Expanded(
            child: Text(
              errorText,
              style: TextStyle(
                color: AppColors.white,
                fontSize: responsive.font(16),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.primary,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(responsive.ui(10)),
      ),
      margin: EdgeInsets.all(responsive.ui(16)),
    ),
  );
}

void showSuccessSnack(BuildContext context, {required String message}) {
  final responsive = ResponsiveUtil(context);

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Icon(
            Icons.check_circle_outline,
            color: AppColors.white,
            size: responsive.ui(20),
          ),
          SizedBox(width: responsive.w(12)),
          Expanded(
            child: Text(
              AppLocalization.of(context)!.translate(message),
              style: TextStyle(
                color: AppColors.white,
                fontSize: responsive.font(16),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.green.shade600,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(responsive.ui(10)),
      ),
      margin: EdgeInsets.all(responsive.ui(16)),
    ),
  );
}
