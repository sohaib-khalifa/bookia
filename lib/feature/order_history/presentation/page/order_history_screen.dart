import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/routes/navigations.dart';
import 'package:bookia/core/styles/colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/custom_svg_picture.dart';
import 'package:bookia/feature/order_history/presentation/cubit/order_history_cubit.dart';
import 'package:bookia/feature/order_history/presentation/cubit/order_history_state.dart';
import 'package:bookia/feature/order_history/presentation/widgets/order_item_widget.dart';
import 'package:bookia/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          LocaleKeys.my_orders.tr(),
          style: TextStyles.title.copyWith(fontWeight: FontWeight.bold),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: GestureDetector(
            onTap: () => pop(context),
            child: const CustomSvgPicture(path: AppImages.backSvg),
          ),
        ),
      ),
      body: BlocBuilder<OrderHistoryCubit, OrderHistoryState>(
        builder: (context, state) {
          if (state is OrderHistoryLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          } else if (state is OrderHistoryLoaded) {
            if (state.orders.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.receipt_long_outlined,
                      size: 80,
                      color: AppColors.greyColor,
                    ),
                    const Gap(16),
                    Text(
                      LocaleKeys.no_orders_yet.tr(),
                      style: TextStyles.subtitle1.copyWith(
                        color: AppColors.greyColor,
                      ),
                    ),
                  ],
                ),
              );
            }
            return NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) {
                if (scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent) {
                  context.read<OrderHistoryCubit>().loadMoreOrders();
                }
                return false;
              },
              child: ListView.separated(
                padding: const EdgeInsets.all(22),
                itemCount: state.orders.length,
                separatorBuilder: (context, index) => const Gap(12),
                itemBuilder: (context, index) {
                  return OrderItemWidget(order: state.orders[index]);
                },
              ),
            );
          } else if (state is OrderHistoryError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    LocaleKeys.something_went_wrong.tr(),
                    style: TextStyles.subtitle1.copyWith(
                      color: AppColors.greyColor,
                    ),
                  ),
                  const Gap(16),
                  TextButton(
                    onPressed: () {
                      context.read<OrderHistoryCubit>().getOrderHistory();
                    },
                    child: Text(
                      LocaleKeys.retry.tr(),
                      style: TextStyles.body.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
