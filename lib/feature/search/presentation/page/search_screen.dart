import 'package:bookia/core/styles/colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/shimmer/shimmer_grid_view.dart';
import 'package:bookia/feature/home/presentation/widgets/book_card.dart';
import 'package:bookia/feature/search/presentation/cubit/search_cubit.dart';
import 'package:bookia/feature/search/presentation/cubit/search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

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
        hintText: 'Search books...',
        hintStyle: TextStyles.body.copyWith(color: AppColors.greyColor),
        filled: true,
        fillColor: AppColors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
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
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return ShimmerGridView(
            itemCount: 6,
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            mainAxisExtent: 290,
          ); // // ShimmerGridView
        }

        if (state is SearchError) {
          return const _EmptyPrompt(message: 'Something went wrong');
        }

        final products = context.read<SearchCubit>().products;
        if (products.isEmpty) {
          return const _EmptyPrompt(message: 'No books found');
        }

        return Padding(
          padding: const EdgeInsets.all(16),
          child: GridView.builder(
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.62,
            ), // // SliverGridDelegateWithFixedCrossAxisCount
            itemBuilder: (context, index) {
              return BookCard(book: products[index]);
            },
          ), // // GridView.builder
        ); // // Padding
      },
    ); // // BlocBuilder
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
          const Icon(Icons.search, size: 64, color: AppColors.greyColor),
          const Gap(12),
          Text(
            message,
            style: TextStyles.body.copyWith(color: AppColors.greyColor),
          ),
        ],
      ),
    );
  }
}