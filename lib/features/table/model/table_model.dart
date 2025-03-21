class TableModel {
  final String id;
  final String name;
  final String? status;
  final String? orderId;
  final String floorId;
  final DateTime? operationTime;

//<editor-fold desc="Data Methods">
  const TableModel({
    required this.id,
    required this.name,
    this.status,
    this.orderId,
    required this.floorId,
    this.operationTime,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TableModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          status == other.status &&
          orderId == other.orderId &&
          floorId == other.floorId &&
          operationTime == other.operationTime);

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      status.hashCode ^
      orderId.hashCode ^
      floorId.hashCode ^
      operationTime.hashCode;

  @override
  String toString() {
    return 'TableModel{' +
        ' id: $id,' +
        ' name: $name,' +
        ' status: $status,' +
        ' orderId: $orderId,' +
        ' floorId: $floorId,' +
        ' operationTime: $operationTime,' +
        '}';
  }

  TableModel copyWith({
    String? id,
    String? name,
    String? status,
    String? orderId,
    String? floorId,
    DateTime? operationTime,
  }) {
    return TableModel(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      orderId: orderId ?? this.orderId,
      floorId: floorId ?? this.floorId,
      operationTime: operationTime ?? this.operationTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'status': this.status,
      'orderId': this.orderId,
      'floorId': this.floorId,
      'operationTime': this.operationTime,
    };
  }

  factory TableModel.fromMap(Map<String, dynamic> map) {
    return TableModel(
      id: map['id'] as String,
      name: map['name'] as String,
      status: map['status'] as String,
      orderId: map['orderId'] as String,
      floorId: map['floorId'] as String,
      operationTime: map['operationTime'] as DateTime,
    );
  }

//</editor-fold>
}