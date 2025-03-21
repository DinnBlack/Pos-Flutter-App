import 'order_detail_model.dart';

class OrderModel {
  final String id;
  final String customerName;
  final String orderStatus;
  final double totalPayment;
  final String paymentStatus;
  final String paymentEmployee;
  final String orderEmployee;
  final List<OrderDetailModel> orderDetails;
  final DateTime createdAt;
  final DateTime updatedAt;

//<editor-fold desc="Data Methods">
  const OrderModel({
    required this.id,
    required this.customerName,
    required this.orderStatus,
    required this.totalPayment,
    required this.paymentStatus,
    required this.paymentEmployee,
    required this.orderEmployee,
    required this.orderDetails,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrderModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          customerName == other.customerName &&
          orderStatus == other.orderStatus &&
          totalPayment == other.totalPayment &&
          paymentStatus == other.paymentStatus &&
          paymentEmployee == other.paymentEmployee &&
          orderEmployee == other.orderEmployee &&
          orderDetails == other.orderDetails &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt);

  @override
  int get hashCode =>
      id.hashCode ^
      customerName.hashCode ^
      orderStatus.hashCode ^
      totalPayment.hashCode ^
      paymentStatus.hashCode ^
      paymentEmployee.hashCode ^
      orderEmployee.hashCode ^
      orderDetails.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;

  @override
  String toString() {
    return 'OrderModel{' +
        ' id: $id,' +
        ' customerName: $customerName,' +
        ' orderStatus: $orderStatus,' +
        ' totalPayment: $totalPayment,' +
        ' paymentStatus: $paymentStatus,' +
        ' paymentEmployee: $paymentEmployee,' +
        ' orderEmployee: $orderEmployee,' +
        ' orderDetails: $orderDetails,' +
        ' createdAt: $createdAt,' +
        ' updatedAt: $updatedAt,' +
        '}';
  }

  OrderModel copyWith({
    String? id,
    String? customerName,
    String? orderStatus,
    double? totalPayment,
    String? paymentStatus,
    String? paymentEmployee,
    String? orderEmployee,
    List<OrderDetailModel>? orderDetails,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return OrderModel(
      id: id ?? this.id,
      customerName: customerName ?? this.customerName,
      orderStatus: orderStatus ?? this.orderStatus,
      totalPayment: totalPayment ?? this.totalPayment,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paymentEmployee: paymentEmployee ?? this.paymentEmployee,
      orderEmployee: orderEmployee ?? this.orderEmployee,
      orderDetails: orderDetails ?? this.orderDetails,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'customerName': this.customerName,
      'orderStatus': this.orderStatus,
      'totalPayment': this.totalPayment,
      'paymentStatus': this.paymentStatus,
      'paymentEmployee': this.paymentEmployee,
      'orderEmployee': this.orderEmployee,
      'orderDetails': this.orderDetails,
      'createdAt': this.createdAt,
      'updatedAt': this.updatedAt,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] as String,
      customerName: map['customerName'] as String,
      orderStatus: map['orderStatus'] as String,
      totalPayment: map['totalPayment'] as double,
      paymentStatus: map['paymentStatus'] as String,
      paymentEmployee: map['paymentEmployee'] as String,
      orderEmployee: map['orderEmployee'] as String,
      orderDetails: map['orderDetails'] as List<OrderDetailModel>,
      createdAt: map['createdAt'] as DateTime,
      updatedAt: map['updatedAt'] as DateTime,
    );
  }

//</editor-fold>
}