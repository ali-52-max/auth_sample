import 'package:auth_sample/core/constants/app_values.dart';
import 'package:auth_sample/features/auth/presentation/widgets/language_menu_button.dart';
import 'package:auth_sample/features/auth/presentation/widgets/common_social_footer.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:auth_sample/features/auth/presentation/widgets/scaffold_body.dart';
import 'package:auth_sample/core/utils/responsive_util.dart';
import 'package:auth_sample/core/router/app_router.dart';
import 'package:auth_sample/core/localization/app_localization.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoAnimation;
  late Animation<double> _textAnimation;
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _scheduleNavigation();
  }

  void _initializeAnimations() {
    _controller = AnimationController(
      duration: AppAnimations.mainAnimationDuration,
      vsync: this,
    );

    _logoAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          AppAnimations.logoInterval.begin,
          AppAnimations.logoInterval.end,
          curve: AppAnimations.logoCurve,
        ),
      ),
    );

    _textAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          AppAnimations.textInterval.begin,
          AppAnimations.textInterval.end,
          curve: AppAnimations.textCurve,
        ),
      ),
    );

    _controller.forward();
  }

  void _scheduleNavigation() {
    _navigationTimer = Timer(AppAnimations.splashDelay, _navigateToIntro);
  }

  void _navigateToIntro() {
    if (mounted) {
      Navigator.pushReplacementNamed(context, AppRouter.intro);
    }
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = ResponsiveUtil(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ScaffoldBody(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              physics: AppStyles.physicsNeverScroll,
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
                          child: _AnimatedLogoSection(
                            r: r,
                            logoAnimation: _logoAnimation,
                            textAnimation: _textAnimation,
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

class _AnimatedLogoSection extends StatelessWidget {
  final ResponsiveUtil r;
  final Animation<double> logoAnimation;
  final Animation<double> textAnimation;

  const _AnimatedLogoSection({
    required this.r,
    required this.logoAnimation,
    required this.textAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Animated logo
        ScaleTransition(
          scale: logoAnimation,
          child: FaIcon(
            AppIcons.dumbbell,
            color: AppColors.white,
            size: r.ui(AppDimens.logoIconSize),
          ),
        ),
        SizedBox(height: r.h(AppDimens.logoTextSpacing)),
        // Animated text
        FadeTransition(
          opacity: textAnimation,
          child: Text(
            AppLocalization.of(context)!.fitnessClub,
            style: TextStyle(
              fontSize: r.font(AppDimens.fitnessClubFontSize),
              fontWeight: AppStyles.fontWeightLight,
              color: AppColors.white,
            ),
          ),
        ),
        SizedBox(height: r.h(AppDimens.indicatorSpacing)),
        // Loading indicator
        _SplashIndicator(r: r),
      ],
    );
  }
}

class _SplashIndicator extends StatefulWidget {
  final ResponsiveUtil r;
  const _SplashIndicator({required this.r});

  @override
  State<_SplashIndicator> createState() => _SplashIndicatorState();
}

class _SplashIndicatorState extends State<_SplashIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: AppAnimations.indicatorDuration,
      vsync: this,
    )..repeat(reverse: true);

    _animation =
        Tween<double>(
          begin: AppAnimations.indicatorBegin,
          end: AppAnimations.indicatorEnd,
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: AppAnimations.indicatorCurve,
          ),
        );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(AppDimens.indicatorDotCount, (index) {
          return Container(
            margin: EdgeInsets.symmetric(
              horizontal: widget.r.w(AppDimens.indicatorDotMargin),
            ),
            width: widget.r.w(AppDimens.indicatorDotSize),
            height: widget.r.w(AppDimens.indicatorDotSize),
            decoration: BoxDecoration(
              color: index == AppDimens.indicatorMiddleDotIndex
                  ? AppColors.primary
                  : AppColors.white,
              shape: BoxShape.circle,
            ),
          );
        }),
      ),
    );
  }
}
