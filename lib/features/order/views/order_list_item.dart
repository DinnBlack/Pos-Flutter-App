import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/utils/currency_formatter.dart';
import '../model/order_model.dart';

class OrderListItem extends StatelessWidget {
  final OrderModel order;

  const OrderListItem({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Card(
      color: colors.secondary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("#${order.id}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: colors.primary)),
                _statusChip(order.orderStatus),
              ],
            ),
            const SizedBox(height: 8),
            Text("🕒 ${DateFormat('dd/MM/yyyy - hh:mm a').format(order.createdAt)}",
                style: TextStyle(color: Colors.grey[700])),
            Text("👤 ${order.customerName}",
                style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _paymentStatusChip(order.paymentStatus),
                Text("💰 ${CurrencyFormatter.format(order.totalPayment)}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () => _showOrderDetails(context, order),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                ),
                child: const Text("Xem chi tiết"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statusChip(String status) {
    Color color = status == "completed"
        ? Colors.green
        : (status == "pending" ? Colors.orange : Colors.grey);
    return Chip(
      label: Text(status.toUpperCase(),
          style: const TextStyle(fontSize: 10, color: Colors.white)),
      backgroundColor: color,
      padding: const EdgeInsets.symmetric(horizontal: 8),
    );
  }

  Widget _paymentStatusChip(String status) {
    Color color = status == "paid" ? Colors.green : Colors.red;
    return Chip(
      label: Text(status.toUpperCase(),
          style: const TextStyle(fontSize: 10, color: Colors.white)),
      backgroundColor: color,
      padding: const EdgeInsets.symmetric(horizontal: 8),
    );
  }

  void _showOrderDetails(BuildContext context, OrderModel order) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      backgroundColor: Colors.white,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Chi tiết đơn hàng",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const Divider(),
              ...order.orderDetails.map((detail) => ListTile(
                leading: CircleAvatar(
                    backgroundImage:
                    NetworkImage(detail.product.imageUrl)),
                title: Text(detail.product.name,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(
                    "SL: ${detail.quantity} - Giá: ${CurrencyFormatter.format(detail.totalPrice)}"),
              )),
            ],
          ),
        );
      },
    );
  }
}