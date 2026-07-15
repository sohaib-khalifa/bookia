class OrderProduct {
  int? orderProductId;
  int? productId;
  String? productName;
  String? productImage;
  String? productPrice;
  int? productDiscount;
  double? productPriceAfterDiscount;
  int? orderProductQuantity;
  String? productTotal;

  OrderProduct({
    this.orderProductId,
    this.productId,
    this.productName,
    this.productImage,
    this.productPrice,
    this.productDiscount,
    this.productPriceAfterDiscount,
    this.orderProductQuantity,
    this.productTotal,
  });

  factory OrderProduct.fromJson(Map<String, dynamic> json) => OrderProduct(
        orderProductId: json['order_product_id'] as int?,
        productId: json['product_id'] as int?,
        productName: json['product_name'] as String?,
        productImage: json['product_image'] as String? ?? json['image'] as String? ?? json['product_image_url'] as String?,
        productPrice: json['product_price'] as String?,
        productDiscount: json['product_discount'] as int?,
        productPriceAfterDiscount: (json['product_price_after_discount'] as num?)?.toDouble(),
        orderProductQuantity: json['order_product_quantity'] as int?,
        productTotal: json['product_total'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'order_product_id': orderProductId,
        'product_id': productId,
        'product_name': productName,
        'product_image': productImage,
        'product_price': productPrice,
        'product_discount': productDiscount,
        'product_price_after_discount': productPriceAfterDiscount,
        'order_product_quantity': orderProductQuantity,
        'product_total': productTotal,
      };
}

class OrderDetailsData {
  int? id;
  String? orderCode;
  String? total;
  String? name;
  String? email;
  String? address;
  String? governorate;
  String? phone;
  dynamic tax;
  String? subTotal;
  String? orderDate;
  String? status;
  dynamic rejectDetails;
  dynamic notes;
  int? discount;
  List<OrderProduct>? orderProducts;

  OrderDetailsData({
    this.id,
    this.orderCode,
    this.total,
    this.name,
    this.email,
    this.address,
    this.governorate,
    this.phone,
    this.tax,
    this.subTotal,
    this.orderDate,
    this.status,
    this.rejectDetails,
    this.notes,
    this.discount,
    this.orderProducts,
  });

  factory OrderDetailsData.fromJson(Map<String, dynamic> json) =>
      OrderDetailsData(
        id: json['id'] as int?,
        orderCode: json['order_code'] as String?,
        total: json['total'] as String?,
        name: json['name'] as String?,
        email: json['email'] as String?,
        address: json['address'] as String?,
        governorate: json['governorate'] as String?,
        phone: json['phone'] as String?,
        tax: json['tax'],
        subTotal: json['sub_total'] as String?,
        orderDate: json['order_date'] as String?,
        status: json['status'] as String?,
        rejectDetails: json['reject_details'],
        notes: json['notes'],
        discount: json['discount'] as int?,
        orderProducts: (json['order_products'] as List<dynamic>?)
            ?.map((e) => OrderProduct.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'order_code': orderCode,
        'total': total,
        'name': name,
        'email': email,
        'address': address,
        'governorate': governorate,
        'phone': phone,
        'tax': tax,
        'sub_total': subTotal,
        'order_date': orderDate,
        'status': status,
        'reject_details': rejectDetails,
        'notes': notes,
        'discount': discount,
        'order_products': orderProducts?.map((e) => e.toJson()).toList(),
      };
}

class OrderDetailsResponse {
  OrderDetailsData? data;
  String? message;
  List<dynamic>? error;
  int? status;

  OrderDetailsResponse({this.data, this.message, this.error, this.status});

  factory OrderDetailsResponse.fromJson(Map<String, dynamic> json) {
    return OrderDetailsResponse(
      data: json['data'] != null
          ? OrderDetailsData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
      message: json['message'] as String?,
      error: json['error'] as List<dynamic>?,
      status: json['status'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
        'message': message,
        'error': error,
        'status': status,
      };
}
