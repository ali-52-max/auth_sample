import 'package:auth_sample/core/constants/app_values.dart';
import 'package:auth_sample/core/localization/app_localization.dart';
import 'package:auth_sample/core/localization/language_provider.dart';
import 'package:auth_sample/core/utils/responsive_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LanguageMenuButton extends StatelessWidget {
  final ResponsiveUtil r;
  const LanguageMenuButton({super.key, required this.r});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: FaIcon(
        AppIcons.menu,
        color: AppColors.white,
        size: r.ui(AppDimens.iconMedium),
      ),
      onSelected: (String result) {
        if (result == AppStrings.languageKey) {
          _showLanguageDialog(context);
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: AppStrings.languageKey,
          child: Text(AppLocalization.of(context)!.changeAppLanguage),
        ),
      ],
    );
  }

  void _showLanguageDialog(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(
      context,
      listen: false,
    );
    final currentLocale = languageProvider.locale.languageCode;
    final r = ResponsiveUtil(context);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _LanguageDialog(
          r: r,
          languageProvider: languageProvider,
          currentLocale: currentLocale,
        );
      },
    );
  }
}

class _LanguageDialog extends StatelessWidget {
  final ResponsiveUtil r;
  final LanguageProvider languageProvider;
  final String currentLocale;
  const _LanguageDialog({
    required this.r,
    required this.languageProvider,
    required this.currentLocale,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalization.of(context)!.selectLanguage),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _LanguageOption(
            language: AppLocalization.of(context)!.english,
            localeCode: AppStrings.enLocale,
            isSelected: currentLocale == AppStrings.enLocale,
            onTap: () {
              languageProvider.setLocale(const Locale(AppStrings.enLocale));
              Navigator.pop(context);
            },
          ),
          _LanguageOption(
            language: AppLocalization.of(context)!.arabic,
            localeCode: AppStrings.arLocale,
            isSelected: currentLocale == AppStrings.arLocale,
            onTap: () {
              languageProvider.setLocale(const Locale(AppStrings.arLocale));
              Navigator.pop(context);
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            AppLocalization.of(context)!.cancel,
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: AppStyles.fontWeightMedium,
              fontSize: r.font(AppDimens.fontLarge),
            ),
          ),
        ),
      ],
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String language;
  final String localeCode;
  final bool isSelected;
  final VoidCallback onTap;
  const _LanguageOption({
    required this.language,
    required this.localeCode,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(language),
      trailing: isSelected
          ? Icon(AppIcons.check, color: AppColors.primary)
          : null,
      onTap: onTap,
    );
  }
}
