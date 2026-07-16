import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/feature/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:bookia/feature/checkout/presentation/cubit/checkout_state.dart';
import 'package:bookia/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectGovernorateBottomSheet extends StatelessWidget {
  const SelectGovernorateBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutCubit, CheckoutState>(
      builder: (context, state) {
        var cubit = context.read<CheckoutCubit>();
        return Container(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(LocaleKeys.select_governorate.tr(), style: TextStyles.title),
              Gap(20.h),
              if (state is GetGovernoratesLoading)
                const Center(child: CircularProgressIndicator())
              else if (state is GetGovernoratesError)
                Center(child: Text(LocaleKeys.error_loading_governorates.tr()))
              else
                Expanded(
                  child: ListView.separated(
                    itemCount: cubit.governorates.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      var governorate = cubit.governorates[index];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          governorate.governorateNameEn ?? '',
                          style: TextStyles.body,
                        ),
                        onTap: () {
                          cubit.selectGovernorate(governorate);
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
