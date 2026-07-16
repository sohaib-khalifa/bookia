import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/routes/navigations.dart';
import 'package:bookia/core/styles/colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/custom_svg_picture.dart';
import 'package:bookia/core/widgets/my_body_view.dart';
import 'package:bookia/core/widgets/shimmer/shimmer_cart.dart';
import 'package:bookia/feature/cart/presentation/widgets/cart_action/cart_action_widget.dart';
import 'package:bookia/feature/home/data/model/best_seller_response/product.dart';
import 'package:bookia/feature/wishlist/presentation/widgets/wishlist_action/wishlist_action.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.model});
  final Product model;

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
        actions: [WishlistActionWidget(id: model.id ?? 0)],
      ),
      body: MyBodyView(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Hero(
                tag: model.id ?? '',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: CachedNetworkImage(
                    imageUrl: model.image ?? '',
                    width: 180.w,
                    height: 270.h,
                    fit: BoxFit.cover,
                    progressIndicatorBuilder: (context, url, progress) {
                      return ShimmerCard(
                        width: 180.w,
                        height: 270.h,
                        borderRadius: 10.r,
                      );
                    },
                    errorWidget: (context, url, error) {
                      return ShimmerCard(
                        width: 180.w,
                        height: 270.h,
                        borderRadius: 10.r,
                      );
                    },
                  ),
                ),
              ),
              Gap(11.h),
              Text(
                model.name ?? '',
                style: TextStyles.headline,
                textAlign: TextAlign.center,
              ),
              Gap(11.h),
              Text(
                model.category ?? '',
                style: TextStyles.caption1.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
              Gap(20.h),
              Text(
                model.description ?? '',
                textAlign: TextAlign.justify,
                style: TextStyles.caption2.copyWith(color: AppColors.darkColor),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(22.w, 5.h, 22.w, 22.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${model.price} \$', style: TextStyles.title),
            // MainButton(minWidth: 200, text: 'Add To Cart', onPressed: () {}),
            CartActionWidget(productId: model.id ?? 0),
          ],
        ),
      ),
    );
  }
}
