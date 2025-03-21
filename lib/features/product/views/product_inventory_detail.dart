import 'package:flutter/material.dart';
import '../../../core/utils/currency_formatter.dart';
import '../model/product_model.dart';

class ProductInventoryDetail extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onClose;

  const ProductInventoryDetail({
    super.key,
    required this.product,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(right: 10, bottom: 10),
      decoration: BoxDecoration(
        color: colors.secondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Chi tiết sản phẩm",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: onClose, // Gọi hàm đóng
              )
            ],
          ),
          Divider(),
          Text("ID: ${product.id}", style: TextStyle(fontSize: 16)),
          Text("Tên: ${product.name}", style: TextStyle(fontSize: 16)),
          Text("Giá: ${CurrencyFormatter.format(product.price)}", style: TextStyle(fontSize: 16)),
          SizedBox(height: 10),
          Image.network(product.imageUrl, height: 150, width: double.infinity, fit: BoxFit.cover),
        ],
      ),
    );
  }


}
