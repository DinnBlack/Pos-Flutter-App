import 'package:flutter/material.dart';
import 'package:order_management_flutter_app/features/order/model/order_detail_model.dart';
import 'package:order_management_flutter_app/features/order/views/widgets/order_detail_item.dart';

import '../../../core/widgets/dash_divider.dart';

class OrderDetail extends StatelessWidget {
  final List<OrderDetailModel> orderDetail;

  const OrderDetail({super.key, required this.orderDetail});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => DashDivider(),
      itemCount: orderDetail.length,
      itemBuilder: (context, index) {
        final orderDetailItem = orderDetail[index];
        return OrderDetailItem(orderDetailItem: orderDetailItem);
      },
    );
  }
}
