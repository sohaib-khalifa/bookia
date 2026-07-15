import 'package:bookia/feature/order_history/data/models/order_history_response/order.dart';
import 'package:bookia/feature/order_history/data/repo/order_history_repo.dart';
import 'package:bookia/feature/order_history/presentation/cubit/order_history_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderHistoryCubit extends Cubit<OrderHistoryState> {
  OrderHistoryCubit() : super(OrderHistoryInitial());

  List<Order> orders = [];
  int currentPage = 1;
  int lastPage = 1;

  Future<void> getOrderHistory() async {
    emit(OrderHistoryLoading());
    var response = await OrderHistoryRepo.getOrderHistory(page: 1);
    if (response != null && response.data != null) {
      orders = response.data!.orders ?? [];
      currentPage = response.data!.meta?.currentPage ?? 1;
      lastPage = response.data!.meta?.lastPage ?? 1;
      emit(OrderHistoryLoaded(
        orders: orders,
        currentPage: currentPage,
        lastPage: lastPage,
      ));
    } else {
      emit(OrderHistoryError());
    }
  }

  Future<void> loadMoreOrders() async {
    if (currentPage >= lastPage) return;
    var nextPage = currentPage + 1;
    var response = await OrderHistoryRepo.getOrderHistory(page: nextPage);
    if (response != null && response.data != null) {
      orders.addAll(response.data!.orders ?? []);
      currentPage = response.data!.meta?.currentPage ?? nextPage;
      lastPage = response.data!.meta?.lastPage ?? lastPage;
      emit(OrderHistoryLoaded(
        orders: orders,
        currentPage: currentPage,
        lastPage: lastPage,
      ));
    }
  }
}
