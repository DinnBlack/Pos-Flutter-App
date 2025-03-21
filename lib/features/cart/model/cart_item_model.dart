import '../../product/model/product_model.dart';

class CartItemModel {
  final ProductModel product;
  final int quantity;

//<editor-fold desc="Data Methods">
  const CartItemModel({
    required this.product,
    required this.quantity,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CartItemModel &&
          runtimeType == other.runtimeType &&
          product == other.product &&
          quantity == other.quantity);

  @override
  int get hashCode => product.hashCode ^ quantity.hashCode;

  @override
  String toString() {
    return 'CartItemModel{' +
        ' product: $product,' +
        ' quantity: $quantity,' +
        '}';
  }

  CartItemModel copyWith({
    ProductModel? product,
    int? quantity,
  }) {
    return CartItemModel(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'product': product.toMap(),
      'quantity': quantity,
    };
  }

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      product: ProductModel.fromMap(map['product']),
      quantity: map['quantity'] as int,
    );
  }

//</editor-fold>
}