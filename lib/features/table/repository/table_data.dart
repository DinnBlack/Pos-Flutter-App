import '../model/table_model.dart';

List<TableModel> demoTables = [
  // Tầng 1
  TableModel(id: '1', name: 'Bàn 1', status: 'Đang hoạt động', orderId: 'ORD001', floorId: 'tang1', operationTime: DateTime(2025, 3, 20, 10, 0)),
  TableModel(id: '2', name: 'Bàn 2', status: 'Sẵn sàng', orderId: null, floorId: 'tang1', operationTime: null),
  TableModel(id: '3', name: 'Bàn 3', status: 'Đang hoạt động', orderId: 'ORD002', floorId: 'tang1', operationTime: DateTime(2025, 3, 20, 11, 0)),
  TableModel(id: '4', name: 'Bàn 4', status: 'Sẵn sàng', orderId: null, floorId: 'tang1', operationTime: null),
  TableModel(id: '5', name: 'Bàn 5', status: 'Đang hoạt động', orderId: 'ORD003', floorId: 'tang1', operationTime: DateTime(2025, 3, 20, 9, 30)),
  TableModel(id: '6', name: 'Bàn 6', status: 'Đóng', orderId: null, floorId: 'tang1', operationTime: null),

  // Tầng 2
  TableModel(id: '7', name: 'Bàn 7', status: 'Sẵn sàng', orderId: null, floorId: 'tang2', operationTime: null),
  TableModel(id: '8', name: 'Bàn 8', status: 'Đang hoạt động', orderId: 'ORD001', floorId: 'tang2', operationTime: DateTime(2025, 3, 20, 10, 15)),
  TableModel(id: '9', name: 'Bàn 9', status: 'Đang hoạt động', orderId: 'ORD002', floorId: 'tang2', operationTime: DateTime(2025, 3, 20, 11, 30)),
  TableModel(id: '10', name: 'Bàn 10', status: 'Sẵn sàng', orderId: null, floorId: 'tang2', operationTime: null),
  TableModel(id: '11', name: 'Bàn 11', status: 'Đang hoạt động', orderId: 'ORD003', floorId: 'tang2', operationTime: DateTime(2025, 3, 20, 9, 45)),
  TableModel(id: '12', name: 'Bàn 12', status: 'Đóng', orderId: null, floorId: 'tang2', operationTime: null),

  // Tầng 3
  TableModel(id: '13', name: 'Bàn 13', status: 'Đóng', orderId: null, floorId: 'tang3', operationTime: null),
  TableModel(id: '14', name: 'Bàn 14', status: 'Đang hoạt động', orderId: 'ORD001', floorId: 'tang3', operationTime: DateTime(2025, 3, 20, 10, 30)),
  TableModel(id: '15', name: 'Bàn 15', status: 'Sẵn sàng', orderId: null, floorId: 'tang3', operationTime: null),
  TableModel(id: '16', name: 'Bàn 16', status: 'Đang hoạt động', orderId: 'ORD002', floorId: 'tang3', operationTime: DateTime(2025, 3, 20, 11, 45)),
  TableModel(id: '17', name: 'Bàn 17', status: 'Đóng', orderId: null, floorId: 'tang3', operationTime: null),
  TableModel(id: '18', name: 'Bàn 18', status: 'Đóng', orderId: null, floorId: 'tang3', operationTime: null),
];
