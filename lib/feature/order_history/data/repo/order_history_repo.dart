import 'package:bookia/core/services/apis/apis.dart';
import 'package:bookia/core/services/apis/dio_provider.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/feature/order_history/data/models/order_history_response/order_history_response.dart';

class OrderHistoryRepo {
  static Future<OrderHistoryResponse?> getOrderHistory({int page = 1}) async {
    try {
      var response = await DioProvider.get(
        endpoint: Apis.orderHistory,
        queryParameters: {'page': page},
        headers: {"authorization": "Bearer ${SharedPref.getToken()}"},
      );
      if (response.statusCode == 200) {
        return OrderHistoryResponse.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
