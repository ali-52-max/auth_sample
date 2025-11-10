import 'package:auth_sample/core/constants/app_values.dart';
import 'package:auth_sample/core/localization/app_localization.dart';
import 'package:auth_sample/core/utils/responsive_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CommonSocialFooter extends StatelessWidget {
  final ResponsiveUtil r;
  const CommonSocialFooter({super.key, required this.r});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          AppLocalization.of(context)!.loginWithSocialMedia,
          style: TextStyle(
            color: AppColors.white,
            fontSize: r.font(AppDimens.socialMediaFontSize),
          ),
        ),
        SizedBox(height: r.h(AppDimens.socialTextSpacing)),
        _SocialMediaRow(r: r),
      ],
    );
  }
}

class _SocialMediaRow extends StatelessWidget {
  final ResponsiveUtil r;
  const _SocialMediaRow({required this.r});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _SocialIcon(AppIcons.instagram, r: r),
        _SocialIcon(AppIcons.twitter, r: r),
        _SocialIcon(AppIcons.facebook, r: r),
      ],
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final ResponsiveUtil r;
  const _SocialIcon(this.icon, {required this.r});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: r.pad(horizontal: AppDimens.socialIconPadding),
      child: FaIcon(
        icon,
        color: AppColors.white,
        size: r.ui(AppDimens.socialIconSize),
      ),
    );
  }
}
