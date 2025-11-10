import 'package:auth_sample/core/constants/app_values.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/utils/responsive_util.dart';

class CustomInputField extends StatelessWidget {
  final String label;
  final bool isPassword;
  final IconData? icon;
  final VoidCallback? onIconTap;
  final ResponsiveUtil r;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String? errorText;

  const CustomInputField({
    required this.label,
    required this.isPassword,
    this.icon,
    this.onIconTap,
    required this.r,
    this.controller,
    this.onChanged,
    this.errorText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      obscureText: isPassword,
      style: TextStyle(
        color: AppColors.grey,
        fontSize: r.font(AppDimens.fontLarge),
      ),
      decoration: InputDecoration(
        labelText: label,
        suffix: icon != null
            ? GestureDetector(
                onTap: onIconTap,
                child: FaIcon(
                  icon,
                  color: _getIconColor(),
                  size: r.ui(AppDimens.iconSmall),
                ),
              )
            : null,
        labelStyle: TextStyle(
          color: AppColors.primary,
          fontSize: r.font(AppDimens.fontLarge),
          fontWeight: AppStyles.fontWeightSemiBold,
        ),
        floatingLabelStyle: TextStyle(
          color: AppColors.primary,
          fontSize: r.font(AppDimens.fontExtraLarge),
          fontWeight: AppStyles.fontWeightBold,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: errorText != null ? AppColors.error : AppColors.grey400,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: errorText != null ? AppColors.error : AppColors.grey400,
            width: AppDimens.borderWidthThin,
          ),
        ),
        errorText: errorText,
        errorStyle: TextStyle(
          color: AppColors.error,
          fontSize: r.font(AppDimens.fontSmall),
          fontWeight: AppStyles.fontWeightMedium,
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.error,
            width: AppDimens.borderWidthThin,
          ),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.error,
            width: AppDimens.borderWidthThick,
          ),
        ),
      ),
    );
  }

  Color _getIconColor() {
    if (errorText != null) {
      return AppColors.error;
    }
    return AppColors.grey;
  }
}
