import 'package:bookia/feature/order_history/data/repo/order_history_repo.dart';
import 'package:bookia/feature/order_history/presentation/cubit/order_details/order_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  OrderDetailsCubit() : super(OrderDetailsInitial());

  Future<void> getOrderDetails(int orderId) async {
    emit(OrderDetailsLoading());
    var response = await OrderHistoryRepo.getOrderDetails(orderId);
    if (response != null && response.data != null) {
      emit(OrderDetailsLoaded(response.data!));
    } else {
      emit(OrderDetailsError());
    }
  }
}
