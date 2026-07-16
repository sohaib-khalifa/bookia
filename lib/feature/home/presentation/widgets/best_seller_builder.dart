import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/my_body_view.dart';
import 'package:bookia/core/widgets/shimmer/shimmer_grid_view.dart';
import 'package:bookia/feature/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/feature/home/presentation/cubit/home_state.dart';
import 'package:bookia/feature/home/presentation/widgets/book_card.dart';
import 'package:bookia/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BestSellerBuilder extends StatelessWidget {
  const BestSellerBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = context.read<HomeCubit>();
        final crossAxisCount = (MediaQuery.sizeOf(context).width / 180).floor().clamp(2, 10);
        return MyBodyView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(LocaleKeys.best_seller.tr(), style: TextStyles.title),

              Gap(10.h),
              if (state is! HomeLoadedState)
                ShimmerGridView(
                  itemCount: crossAxisCount * 2,
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 10.h,
                  mainAxisExtent: 290.h,
                )
              else
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 10.w,
                    mainAxisSpacing: 10.h,
                    mainAxisExtent: 290.h,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: cubit.products.length,
                  itemBuilder: (BuildContext context, int index) {
                    var book = cubit.products[index];
                    return BookCard(book: book);
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}
