import 'package:flutter/material.dart';
import 'package:order_management_flutter_app/core/utils/responsive.dart';
import '../../../core/utils/constants.dart';
import '../model/product_model.dart';
import 'widgets/product_list_item.dart';

class ProductList extends StatelessWidget {
  final List<ProductModel> products;

  const ProductList({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      int crossAxisCount;

      if (Responsive.isMobile(context)) {
        crossAxisCount = 2;
      } else if (Responsive.isTablet(context)) {
        crossAxisCount = 3;
      } else {
        crossAxisCount = 3;
      }

      return GridView.builder(
        shrinkWrap: true,
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: products.length,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: defaultPadding,
          mainAxisSpacing: defaultPadding,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) =>
            ProductListItem(product: products[index]),
      );
    });
  }
}
