import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/routes/navigations.dart';
import 'package:bookia/core/styles/colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/custom_svg_picture.dart';
import 'package:bookia/core/widgets/custom_text_form_field.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/core/widgets/my_body_view.dart';
import 'package:bookia/feature/auth/presentation/widgets/auth_footer.dart';
import 'package:bookia/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ForgotPasswordScreen extends StatelessWidget {
  // const ForgotPasswordScreen({super.key});
  const ForgotPasswordScreen({super.key, required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: MyBodyView(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(LocaleKeys.forgot_password.tr(), style: TextStyles.headline),
              Gap(10),
              Text(
                LocaleKeys.forgot_password_description.tr(),
                style: TextStyles.body.copyWith(color: AppColors.darkGreyColor),
              ),
              Gap(32),
              CustomTextFormField(hintText: LocaleKeys.enter_your_email.tr()),
              Gap(40),
              MainButton(text: LocaleKeys.send_code.tr(), onPressed: () {}),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AuthFooter(
        label: LocaleKeys.remember_password.tr(),
        buttonLabel: LocaleKeys.login.tr(),
        onTap: () {
          pop(context);
        },
      ),
    );
  }
}
