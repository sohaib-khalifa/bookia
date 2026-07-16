import 'package:bookia/core/styles/colors.dart';
import 'package:bookia/core/widgets/shimmer/shimmer_cart.dart';
import 'package:bookia/feature/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/feature/home/presentation/cubit/home_state.dart';
import 'package:bookia/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeSlider extends StatefulWidget {
  const HomeSlider({super.key});

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = context.read<HomeCubit>();

        if (state is! HomeLoadedState) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                ShimmerCard(
                  width: double.infinity,
                  height: 150.h,
                  borderRadius: 10.r,
                ),
                Gap(10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (index) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 3.w),
                      width: 10.w,
                      height: 10.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return Column(
          children: [
            CarouselSlider.builder(
              itemCount: cubit.sliders.length,
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: Image.network(
                        cubit.sliders[itemIndex].image ?? '',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(child: Text(LocaleKeys.error.tr()));
                        },
                      ),
                    );
                  },
              options: CarouselOptions(
                reverse: false,
                height: 150.h,
                viewportFraction: 0.9,
                autoPlay: true,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                onPageChanged: (index, reason) {
                  setState(() {
                    activeIndex = index;
                  });
                },
                scrollDirection: Axis.horizontal,
              ),
            ),
            Gap(10.h),
            AnimatedSmoothIndicator(
              activeIndex: activeIndex,
              count: cubit.sliders.length,
              effect: ExpandingDotsEffect(
                dotWidth: 10.w,
                dotHeight: 10.h,
                expansionFactor: 4,
                activeDotColor: AppColors.primaryColor,
                dotColor: AppColors.borderColor,
              ),
            ),
          ],
        );
      },
    );
  }
}
