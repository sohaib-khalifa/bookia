import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/functions/validations.dart';
import 'package:bookia/core/routes/navigations.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/styles/colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/custom_svg_picture.dart';
import 'package:bookia/core/widgets/custom_text_form_field.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/core/widgets/my_body_view.dart';
import 'package:bookia/feature/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:bookia/feature/checkout/presentation/cubit/checkout_state.dart';
import 'package:bookia/feature/checkout/presentation/widgets/select_governorate_bottom_sheet.dart';
import 'package:bookia/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlaceOrderScreen extends StatelessWidget {
  const PlaceOrderScreen({super.key, required this.total});

  final double total;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: () => pop(context),
              child: const CustomSvgPicture(path: AppImages.backSvg),
            ),
          ],
        ),
      ),
      body: MyBodyView(
        child: BlocConsumer<CheckoutCubit, CheckoutState>(
          listener: (context, state) {
            if (state is PlaceOrderLoading) {
              showLoadingDialog(context);
            } else if (state is PlaceOrderSuccess) {
              pushToBase(context, Routes.orderSuccess);
            } else if (state is PlaceOrderError) {
              pop(context);
              showToast(context, LocaleKeys.something_went_wrong.tr());
            }
          },
          builder: (context, state) {
            var cubit = context.read<CheckoutCubit>();
            return SingleChildScrollView(
              child: Form(
                key: cubit.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(LocaleKeys.place_your_order.tr(), style: TextStyles.headline),
                    Gap(10.h),
                    Text(
                      LocaleKeys.place_order_description.tr(),
                      style: TextStyles.caption1.copyWith(
                        color: AppColors.greyColor,
                      ),
                    ),
                    Gap(30.h),
                    CustomTextFormField(
                      controller: cubit.nameController,
                      keyboardType: TextInputType.emailAddress,

                      hintText: LocaleKeys.full_name.tr(),
                      validator: (v) {
                        if (v != null && v.isEmpty) {
                          return LocaleKeys.please_enter_name.tr();
                        }
                        return null;
                      },
                    ),
                    Gap(15.h),

                    CustomTextFormField(
                      controller: cubit.addressController,
                      hintText: LocaleKeys.address.tr(),
                      validator: (v) {
                        if (v != null && v.isEmpty) {
                          return LocaleKeys.please_enter_address.tr();
                        }
                        return null;
                      },
                    ),
                    Gap(15.h),
                    CustomTextFormField(
                      controller: cubit.phoneController,
                      keyboardType: TextInputType.phone,
                      hintText: LocaleKeys.phone.tr(),
                      validator: (v) {
                        if (v != null && v.isEmpty) {
                          return LocaleKeys.please_enter_phone.tr();
                        } else if (!isEgyptianPhone(v!)) {
                          return LocaleKeys.please_enter_valid_phone.tr();
                        }
                        return null;
                      },
                    ),
                    Gap(15.h),
                    CustomTextFormField(
                      readOnly: true,
                      controller: cubit.governorateController,
                      validator: (v) {
                        if (v != null && v.isEmpty) {
                          return LocaleKeys.please_select_governorate.tr();
                        }
                        return null;
                      },
                      hintText: LocaleKeys.governorate.tr(),
                      suffixIcon: const Icon(Icons.keyboard_arrow_down),
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: AppColors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20.r),
                            ),
                          ),
                          builder: (context) {
                            return BlocProvider.value(
                              value: cubit,
                              child: const SelectGovernorateBottomSheet(),
                            );
                          },
                        );
                      },
                    ),
                    Gap(100.h),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BlocBuilder<CheckoutCubit, CheckoutState>(
        builder: (context, state) {
          var cubit = context.read<CheckoutCubit>();
          return Padding(
            padding: EdgeInsets.fromLTRB(22.w, 10.h, 22.w, 22.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      LocaleKeys.total.tr(),
                      style: TextStyles.subtitle1.copyWith(
                        color: AppColors.greyColor,
                      ),
                    ),
                    Text(
                      '\$${total.toStringAsFixed(2)}',
                      style: TextStyles.subtitle1,
                    ),
                  ],
                ),
                Gap(20.h),
                MainButton(
                  text: LocaleKeys.submit_order.tr(),
                  onPressed: () {
                    if (cubit.formKey.currentState!.validate()) {
                      cubit.placeOrder();
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
