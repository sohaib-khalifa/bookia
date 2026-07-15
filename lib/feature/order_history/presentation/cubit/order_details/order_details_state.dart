import 'package:bookia/feature/order_history/data/models/order_details_response/order_details_response.dart';

abstract class OrderDetailsState {}

class OrderDetailsInitial extends OrderDetailsState {}

class OrderDetailsLoading extends OrderDetailsState {}

class OrderDetailsLoaded extends OrderDetailsState {
  final OrderDetailsData details;
  OrderDetailsLoaded(this.details);
}

class OrderDetailsError extends OrderDetailsState {}
