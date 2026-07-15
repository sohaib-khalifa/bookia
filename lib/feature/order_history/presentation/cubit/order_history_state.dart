import 'package:bookia/feature/order_history/data/models/order_history_response/order.dart';

abstract class OrderHistoryState {}

class OrderHistoryInitial extends OrderHistoryState {}

class OrderHistoryLoading extends OrderHistoryState {}

class OrderHistoryLoaded extends OrderHistoryState {
  final List<Order> orders;
  final int currentPage;
  final int lastPage;
  OrderHistoryLoaded({
    required this.orders,
    required this.currentPage,
    required this.lastPage,
  });
}

class OrderHistoryError extends OrderHistoryState {}
