import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/styles/colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/custom_svg_picture.dart';
import 'package:bookia/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Divider()),
            Gap(40.w),
            Text(
              LocaleKeys.or.tr(),
              style: TextStyles.caption1.copyWith(
                color: AppColors.darkGreyColor,
              ),
            ),
            Gap(40.w),
            Expanded(child: Divider()),
          ],
        ),
        Gap(20.h),
        SocialButton(
          image: AppImages.googleSvg,
          label: LocaleKeys.continue_with_google.tr(),
          onTap: () {},
        ),
        Gap(10.h),
        SocialButton(
          image: AppImages.appleSvg,
          label: LocaleKeys.continue_with_facebook.tr(),
          onTap: () {},
        ),
      ],
    );
  }
}

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
    required this.image,
    required this.label,
    required this.onTap,
  });
  final String image;
  final String label;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15.w),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderColor),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomSvgPicture(path: image),
            Gap(10.w),
            Text(
              label,
              style: TextStyles.caption1.copyWith(
                color: AppColors.darkGreyColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
