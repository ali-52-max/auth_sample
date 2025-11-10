import 'package:auth_sample/core/constants/app_values.dart';
import 'package:flutter/material.dart';
import 'package:auth_sample/core/utils/responsive_util.dart';

enum ButtonStyleType { intro, auth }

class CustomButton extends StatelessWidget {
  final String label;
  final Color? backgroundColor;
  final Color textColor;
  final Color? overlayColor;
  final VoidCallback? onPressed;
  final ResponsiveUtil responsive;
  final ButtonStyleType type;
  final bool isLoading;

  const CustomButton({
    required this.label,
    this.backgroundColor,
    required this.textColor,
    required this.onPressed,
    required this.responsive,
    this.overlayColor,
    required this.type,
    this.isLoading = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final buttonStyle = switch (type) {
      ButtonStyleType.intro => ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        overlayColor: overlayColor ?? AppColors.white10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            responsive.r(AppDimens.extraLargeRadius),
          ),
          side: const BorderSide(color: AppColors.white),
        ),
        shadowColor: AppColors.transparent,
        surfaceTintColor: AppColors.transparent,
        elevation: 0,
      ),
      ButtonStyleType.auth => ElevatedButton.styleFrom(
        backgroundColor: AppColors.transparent,
        surfaceTintColor: AppColors.transparent,
        shadowColor: AppColors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            responsive.r(AppDimens.extraLargeRadius),
          ),
        ),
      ),
    };

    final buttonChild = isLoading
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: responsive.font(AppDimens.loaderSize),
                height: responsive.font(AppDimens.loaderSize),
                child: CircularProgressIndicator(
                  strokeWidth: AppDimens.loaderThickness,
                  valueColor: AlwaysStoppedAnimation<Color>(textColor),
                ),
              ),
              SizedBox(width: responsive.w(10)),
              Text(
                label,
                style: TextStyle(
                  fontSize: responsive.font(AppDimens.fontExtraLarge),
                  fontWeight: AppStyles.fontWeightBold,
                  color: textColor,
                ),
              ),
            ],
          )
        : Text(
            label,
            style: TextStyle(
              fontSize: responsive.font(AppDimens.fontExtraLarge),
              fontWeight: AppStyles.fontWeightBold,
              color: textColor,
            ),
          );

    final button = ElevatedButton(
      style: buttonStyle,
      onPressed: isLoading ? null : onPressed,
      child: buttonChild,
    );

    return SizedBox(
      height: responsive.h(AppDimens.buttonHeight),
      width: responsive.w(AppDimens.buttonWidth),
      child: type == ButtonStyleType.auth
          ? Container(
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(
                  responsive.r(AppDimens.extraLargeRadius),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.gradientEnd.withValues(alpha: 0.3),
                    blurRadius: 4.0,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: button,
            )
          : button,
    );
  }
}
