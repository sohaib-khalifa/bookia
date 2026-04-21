import 'package:bookia/core/styles/colors.dart';
import 'package:bookia/feature/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/feature/home/presentation/cubit/home_state.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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

        return Column(
          children: [
            CarouselSlider.builder(
              itemCount: cubit.sliders.length,
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        cubit.sliders[itemIndex].image ?? '',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(child: Text('Error'));
                        },
                      ),
                    );
                  },
              options: CarouselOptions(
                reverse: false,
                height: 150,
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
            Gap(10),
            AnimatedSmoothIndicator(
              activeIndex: activeIndex,

              count: cubit.sliders.length,
              effect: ExpandingDotsEffect(
                dotWidth: 10,
                dotHeight: 10,
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
