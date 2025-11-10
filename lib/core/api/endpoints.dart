class EndPoints {
  EndPoints._();

  // Auth
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String refreshToken = '/auth/refresh';

  // Profile
  static const String getUserProfile = '/profile/me';
  static const String updateUserProfile = '/profile/update';
}
