import 'package:order_management_flutter_app/features/product/model/product_model.dart';

class OrderDetailModel {
  final ProductModel product;
  final int quantity;
  final double totalPrice;

//<editor-fold desc="Data Methods">
  const OrderDetailModel({
    required this.product,
    required this.quantity,
    required this.totalPrice,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrderDetailModel &&
          runtimeType == other.runtimeType &&
          product == other.product &&
          quantity == other.quantity &&
          totalPrice == other.totalPrice);

  @override
  int get hashCode =>
      product.hashCode ^ quantity.hashCode ^ totalPrice.hashCode;

  @override
  String toString() {
    return 'OrderDetailModel{' +
        ' product: $product,' +
        ' quantity: $quantity,' +
        ' totalPrice: $totalPrice,' +
        '}';
  }

  OrderDetailModel copyWith({
    ProductModel? product,
    int? quantity,
    double? totalPrice,
  }) {
    return OrderDetailModel(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'product': this.product,
      'quantity': this.quantity,
      'totalPrice': this.totalPrice,
    };
  }

  factory OrderDetailModel.fromMap(Map<String, dynamic> map) {
    return OrderDetailModel(
      product: map['product'] as ProductModel,
      quantity: map['quantity'] as int,
      totalPrice: map['totalPrice'] as double,
    );
  }

//</editor-fold>
}