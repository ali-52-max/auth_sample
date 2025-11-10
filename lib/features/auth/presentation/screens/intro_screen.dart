import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:auth_sample/features/auth/presentation/widgets/scaffold_body.dart';
import 'package:auth_sample/core/utils/responsive_util.dart';
import 'package:auth_sample/core/router/app_router.dart';
import 'package:auth_sample/core/localization/app_localization.dart';
import 'package:auth_sample/features/auth/presentation/widgets/custom_button.dart';
import 'package:auth_sample/core/constants/app_values.dart';
import 'package:auth_sample/features/auth/presentation/widgets/language_menu_button.dart';
import 'package:auth_sample/features/auth/presentation/widgets/common_social_footer.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final r = ResponsiveUtil(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ScaffoldBody(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              physics: AppStyles.physicsBouncing,
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: r.pad(
                      horizontal: AppDimens.horizontalPadding,
                      vertical: AppDimens.verticalPadding,
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: LanguageMenuButton(r: r),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _LogoSection(r: r),
                              _AuthButtonsSection(r: r),
                            ],
                          ),
                        ),
                        CommonSocialFooter(r: r),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LogoSection extends StatelessWidget {
  final ResponsiveUtil r;
  const _LogoSection({required this.r});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FaIcon(
          AppIcons.dumbbell,
          color: AppColors.white,
          size: r.ui(AppDimens.logoIconSize),
        ),
        SizedBox(height: r.h(AppDimens.logoTextSpacing)),
        Text(
          AppLocalization.of(context)!.fitnessClub,
          style: TextStyle(
            fontSize: r.font(AppDimens.fitnessClubFontSize),
            fontWeight: AppStyles.fontWeightRegular,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }
}

class _AuthButtonsSection extends StatelessWidget {
  final ResponsiveUtil r;
  const _AuthButtonsSection({required this.r});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          AppLocalization.of(context)!.welcomeBack,
          style: TextStyle(
            color: AppColors.white,
            fontSize: r.font(AppDimens.fontDisplay),
            fontWeight: AppStyles.fontWeightMedium,
          ),
        ),
        SizedBox(height: r.h(AppDimens.authButtonsSpacing)),
        CustomButton(
          type: ButtonStyleType.intro,
          label: AppLocalization.of(context)!.signIn,
          backgroundColor: AppColors.transparent,
          textColor: AppColors.white,
          overlayColor: AppColors.white10,
          onPressed: () => Navigator.pushNamed(context, AppRouter.login),
          responsive: r,
        ),
        SizedBox(height: r.h(AppDimens.buttonSpacing)),
        CustomButton(
          type: ButtonStyleType.intro,
          label: AppLocalization.of(context)!.signUp,
          backgroundColor: AppColors.white,
          textColor: AppColors.black,
          onPressed: () => Navigator.pushNamed(context, AppRouter.register),
          responsive: r,
        ),
      ],
    );
  }
}
