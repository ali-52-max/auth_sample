import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auth_sample/core/router/app_router.dart';
import 'package:auth_sample/core/utils/responsive_util.dart';
import 'package:auth_sample/core/localization/app_localization.dart';
import 'package:auth_sample/features/auth/presentation/widgets/auth_template.dart';
import 'package:auth_sample/features/auth/presentation/widgets/custom_button.dart';
import 'package:auth_sample/features/auth/presentation/widgets/custom_input_field.dart';
import 'package:auth_sample/features/auth/presentation/widgets/quick_action.dart';
import 'package:auth_sample/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:auth_sample/features/auth/presentation/blocs/forms/signup_form/signup_form_bloc.dart';
import 'package:auth_sample/core/utils/validators/index.dart';
import 'package:auth_sample/core/constants/app_values.dart';
import '../blocs/auth_event.dart';
import '../blocs/auth_state.dart';
import '../widgets/app_feedback.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obscureText = true;
  bool _confirmObscureText = true;

  @override
  Widget build(BuildContext context) {
    final r = ResponsiveUtil(context);

    return BlocProvider(
      create: (_) => SignUpFormBloc(),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          state.whenOrNull(
            successfulRegister: (user) {
              showSuccessSnack(context, message: 'signupSuccess');
              Navigator.pop(context);
            },
            error: (failureKey) {
              showErrorSnack(context, failureKey: failureKey);
            },
          );
        },
        child: AuthTemplate(
          headerText: AppLocalization.of(context)!.createAccount,
          r: r,
          authBodySection: [
            _FullNameField(r: r),
            SizedBox(height: r.h(AppDimens.spacingSmall)),
            _EmailField(r: r),
            SizedBox(height: r.h(AppDimens.spacingSmall)),
            _PasswordField(
              r: r,
              obscureText: _obscureText,
              onToggleObscureText: () =>
                  setState(() => _obscureText = !_obscureText),
            ),
            SizedBox(height: r.h(AppDimens.spacingSmall)),
            _ConfirmPasswordField(
              r: r,
              obscureText: _confirmObscureText,
              onToggleObscureText: () =>
                  setState(() => _confirmObscureText = !_confirmObscureText),
            ),
            SizedBox(height: r.h(AppDimens.spacingLarge)),
            _SubmitButton(r: r),
            const Spacer(),
            _QuickActionSection(r: r),
          ],
        ),
      ),
    );
  }
}

// Full Name Field Widget
class _FullNameField extends StatelessWidget {
  final ResponsiveUtil r;

  const _FullNameField({required this.r});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpFormBloc, SignupFormState>(
      buildWhen: (previous, current) =>
          previous.fullName != current.fullName ||
          previous.fullNameHasInteracted != current.fullNameHasInteracted,
      builder: (context, state) {
        return CustomInputField(
          label: AppLocalization.of(context)!.fullName,
          isPassword: false,
          icon: state.fullName.isValid && state.fullNameHasInteracted
              ? AppIcons.checkCircle
              : AppIcons.xmarkCircle,
          r: r,
          onChanged: (value) =>
              context.read<SignUpFormBloc>().add(SignupFullNameChanged(value)),
          errorText: state.shouldShowFullNameError
              ? _getFullNameError(state.fullName.error, context)
              : null,
        );
      },
    );
  }

  String? _getFullNameError(
    FullNameValidationError? error,
    BuildContext context,
  ) {
    if (error == null) return null;

    switch (error) {
      case FullNameValidationError.empty:
        return AppLocalization.of(context)!.fullNameRequired;
      case FullNameValidationError.invalid:
        return AppLocalization.of(context)!.invalidFullName;
    }
  }
}

// Email Field Widget
class _EmailField extends StatelessWidget {
  final ResponsiveUtil r;

  const _EmailField({required this.r});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpFormBloc, SignupFormState>(
      buildWhen: (previous, current) =>
          previous.email != current.email ||
          previous.emailHasInteracted != current.emailHasInteracted,
      builder: (context, state) {
        return CustomInputField(
          label: AppLocalization.of(context)!.phoneOrGmail,
          isPassword: false,
          icon: state.email.isValid && state.emailHasInteracted
              ? AppIcons.checkCircle
              : AppIcons.xmarkCircle,
          r: r,
          onChanged: (value) =>
              context.read<SignUpFormBloc>().add(SignupEmailChanged(value)),
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
    return BlocBuilder<SignUpFormBloc, SignupFormState>(
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
              context.read<SignUpFormBloc>().add(SignupPasswordChanged(value)),
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

// Confirm Password Field Widget
class _ConfirmPasswordField extends StatelessWidget {
  final ResponsiveUtil r;
  final bool obscureText;
  final VoidCallback onToggleObscureText;

  const _ConfirmPasswordField({
    required this.r,
    required this.obscureText,
    required this.onToggleObscureText,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpFormBloc, SignupFormState>(
      buildWhen: (previous, current) =>
          previous.confirmPassword != current.confirmPassword ||
          previous.confirmPasswordHasInteracted !=
              current.confirmPasswordHasInteracted,
      builder: (context, state) {
        return CustomInputField(
          label: AppLocalization.of(context)!.confirmPassword,
          isPassword: obscureText,
          icon: obscureText ? AppIcons.eyeSlash : AppIcons.eye,
          onIconTap: onToggleObscureText,
          r: r,
          onChanged: (value) => context.read<SignUpFormBloc>().add(
            SignupConfirmPasswordChanged(value),
          ),
          errorText: state.shouldShowConfirmPasswordError
              ? _getConfirmPasswordError(state.confirmPassword.error, context)
              : null,
        );
      },
    );
  }

  String? _getConfirmPasswordError(
    ConfirmPasswordValidationError? error,
    BuildContext context,
  ) {
    if (error == null) return null;

    switch (error) {
      case ConfirmPasswordValidationError.empty:
        return AppLocalization.of(context)!.confirmPasswordRequired;
      case ConfirmPasswordValidationError.invalid:
        return AppLocalization.of(context)!.passwordsDoNotMatch;
    }
  }
}

// Submit Button Widget
class _SubmitButton extends StatelessWidget {
  final ResponsiveUtil r;

  const _SubmitButton({required this.r});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpFormBloc, SignupFormState>(
      listener: (context, formState) {
        if (formState.submissionReady) {
          context.read<AuthBloc>().add(
            SignUp(
              fullName: formState.fullName.value,
              email: formState.email.value,
              password: formState.password.value,
            ),
          );
          context.read<SignUpFormBloc>().add(ResetSignupSubmission());
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
          label: AppLocalization.of(context)!.signUp,
          onPressed: isFormValid
              ? () => context.read<SignUpFormBloc>().add(SignupFormSubmitted())
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
      text: AppLocalization.of(context)!.alreadyHaveAccount,
      action: AppLocalization.of(context)!.signIn,
      onTap: () => Navigator.pushReplacementNamed(context, AppRouter.login),
      r: r,
    );
  }
}
