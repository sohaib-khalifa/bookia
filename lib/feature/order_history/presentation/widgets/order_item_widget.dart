import 'package:bookia/core/routes/navigations.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/styles/colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/feature/order_history/data/models/order_history_response/order.dart';
import 'package:bookia/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class OrderItemWidget extends StatelessWidget {
  const OrderItemWidget({super.key, required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (order.id != null) {
          pushTo(context, Routes.orderDetails, extra: order.id);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.borderColor, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${LocaleKeys.order_no.tr()}${order.orderCode ?? ''}',
                  style: TextStyles.subtitle2.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  order.orderDate ?? '',
                  style: TextStyles.caption1.copyWith(
                    color: AppColors.greyColor,
                  ),
                ),
              ],
            ),
            const Divider(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(order.status),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    order.status ?? '',
                    style: TextStyles.caption2.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  '${LocaleKeys.total_amount.tr()} \$${order.total ?? '0'}',
                  style: TextStyles.caption1.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
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
