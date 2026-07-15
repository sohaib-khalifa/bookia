import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/styles/colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/custom_svg_picture.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const CustomSvgPicture(
              path: AppImages.successSvg,
              width: 120,
              height: 120,
            ),
            const Gap(30),
            Text(
              LocaleKeys.success.tr(),
              style: TextStyles.headline.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(16),
            Text(
              LocaleKeys.order_success_description.tr(),
              style: TextStyles.caption1.copyWith(
                color: AppColors.greyColor,
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            MainButton(
              text: LocaleKeys.back_to_home.tr(),
              onPressed: () {
                context.go(Routes.main, extra: 0);
              },
            ),
            const Gap(30),
          ],
        ),
      ),
    );
  }
}
