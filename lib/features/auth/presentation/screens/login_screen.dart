import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:auth_sample/features/auth/presentation/blocs/auth_state.dart';
import 'package:auth_sample/core/router/app_router.dart';
import 'package:auth_sample/core/utils/responsive_util.dart';
import 'package:auth_sample/core/localization/app_localization.dart';
import 'package:auth_sample/features/auth/presentation/blocs/auth_event.dart';
import 'package:auth_sample/features/auth/presentation/widgets/auth_template.dart';
import 'package:auth_sample/features/auth/presentation/widgets/custom_button.dart';
import 'package:auth_sample/features/auth/presentation/widgets/custom_input_field.dart';
import 'package:auth_sample/features/auth/presentation/widgets/quick_action.dart';
import 'package:auth_sample/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:auth_sample/features/auth/presentation/blocs/forms/signIn_form/sign_in_form_bloc.dart';
import 'package:auth_sample/core/utils/validators/index.dart';
import 'package:auth_sample/core/constants/app_values.dart';

import '../widgets/app_feedback.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final r = ResponsiveUtil(context);

    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => SignInFormBloc())],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          state.whenOrNull(
            successfulLogin: (authSession) {
              showSuccessSnack(context, message: 'loginSuccess');
              Navigator.pop(context);
            },
            error: (failureKey) {
              showErrorSnack(context, failureKey: failureKey);
            },
          );
        },
        child: AuthTemplate(
          headerText: AppLocalization.of(context)!.login,
          r: r,
          authBodySection: [
            _EmailField(r: r),
            SizedBox(height: r.h(AppDimens.spacingSmall)),
            _PasswordField(
              r: r,
              obscureText: _obscureText,
              onToggleObscureText: () =>
                  setState(() => _obscureText = !_obscureText),
            ),
            SizedBox(height: r.h(AppDimens.spacingMedium)),
            _buildForgotPassword(context, r),
            SizedBox(height: r.h(AppDimens.spacingExtraLarge)),
            _SubmitButton(r: r),
            const Spacer(),
            _QuickActionSection(r: r),
          ],
        ),
      ),
    );
  }

  Widget _buildForgotPassword(BuildContext context, ResponsiveUtil r) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () => _showForgotPasswordDialog(context),
        child: Text(
          AppLocalization.of(context)!.forgotPassword,
          style: TextStyle(
            color: AppColors.textBlack87,
            fontWeight: AppStyles.fontWeightMedium,
            fontSize: r.font(AppDimens.fontLarge),
          ),
        ),
      ),
    );
  }

  void _showForgotPasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(AppLocalization.of(context)!.forgotPassword),
        content: Text(AppLocalization.of(context)!.weWillSendPasswordReset),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              AppLocalization.of(context)!.cancel,
              style: const TextStyle(color: AppColors.primary),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              AppLocalization.of(context)!.send,
              style: const TextStyle(color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}

// Email Field Widget
class _EmailField extends StatelessWidget {
  final ResponsiveUtil r;

  const _EmailField({required this.r});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInFormBloc, SignInFormState>(
      buildWhen: (previous, current) =>
          previous.email != current.email ||
          previous.emailHasInteracted != current.emailHasInteracted,
      builder: (context, state) {
        return CustomInputField(
          label: AppLocalization.of(context)!.gmail,
          isPassword: false,
          icon: state.email.isValid && state.emailHasInteracted
              ? AppIcons.checkCircle
              : AppIcons.xmarkCircle,
          r: r,
          onChanged: (value) =>
              context.read<SignInFormBloc>().add(SignInEmailChanged(value)),
          errorText: state.shouldShowEmailError
              ? _getEmailError(state.email.error, context)
              : null,
        );
      },
    );
  }

  String? _getEmailError(EmailValidationError? error, BuildContext context) {
    if (error == null) return null;

    switch (error) {
      case EmailValidationError.empty:
        return AppLocalization.of(context)!.emailRequired;
      case EmailValidationError.invalid:
        return AppLocalization.of(context)!.invalidEmail;
    }
  }
}

// Password Field Widget
class _PasswordField extends StatelessWidget {
  final ResponsiveUtil r;
  final bool obscureText;
  final VoidCallback onToggleObscureText;

  const _PasswordField({
    required this.r,
    required this.obscureText,
    required this.onToggleObscureText,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInFormBloc, SignInFormState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.passwordHasInteracted != current.passwordHasInteracted,
      builder: (context, state) {
        return CustomInputField(
          label: AppLocalization.of(context)!.password,
          isPassword: obscureText,
          icon: obscureText ? AppIcons.eyeSlash : AppIcons.eye,
          onIconTap: onToggleObscureText,
          r: r,
          onChanged: (value) =>
              context.read<SignInFormBloc>().add(SignInPasswordChanged(value)),
          errorText: state.shouldShowPasswordError
              ? _getPasswordError(state.password.error, context)
              : null,
        );
      },
    );
  }

  String? _getPasswordError(
    PasswordValidationError? error,
    BuildContext context,
  ) {
    if (error == null) return null;

    switch (error) {
      case PasswordValidationError.empty:
        return AppLocalization.of(context)!.passwordRequired;
      case PasswordValidationError.tooShort:
        return AppLocalization.of(context)!.passwordTooShort;
    }
  }
}

// Submit Button Widget
class _SubmitButton extends StatelessWidget {
  final ResponsiveUtil r;

  const _SubmitButton({required this.r});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInFormBloc, SignInFormState>(
      listener: (context, formState) {
        if (formState.submissionReady) {
          context.read<AuthBloc>().add(
            SignIn(
              email: formState.email.value,
              password: formState.password.value,
            ),
          );
          context.read<SignInFormBloc>().add(ResetSubmission());
        }
      },
      builder: (context, formState) {
        final authState = context.watch<AuthBloc>().state;
        final isLoading = authState is Loading;
        final isFormValid = formState.isValid && !isLoading;

        return CustomButton(
          type: ButtonStyleType.auth,
          responsive: r,
          textColor: AppColors.white,
          label: AppLocalization.of(context)!.signIn,
          onPressed: isFormValid
              ? () => context.read<SignInFormBloc>().add(SignInFormSubmitted())
              : null,
          isLoading: isLoading,
        );
      },
    );
  }
}

// Quick Action Section Widget
class _QuickActionSection extends StatelessWidget {
  final ResponsiveUtil r;

  const _QuickActionSection({required this.r});

  @override
  Widget build(BuildContext context) {
    return QuickAction(
      text: AppLocalization.of(context)!.dontHaveAccount,
      action: AppLocalization.of(context)!.signUp,
      onTap: () => Navigator.pushReplacementNamed(context, AppRouter.register),
      r: r,
    );
  }
}
