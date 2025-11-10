import 'dart:math';
import 'package:flutter/material.dart';

/// A responsive utility class for adaptive scaling of dimensions, text, and padding.
///
/// You can initialize it in two ways:
/// ```dart
/// // In widgets (recommended)
/// final r = ResponsiveUtil(context);
///
/// // Or globally (e.g., in theme setup)
/// ResponsiveUtil.init(Size(390, 844)); // Once, during app start
/// final r = ResponsiveUtil.instance;
/// ```
class ResponsiveUtil {
  final MediaQueryData? _mediaQuery;

  // Reference iPhone 13 design size
  static const double _designWidth = 390;
  static const double _designHeight = 844;
  static const double _maxScaleFactor = 1.1;

  static ResponsiveUtil? _instance;

  /// Singleton instance (must call `init()` first if using non-context version)
  static ResponsiveUtil get instance {
    assert(
      _instance != null,
      'ResponsiveUtil.init(Size) must be called first.',
    );
    return _instance!;
  }

  /// Initialize for non-context use (e.g., in themes)
  static void init(Size logicalScreenSize) {
    final fakeMediaQuery = MediaQueryData(size: logicalScreenSize);
    _instance = ResponsiveUtil._internal(fakeMediaQuery);
  }

  /// Create using context (widget-level)
  factory ResponsiveUtil(BuildContext context) =>
      ResponsiveUtil._internal(MediaQuery.of(context));

  ResponsiveUtil._internal(this._mediaQuery);

  // ==== Screen Dimensions ====
  double get screenWidth => _mediaQuery!.size.width;
  double get screenHeight => _mediaQuery!.size.height;
  double get statusBarHeight => _mediaQuery!.padding.top;
  double get bottomBarHeight => _mediaQuery!.padding.bottom;
  double get safeAreaHeight => screenHeight - statusBarHeight - bottomBarHeight;

  // ==== Scale Factors ====
  double get _widthFactor => min(screenWidth / _designWidth, _maxScaleFactor);
  double get _heightFactor =>
      min(screenHeight / _designHeight, _maxScaleFactor);
  double get _scaleFactor => min(_widthFactor, _heightFactor);

  // ==== Public API ====

  /// Scales width proportionally.
  double w(double width, {double? min, double? max}) =>
      _clamp(width * _widthFactor, min, max);

  /// Scales height proportionally.
  double h(double height, {double? min, double? max}) =>
      _clamp(height * _heightFactor, min, max);

  /// Scales text/font size.
  double font(double size, {double? min, double? max}) =>
      _clamp(size * _scaleFactor, min, max);

  /// Scales general UI elements (icons, avatars, buttons) with blended logic.
  double ui(double size, {double? min, double? max}) {
    final ratio = screenHeight / screenWidth;
    final weight = ratio > 1.8 ? 0.4 : 0.6;
    final factor = (_widthFactor * weight) + (_heightFactor * (1 - weight));
    return _clamp(size * factor, min, max);
  }

  /// Scales a radius.
  double r(double radius) => radius * _scaleFactor;

  /// Creates responsive symmetric padding.
  EdgeInsets pad({
    double? horizontal,
    double? vertical,
    double? minH,
    double? maxH,
    double? minV,
    double? maxV,
  }) {
    return EdgeInsets.symmetric(
      horizontal: horizontal != null ? w(horizontal, min: minH, max: maxH) : 0,
      vertical: vertical != null ? h(vertical, min: minV, max: maxV) : 0,
    );
  }

  EdgeInsets padOnly({
    double? top,
    double? bottom,
    double? right,
    double? left,
    double? minH,
    double? maxH,
    double? minV,
    double? maxV,
  }) {
    return EdgeInsets.only(
      top: top != null ? h(top, min: minH, max: maxH) : 0,
      bottom: bottom != null ? h(bottom, min: minH, max: maxH) : 0,
      right: right != null ? w(right, min: minH, max: maxH) : 0,
      left: left != null ? h(left, min: minH, max: maxH) : 0,
    );
  }

  Widget withSafeArea(
    Widget child, {
    bool top = true,
    bool bottom = true,
    bool left = true,
    bool right = true,
  }) {
    final p = _mediaQuery!.padding;
    return Padding(
      padding: EdgeInsets.only(
        top: top ? p.top : 0,
        bottom: bottom ? p.bottom : 0,
        left: left ? p.left : 0,
        right: right ? p.right : 0,
      ),
      child: child,
    );
  }

  // ==== Helpers ====
  double _clamp(double value, double? min, double? max) {
    if (min != null) value = maxValue(value, min);
    if (max != null) value = minValue(value, max);
    return value;
  }

  double maxValue(double a, double b) => a > b ? a : b;
  double minValue(double a, double b) => a < b ? a : b;

  // ==== Extras for layout classification ====
  bool get isTablet => screenWidth >= 600;
  bool get isDesktop => screenWidth >= 1000;
  bool get isPortrait => screenHeight > screenWidth;
  double get aspectRatio => screenWidth / screenHeight;
}
