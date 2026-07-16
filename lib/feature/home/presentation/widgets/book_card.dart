import 'package:bookia/core/routes/navigations.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/styles/colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/feature/home/data/model/best_seller_response/product.dart';
import 'package:bookia/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookCard extends StatelessWidget {
  const BookCard({
    super.key,
    required this.book,
    this.onRemoveFromWishlist,
    this.onRefresh,
  });

  final Product book;
  final VoidCallback? onRemoveFromWishlist;
  final VoidCallback? onRefresh;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pushTo(context, Routes.details, extra: book).then((value) {
          onRefresh?.call();
        });
      },
      child: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: AppColors.white,
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Hero(
                tag: book.id ?? '',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Image.network(
                    book.image ?? '',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(child: Text(LocaleKeys.error.tr()));
                    },
                  ),
                ),
              ),
            ),
            Gap(10.h),
            SizedBox(
              height: 50.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    book.name ?? '',
                    style: TextStyles.body,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Gap(10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(book.price ?? '', style: TextStyles.body)),
                onRemoveFromWishlist != null
                    ? IconButton(
                        onPressed: onRemoveFromWishlist,
                        icon: Icon(Icons.delete, color: AppColors.errorColor),
                      )
                    : MainButton(
                        minHeight: 35.h,
                        minWidth: 60.w,
                        bgColor: AppColors.darkColor,
                        text: LocaleKeys.buy.tr(),
                        onPressed: () {},
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
