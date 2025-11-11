import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// --- COLORS ---
class AppColors {
  static const Color primary = Color(0xFFbd1738);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color textBlack87 = Colors.black87;
  static const Color transparent = Colors.transparent;
  static final Color white10 = Color(0x1AFFFFFF);

  static const Color backgroundGrey = Color(0xfff5f5f5);
  static const Color darkText = Color(0xff0e0526);
  static const Color grey = Colors.grey;
  static final Color grey400 = Colors.grey.shade400;
  static final Color grey500 = Colors.grey.shade500;
  static final Color grey600 = Colors.grey[600]!;
  static const Color error = Color(0xFFbd1738);

  // Gradient Colors
  static const Color gradientStart = Color(0xFFbd1738);
  static const Color gradientMiddle = Color(0xFF6c1d3c);
  static const Color gradientEnd = Color(0xFF341a38);

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [gradientStart, gradientMiddle, gradientEnd],
    stops: [0.0, 0.5, 1.0],
  );
}

// --- DIMENSIONS ---
class AppDimens {
  // Padding & Spacing
  static const double horizontalPadding = 30.0;
  static const double verticalPadding = 20.0;
  static const double spacingSmall = 15.0;
  static const double spacingMedium = 20.0;
  static const double spacingLarge = 40.0;
  static const double spacingExtraLarge = 50.0;

  // Icons
  static const double iconSmall = 20.0;
  static const double iconMedium = 30.0;
  static const double logoIconSize = 80.0;

  // Fonts
  static const double fontSmall = 16.0;
  static const double fontMedium = 18.0;
  static const double fontLarge = 20.0;
  static const double fontExtraLarge = 25.0;
  static const double fontHeader = 35.0;
  static const double fontDisplay = 40.0;

  // Borders & Radii
  static const double smallRadius = 8.0;
  static const double mediumRadius = 10.0;
  static const double largeRadius = 15.0;
  static const double extraLargeRadius = 40.0;
  static const double containerRadius = 50.0;
  static const double borderWidthThin = 1.0;
  static const double borderWidthThick = 1.5;
  static const double loaderThickness = 2.0;

  // Specific Widget Sizes
  static const double buttonHeight = 60.0;
  static const double buttonWidth = 350.0;
  static const double loaderSize = 20.0;
  static const double buttonSpacing = 20.0;
  static const double logoTextSpacing = 20.0;
  static const double fitnessClubFontSize = 30.0;
  static const double indicatorSpacing = 30.0;
  static const double indicatorDotMargin = 4.0;
  static const double indicatorDotSize = 12.0;
  static const int indicatorDotCount = 3;
  static const int indicatorMiddleDotIndex = 1;
  static const double socialMediaFontSize = 16.0;
  static const double socialTextSpacing = 20.0;
  static const double socialIconPadding = 10.0;
  static const double socialIconSize = 25.0;
  static const double authButtonsSpacing = 30.0;
}

// --- STRINGS ---
class AppStrings {
  static const String languageKey = 'language';
  static const String enLocale = 'en';
  static const String arLocale = 'ar';
}

// --- STYLES ---
class AppStyles {
  static const FontWeight fontWeightLight = FontWeight.w300;
  static const FontWeight fontWeightRegular = FontWeight.w400;
  static const FontWeight fontWeightMedium = FontWeight.w500;
  static const FontWeight fontWeightSemiBold = FontWeight.w600;
  static const FontWeight fontWeightBold = FontWeight.w700;

  static const ScrollPhysics physicsNeverScroll =
      NeverScrollableScrollPhysics();
  static const ScrollPhysics physicsBouncing = BouncingScrollPhysics();
}

// --- ICONS ---
class AppIcons {
  static const IconData menu = Icons.more_horiz;
  static const IconData errorOutline = Icons.error_outline;
  static const IconData checkCircleOutline = Icons.check_circle_outline;
  static const IconData check = FontAwesomeIcons.check;
  static const IconData dumbbell = FontAwesomeIcons.dumbbell;
  static const IconData instagram = FontAwesomeIcons.instagram;
  static const IconData twitter = FontAwesomeIcons.twitter;
  static const IconData facebook = FontAwesomeIcons.facebook;
  static const IconData eye = FontAwesomeIcons.eye;
  static const IconData eyeSlash = FontAwesomeIcons.eyeSlash;
  static const IconData checkCircle = FontAwesomeIcons.check;
  static const IconData xmarkCircle = FontAwesomeIcons.circleXmark;
}

// --- ANIMATIONS ---
class AppAnimations {
  static const Duration mainAnimationDuration = Duration(milliseconds: 1500);
  static const Duration splashDelay = Duration(seconds: 3);
  static const Interval logoInterval = Interval(0.0, 0.6);
  static const Curve logoCurve = Curves.easeOutBack;
  static const Interval textInterval = Interval(0.3, 1.0);
  static const Curve textCurve = Curves.easeOut;
  static const Duration indicatorDuration = Duration(milliseconds: 600);
  static const double indicatorBegin = 0.3;
  static const double indicatorEnd = 1.0;
  static const Curve indicatorCurve = Curves.easeInOut;
}
