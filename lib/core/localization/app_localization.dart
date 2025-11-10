import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalization {
  final Locale locale;

  AppLocalization(this.locale);

  static AppLocalization? of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  static const LocalizationsDelegate<AppLocalization> delegate =
      _AppLocalizationDelegate();

  Map<String, String> _localizedStrings = {};

  Future<bool> load() async {
    final jsonString = await rootBundle.loadString(
      'assets/localization/app_${locale.languageCode}.arb',
    );
    final Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  String translate(String key, [Map<String, String>? args]) {
    String translation = _localizedStrings[key] ?? key;

    if (args != null) {
      args.forEach((key, value) {
        translation = translation.replaceAll('{$key}', value);
      });
    }

    return translation;
  }

  String get appTitle => translate('appTitle');
  String welcome(String name) => translate('welcome', {'name': name});
  String get login => translate('login');
  String get signIn => translate('signIn');
  String get signUp => translate('signUp');
  String get gmail => translate('gmail');
  String get password => translate('password');
  String get forgotPassword => translate('forgotPassword');
  String get dontHaveAccount => translate('dontHaveAccount');
  String get alreadyHaveAccount => translate('alreadyHaveAccount');
  String get createAccount => translate('createAccount');
  String get fullName => translate('fullName');
  String get phoneOrGmail => translate('phoneOrGmail');
  String get confirmPassword => translate('confirmPassword');
  String get changeAppLanguage => translate('changeAppLanguage');
  String get selectLanguage => translate('selectLanguage');
  String get english => translate('english');
  String get arabic => translate('arabic');
  String get cancel => translate('cancel');
  String get yes => translate('yes');
  String get confirm => translate('confirm');
  String get send => translate('send');
  String get weWillSendPasswordReset => translate('weWillSendPasswordReset');
  String get welcomeBack => translate('welcomeBack');
  String get loginWithSocialMedia => translate('loginWithSocialMedia');
  String get fitnessClub => translate('fitnessClub');
  String get splashSlogan => translate('splashSlogan');
  String get emailRequired => translate('emailRequired');
  String get invalidEmail => translate('invalidEmail');
  String get passwordRequired => translate('passwordRequired');
  String get passwordTooShort => translate('passwordTooShort');
  String get fullNameRequired => translate('fullNameRequired');
  String get invalidFullName => translate('invalidFullName');
  String get confirmPasswordRequired => translate('confirmPasswordRequired');
  String get passwordsDoNotMatch => translate('passwordsDoNotMatch');
  String get signingIn => translate('signingIn');
  String get signingUp => translate('signingUp');
  String get invalidCredentials => translate('invalidCredentials');
  String get emailAlreadyInUse => translate('emailAlreadyInUse');
  String get networkError => translate('networkError');
  String get unknownError => translate('unknownError');
  String get weakPassword => translate('weakPassword');
  String get loginSuccess => translate('loginSuccess');
  String get signupSuccess => translate('signupSuccess');
}

class _AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  const _AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale) async {
    final localization = AppLocalization(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(_AppLocalizationDelegate old) => false;
}
