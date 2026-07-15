// import 'dart:developer';

import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/functions/validations.dart';
import 'package:bookia/core/routes/navigations.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/styles/colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/custom_svg_picture.dart';
import 'package:bookia/core/widgets/custom_text_form_field.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/core/widgets/my_body_view.dart';
import 'package:bookia/core/widgets/password_text_form_field.dart';
import 'package:bookia/feature/auth/presentation/login_register/cubit/auth_cubit.dart';
import 'package:bookia/feature/auth/presentation/login_register/cubit/auth_state.dart';
import 'package:bookia/feature/auth/presentation/login_register/widgets/social_login.dart';
import 'package:bookia/feature/auth/presentation/widgets/auth_footer.dart';
import 'package:bookia/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          pop(context);
          // log("success");
          pushToBase(context, Routes.main);
        } else if (state is AuthErrorState) {
          pop(context);
          showToast(context, state.message);
        } else if (state is AuthLoadingState) {
          showLoadingDialog(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              GestureDetector(
                onTap: () => pop(context),
                child: CustomSvgPicture(path: AppImages.backSvg),
              ),
            ],
          ),
        ),
        body: _loginBody(context),
        bottomNavigationBar: AuthFooter(
          label: LocaleKeys.dont_have_account.tr(),
          buttonLabel: LocaleKeys.sign_up.tr(),
          onTap: () {
            pushReplacement(context, Routes.register);
          },
        ),
      ),
    );
  }

  MyBodyView _loginBody(BuildContext context) {
    var cubit = context.read<AuthCubit>();

    return MyBodyView(
      child: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.onUnfocus,
          key: cubit.formKey,
          child: Column(
            children: [
              Text(
                LocaleKeys.welcome_back.tr(),
                style: TextStyles.headline,
              ),
              Gap(32),
              CustomTextFormField(
                controller: cubit.emailController,
                hintText: LocaleKeys.enter_your_email.tr(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return LocaleKeys.please_enter_email.tr();
                  } else if (!isEmailValid(value)) {
                    return LocaleKeys.please_enter_valid_email.tr();
                  }
                  return null;
                },
              ),
              Gap(16),
              PasswordTextFormField(
                controller: cubit.passwordController,
                hintText: LocaleKeys.enter_your_password.tr(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return LocaleKeys.please_enter_password.tr();
                  }
                  return null;
                },
              ),
              Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      pushTo(context, Routes.forgotPassword);
                    },
                    child: Text(
                      LocaleKeys.forgot_password.tr(),
                      style: TextStyles.caption1.copyWith(
                        color: AppColors.darkGreyColor,
                      ),
                    ),
                  ),
                ],
              ),
              Gap(30),
              MainButton(
                text: LocaleKeys.login.tr(),
                onPressed: () {
                  if (cubit.formKey.currentState!.validate()) {
                    cubit.login();
                  }
                },
              ),
              Gap(30),
              SocialLogin(),
            ],
          ),
        ),
      ),
    );
  }
}
