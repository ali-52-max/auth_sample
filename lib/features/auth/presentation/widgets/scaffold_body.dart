import 'package:auth_sample/core/constants/app_values.dart';
import 'package:flutter/material.dart';

class ScaffoldBody extends StatelessWidget {
  final Widget child;
  const ScaffoldBody({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
      child: child,
    );
  }
}
