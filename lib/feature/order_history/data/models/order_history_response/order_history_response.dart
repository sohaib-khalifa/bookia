import 'order.dart';

class OrderHistoryMeta {
  int? total;
  int? perPage;
  int? currentPage;
  int? lastPage;

  OrderHistoryMeta({this.total, this.perPage, this.currentPage, this.lastPage});

  factory OrderHistoryMeta.fromJson(Map<String, dynamic> json) =>
      OrderHistoryMeta(
        total: json['total'] as int?,
        perPage: json['per_page'] as int?,
        currentPage: json['current_page'] as int?,
        lastPage: json['last_page'] as int?,
      );
}

class OrderHistoryData {
  List<Order>? orders;
  OrderHistoryMeta? meta;

  OrderHistoryData({this.orders, this.meta});

  factory OrderHistoryData.fromJson(Map<String, dynamic> json) =>
      OrderHistoryData(
        orders: (json['orders'] as List<dynamic>?)
            ?.map((e) => Order.fromJson(e as Map<String, dynamic>))
            .toList(),
        meta: json['meta'] != null
            ? OrderHistoryMeta.fromJson(json['meta'] as Map<String, dynamic>)
            : null,
      );
}

class OrderHistoryResponse {
  OrderHistoryData? data;
  String? message;
  List<dynamic>? error;
  int? status;

  OrderHistoryResponse({this.data, this.message, this.error, this.status});

  factory OrderHistoryResponse.fromJson(Map<String, dynamic> json) {
    return OrderHistoryResponse(
      data: json['data'] != null
          ? OrderHistoryData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
      message: json['message'] as String?,
      error: json['error'] as List<dynamic>?,
      status: json['status'] as int?,
    );
  }
}
