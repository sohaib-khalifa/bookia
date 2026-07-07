import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/routes/navigations.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/core/styles/colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/custom_svg_picture.dart';
import 'package:bookia/feature/profile/presentation/widgets/profile_item_widget.dart';
import 'package:bookia/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var user = SharedPref.getUserInfo();
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.profile.tr()),
        actions: [
          IconButton(
            onPressed: () {
              // Handle Logout
              SharedPref.clear();
              pushToBase(context, Routes.login);
            },
            icon: const CustomSvgPicture(path: AppImages.logoutSvg),
          ),
          const Gap(10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: user?.image ?? '',
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const Gap(20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user?.name ?? LocaleKeys.guest_user.tr(),
                        style: TextStyles.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Gap(5),
                      Text(
                        user?.email ?? '',
                        style: TextStyles.caption1.copyWith(
                          color: AppColors.greyColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Gap(30),
            ProfileItemWidget(title: LocaleKeys.my_orders.tr(), onTap: () {}),
            const Gap(15),
            ProfileItemWidget(
              title: LocaleKeys.edit_profile.tr(),
              onTap: () {
                pushTo(context, Routes.editProfile).then((value) {
                  setState(() {});
                });
              },
            ),
            const Gap(15),
            ProfileItemWidget(title: LocaleKeys.reset_password.tr(), onTap: () {}),
            const Gap(15),
            ProfileItemWidget(title: LocaleKeys.faq.tr(), onTap: () {}),
            const Gap(15),
            ProfileItemWidget(title: LocaleKeys.contact_us.tr(), onTap: () {}),
            const Gap(15),
            ProfileItemWidget(title: LocaleKeys.privacy_and_terms.tr(), onTap: () {}),
          ],
        ),
      ),
    );
  }
}
