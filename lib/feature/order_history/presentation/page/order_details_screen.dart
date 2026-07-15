import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/routes/navigations.dart';
import 'package:bookia/core/styles/colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/custom_svg_picture.dart';
import 'package:bookia/feature/order_history/presentation/cubit/order_details/order_details_cubit.dart';
import 'package:bookia/feature/order_history/presentation/cubit/order_details/order_details_state.dart';
import 'package:bookia/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key, required this.orderId});

  final int orderId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
          builder: (context, state) {
            if (state is OrderDetailsLoaded) {
              return Text(
                '#${state.details.orderCode ?? ''}',
                style: TextStyles.title.copyWith(fontWeight: FontWeight.bold),
              );
            }
            return Text(
              LocaleKeys.order_details.tr(),
              style: TextStyles.title.copyWith(fontWeight: FontWeight.bold),
            );
          },
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: GestureDetector(
            onTap: () => pop(context),
            child: const CustomSvgPicture(path: AppImages.backSvg),
          ),
        ),
      ),
      body: BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
        builder: (context, state) {
          if (state is OrderDetailsLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          } else if (state is OrderDetailsLoaded) {
            final details = state.details;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Status & Date
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(details.status),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          details.status ?? '',
                          style: TextStyles.caption1.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        details.orderDate ?? '',
                        style: TextStyles.caption1.copyWith(
                          color: AppColors.greyColor,
                        ),
                      ),
                    ],
                  ),
                  const Gap(24),

                  // Delivery Address Section
                  Text(
                    LocaleKeys.delivery_address.tr(),
                    style: TextStyles.subtitle2.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkColor,
                    ),
                  ),
                  const Gap(10),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.borderColor, width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          details.name ?? '',
                          style: TextStyles.body.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Gap(6),
                        Text(
                          '${details.address ?? ''}, ${details.governorate ?? ''}',
                          style: TextStyles.caption1.copyWith(
                            color: AppColors.greyColor,
                          ),
                        ),
                        if (details.phone != null && details.phone!.isNotEmpty) ...[
                          const Gap(8),
                          Row(
                            children: [
                              const Icon(
                                Icons.phone,
                                size: 16,
                                color: AppColors.greyColor,
                              ),
                              const Gap(8),
                              Text(
                                details.phone!,
                                style: TextStyles.caption1.copyWith(
                                  color: AppColors.darkColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                  const Gap(24),

                  // Items List Section
                  Text(
                    '${LocaleKeys.cart.tr()} (${details.orderProducts?.length ?? 0})',
                    style: TextStyles.subtitle2.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkColor,
                    ),
                  ),
                  const Gap(10),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: details.orderProducts?.length ?? 0,
                    separatorBuilder: (context, index) => const Gap(12),
                    itemBuilder: (context, index) {
                      final product = details.orderProducts![index];
                      return Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.borderColor, width: 1),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: product.productImage != null && product.productImage!.isNotEmpty
                                  ? CachedNetworkImage(
                                      imageUrl: product.productImage!,
                                      width: 60,
                                      height: 80,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Container(
                                        width: 60,
                                        height: 80,
                                        color: AppColors.borderColor.withValues(alpha: 0.5),
                                        child: const Center(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) => Container(
                                        width: 60,
                                        height: 80,
                                        color: AppColors.borderColor.withValues(alpha: 0.5),
                                        child: const Icon(
                                          Icons.book_outlined,
                                          color: AppColors.primaryColor,
                                          size: 30,
                                        ),
                                      ),
                                    )
                                  : Container(
                                      width: 60,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        color: AppColors.borderColor.withValues(alpha: 0.5),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Icon(
                                        Icons.book_outlined,
                                        color: AppColors.primaryColor,
                                        size: 30,
                                      ),
                                    ),
                            ),
                            const Gap(16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.productName ?? '',
                                    style: TextStyles.body.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const Gap(6),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Qty: ${product.orderProductQuantity ?? 1}',
                                        style: TextStyles.caption1.copyWith(
                                          color: AppColors.greyColor,
                                        ),
                                      ),
                                      Text(
                                        '\$${product.productTotal ?? ''}',
                                        style: TextStyles.caption1.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const Gap(24),

                  // Payment Summary Section
                  Text(
                    LocaleKeys.payment_summary.tr(),
                    style: TextStyles.subtitle2.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkColor,
                    ),
                  ),
                  const Gap(10),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.borderColor, width: 1),
                    ),
                    child: Column(
                      children: [
                        _buildSummaryRow(
                          LocaleKeys.sub_total.tr(),
                          '\$${details.subTotal ?? '0.00'}',
                        ),
                        const Gap(10),
                        _buildSummaryRow(
                          LocaleKeys.discount.tr(),
                          '\$${details.discount ?? 0}',
                          isDiscount: true,
                        ),
                        const Gap(10),
                        _buildSummaryRow(
                          LocaleKeys.tax.tr(),
                          '\$${details.tax ?? 0}',
                        ),
                        const Divider(height: 24),
                        _buildSummaryRow(
                          LocaleKeys.total.tr(),
                          '\$${details.total ?? '0.00'}',
                          isTotal: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (state is OrderDetailsError) {
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
                      context.read<OrderDetailsCubit>().getOrderDetails(orderId);
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

  Widget _buildSummaryRow(
    String label,
    String value, {
    bool isDiscount = false,
    bool isTotal = false,
  }) {
    final textStyle = isTotal
        ? TextStyles.body.copyWith(fontWeight: FontWeight.bold, color: AppColors.darkColor)
        : TextStyles.caption1.copyWith(color: AppColors.greyColor);
    final valueStyle = isTotal
        ? TextStyles.body.copyWith(fontWeight: FontWeight.bold, color: AppColors.primaryColor)
        : TextStyles.caption1.copyWith(
            fontWeight: FontWeight.w600,
            color: isDiscount ? Colors.red : AppColors.darkColor,
          );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: textStyle),
        Text(value, style: valueStyle),
      ],
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'new':
        return AppColors.primaryColor;
      case 'processing':
        return const Color(0xFF2196F3);
      case 'delivered':
        return const Color(0xFF4CAF50);
      case 'cancelled':
        return AppColors.errorColor;
      default:
        return AppColors.greyColor;
    }
  }
}
