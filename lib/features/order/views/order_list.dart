import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:order_management_flutter_app/core/utils/responsive.dart';

import '../../../core/utils/currency_formatter.dart';
import '../model/order_detail_model.dart';
import '../model/order_model.dart';
import '../repository/order_data.dart';
import 'order_detail.dart';
import 'order_list_item.dart';

class OrderList extends StatelessWidget {
  final List<OrderModel> orders;

  const OrderList({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    bool isMobile = Responsive.isMobile(context);

    return Container(
      decoration: BoxDecoration(
        color: isMobile ? colors.background : colors.secondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: isMobile ? _buildMobileList() : _buildDataTable(context, colors),
    );
  }

  Widget _buildMobileList() {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return OrderListItem(order: orders[index]);
      },
    );
  }

  Widget _buildDataTable(BuildContext context, ColorScheme colors) {
    return DataTable2(
      columnSpacing: 10,
      horizontalMargin: 10,
      dividerThickness: 0,
      border: TableBorder(
        horizontalInside: BorderSide(color: Colors.grey.shade300, width: 0.5),
      ),
      columns: [
        DataColumn2(
            label: _buildColumnHeader("ID", colors), size: ColumnSize.S),
        DataColumn2(
            label: _buildColumnHeader("Date & Time", colors),
            size: ColumnSize.M),
        DataColumn2(
            label: _buildColumnHeader("Customer Name", colors),
            size: ColumnSize.M),
        DataColumn2(
            label: _buildColumnHeader("Order Status", colors),
            size: ColumnSize.M),
        DataColumn2(
            label: _buildColumnHeader("Total Payment", colors),
            size: ColumnSize.M),
        DataColumn2(
            label: _buildColumnHeader("Payment Status", colors),
            size: ColumnSize.M),
        DataColumn2(
            label: _buildColumnHeader("Detail", colors), size: ColumnSize.S),
      ],
      rows: orders.map((order) {
        return DataRow(
          cells: [
            DataCell(Center(child: Text(order.id))),
            DataCell(Center(
                child: Text(
                    DateFormat('dd/MM - hh:mm a').format(order.createdAt)))),
            DataCell(Center(child: Text(order.customerName))),
            DataCell(Center(child: _statusChip(order.orderStatus))),
            DataCell(Center(
                child: Text(CurrencyFormatter.format(order.totalPayment)))),
            DataCell(Center(child: _paymentStatusChip(order.paymentStatus))),
            DataCell(
              Center(
                child: TextButton(
                  onPressed: () =>
                      _showOrderDetails(context, order.orderDetails),
                  child: const Text("Detail",
                      style: TextStyle(color: Colors.blue)),
                ),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildColumnHeader(String title, ColorScheme colors) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: double.infinity,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: colors.background,
      ),
      child: Text(title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
    );
  }

  Widget _statusChip(String status) {
    Color color = status == "completed"
        ? Colors.green
        : (status == "pending" ? Colors.orange : Colors.grey);
    return Text(status, style: TextStyle(color: color));
  }

  Widget _paymentStatusChip(String status) {
    Color color = status == "paid" ? Colors.green : Colors.red;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: color.withOpacity(0.1),
      ),
      child: Text(status, style: TextStyle(color: color)),
    );
  }

  void _showOrderDetails(
      BuildContext context, List<OrderDetailModel> orderDetail) {
    final colors = Theme.of(context).colorScheme;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: colors.secondary,
          content: SizedBox(
            width: 400,
              child: OrderDetail(
            orderDetail: orderDetail,
          )),
        );
      },
    );
  }
}
