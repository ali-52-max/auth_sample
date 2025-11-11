import 'package:auth_sample/core/constants/app_values.dart';
import 'package:auth_sample/features/auth/presentation/widgets/scaffold_body.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/responsive_util.dart';
import 'language_menu_button.dart';

class AuthTemplate extends StatelessWidget {
  final ResponsiveUtil r;
  final String headerText;
  final List<Widget> authBodySection;

  const AuthTemplate({
    super.key,
    required this.r,
    required this.authBodySection,
    required this.headerText,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: ScaffoldBody(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: AppStyles.physicsBouncing,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        // Header section
                        Padding(
                          padding: r.pad(
                            horizontal: 25,
                            vertical: AppDimens.spacingExtraLarge,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                headerText,
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: r.font(AppDimens.fontHeader),
                                  fontWeight: AppStyles.fontWeightSemiBold,
                                ),
                              ),
                              LanguageMenuButton(r: r),
                            ],
                          ),
                        ),

                        // Body section
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            padding: r.padOnly(
                              left: AppDimens.horizontalPadding,
                              right: AppDimens.horizontalPadding,
                              top: AppDimens.spacingExtraLarge,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.backgroundGrey,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(
                                  r.r(AppDimens.containerRadius),
                                ),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: authBodySection,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
