import 'dart:async';

import 'package:bookia/feature/home/data/model/best_seller_response/product.dart';
import 'package:bookia/feature/search/data/repo/search_repo.dart';
import 'package:bookia/feature/search/presentation/cubit/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  List<Product> products = [];
  Timer? _debounce;

  void onSearchChanged(String query) {
    _debounce?.cancel();
    if (query.trim().isEmpty) {
      products = [];
      emit(SearchInitial());
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 500), () {
      _search(query.trim());
    }); // // Timer
  }

  Future<void> _search(String query) async {
    emit(SearchLoading());
    final response = await SearchRepo.searchProducts(query);

    if (response != null) {
      products = response.data?.products ?? [];
      emit(SearchLoaded());
    } else {
      emit(SearchError());
    }
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}