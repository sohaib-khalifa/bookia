import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/widgets/custom_svg_picture.dart';
import 'package:bookia/feature/home/presentation/widgets/home_slider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [CustomSvgPicture(path: AppImages.logoSvg, height: 30)],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: CustomSvgPicture(path: AppImages.searchSvg),
          ),
        ],
      ),
      body: Column(children: [HomeSlider(), Gap(20)]),
    );
  }
}
