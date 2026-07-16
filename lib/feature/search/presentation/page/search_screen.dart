import 'package:bookia/core/styles/colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/shimmer/shimmer_grid_view.dart';
import 'package:bookia/feature/home/data/model/best_seller_response/product.dart';
import 'package:bookia/feature/home/presentation/widgets/book_card.dart';
import 'package:bookia/feature/search/presentation/cubit/search_cubit.dart';
import 'package:bookia/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchCubit(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          elevation: 0,
          leading: const BackButton(color: AppColors.darkColor),
          title: _SearchField(controller: _controller),
        ),
        body: const _SearchBody(),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SearchCubit>();
    return TextField(
      controller: controller,
      autofocus: true,
      onChanged: cubit.onSearchChanged,
      style: TextStyles.body,
      decoration: InputDecoration(
        hintText: LocaleKeys.search_books.tr(),
        hintStyle: TextStyles.body.copyWith(color: AppColors.greyColor),
        filled: true,
        fillColor: AppColors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColors.borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColors.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColors.primaryColor),
        ),
      ),
    );
  }
}

class _SearchBody extends StatelessWidget {
  const _SearchBody();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SearchCubit>();
    return BlocBuilder<SearchCubit, PagingState<int, Product>>(
      builder: (context, pagingState) {
        final crossAxisCount = (MediaQuery.sizeOf(context).width / 180).floor().clamp(2, 10);
        if (pagingState.isLoading && pagingState.pages == null) {
          return ShimmerGridView(
            itemCount: crossAxisCount * 3,
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 10.w,
            mainAxisSpacing: 10.h,
            mainAxisExtent: 290.h,
          );
        }

        if (pagingState.error != null && pagingState.pages == null) {
          return _EmptyPrompt(message: LocaleKeys.something_went_wrong.tr());
        }

        final items = pagingState.pages?.expand((p) => p).toList() ?? [];
        if (!pagingState.isLoading && items.isEmpty) {
          return _EmptyPrompt(message: LocaleKeys.no_books_found.tr());
        }

        return Padding(
          padding: EdgeInsets.all(16.w),
          child: PagedGridView<int, Product>(
            state: pagingState,
            fetchNextPage: cubit.fetchNextPage,
            padding: EdgeInsets.zero,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 12.h,
              childAspectRatio: 0.62,
            ),
            builderDelegate: PagedChildBuilderDelegate<Product>(
              itemBuilder: (context, item, index) => BookCard(book: item),
              newPageProgressIndicatorBuilder: (_) => Center(
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: const CircularProgressIndicator(),
                ),
              ),
              newPageErrorIndicatorBuilder: (_) => Center(
                child: TextButton(
                  onPressed: cubit.fetchNextPage,
                  child: Text(LocaleKeys.retry.tr()),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _EmptyPrompt extends StatelessWidget {
  const _EmptyPrompt({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.search, size: 64.w, color: AppColors.greyColor),
          Gap(12.h),
          Text(
            message,
            style: TextStyles.body.copyWith(color: AppColors.greyColor),
          ),
        ],
      ),
    );
  }
}
